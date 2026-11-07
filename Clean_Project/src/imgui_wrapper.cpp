/**
 * imgui_wrapper.cpp - ImGui wrapper WITHOUT ImGui_ImplWin32
 *
 * [English] BlueStacks uses an offscreen GL context. WindowFromDC() returns
 *           a hidden window with zero ClientRect → ImGui DisplaySize = 0 → nothing renders.
 *           Fix: Use ImGui_ImplOpenGL2 for rendering ONLY.
 *           Manually set DisplaySize from GL viewport, manually handle mouse/keyboard.
 *           This is the standard approach for DLL injection overlays.
 * [සිංහල] BlueStacks offscreen context use karana nisa WindowFromDC() zero-size window
 *         denawa. DisplaySize=0 nisa ImGui kisi deyak render karanawa na.
 *         Fix: ImGui_ImplWin32 nadda - GL viewport eken size gana, manual input.
 */

#include "../imgui/imgui.h"
#include "../imgui/imgui_impl_opengl2.h"

// Pull in gl.h types for glGetIntegerv
#include <windows.h>
#include <GL/gl.h>

#include "../include/imgui_wrapper.h"

// ============================================================================
// State
// ============================================================================
static bool   s_initialized = false;
static LARGE_INTEGER s_freq  = {};
static LARGE_INTEGER s_last  = {};

// ============================================================================
// ImGuiW_Init
// [English] Initialize ImGui + OpenGL2 backend only. No Win32 backend.
//           Display size and input are handled manually each frame.
// ============================================================================
extern "C" bool ImGuiW_Init(HDC hdc)
{
    (void)hdc; // Not needed anymore

    if (s_initialized)
        return true;

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();

    ImGuiIO& io = ImGui::GetIO();
    io.IniFilename = NULL;          // No .ini file
    io.LogFilename = NULL;          // No log file
    io.MouseDrawCursor = true;      // ImGui draws its own cursor over game cursor

    // Dark purple theme (EXT X CHEATS style)
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

    // OpenGL2 backend for rendering
    ImGui_ImplOpenGL2_Init();

    // Timer for DeltaTime
    QueryPerformanceFrequency(&s_freq);
    QueryPerformanceCounter(&s_last);

    s_initialized = true;
    return true;
}

// ============================================================================
// ImGuiW_Shutdown
// ============================================================================
extern "C" void ImGuiW_Shutdown(void)
{
    if (!s_initialized)
        return;
    ImGui_ImplOpenGL2_Shutdown();
    ImGui::DestroyContext();
    s_initialized = false;
}

extern "C" bool ImGuiW_IsInitialized(void)
{
    return s_initialized;
}

// ============================================================================
// ImGuiW_NewFrame
// [English] Manually set DisplaySize from GL viewport + handle mouse/keyboard.
//           This avoids all HWND/Win32 backend issues with offscreen contexts.
// [සිංහල] GL viewport eken DisplaySize gana. Mouse/keyboard manually handle.
//         HWND zero-size problem naha!
// ============================================================================
extern "C" void ImGuiW_NewFrame(void)
{
    ImGuiIO& io = ImGui::GetIO();

    // --- Display size from GL viewport ---
    GLint viewport[4] = {};
    glGetIntegerv(GL_VIEWPORT, viewport);
    float vpX = (float)viewport[0];
    float vpY = (float)viewport[1];
    float vpW = (float)viewport[2];
    float vpH = (float)viewport[3];

    if (vpW <= 0.0f || vpH <= 0.0f)
    {
        vpW = (float)GetSystemMetrics(SM_CXSCREEN);
        vpH = (float)GetSystemMetrics(SM_CYSCREEN);
        vpX = 0.0f; vpY = 0.0f;
    }
    io.DisplaySize = ImVec2(vpW, vpH);

    // --- Delta time ---
    LARGE_INTEGER now;
    QueryPerformanceCounter(&now);
    io.DeltaTime = (float)(now.QuadPart - s_last.QuadPart) / (float)s_freq.QuadPart;
    if (io.DeltaTime <= 0.0f) io.DeltaTime = 0.00001f;
    s_last = now;

    // --- Mouse: screen coords → viewport-relative coords ---
    POINT pt;
    GetCursorPos(&pt);
    // Subtract viewport origin so mouse maps correctly inside the game viewport
    io.MousePos = ImVec2((float)pt.x - vpX, (float)pt.y - vpY);

    // --- Mouse buttons ---
    io.MouseDown[0] = (GetAsyncKeyState(VK_LBUTTON) & 0x8000) != 0;
    io.MouseDown[1] = (GetAsyncKeyState(VK_RBUTTON) & 0x8000) != 0;
    io.MouseDown[2] = (GetAsyncKeyState(VK_MBUTTON) & 0x8000) != 0;

    // =====================================================================
    // CRITICAL: Reset GL state before ImGui renders
    // [English] Chams rendering leaves glPolygonMode=GL_LINE, glDepthMask=0 etc.
    //           If ImGui renders with GL_LINE polygon mode → wireframe → NO TEXT!
    //           Explicitly reset to safe defaults before every ImGui frame.
    // [සිංහල] Chams rendering GL state dirty karala tiyenawa (GL_LINE, GL_GREATER).
    //         ImGui GL_LINE moden render una natuwa text pennenawa naa!
    //         Explicitly reset karanawa.
    // =====================================================================
    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL); // Wireframe OFF → solid fill
    glDisable(GL_DEPTH_TEST);                  // No depth test for 2D overlay
    glDepthMask(GL_TRUE);                      // Re-enable depth writes
    glDisable(GL_CULL_FACE);                   // No face culling for UI
    glEnable(GL_BLEND);                        // Alpha blending ON for UI
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glDisable(GL_SCISSOR_TEST);                // Clear any leftover scissor

    ImGui_ImplOpenGL2_NewFrame();
    ImGui::NewFrame();
}

// ============================================================================
// ImGuiW_Render
// ============================================================================
extern "C" void ImGuiW_Render(void)
{
    ImGui::Render();
    ImGui_ImplOpenGL2_RenderDrawData(ImGui::GetDrawData());
}

// ============================================================================
// Window & Tabs
// ============================================================================
extern "C" bool ImGuiW_Begin(const char* name, bool* p_open)
{
    return ImGui::Begin(name, p_open, ImGuiWindowFlags_NoCollapse);
}

extern "C" void ImGuiW_End(void)
{
    ImGui::End();
}

extern "C" bool ImGuiW_BeginTabBar(const char* id)
{
    return ImGui::BeginTabBar(id, 0);
}

extern "C" void ImGuiW_EndTabBar(void)
{
    ImGui::EndTabBar();
}

extern "C" bool ImGuiW_BeginTabItem(const char* label)
{
    return ImGui::BeginTabItem(label);
}

extern "C" void ImGuiW_EndTabItem(void)
{
    ImGui::EndTabItem();
}

extern "C" void ImGuiW_BeginChild(const char* id)
{
    ImGui::BeginChild(id, ImVec2(0, 0), ImGuiChildFlags_Borders);
}

extern "C" void ImGuiW_EndChild(void)
{
    ImGui::EndChild();
}

// ============================================================================
// Widgets
// ============================================================================
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

extern "C" void ImGuiW_SetNextWindowSize(float w, float h)
{
    ImGui::SetNextWindowSize(ImVec2(w, h), ImGuiCond_FirstUseEver);
}
