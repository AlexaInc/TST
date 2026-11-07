/**
 * imgui_wrapper.cpp - Dear ImGui wrapper (OpenGL2 renderer, manual platform)
 *
 * [English] Deliberately does NOT use ImGui_ImplWin32: BlueStacks presents
 *           through an offscreen/hidden window, so WindowFromDC() based sizing
 *           is unreliable. Instead:
 *             - sizes are pushed in from overlay_state.c (client rect +
 *               framebuffer scale), and
 *             - input is pushed in from input_hook.c as proper events.
 *
 *           ImGuiW_NewFrame() no longer touches GL state - that all lives in
 *           Overlay_BeginDraw()/Overlay_EndDraw(), which SAVE and RESTORE it.
 */

#include "../imgui/imgui.h"
#include "../imgui/imgui_impl_opengl3.h"

#include <windows.h>
#include <GL/gl.h>
#include <float.h>

#include "../include/imgui_wrapper.h"
#include "../include/input_hook.h"
#include "../include/gl_real.h"

/* ========================================================================= */
/* State                                                                     */
/* ========================================================================= */
static bool          s_initialized = false;
static LARGE_INTEGER s_freq;
static LARGE_INTEGER s_last;
static bool          s_haveMetrics = false;
static int           s_displayW = 0, s_displayH = 0;
static float         s_scaleX = 1.0f, s_scaleY = 1.0f;
static bool          s_prevMouseValid = false;
static const char*   g_glslVersion = "#version 150";
/* Menu rectangle, captured while the window is current. Reading GetWindowPos()
 * after ImGui::End() dereferences a NULL g.CurrentWindow (that crashed
 * HD-Player.exe with "referenced memory at 0x...026"), so we snapshot it here
 * and never touch ImGui state from outside Begin/End again. */
static float         s_lastWinRect[4] = { 0.0f, 0.0f, 0.0f, 0.0f };

/* ========================================================================= */
/* Key translation: Windows VK -> ImGuiKey                                   */
/* ========================================================================= */
static ImGuiKey VkToImGuiKey(int vk)
{
    if (vk >= 'A' && vk <= 'Z')          return (ImGuiKey)(ImGuiKey_A + (vk - 'A'));
    if (vk >= '0' && vk <= '9')          return (ImGuiKey)(ImGuiKey_0 + (vk - '0'));
    if (vk >= VK_F1 && vk <= VK_F12)     return (ImGuiKey)(ImGuiKey_F1 + (vk - VK_F1));
    if (vk >= VK_NUMPAD0 && vk <= VK_NUMPAD9)
        return (ImGuiKey)(ImGuiKey_Keypad0 + (vk - VK_NUMPAD0));

    switch (vk)
    {
    case VK_TAB:        return ImGuiKey_Tab;
    case VK_LEFT:       return ImGuiKey_LeftArrow;
    case VK_RIGHT:      return ImGuiKey_RightArrow;
    case VK_UP:         return ImGuiKey_UpArrow;
    case VK_DOWN:       return ImGuiKey_DownArrow;
    case VK_PRIOR:      return ImGuiKey_PageUp;
    case VK_NEXT:       return ImGuiKey_PageDown;
    case VK_HOME:       return ImGuiKey_Home;
    case VK_END:        return ImGuiKey_End;
    case VK_INSERT:     return ImGuiKey_Insert;
    case VK_DELETE:     return ImGuiKey_Delete;
    case VK_BACK:       return ImGuiKey_Backspace;
    case VK_SPACE:      return ImGuiKey_Space;
    case VK_RETURN:     return ImGuiKey_Enter;
    case VK_ESCAPE:     return ImGuiKey_Escape;
    case VK_OEM_PLUS:   return ImGuiKey_Equal;
    case VK_OEM_MINUS:  return ImGuiKey_Minus;
    case VK_OEM_COMMA:  return ImGuiKey_Comma;
    case VK_OEM_PERIOD: return ImGuiKey_Period;
    case VK_SHIFT:      return ImGuiKey_LeftShift;
    case VK_LSHIFT:     return ImGuiKey_LeftShift;
    case VK_RSHIFT:     return ImGuiKey_RightShift;
    case VK_CONTROL:    return ImGuiKey_LeftCtrl;
    case VK_LCONTROL:   return ImGuiKey_LeftCtrl;
    case VK_RCONTROL:   return ImGuiKey_RightCtrl;
    case VK_MENU:       return ImGuiKey_LeftAlt;
    case VK_LMENU:      return ImGuiKey_LeftAlt;
    case VK_RMENU:      return ImGuiKey_RightAlt;
    default:            return ImGuiKey_None;
    }
}

/* ========================================================================= */
/* Lifecycle                                                                 */
/* ========================================================================= */
extern "C" bool ImGuiW_Init(HDC hdc)
{
    (void)hdc;
    if (s_initialized) return true;

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();

    ImGuiIO& io = ImGui::GetIO();
    io.IniFilename = NULL;
    io.LogFilename = NULL;
    io.MouseDrawCursor = true;
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;
    io.BackendPlatformName = "BS-manual";

    ImGui::StyleColorsDark();
    ImGuiStyle& style = ImGui::GetStyle();
    style.WindowRounding  = 6.0f;
    style.FrameRounding   = 4.0f;
    style.GrabRounding    = 3.0f;
    style.TabRounding     = 4.0f;
    style.Colors[ImGuiCol_WindowBg]         = ImVec4(0.08f, 0.08f, 0.10f, 0.95f);
    style.Colors[ImGuiCol_Header]           = ImVec4(0.35f, 0.15f, 0.55f, 1.00f);
    style.Colors[ImGuiCol_HeaderHovered]    = ImVec4(0.45f, 0.20f, 0.65f, 1.00f);
    style.Colors[ImGuiCol_HeaderActive]     = ImVec4(0.50f, 0.25f, 0.70f, 1.00f);
    style.Colors[ImGuiCol_Button]           = ImVec4(0.25f, 0.10f, 0.40f, 1.00f);
    style.Colors[ImGuiCol_ButtonHovered]    = ImVec4(0.35f, 0.15f, 0.55f, 1.00f);
    style.Colors[ImGuiCol_ButtonActive]     = ImVec4(0.45f, 0.20f, 0.65f, 1.00f);
    style.Colors[ImGuiCol_Tab]              = ImVec4(0.20f, 0.10f, 0.35f, 1.00f);
    style.Colors[ImGuiCol_TabSelected]      = ImVec4(0.35f, 0.15f, 0.55f, 1.00f);
    style.Colors[ImGuiCol_TabHovered]       = ImVec4(0.45f, 0.20f, 0.65f, 1.00f);
    style.Colors[ImGuiCol_FrameBg]          = ImVec4(0.15f, 0.10f, 0.20f, 1.00f);
    style.Colors[ImGuiCol_CheckMark]        = ImVec4(0.80f, 0.40f, 1.00f, 1.00f);
    style.Colors[ImGuiCol_SliderGrab]       = ImVec4(0.60f, 0.30f, 0.85f, 1.00f);
    style.Colors[ImGuiCol_SliderGrabActive] = ImVec4(0.80f, 0.40f, 1.00f, 1.00f);

    /* ---- renderer backend: OpenGL3 (shaders + VAO/VBO) ------------------
     * BlueStacks' Qt RHI creates an OpenGL **4.5 core profile** context. In a
     * core profile the whole fixed-function pipeline that imgui_impl_opengl2
     * uses (glBegin / glVertexPointer / glEnableClientState / GL_LIGHTING /
     * glTexEnvi) does not exist: every draw is rejected and the driver reports
     * GL_INVALID_ENUM (0x0500) - which is exactly what the log showed while
     * still reporting thousands of vertices. A shader-based renderer works in
     * both core and compatibility profiles, so we always use it. */
    {
        GLint major = 0, minor = 0;
        if (glr.GetIntegerv)
        {
            glr.GetIntegerv(0x821B /*GL_MAJOR_VERSION*/, &major);
            glr.GetIntegerv(0x821C /*GL_MINOR_VERSION*/, &minor);
        }
        const char* glsl = (major > 3 || (major == 3 && minor >= 2))
                           ? "#version 150" : "#version 130";
        ImGui_ImplOpenGL3_Init(glsl);
        g_glslVersion = glsl;
    }

    QueryPerformanceFrequency(&s_freq);
    QueryPerformanceCounter(&s_last);

    s_initialized = true;
    return true;
}

extern "C" void ImGuiW_Shutdown(void)
{
    if (!s_initialized) return;
    ImGui_ImplOpenGL3_Shutdown();
    ImGui::DestroyContext();
    s_initialized = false;
    s_haveMetrics = false;
}

extern "C" bool ImGuiW_IsInitialized(void) { return s_initialized; }

extern "C" void ImGuiW_OnContextLost(void)
{
    if (!s_initialized) return;

    /* The emulator recreated its GL context (or lost it on a device reset):
     * shaders, VAO, VBO and the font atlas are all dead. Drop the device
     * objects (the backend recreates them on the next RenderDrawData) and ask
     * for a fresh texture upload. */
    ImGui_ImplOpenGL3_DestroyDeviceObjects();
    ImGuiPlatformIO& pio = ImGui::GetPlatformIO();
    for (ImTextureData* tex : pio.Textures)
    {
        if (!tex) continue;
        tex->BackendUserData = NULL;
        tex->SetTexID(ImTextureID_Invalid);
        tex->SetStatus(ImTextureStatus_WantCreate);
    }
}

/* ========================================================================= */
/* Metrics + input                                                           */
/* ========================================================================= */
extern "C" void ImGuiW_SetDisplayMetrics(int displayW, int displayH,
                                         float framebufferScaleX, float framebufferScaleY)
{
    if (displayW < 1) displayW = 1;
    if (displayH < 1) displayH = 1;

    /* ImGui likes integers for the display size; keep the scale normalised so
     * that display * scale lands exactly on the framebuffer size. */
    s_displayW = displayW;
    s_displayH = displayH;
    s_scaleX   = framebufferScaleX > 0.0f ? framebufferScaleX : 1.0f;
    s_scaleY   = framebufferScaleY > 0.0f ? framebufferScaleY : 1.0f;
    s_haveMetrics = true;
}

extern "C" void ImGuiW_FeedInput(const InputFrame* in)
{
    if (!s_initialized || !in) return;
    ImGuiIO& io = ImGui::GetIO();

    /* ---- keyboard: queue real events, no direct io.KeyCtrl poking ---- */
    for (int vk = 8; vk < 256; vk++)
    {
        if (!in->keyPressed[vk] && !in->keyReleased[vk]) continue;
        ImGuiKey k = VkToImGuiKey(vk);
        if (k == ImGuiKey_None) continue;
        io.AddKeyEvent(k, in->keyPressed[vk] ? true : false);
    }
    /* Modifier mirror for sliders/combos */
    io.AddKeyEvent(ImGuiMod_Ctrl,  in->keyDown[VK_CONTROL] || in->keyDown[VK_LCONTROL] || in->keyDown[VK_RCONTROL]);
    io.AddKeyEvent(ImGuiMod_Shift, in->keyDown[VK_SHIFT]   || in->keyDown[VK_LSHIFT]   || in->keyDown[VK_RSHIFT]);
    io.AddKeyEvent(ImGuiMod_Alt,   in->keyDown[VK_MENU]    || in->keyDown[VK_LMENU]    || in->keyDown[VK_RMENU]);

    /* ---- mouse in CLIENT coordinates (was screen coords -> dead UI) ---- */
    if (in->mouseValid)
    {
        io.AddMousePosEvent((float)in->mouseX, (float)in->mouseY);
        s_prevMouseValid = true;
    }
    else if (s_prevMouseValid)
    {
        io.AddMousePosEvent(-FLT_MAX, -FLT_MAX);   /* outside: do not hover */
        s_prevMouseValid = false;
    }

    io.AddMouseButtonEvent(0, in->mouseDown[0]);
    io.AddMouseButtonEvent(1, in->mouseDown[1]);
    io.AddMouseButtonEvent(2, in->mouseDown[2]);

    if (in->wheel != 0.0f)
        io.AddMouseWheelEvent(0.0f, in->wheel);
}

extern "C" void ImGuiW_NewFrame(void)
{
    if (!s_initialized) return;
    ImGuiIO& io = ImGui::GetIO();

    if (s_haveMetrics)
    {
        io.DisplaySize             = ImVec2((float)s_displayW, (float)s_displayH);
        io.DisplayFramebufferScale = ImVec2(s_scaleX, s_scaleY);
    }

    LARGE_INTEGER now;
    QueryPerformanceCounter(&now);
    io.DeltaTime = (float)(now.QuadPart - s_last.QuadPart) / (float)s_freq.QuadPart;
    if (io.DeltaTime <= 0.0f || io.DeltaTime > 1.0f) io.DeltaTime = 1.0f / 60.0f;
    s_last = now;

    ImGui_ImplOpenGL3_NewFrame();
    ImGui::NewFrame();
}

extern "C" void ImGuiW_Render(void)
{
    if (!s_initialized) return;
    ImGui::Render();
    ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
}

extern "C" bool ImGuiW_WantCaptureMouse(void)
{
    return s_initialized && ImGui::GetIO().WantCaptureMouse;
}

extern "C" void ImGuiW_GetCurrentWindowRect(float out[4])
{
    if (!out) return;
    /* Pure copy of the snapshot - safe to call at any time, inside or outside
     * a Begin/End pair. */
    out[0] = s_lastWinRect[0]; out[1] = s_lastWinRect[1];
    out[2] = s_lastWinRect[2]; out[3] = s_lastWinRect[3];
}

extern "C" void ImGuiW_GetStats(int* outVerts, int* outCmds, int* outLists,
                                float* outDisplayW, float* outDisplayH)
{
    int verts = 0, cmds = 0, lists = 0;
    float dw = 0.0f, dh = 0.0f;
    if (s_initialized)
    {
        ImDrawData* dd = ImGui::GetDrawData();
        if (dd)
        {
            verts = dd->TotalVtxCount;
            cmds  = dd->TotalIdxCount;
            lists = dd->CmdListsCount;
            dw    = dd->DisplaySize.x;
            dh    = dd->DisplaySize.y;
        }
    }
    if (outVerts)    *outVerts = verts;
    if (outCmds)     *outCmds = cmds;
    if (outLists)    *outLists = lists;
    if (outDisplayW) *outDisplayW = dw;
    if (outDisplayH) *outDisplayH = dh;
}

/* ========================================================================= */
/* Window helpers + widgets                                                  */
/* ========================================================================= */
extern "C" void ImGuiW_SetNextWindowSize(float w, float h, bool firstUseOnly)
{
    ImGui::SetNextWindowSize(ImVec2(w, h),
                             firstUseOnly ? ImGuiCond_FirstUseEver : ImGuiCond_Always);
}

extern "C" void ImGuiW_SetNextWindowPos(float x, float y)
{
    ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_Always);
}

extern "C" bool ImGuiW_Begin(const char* name, bool* p_open)
{
    bool visible = ImGui::Begin(name, p_open, ImGuiWindowFlags_NoCollapse);
    /* Snapshot while g.CurrentWindow is guaranteed valid. */
    ImVec2 p  = ImGui::GetWindowPos();
    ImVec2 sz = ImGui::GetWindowSize();
    s_lastWinRect[0] = p.x;  s_lastWinRect[1] = p.y;
    s_lastWinRect[2] = sz.x; s_lastWinRect[3] = sz.y;
    return visible;
}

extern "C" void ImGuiW_End(void)                        { ImGui::End(); }
extern "C" bool ImGuiW_BeginTabBar(const char* id)      { return ImGui::BeginTabBar(id, 0); }
extern "C" void ImGuiW_EndTabBar(void)                  { ImGui::EndTabBar(); }
extern "C" bool ImGuiW_BeginTabItem(const char* label)  { return ImGui::BeginTabItem(label); }
extern "C" void ImGuiW_EndTabItem(void)                 { ImGui::EndTabItem(); }
extern "C" void ImGuiW_BeginChild(const char* id)       { ImGui::BeginChild(id, ImVec2(0, 0), ImGuiChildFlags_Borders); }
extern "C" void ImGuiW_EndChild(void)                   { ImGui::EndChild(); }

extern "C" void ImGuiW_Text(const char* text)         { ImGui::TextUnformatted(text); }
extern "C" void ImGuiW_TextDisabled(const char* text) { ImGui::TextDisabled("%s", text); }
extern "C" void ImGuiW_Separator(void)                { ImGui::Separator(); }

extern "C" bool ImGuiW_Checkbox(const char* label, bool* v)
{
    return ImGui::Checkbox(label, v);
}

extern "C" bool ImGuiW_ColorEdit4(const char* label, float col[4])
{
    return ImGui::ColorEdit4(label, col, ImGuiColorEditFlags_AlphaBar);
}

extern "C" bool ImGuiW_SliderFloat(const char* label, float* v, float v_min, float v_max, const char* format)
{
    return ImGui::SliderFloat(label, v, v_min, v_max, format);
}

extern "C" bool ImGuiW_Combo(const char* label, int* current_item, const char* const items[], int items_count)
{
    return ImGui::Combo(label, current_item, items, items_count);
}

extern "C" bool ImGuiW_Button(const char* label)
{
    return ImGui::Button(label);
}
