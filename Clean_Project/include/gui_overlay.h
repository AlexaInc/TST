/**
 * gui_overlay.h - Dear ImGui In-Game Menu Interface
 * 
 * [English] Declarations for rendering the custom in-game overlay menu (EXT X CHEATS).
 * [සිංහල] In-game Cheat Menu එක (Tabs: Legit, Chams, Infomation) render කරන functions.
 */

#ifndef GUI_OVERLAY_H
#define GUI_OVERLAY_H

#include <windows.h>
#include <stdbool.h>

// [English] Flag indicating whether the in-game menu is currently open/visible
// [සිංහල] Menu එක දැනට screen එකේ open වී ඇත්දැයි පෙන්වන flag එක (Insert / Home key)
extern bool g_bMenuOpen;

// [English] Initializes the ImGui style, dark/purple custom theme
// [සිංහල] Menu එකේ dark/purple theme එක සහ UI styles සකස් කිරීම
void GUI_InitTheme(void);

// [English] Main render entry point called inside wglSwapBuffers
// [සිංහල] wglSwapBuffers ඇතුළතදී Menu එක සහ HUD එක අඳින ප්‍රධාන function එක
void GUI_Render(void);

#endif // GUI_OVERLAY_H
