/**
 * gui_overlay.h - In-game menu (EXT X CHEATS)
 *
 * [English] GUI_Render() now receives the frame's real metrics and the input
 *           snapshot, so it can never draw with a stale size and never poll
 *           keys itself.
 */

#ifndef GUI_OVERLAY_H
#define GUI_OVERLAY_H

#include <windows.h>
#include <stdbool.h>
#include "../include/input_hook.h"
#include "../include/overlay_state.h"

extern bool g_bMenuOpen;

void GUI_InitTheme(void);

/* Process only the menu hotkey. Returns true when the menu is open, i.e.
 * when GUI_Render() must be called this frame. */
bool GUI_HandleHotkeys(const InputFrame* in);

/* Build + submit the UI for this present (only when the menu is open). */
void GUI_Render(const InputFrame* in, const OverlayFrame* f);

#endif /* GUI_OVERLAY_H */
