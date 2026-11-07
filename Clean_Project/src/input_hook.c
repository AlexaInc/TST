/**
 * input_hook.c - Window subclass + cached key table + edge detection
 *
 * See input_hook.h for the "why". The behaviour mirrors the original
 * ReShade build's input poll (decompiled 0x50b60):
 *   - 256-byte key table at +0x12, bit 0x80 = down
 *   - previous state kept for edge detection (0x2c / PrintScreen handling)
 *   - GetAsyncKeyState() HIGH bit only
 */

#include <windows.h>
#include <stdbool.h>
#include "../include/input_hook.h"

#ifndef GET_X_LPARAM
#define GET_X_LPARAM(lp) ((int)(short)LOWORD(lp))
#define GET_Y_LPARAM(lp) ((int)(short)HIWORD(lp))
#endif

/* ------------------------------------------------------------------------- */
/* State shared with the window thread                                       */
/* ------------------------------------------------------------------------- */
static CRITICAL_SECTION s_cs;
static bool    s_csReady   = false;
static HWND    s_hwnd      = NULL;
static WNDPROC s_oldProc   = NULL;
static bool    s_attached  = false;

static BYTE    s_keyMsg[256];      /* set/cleared by window messages       */
static BYTE    s_keyPrev[256];     /* previous frame, for edge detection   */
static DWORD   s_keyEdgeMs[256];   /* debounce timestamps                  */

static BYTE    s_mouseMsg[3];      /* from WM_*BUTTON*                     */
static int     s_msgX = -1, s_msgY = -1;
static bool    s_haveMsgPos = false;
static int     s_wheelAccum = 0;
static bool    s_lostFocus = false;

/* ---- virtual cursor -------------------------------------------------------
 * FPS games grab the mouse and call SetCursorPos() every frame to re-centre
 * it. The visible OS cursor is therefore nailed to the middle of the game view
 * and can never reach our menu ("cursor locked outside the menu"). Nothing we
 * hook can change that, so while the menu is open we stop using the OS cursor
 * for ImGui and use an accumulated raw-delta cursor instead. ImGui draws its
 * own pointer (io.MouseDrawCursor), so the user sees a normal cursor that they
 * fully control. */
static volatile LONG s_virtActive = 0;
static float   s_virtX = 0.0f, s_virtY = 0.0f;
static volatile LONG s_rawAccumX = 0, s_rawAccumY = 0;
static float   s_mouseSensitivity = 1.0f;   /* raw counts -> client pixels */

void Input_SetSensitivity(float s)
{
    if (s < 0.1f) s = 0.1f;
    if (s > 8.0f) s = 8.0f;
    s_mouseSensitivity = s;
}

/* UI rectangle + engine input blocking */
static volatile LONG s_uiEnabled = 0;
static float  s_uiX = 0, s_uiY = 0, s_uiW = 0, s_uiH = 0;
static volatile LONG s_blockGame = 0;

void Input_SetUiRect(float x, float y, float w, float h)
{
    s_uiX = x; s_uiY = y; s_uiW = w; s_uiH = h;
    InterlockedExchange(&s_uiEnabled, (w > 1.0f && h > 1.0f) ? 1 : 0);
}

void Input_SetBlockGameInput(bool block)
{
    bool was = s_blockGame != 0;
    InterlockedExchange(&s_blockGame, block ? 1 : 0);

    if (block && !was)
    {
        /* Menu just opened: start the virtual cursor where the real one is,
         * or in the middle of the window if the game has it pinned. */
        POINT p = { 0, 0 };
        GetCursorPos(&p);
        if (s_hwnd && IsWindow(s_hwnd)) ScreenToClient(s_hwnd, &p);
        RECT rc = { 0, 0, 0, 0 };
        if (s_hwnd && IsWindow(s_hwnd)) GetClientRect(s_hwnd, &rc);
        float cx = (float)p.x, cy = (float)p.y;
        if (cx <= rc.left || cx >= rc.right || cy <= rc.top || cy >= rc.bottom)
        {
            cx = (rc.right - rc.left) * 0.5f;
            cy = (rc.bottom - rc.top) * 0.5f;
        }
        s_virtX = cx; s_virtY = cy;
        InterlockedExchange(&s_rawAccumX, 0);
        InterlockedExchange(&s_rawAccumY, 0);
        InterlockedExchange(&s_virtActive, 1);
    }
    else if (!block && was)
    {
        InterlockedExchange(&s_virtActive, 0);
    }
}

/* True when the menu is driving the pointer from raw deltas. */
bool Input_VirtualCursorActive(void) { return s_virtActive != 0; }

static bool PointInUi(int x, int y)
{
    if (!s_uiEnabled) return false;
    return ((float)x >= s_uiX && (float)x <= s_uiX + s_uiW &&
            (float)y >= s_uiY && (float)y <= s_uiY + s_uiH);
}

static void Lock(void);
static void Unlock(void);

/* ------------------------------------------------------------------------- */
/* Low-level mouse hook on its own thread                                    */
/* ------------------------------------------------------------------------- */
/* The WndProc subclass only sees messages that arrive on the subclassed hwnd.
 * Qt reads the pointer for the game camera through Raw Input on its own
 * threads, so a click could still reach the emulator. A WH_MOUSE_LL hook is
 * installed *before* the input queue, so returning 1 there stops the event
 * from being delivered to anything - including Raw Input. It must live on a
 * thread that pumps messages, hence the dedicated thread below. */
static HHOOK    s_llMouse = NULL;
static HANDLE   s_llThread = NULL;
static DWORD    s_llThreadId = 0;
static HMODULE  s_selfModule = NULL;

static LRESULT CALLBACK LLMouseProc(int nCode, WPARAM wp, LPARAM lp)
{
    if (nCode == HC_ACTION && s_blockGame)
    {
        MSLLHOOKSTRUCT* m = (MSLLHOOKSTRUCT*)lp;
        if (m)
        {
            POINT c = m->pt;
            if (s_hwnd && IsWindow(s_hwnd))
                ScreenToClient(s_hwnd, &c);
            if (PointInUi(c.x, c.y))
            {
                /* Feed our own state so ImGui still sees the click ... */
                Lock();
                s_msgX = c.x; s_msgY = c.y; s_haveMsgPos = true;
                switch (wp)
                {
                case WM_LBUTTONDOWN: s_mouseMsg[0] = 1; break;
                case WM_LBUTTONUP:   s_mouseMsg[0] = 0; break;
                case WM_RBUTTONDOWN: s_mouseMsg[1] = 1; break;
                case WM_RBUTTONUP:   s_mouseMsg[1] = 0; break;
                case WM_MBUTTONDOWN: s_mouseMsg[2] = 1; break;
                case WM_MBUTTONUP:   s_mouseMsg[2] = 0; break;
                case WM_MOUSEWHEEL:  s_wheelAccum += (short)HIWORD(m->mouseData); break;
                case WM_MOUSEMOVE:   break;
                default:             break;
                }
                Unlock();
                /* ... and stop it from reaching the emulator/game. */
                return 1;
            }
        }
    }
    return CallNextHookEx(s_llMouse, nCode, wp, lp);
}

/* Receives WM_INPUT (raw mouse deltas). Raw deltas are relative and are *not*
 * affected by the game re-centring the cursor, which is exactly what we need. */
static LRESULT CALLBACK RawWndProc(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp)
{
    if (msg == WM_INPUT)
    {
        RAWINPUT ri;
        UINT size = sizeof(ri);
        if (GetRawInputData((HRAWINPUT)lp, RID_INPUT, &ri, &size, sizeof(RAWINPUTHEADER)) != (UINT)-1)
        {
            if (ri.header.dwType == RIM_TYPEMOUSE && ri.data.mouse.usFlags == MOUSE_MOVE_RELATIVE)
            {
                if (s_virtActive)
                {
                    InterlockedExchangeAdd(&s_rawAccumX, ri.data.mouse.lLastX);
                    InterlockedExchangeAdd(&s_rawAccumY, ri.data.mouse.lLastY);
                }
            }
        }
        return 0;
    }
    return DefWindowProcW(hwnd, msg, wp, lp);
}

static DWORD WINAPI InputThreadProc(LPVOID param)
{
    (void)param;
    if (!s_selfModule) return 0;

    /* --- hidden window + raw mouse (relative deltas) --- */
    WNDCLASSEXW wc;
    memset(&wc, 0, sizeof(wc));
    wc.cbSize        = sizeof(wc);
    wc.lpfnWndProc   = RawWndProc;
    wc.hInstance     = s_selfModule;
    wc.lpszClassName = L"ProxyRawInputWnd";
    RegisterClassExW(&wc);
    HWND rawWnd = CreateWindowExW(0, L"ProxyRawInputWnd", L"", 0, 0, 0, 0, 0,
                                  HWND_MESSAGE, NULL, s_selfModule, NULL);
    if (rawWnd)
    {
        RAWINPUTDEVICE rid;
        rid.usUsagePage = 0x01;            /* generic desktop */
        rid.usUsage     = 0x02;            /* mouse           */
        rid.dwFlags     = RIDEV_INPUTSINK;  /* receive even when not focused */
        rid.hwndTarget  = rawWnd;
        if (!RegisterRawInputDevices(&rid, 1, sizeof(rid)))
            for (int i = 0; i < 2; i++) OutputDebugStringA("[proxy] RegisterRawInputDevices failed\n");
    }

    s_llThreadId = GetCurrentThreadId();
    s_llMouse = SetWindowsHookExW(WH_MOUSE_LL, LLMouseProc, s_selfModule, 0);
    if (!s_llMouse)
    {
        OutputDebugStringA("[proxy] SetWindowsHookEx(WH_MOUSE_LL) failed - clicks may pass through\n");
        return 0;
    }
    OutputDebugStringA("[proxy] WH_MOUSE_LL installed - menu clicks are blocked from the game\n");

    MSG msg;
    while (GetMessageW(&msg, NULL, 0, 0) > 0)
    {
        TranslateMessage(&msg);
        DispatchMessageW(&msg);
    }
    UnhookWindowsHookEx(s_llMouse);
    s_llMouse = NULL;
    return 0;
}

/* Start it lazily from the first present (never from DllMain: no threads under
 * the loader lock). */
void Input_StartLowLevelHook(void)
{
    if (s_llThread) return;
    s_selfModule = NULL;
    GetModuleHandleExW(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
                       GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                       (LPCWSTR)(const void*)&LLMouseProc, &s_selfModule);
    if (!s_selfModule) return;
    s_llThread = CreateThread(NULL, 0, InputThreadProc, NULL, 0, &s_llThreadId);
}

static void Lock(void)   { if (s_csReady) EnterCriticalSection(&s_cs); }
static void Unlock(void) { if (s_csReady) LeaveCriticalSection(&s_cs); }

/* ------------------------------------------------------------------------- */
/* Window procedure hook                                                     */
/* ------------------------------------------------------------------------- */
static LRESULT CALLBACK Input_WndProc(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp)
{
    /* ---- keep clicks on the menu away from the emulator/game -------------
     * The overlay is drawn by us, so the game underneath would happily act on
     * the same click. While the menu is open we swallow the mouse messages
     * that land inside the menu rectangle (and all raw input, which the game
     * uses for the camera). Returning 0 without CallWindowProc means Qt never
     * sees the message. */
    if (s_blockGame)
    {
        switch (msg)
        {
        case WM_INPUT:
            return 0;                       /* raw mouse: camera stays still */
        case WM_LBUTTONDOWN: case WM_LBUTTONUP:
        case WM_RBUTTONDOWN: case WM_RBUTTONUP:
        case WM_MBUTTONDOWN: case WM_MBUTTONUP:
        case WM_LBUTTONDBLCLK: case WM_RBUTTONDBLCLK:
        case WM_XBUTTONDOWN: case WM_XBUTTONUP:
        case WM_MOUSEWHEEL: case WM_MOUSEHWHEEL:
        {
            /* WM_MOUSEWHEEL carries SCREEN coordinates, buttons carry client */
            POINT pt;
            if (msg == WM_MOUSEWHEEL || msg == WM_MOUSEHWHEEL)
            {
                pt.x = GET_X_LPARAM(lp); pt.y = GET_Y_LPARAM(lp);
                ScreenToClient(hwnd, &pt);
            }
            else
            {
                pt.x = GET_X_LPARAM(lp); pt.y = GET_Y_LPARAM(lp);
            }
            if (PointInUi(pt.x, pt.y))
            {
                /* still record the state so ImGui sees the click */
                if (msg == WM_LBUTTONDOWN) { Lock(); s_mouseMsg[0] = 1; s_msgX = pt.x; s_msgY = pt.y; s_haveMsgPos = true; Unlock(); }
                if (msg == WM_LBUTTONUP)   { Lock(); s_mouseMsg[0] = 0; Unlock(); }
                if (msg == WM_RBUTTONDOWN) { Lock(); s_mouseMsg[1] = 1; Unlock(); }
                if (msg == WM_RBUTTONUP)   { Lock(); s_mouseMsg[1] = 0; Unlock(); }
                if (msg == WM_MOUSEWHEEL)  { Lock(); s_wheelAccum += GET_WHEEL_DELTA_WPARAM(wp); Unlock(); }
                return 0;                   /* consumed by the overlay */
            }
            break;
        }
        default:
            break;
        }
    }

    switch (msg)
    {
    case WM_KEYDOWN:
    case WM_SYSKEYDOWN:
        if (wp < 256) { Lock(); s_keyMsg[wp] = 1; Unlock(); }
        break;

    case WM_KEYUP:
    case WM_SYSKEYUP:
        if (wp < 256) { Lock(); s_keyMsg[wp] = 0; Unlock(); }
        break;

    case WM_LBUTTONDOWN: Lock(); s_mouseMsg[0] = 1; s_msgX = GET_X_LPARAM(lp); s_msgY = GET_Y_LPARAM(lp); s_haveMsgPos = true; Unlock(); break;
    case WM_LBUTTONUP:   Lock(); s_mouseMsg[0] = 0; Unlock(); break;
    case WM_RBUTTONDOWN: Lock(); s_mouseMsg[1] = 1; s_msgX = GET_X_LPARAM(lp); s_msgY = GET_Y_LPARAM(lp); s_haveMsgPos = true; Unlock(); break;
    case WM_RBUTTONUP:   Lock(); s_mouseMsg[1] = 0; Unlock(); break;
    case WM_MBUTTONDOWN: Lock(); s_mouseMsg[2] = 1; Unlock(); break;
    case WM_MBUTTONUP:   Lock(); s_mouseMsg[2] = 0; Unlock(); break;

    case WM_MOUSEMOVE:
        Lock();
        s_msgX = GET_X_LPARAM(lp);
        s_msgY = GET_Y_LPARAM(lp);
        s_haveMsgPos = true;
        Unlock();
        break;

    case WM_MOUSEWHEEL:
        Lock(); s_wheelAccum += GET_WHEEL_DELTA_WPARAM(wp); Unlock();
        break;

    case WM_KILLFOCUS:
    case WM_ACTIVATEAPP:
        if (msg == WM_KILLFOCUS || wp == 0)
        {
            Lock();
            memset(s_keyMsg, 0, sizeof(s_keyMsg));
            s_mouseMsg[0] = s_mouseMsg[1] = s_mouseMsg[2] = 0;
            s_lostFocus = true;
            Unlock();
        }
        break;

    case WM_DESTROY:
        Lock(); s_attached = false; Unlock();
        break;

    default:
        break;
    }

    if (s_oldProc)
        return CallWindowProcW(s_oldProc, hwnd, msg, wp, lp);
    return DefWindowProcW(hwnd, msg, wp, lp);
}

/* ------------------------------------------------------------------------- */
/* Attach / re-attach                                                        */
/* ------------------------------------------------------------------------- */
void Input_Attach(HWND hwnd)
{
    if (!hwnd || !IsWindow(hwnd)) return;

    if (!s_csReady)
    {
        InitializeCriticalSection(&s_cs);
        s_csReady = true;
    }

    /* Emulators (Qt) sometimes restore their own WndProc after a resize or a
     * fullscreen toggle, so verify ownership on every present and re-install. */
    if (hwnd == s_hwnd && s_attached)
    {
        LONG_PTR cur = GetWindowLongPtrW(hwnd, GWLP_WNDPROC);
        if (cur == (LONG_PTR)Input_WndProc) return;
        s_attached = false;
    }

    /* Never call SetWindowLongPtr while holding the lock: the owning thread
     * may be inside our WndProc waiting for it. */
    HWND     prevHwnd = s_hwnd;
    WNDPROC  prevProc = s_oldProc;
    bool     prevAtt  = s_attached;

    if (prevHwnd && prevHwnd != hwnd && prevProc && prevAtt && IsWindow(prevHwnd))
        SetWindowLongPtrW(prevHwnd, GWLP_WNDPROC, (LONG_PTR)prevProc);

    Lock();
    s_hwnd = hwnd;
    Unlock();

    LONG_PTR old = SetWindowLongPtrW(hwnd, GWLP_WNDPROC, (LONG_PTR)Input_WndProc);
    if (old && old != (LONG_PTR)Input_WndProc)
    {
        s_oldProc = (WNDPROC)old;
        s_attached = true;
    }
    else
    {
        /* Couldn't subclass (rare). Polling fallback in Input_Collect still
         * gives us Insert - just without client-space mouse messages. */
        s_attached = false;
    }
}

bool Input_IsAttached(void) { return s_attached; }

void Input_ReleaseCursorForUI(bool uiOpen)
{
    if (uiOpen)
    {
        /* The emulator clips/hides the cursor for FPS games. While our menu is
         * open, let the user move the pointer freely. */
        ClipCursor(NULL);
    }
}

/* ------------------------------------------------------------------------- */
/* Per-frame collection                                                      */
/* ------------------------------------------------------------------------- */
void Input_Collect(InputFrame* out, int onlyVk)
{
    if (!out) return;
    memset(out, 0, sizeof(*out));

    if (s_csReady) Lock();

    DWORD now = GetTickCount();
    HWND  hwnd = s_hwnd;

    int vkFrom = 8, vkTo = 256;
    if (onlyVk > 0 && onlyVk < 256) { vkFrom = onlyVk; vkTo = onlyVk + 1; }

    for (int vk = vkFrom; vk < vkTo; vk++)
    {
        /* High bit only - never the "pressed since last call" low bit. */
        bool polled = (GetAsyncKeyState(vk) & 0x8000) != 0;
        bool down   = polled || (s_keyMsg[vk] != 0);

        out->keyDown[vk] = down;
        if (down && !s_keyPrev[vk])
        {
            /* Debounce: one logical press per physical press, even if both
             * the message path and the poll path fire in the same frame. */
            if ((DWORD)(now - s_keyEdgeMs[vk]) >= 120 || s_keyEdgeMs[vk] == 0)
            {
                out->keyPressed[vk] = true;
                s_keyEdgeMs[vk] = now ? now : 1;
            }
        }
        else if (!down && s_keyPrev[vk])
        {
            out->keyReleased[vk] = true;
        }
        s_keyPrev[vk] = down ? 1 : 0;
    }

    /* Hotkey-only pass (cheap path used while the menu is closed). It must not
     * touch the mouse state: consuming the raw-delta accumulator here and then
     * throwing the result away is what made the virtual cursor jump. */
    if (onlyVk > 0)
    {
        if (s_csReady) Unlock();
        return;
    }

    /* ---- mouse buttons ---- */
    for (int i = 0; i < 3; i++)
    {
        int vk = (i == 0) ? VK_LBUTTON : (i == 1 ? VK_RBUTTON : VK_MBUTTON);
        out->mouseDown[i] = ((GetAsyncKeyState(vk) & 0x8000) != 0) ||
                            (s_mouseMsg[i] != 0);
    }

    /* ---- mouse position -------------------------------------------------
     * While the menu is open the OS cursor is being re-centred by the game, so
     * we integrate the raw deltas instead (also 1:1 with the OS cursor when we
     * allow the raw path). Everything stays in client pixels. */
    if (s_virtActive)
    {
        LONG dx = InterlockedExchange(&s_rawAccumX, 0);
        LONG dy = InterlockedExchange(&s_rawAccumY, 0);
        if (dx || dy)
        {
            /* Keep the fractional part: a slow drag is a stream of 1-count
             * deltas that would otherwise be dropped between frames. */
            s_virtX += (float)dx * s_mouseSensitivity;
            s_virtY += (float)dy * s_mouseSensitivity;
        }

        RECT rc = { 0, 0, 0, 0 };
        if (hwnd && IsWindow(hwnd)) GetClientRect(hwnd, &rc);
        float wmax = (float)(rc.right - rc.left);
        float hmax = (float)(rc.bottom - rc.top);
        if (wmax > 2.0f && hmax > 2.0f)
        {
            if (s_virtX < 0.0f) s_virtX = 0.0f;
            if (s_virtY < 0.0f) s_virtY = 0.0f;
            if (s_virtX > wmax - 1.0f) s_virtX = wmax - 1.0f;
            if (s_virtY > hmax - 1.0f) s_virtY = hmax - 1.0f;
        }
        out->mouseX = (int)s_virtX;
        out->mouseY = (int)s_virtY;
        out->mouseValid = true;
    }
    else if (s_haveMsgPos && s_msgX >= 0)
    {
        out->mouseX = s_msgX;
        out->mouseY = s_msgY;
        out->mouseValid = true;
    }
    else if (hwnd && IsWindow(hwnd))
    {
        POINT pt;
        if (GetCursorPos(&pt) && ScreenToClient(hwnd, &pt))
        {
            out->mouseX = pt.x;
            out->mouseY = pt.y;
            out->mouseValid = true;
        }
    }

    if (s_wheelAccum != 0)
    {
        out->wheel = (float)s_wheelAccum / (float)WHEEL_DELTA;
        s_wheelAccum = 0;
    }

    out->focusLost = s_lostFocus;
    s_lostFocus = false;

    if (s_csReady) Unlock();
}
