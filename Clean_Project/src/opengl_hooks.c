/**
 * opengl_hooks.c - Proxy core: swap hook, overlay pipeline, chams hook
 *
 * [English] Structure mirrors the original ReShade build's wglSwapBuffers
 *           (decompiled 0x15f600):
 *
 *             1. resolve the genuine wglSwapBuffers exactly once (and prove it
 *                is not our own export -> no recursion),
 *             2. find the window for this HDC and compare its client size with
 *                the size we saw last frame,
 *             3. on a size change, reset the overlay so nothing is projected
 *                with a stale size (this is what removed the corner "black
 *                box" after a resize),
 *             4. draw the overlay with full GL state save/restore,
 *             5. call the real wglSwapBuffers.
 *
 * [සිංහල] Original ReShade එකේ wglSwapBuffers එකේ තියෙන පිළිවෙලම:
 *         සැබෑ function එක resolve → window/client size සංසන්දනය →
 *         size වෙනස් නම් overlay reset → state save කරලා UI අඳිනවා →
 *         අන්තිමට සැබෑ swap එක call කරනවා.
 */

#include <windows.h>
#include <stdio.h>
#include <stdbool.h>

#include "../include/gl_real.h"
#include "../include/config.h"
#include "../include/opengl_hooks.h"
#include "../include/gui_overlay.h"
#include "../include/gl_forwarders.h"
#include "../include/imgui_wrapper.h"
#include "../include/input_hook.h"
#include "../include/overlay_state.h"
#include "../include/iat_hook.h"
#include "../include/log.h"
#include "../include/thunk_hook.h"

/* ------------------------------------------------------------------------- */
/* State                                                                     */
/* ------------------------------------------------------------------------- */
static HMODULE g_hReal     = NULL;   /* System32\opengl32.dll               */
static HMODULE g_hSelf     = NULL;   /* this DLL                            */
static bool    g_initDone  = false;

typedef BOOL (WINAPI *PFN_wglSwapBuffers)(HDC);
typedef BOOL (WINAPI *PFN_wglSwapLayerBuffers)(HDC, UINT);
typedef PROC (WINAPI *PFN_wglGetProcAddress_)(LPCSTR);

static PFN_wglSwapBuffers       g_origSwap        = NULL;
static PFN_wglSwapLayerBuffers  g_origSwapLayers  = NULL;

/* Re-entrancy guard: emulators occasionally call the swap from inside the
 * swap (multi-context / multi-window). Never draw the UI twice per frame. */
static __thread int t_inSwap = 0;

void OpenGL_SetSelfModule(HMODULE h) { g_hSelf = h; }

HMODULE GL_GetRealModule(void) { return g_hReal; }

bool GL_CurrentContextIsValid(void)
{
    if (!g_hReal) return false;
    typedef HGLRC (WINAPI *PFN_wglGetCurrentContext)(void);
    PFN_wglGetCurrentContext p =
        (PFN_wglGetCurrentContext)(void*)GetProcAddress(g_hReal, "wglGetCurrentContext");
    return p && p() != NULL;
}

/* ------------------------------------------------------------------------- */
/* Load the genuine DLL and prove it is not us                               */
/* ------------------------------------------------------------------------- */
bool OpenGL_InitHooks(void)
{
    if (g_initDone && g_hReal) return true;

    wchar_t sysPath[MAX_PATH];
    UINT n = GetSystemDirectoryW(sysPath, MAX_PATH);
    if (n == 0 || n + 16 >= MAX_PATH) return false;
    lstrcatW(sysPath, L"\\opengl32.dll");

    HMODULE h = LoadLibraryW(sysPath);      /* full path: a *distinct* module */
    if (!h) return false;

    /* If the loader handed us our own module (can happen when the proxy sits
     * in a directory that is already in the search path), bail out instead of
     * recursing into ourselves forever. */
    if (h == g_hSelf)
    {
        OutputDebugStringA("[Clean_Project] FATAL: real opengl32.dll resolved to ourselves\n");
        return false;
    }

    g_hReal = h;

    g_origSwap = (PFN_wglSwapBuffers)(void*)GetProcAddress(g_hReal, "wglSwapBuffers");
    g_origSwapLayers = (PFN_wglSwapLayerBuffers)(void*)GetProcAddress(g_hReal, "wglSwapLayerBuffers");

    if (!g_origSwap)
    {
        OutputDebugStringA("[Clean_Project] FATAL: no genuine wglSwapBuffers\n");
        g_hReal = NULL;
        return false;
    }
    if ((void*)g_origSwap == (void*)&Hooked_wglSwapBuffers)
    {
        OutputDebugStringA("[Clean_Project] FATAL: wglSwapBuffers resolved to our hook\n");
        g_origSwap = NULL;
        g_hReal = NULL;
        return false;
    }

    /* Fill the GL/WGL forwarder stubs (gl_forwarders.S) */
    GL_ForwardersInit(g_hReal);

    /* ---- the important part for BlueStacks ------------------------------
     * Redirect the *genuine* System32 thunks as well. The Qt renderer loads
     * System32\opengl32.dll directly, so without this its present call never
     * reaches the proxy export and the overlay is drawn into a surface that is
     * never displayed. */
    {
        static ThunkHook hSwap, hLayers, hGdi;
        if (!hSwap.installed)
        {
            if (ThunkHook_Install("opengl32.dll", "wglSwapBuffers",
                                  (void*)&Proxy_wglSwapBuffers, &hSwap) && hSwap.original)
                g_origSwap = (PFN_wglSwapBuffers)hSwap.original;
        }
        if (!hLayers.installed)
        {
            if (ThunkHook_Install("opengl32.dll", "wglSwapLayerBuffers",
                                  (void*)&Proxy_wglSwapLayerBuffers, &hLayers) && hLayers.original)
                g_origSwapLayers = (PFN_wglSwapLayerBuffers)hLayers.original;
        }
        if (!hGdi.installed)
        {
            if (ThunkHook_Install("gdi32.dll", "SwapBuffers",
                                  (void*)&Proxy_SwapBuffers, &hGdi) && hGdi.original)
                Proxy_SetGdiOriginal(hGdi.original);
        }
    }

    g_initDone = true;
    OutputDebugStringA("[Clean_Project] real opengl32.dll loaded and forwarders bound\n");
    return true;
}

void OpenGL_ShutdownHooks(void)
{
    /* Do NOT FreeLibrary here: code may still call our stubs during shutdown. */
    g_origSwap = NULL;
    g_origSwapLayers = NULL;
}

/* ------------------------------------------------------------------------- */
/* Overlay pipeline                                                          */
/* ------------------------------------------------------------------------- */
static bool     s_menuWasOpen = false;
static DWORD    s_lastDrawTick = 0;
static unsigned s_presentCount = 0;
static unsigned s_countWgl = 0, s_countGdi = 0, s_countLayers = 0;
static const char* s_lastPath = "?";

static void HandlePresent(HDC hdc, const char* path)
{
    s_presentCount++;
    s_lastPath = path;

    if (path[0] == 'g') s_countGdi++;
    else if (path[3] == 'S') s_countLayers++;
    else s_countWgl++;

    /* Cheap heartbeat + present-path mix: if the visible picture is presented by
     * a path we never see, this is where it shows up. */
    LogfEvery("present", 3000, "present #%u via %s (hdc=%p) | mix wgl=%u gdi=%u layers=%u",
              s_presentCount, path, (void*)hdc, s_countWgl, s_countGdi, s_countLayers);

    /* NOTE: BlueStacks presents TWICE per frame on the same HDC
     * (wglSwapLayerBuffers + gdi32!SwapBuffers). Both swaps must have the
     * overlay in their back buffer, otherwise the window alternates between
     * "menu" and "no menu" frames - the rapid open/close flicker.
     * So: draw before every present. The GL state save is cached for a few
     * milliseconds (see overlay_state.c), so the second draw is cheap. */
    DWORD now = GetTickCount();
    (void)now;

    /* Qt/BlueStacks load modules late; keep re-scanning the IATs so a
     * SwapBuffers import that appears after us still gets redirected. */
    {
        static DWORD lastScan = 0;
        if ((DWORD)(now - lastScan) > 5000)
        {
            lastScan = now ? now : 1;
            int n = IATHook_InstallAll();
            if (n > 0)
                Logf("IAT scan: %d new entry(ies) redirected (total %d, gdi32!SwapBuffers=%d)",
                     n, IATHook_PatchedCount(), (int)IATHook_GotGDISwap());
        }
    }

    /* ---- 1. HOTKEY FIRST -------------------------------------------- */
    /* Deliberately before every other step: if window discovery or the GL
     * table ever fails, the menu can still be toggled and we still log it. */
    int menuKey = g_Config.menuKey > 0 ? g_Config.menuKey : VK_INSERT;
    InputFrame hot;
    Input_Collect(&hot, menuKey);
    bool open = GUI_HandleHotkeys(&hot);
    if (open != s_menuWasOpen)
    {
        s_menuWasOpen = open;
        Logf("MENU %s (key=0x%02X, path=%s)", open ? "OPENED" : "CLOSED", menuKey, path);
    }

    /* ---- 2. GL function table --------------------------------------- */
    if (!GL_LoadRealApi())
    {
        LogfEvery("noapi", 5000,
                  "GL_LoadRealApi() FAILED (real module=%p, ctx valid=%d)",
                  (void*)GL_GetRealModule(), (int)GL_CurrentContextIsValid());
        return;
    }

    /* ---- 2b. F10 cycles the diagnostic mode ------------------------- */
    if (hot.keyPressed[VK_F10])
    {
        g_Config.diagMode = (g_Config.diagMode + 1) % 3;
        Logf("DIAG MODE -> %d (%s)", g_Config.diagMode,
             g_Config.diagMode == 0 ? "off" :
             g_Config.diagMode == 1 ? "magenta marker quad" :
                                      "clear whole frame magenta");
    }

    if (hot.keyPressed[VK_F11])
    {
        g_Config.bOverlayUseBoundFBO = !g_Config.bOverlayUseBoundFBO;
        Logf("FBO STRATEGY -> %s", g_Config.bOverlayUseBoundFBO
             ? "draw into the emulator's bound framebuffer (ReShade style)"
             : "force window backbuffer (FBO 0)");
    }

    /* ---- 3. Window / sizes ------------------------------------------ */
    OverlayFrame f;
    if (!Overlay_Prepare(hdc, &f))
    {
        LogfEvery("noprep", 5000, "Overlay_Prepare() FAILED for hdc=%p", (void*)hdc);
        return;
    }
    Input_SetSensitivity(g_Config.fMouseSensitivity);
    Input_Attach(f.hwnd);
    Input_StartLowLevelHook();

    /* One line of facts per few seconds: which FBO/buffer/mask we are facing. */
    if (open) Overlay_LogDiagState();

    /* ---- 4. ImGui lifecycle ----------------------------------------- */
    if (!ImGuiW_IsInitialized())
    {
        if (!ImGuiW_Init(hdc))
        {
            Logf("ImGuiW_Init() FAILED");
            return;
        }
        ImGuiW_SetDisplayMetrics(f.clientW, f.clientH, f.scaleX, f.scaleY);
        Logf("ImGui initialised (display=%dx%d scale=%.2fx%.2f)",
             f.clientW, f.clientH, f.scaleX, f.scaleY);
    }
    if (f.newContext)
    {
        ImGuiW_OnContextLost();
        Logf("GL context changed (%p) - overlay textures reset", (void*)f.hglrc);
    }

    /* ---- 5. Draw ----------------------------------------------------- */
    InputFrame in;
    if (open) { Input_Collect(&in, 0); } else { memset(&in, 0, sizeof(in)); }

    ImGuiW_SetDisplayMetrics(f.clientW, f.clientH, f.scaleX, f.scaleY);

    Overlay_BeginDraw(&f);

    static const float magenta[4] = { 1.0f, 0.0f, 1.0f, 1.0f };
    if (g_Config.diagMode == 1)
    {
        /* 48x48 solid quad, top-left. Ignores shaders, textures and fonts. */
        Overlay_DrawMarker(0, 0, 48, magenta);
        Overlay_DrawMarker(48, 0, 12, magenta);
        Overlay_DrawMarker(0, 48, 12, magenta);
    }
    else if (g_Config.diagMode == 2)
    {
        /* Big opaque block. If this does not show up, our GL target is not the
         * surface that reaches the screen. */
        Overlay_DrawMarker(0, 0, 300, magenta);
    }

    if (open)
    {
        GUI_Render(&in, &f);

        int verts = 0, cmds = 0, lists = 0;
        float dw = 0.0f, dh = 0.0f;
        ImGuiW_GetStats(&verts, &cmds, &lists, &dw, &dh);
        if (verts <= 0)
            LogfEvery("emptyui", 1000,
                      "WARNING: menu open but ImGui produced 0 vertices "
                      "(display=%.0fx%.0f) - UI would be invisible", dw, dh);
        else
            LogfEvery("uiok", 3000, "UI drawn: %d verts, %d idx, %d lists, display=%.0fx%.0f",
                      verts, cmds, lists, dw, dh);
    }

    /* Did the driver actually accept our commands? (silent no-op detection) */
    if (glr.GetError)
    {
        GLenum e = glr.GetError();
        if (e != 0)
            LogfEvery("glerr", 1000, "GL error 0x%04X after overlay draw", (unsigned)e);
    }

    if (open)
    {
        float ui[4] = { 0, 0, 0, 0 };
        ImGuiW_GetCurrentWindowRect(ui);
        POINT cur = { 0, 0 };
        GetCursorPos(&cur);
        POINT cl = cur;
        ScreenToClient(f.hwnd, &cl);
        bool inside = (in.mouseX >= ui[0] && in.mouseX <= ui[0] + ui[2] &&
                       in.mouseY >= ui[1] && in.mouseY <= ui[1] + ui[3]);
        LogfEvery("mouse", 2000,
                  "MOUSE client=(%d,%d) screen=(%ld,%ld) L=%d | menu rect=(%.0f,%.0f %.0fx%.0f) "
                  "inside=%d wantCapture=%d",
                  in.mouseX, in.mouseY, (long)cur.x, (long)cur.y,
                  (int)in.mouseDown[0], ui[0], ui[1], ui[2], ui[3],
                  (int)inside, (int)ImGuiW_WantCaptureMouse());
    }

    Overlay_EndDraw();
}

/* ------------------------------------------------------------------------- */
/* Exported swap hooks                                                       */
/* ------------------------------------------------------------------------- */
__declspec(dllexport) BOOL WINAPI Hooked_wglSwapBuffers(HDC hdc)
{
    if (!g_initDone && !OpenGL_InitHooks())
        LogfEvery("noinit", 2000, "OpenGL_InitHooks() FAILED - real opengl32.dll not loaded");

    if (!g_origSwap)
    {
        LogfEvery("nooswap", 2000, "no genuine wglSwapBuffers - cannot present");
        return FALSE;
    }

    if (t_inSwap > 0)                       /* nested: present, never redraw */
        return g_origSwap(hdc);

    t_inSwap++;
    if (t_inSwap == 1) IATHook_InstallAll();
    HandlePresent(hdc, "wglSwapBuffers");
    BOOL r = g_origSwap(hdc);
    t_inSwap--;

    return r;
}

__declspec(dllexport) BOOL WINAPI Hooked_wglSwapLayerBuffers(HDC hdc, UINT fuPlanes)
{
    /* Same rule ReShade uses (decompiled 0x15fa60): the main plane swap must
     * go through the hook, otherwise the UI never appears on emulators that
     * present via wglSwapLayerBuffers. */
    if (fuPlanes == WGL_SWAP_MAIN_PLANE)
    {
        /* Nested layer swap inside our own draw: just forward. */
        if (t_inSwap > 0)
            return g_origSwap ? g_origSwap(hdc) : FALSE;
        return Hooked_wglSwapBuffers(hdc);
    }

    if (!g_origSwapLayers && !OpenGL_InitHooks()) return FALSE;
    if (g_origSwapLayers) return g_origSwapLayers(hdc, fuPlanes);
    return FALSE;
}

/* ---- present-path coverage: gdi32!SwapBuffers ------------------------- */
typedef BOOL (WINAPI *PFN_GdiSwapBuffers)(HDC);

static PFN_GdiSwapBuffers g_origGdiSwap = NULL;

BOOL WINAPI Proxy_SwapBuffers(HDC hdc)
{
    if (!g_origGdiSwap)
    {
        /* Not installed through the thunk hook (e.g. gdi32 exports are
         * forwarded differently) - resolve normally. */
        HMODULE g = GetModuleHandleW(L"gdi32.dll");
        if (!g) g = LoadLibraryW(L"gdi32.dll");
        if (g) g_origGdiSwap = (PFN_GdiSwapBuffers)(void*)GetProcAddress(g, "SwapBuffers");
        Logf("gdi32!SwapBuffers entered (chain=%p)", (void*)g_origGdiSwap);
    }

    /* The genuine wglSwapBuffers ends up calling gdi32!SwapBuffers internally.
     * If we are already inside our own swap handling, this is the INNER call of
     * the driver's present: drawing here would inject our shader/projection
     * state into the middle of the emulator's frame (that is what turned the
     * scene into scattered wireframe). Pass straight through. */
    if (t_inSwap > 0)
        return g_origGdiSwap ? g_origGdiSwap(hdc) : FALSE;

    HandlePresent(hdc, "gdi32!SwapBuffers");

    return g_origGdiSwap ? g_origGdiSwap(hdc) : FALSE;
}

/* Called by OpenGL_InitHooks() after a successful thunk install. */
void Proxy_SetGdiOriginal(void* p) { g_origGdiSwap = (PFN_GdiSwapBuffers)p; }

BOOL WINAPI Proxy_wglSwapBuffers(HDC hdc)
{
    return Hooked_wglSwapBuffers(hdc);
}

BOOL WINAPI Proxy_wglSwapLayerBuffers(HDC hdc, UINT fuPlanes)
{
    return Hooked_wglSwapLayerBuffers(hdc, fuPlanes);
}

/* ------------------------------------------------------------------------- */
/* Hooked_wglGetProcAddress: close the last bypass                            */
/* ------------------------------------------------------------------------- */
/* The original DLL intercepts here too (decompiled 0x15fe00+, a strcmp chain
 * that returns its own hook for "glViewport", "glBindFramebuffer", ...).
 * Without this, an emulator that resolves the present/extension entry points
 * through wglGetProcAddress would silently talk to the raw driver and never
 * reach our overlay - "DLL loaded, menu never appears". */
static PROC (WINAPI *g_realWGPA)(LPCSTR) = NULL;

__declspec(dllexport) PROC WINAPI Hooked_wglGetProcAddress(LPCSTR lpszProc)
{
    if (!g_initDone && !OpenGL_InitHooks()) return NULL;
    if (!g_realWGPA)
        g_realWGPA = (PROC (WINAPI *)(LPCSTR))(void*)GetProcAddress(g_hReal, "wglGetProcAddress");

    if (lpszProc)
    {
        if (!lstrcmpiA(lpszProc, "wglSwapBuffers"))
            return (PROC)(void*)&Hooked_wglSwapBuffers;
        if (!lstrcmpiA(lpszProc, "wglSwapLayerBuffers"))
            return (PROC)(void*)&Hooked_wglSwapLayerBuffers;
        if (!lstrcmpiA(lpszProc, "glDrawElements"))
            return (PROC)(void*)&Hooked_glDrawElements;
    }
    return g_realWGPA ? g_realWGPA(lpszProc) : NULL;
}

/* ------------------------------------------------------------------------- */
/* Chams: glDrawElements with STRICT state save/restore                      */
/* ------------------------------------------------------------------------- */
typedef struct ChamsState {
    GLint   depthFunc, depthMask;
    GLint   blend, cull, polyOffsetFill, polyOffsetLine;
    GLint   polyModeF, polyModeB;
    GLfloat lineWidth, color[4], poFactor, poUnits;
    GLint   blendSrc, blendDst;
} ChamsState;

static void Chams_Save(ChamsState* s)
{
    memset(s, 0, sizeof(*s));
    glr.GetIntegerv(GL_DEPTH_FUNC, &s->depthFunc);
    glr.GetIntegerv(GL_DEPTH_WRITEMASK, &s->depthMask);
    glr.GetIntegerv(GL_BLEND, &s->blend);
    glr.GetIntegerv(GL_CULL_FACE, &s->cull);
    glr.GetIntegerv(GL_POLYGON_OFFSET_FILL, &s->polyOffsetFill);
    glr.GetIntegerv(GL_POLYGON_OFFSET_LINE, &s->polyOffsetLine);
    glr.GetIntegerv(GL_BLEND_SRC, &s->blendSrc);
    glr.GetIntegerv(GL_BLEND_DST, &s->blendDst);
    GLint pm[2] = { GL_FILL, GL_FILL };
    glr.GetIntegerv(GL_POLYGON_MODE, pm);
    s->polyModeF = pm[0];
    s->polyModeB = pm[1];
    glr.GetFloatv(GL_LINE_WIDTH, &s->lineWidth);
    glr.GetFloatv(GL_CURRENT_COLOR, s->color);
    glr.GetFloatv(GL_POLYGON_OFFSET_FACTOR, &s->poFactor);
    glr.GetFloatv(GL_POLYGON_OFFSET_UNITS, &s->poUnits);
}

static void Chams_Restore(const ChamsState* s)
{
    glr.DepthFunc((GLenum)s->depthFunc);
    glr.DepthMask((GLboolean)(s->depthMask ? GL_TRUE : GL_FALSE));
    glr.BlendFunc((GLenum)s->blendSrc, (GLenum)s->blendDst);
    glr.CullFace(GL_BACK);
    glr.PolygonMode(GL_FRONT, (GLenum)s->polyModeF);
    glr.PolygonMode(GL_BACK,  (GLenum)s->polyModeB);
    glr.LineWidth(s->lineWidth);
    glr.PolygonOffset(s->poFactor, s->poUnits);
    glr.Color4f(s->color[0], s->color[1], s->color[2], s->color[3]);
    if (s->polyOffsetFill) glr.Enable(GL_POLYGON_OFFSET_FILL); else glr.Disable(GL_POLYGON_OFFSET_FILL);
    if (s->polyOffsetLine) glr.Enable(GL_POLYGON_OFFSET_LINE); else glr.Disable(GL_POLYGON_OFFSET_LINE);
    if (s->blend)          glr.Enable(GL_BLEND);               else glr.Disable(GL_BLEND);
    if (s->cull)           glr.Enable(GL_CULL_FACE);           else glr.Disable(GL_CULL_FACE);
}

__declspec(dllexport) void WINAPI Hooked_glDrawElements(unsigned int mode, int count,
                                                        unsigned int type, const void* indices)
{
    if (!g_initDone && !OpenGL_InitHooks()) return;
    if (!glr.ready && !GL_LoadRealApi()) return;
    if (!glr.DrawElements) return;

    /* Never let our own UI triangles run through the wallhack path. */
    if (Overlay_IsDrawing())
    {
        glr.DrawElements(mode, count, type, indices);
        return;
    }

    /* The game's own draw, untouched. The blend/depth state may have changed,
     * so the cached save is no longer trustworthy. */
    Overlay_InvalidateSavedState();
    glr.DrawElements(mode, count, type, indices);

    if (mode != GL_TRIANGLES || count < 1000) return;
    if (!g_Config.bVisibilityChams && !g_Config.bWireframeChams && !g_Config.bBaseChams)
        return;
    if (!glr.GetUniformLocation) return;

    GLint prog = 0;
    glr.GetIntegerv(GL_CURRENT_PROGRAM, &prog);
    if (prog == 0) return;
    if (glr.GetUniformLocation((GLuint)prog, "_CharaLightIntensity") == -1) return;

    ChamsState st;
    Chams_Save(&st);

    if (g_Config.bVisibilityChams)
    {
        glr.Enable(GL_BLEND);
        glr.Enable(GL_DEPTH_TEST);
        glr.DepthFunc(GL_GREATER);   /* only pixels hidden BEHIND geometry */
        glr.DepthMask(GL_FALSE);     /* never disturb the wall's depth      */

        if (g_Config.bBehindWallHighlight)
        {
            glr.PolygonMode(GL_FRONT_AND_BACK, GL_FILL);
            glr.BlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
            glr.Color4f(g_Config.colBehindHighlight[0], g_Config.colBehindHighlight[1],
                        g_Config.colBehindHighlight[2], g_Config.colBehindHighlight[3]);
            glr.DrawElements(mode, count, type, indices);
        }

        if (g_Config.bBehindWallStroke)
        {
            float a = g_Config.colBehindStroke[3] * g_Config.fGlowIntensity;
            if (a > 1.0f) a = 1.0f;

            glr.LineWidth(g_Config.fStrokeSize);
            glr.PolygonMode(GL_FRONT_AND_BACK, GL_LINE);

            switch (g_Config.glowMode)
            {
            case GLOW_OUTER:
                glr.Enable(GL_POLYGON_OFFSET_FILL);
                glr.PolygonOffset(-2.0f * g_Config.fStrokeSize, -2.0f * g_Config.fStrokeSize);
                glr.BlendFunc(GL_SRC_ALPHA, GL_ONE);
                break;
            case GLOW_INNER:
                glr.Enable(GL_POLYGON_OFFSET_FILL);
                glr.PolygonOffset(1.5f * g_Config.fStrokeSize, 1.5f * g_Config.fStrokeSize);
                glr.BlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                break;
            case GLOW_CENTER:
            default:
                glr.PolygonOffset(0.0f, 0.0f);
                glr.BlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                break;
            }

            glr.Color4f(g_Config.colBehindStroke[0], g_Config.colBehindStroke[1],
                        g_Config.colBehindStroke[2], a);
            glr.DrawElements(mode, count, type, indices);
        }

        glr.DepthFunc(GL_LEQUAL);
        glr.DepthMask(GL_TRUE);

        if (g_Config.bVisibleColorOverride)
        {
            glr.Color4f(g_Config.colVisible[0], g_Config.colVisible[1],
                        g_Config.colVisible[2], g_Config.colVisible[3]);
            glr.DrawElements(mode, count, type, indices);
        }
    }
    else if (g_Config.bWireframeChams)
    {
        glr.Disable(GL_DEPTH_TEST);
        glr.Enable(GL_BLEND);
        glr.PolygonMode(GL_FRONT_AND_BACK, GL_LINE);
        glr.Color4f(g_Config.colWireframe[0], g_Config.colWireframe[1], g_Config.colWireframe[2], 1.0f);
        glr.DrawElements(mode, count, type, indices);
        glr.Enable(GL_DEPTH_TEST);
    }
    else if (g_Config.bBaseChams)
    {
        glr.Disable(GL_DEPTH_TEST);
        glr.Color4f(g_Config.colBase[0], g_Config.colBase[1], g_Config.colBase[2], 1.0f);
        glr.DrawElements(mode, count, type, indices);
        glr.Enable(GL_DEPTH_TEST);
    }

    /* Everything the passes above touched goes back to the game's values. */
    Chams_Restore(&st);
}
