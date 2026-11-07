/**
 * imgui_wrapper.h - C-callable wrapper for Dear ImGui (C++ library)
 *
 * [English] Same idea as before (C project, C++ ImGui) but now:
 *   - DisplaySize / FramebufferScale come from the real window + backbuffer
 *     instead of a random glGetIntegerv(GL_VIEWPORT) sample,
 *   - input arrives through the ImGui event queue (AddKeyEvent /
 *     AddMousePosEvent / AddMouseButtonEvent / AddMouseWheelEvent) with true
 *     client-space coordinates,
 *   - the GL state dirtying that used to live in ImGuiW_NewFrame() moved into
 *     Overlay_BeginDraw()/Overlay_EndDraw() so it is actually restored.
 *
 * [සිංහල] DisplaySize/FramebufferScale දැන් හරි window එකෙන් ගන්නවා,
 *         input එක ImGui event queue එකෙන් (AddKeyEvent වගේ) යවනවා.
 *         GL state අටවන්නේ/restore කරන්නේ Overlay_* functions වලින්.
 */

#ifndef IMGUI_WRAPPER_H
#define IMGUI_WRAPPER_H

#include <windows.h>
#include <stdbool.h>
#include "../include/input_hook.h"

#ifdef __cplusplus
extern "C" {
#endif

/* ---- lifecycle ------------------------------------------------------- */
bool ImGuiW_Init(HDC hdc);
void ImGuiW_Shutdown(void);
bool ImGuiW_IsInitialized(void);

/* GL context was destroyed/re-created (emulator reset): the font atlas
 * texture handle is stale, ask the backend to re-upload it. */
void ImGuiW_OnContextLost(void);

/* ---- per-frame ------------------------------------------------------- */
/* Sizes must be set BEFORE NewFrame (this replaces the old magic that read
 * GL_VIEWPORT inside NewFrame). */
void ImGuiW_SetDisplayMetrics(int displayW, int displayH,
                              float framebufferScaleX, float framebufferScaleY);
void ImGuiW_FeedInput(const InputFrame* in);
void ImGuiW_NewFrame(void);
void ImGuiW_Render(void);

/* ---- window helpers -------------------------------------------------- */
void ImGuiW_SetNextWindowSize(float w, float h, bool firstUseOnly);
void ImGuiW_SetNextWindowPos(float x, float y);
bool ImGuiW_WantCaptureMouse(void);

/* Statistics of the LAST submitted frame. Lets the proxy log whether ImGui
 * actually produced geometry (0 vertices = nothing was drawn). */
void ImGuiW_GetStats(int* outVerts, int* outCmds, int* outLists, float* outDisplayW, float* outDisplayH);

/* Position/size of the window being built (call it between Begin() and End()). */
void ImGuiW_GetCurrentWindowRect(float out[4]);

/* ---- widgets (unchanged API) ----------------------------------------- */
bool ImGuiW_Begin(const char* name, bool* p_open);
void ImGuiW_End(void);
bool ImGuiW_BeginTabBar(const char* id);
void ImGuiW_EndTabBar(void);
bool ImGuiW_BeginTabItem(const char* label);
void ImGuiW_EndTabItem(void);
void ImGuiW_BeginChild(const char* id);
void ImGuiW_EndChild(void);

void ImGuiW_Text(const char* text);
void ImGuiW_TextDisabled(const char* text);
void ImGuiW_Separator(void);
bool ImGuiW_Checkbox(const char* label, bool* v);
bool ImGuiW_ColorEdit4(const char* label, float col[4]);
bool ImGuiW_SliderFloat(const char* label, float* v, float v_min, float v_max, const char* format);
bool ImGuiW_Combo(const char* label, int* current_item, const char* const items[], int items_count);
bool ImGuiW_Button(const char* label);

#ifdef __cplusplus
}
#endif

#endif /* IMGUI_WRAPPER_H */
