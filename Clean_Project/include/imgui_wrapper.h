/**
 * imgui_wrapper.h - C-callable wrapper for Dear ImGui (C++ library)
 *
 * [English] Since our project is pure C but ImGui is C++, this wrapper
 *           provides C-linkage functions that gui_overlay.c can call.
 *           Handles ImGui initialization, new frame, rendering, and all
 *           UI widget calls needed for the Chams settings menu.
 * [සිංහල] ImGui C++ library eka api C project eken call karanna
 *         C-linkage wrapper functions. gui_overlay.c eken me functions
 *         call karanawa.
 */

#ifndef IMGUI_WRAPPER_H
#define IMGUI_WRAPPER_H

#include <windows.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

// ============================================================================
// Lifecycle (ImGui engine init/shutdown)
// ============================================================================

// [English] Initialize ImGui context + OpenGL2 + Win32 backends.
//           Call once after OpenGL context is created.
// [සිංහල] ImGui context saha OpenGL2/Win32 backends init karanawa.
//         OpenGL context haduna passe ekama call krnna.
bool ImGuiW_Init(HDC hdc);

// [English] Shutdown ImGui and free all resources.
// [සිංහල] ImGui shutdown karala resources free karanawa.
void ImGuiW_Shutdown(void);

// [English] Returns true if ImGui has been initialized.
bool ImGuiW_IsInitialized(void);

// ============================================================================
// Frame (call each frame inside wglSwapBuffers)
// ============================================================================

// [English] Begin a new ImGui frame (call before any UI code).
void ImGuiW_NewFrame(void);

// [English] Render ImGui draw data to OpenGL (call after all UI code).
void ImGuiW_Render(void);

// ============================================================================
// Window & Tabs
// ============================================================================
bool ImGuiW_Begin(const char* name, bool* p_open);
void ImGuiW_End(void);
bool ImGuiW_BeginTabBar(const char* id);
void ImGuiW_EndTabBar(void);
bool ImGuiW_BeginTabItem(const char* label);
void ImGuiW_EndTabItem(void);
void ImGuiW_BeginChild(const char* id);
void ImGuiW_EndChild(void);

// ============================================================================
// Widgets
// ============================================================================
void ImGuiW_Text(const char* text);
void ImGuiW_TextDisabled(const char* text);
void ImGuiW_Separator(void);
bool ImGuiW_Checkbox(const char* label, bool* v);
bool ImGuiW_ColorEdit4(const char* label, float col[4]);
bool ImGuiW_SliderFloat(const char* label, float* v, float v_min, float v_max, const char* format);
bool ImGuiW_Combo(const char* label, int* current_item, const char* const items[], int items_count);
bool ImGuiW_Button(const char* label);
void ImGuiW_SetNextWindowSize(float w, float h);

#ifdef __cplusplus
}
#endif

#endif // IMGUI_WRAPPER_H
