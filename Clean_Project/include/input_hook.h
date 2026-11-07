/**
 * input_hook.h - Reliable INSERT / mouse input for an overlay inside BlueStacks
 *
 * [English] Why GetAsyncKeyState(vk) & 1 was the wrong tool:
 *   The low order bit means "was pressed since the *last call by anyone in
 *   this process*". BlueStacks/Qt polls GetAsyncKeyState constantly for its
 *   own hotkeys, and the emulator runs several GL threads - so by the time our
 *   overlay polls it, the flag has already been eaten. Result: Insert "works
 *   sometimes" or not at all. On top of that, if wglSwapBuffers is called by a
 *   second thread/context, a single physical press can be consumed twice.
 *
 *   This module does what the original ReShade build does (decompiled input
 *   poll at 0x50b60):
 *     - keeps its own 256 entry key-state table,
 *     - reads the HIGH bit of GetAsyncKeyState (real "is down", never eaten),
 *     - keeps the previous frame's table to detect the rising/falling edge,
 *     - additionally subclass the emulator window proc, so WM_KEYDOWN /
 *       WM_LBUTTONDOWN / WM_MOUSEMOVE are captured as *events*, exactly once,
 *       with true client coordinates (no GetCursorPos/screen mismatch).
 *
 * [සිංහල] GetAsyncKeyState(vk) & 1 යන low bit එක process එකේ ඕනෑම කෙනෙක්
 *         call කරාම clear වෙනවා. BlueStacks/Qt එක නිතරම poll කරන නිසා
 *         අපේ Insert press එක "කනවා". ඒ නිසා original DLL එක කරන විදියටම
 *         high bit (0x8000) + previous state එකෙන් edge detect කරනවා, අමතරව
 *         emulator window එකෙහි WndProc එක subclass කරලා real key events
 *         ලබාගන්නවා (client coordinates ඇතුව).
 */

#ifndef INPUT_HOOK_H
#define INPUT_HOOK_H

#include <windows.h>
#include <stdbool.h>

typedef struct InputFrame {
    int   mouseX, mouseY;        /* window client coordinates             */
    bool  mouseValid;            /* cursor is over our window             */
    float wheel;                 /* notches this frame                    */
    bool  mouseDown[3];          /* left, right, middle                   */
    bool  keyDown[256];          /* current state  (VK_*)                 */
    bool  keyPressed[256];       /* rising edge    (VK_*)                 */
    bool  keyReleased[256];      /* falling edge   (VK_*)                 */
    bool  focusLost;             /* window lost focus this frame          */
} InputFrame;

/* Subclass the emulator window. Safe to call every frame; it re-installs
 * itself if the emulator (Qt) restored its own WndProc. */
void Input_Attach(HWND hwnd);

/* Fill one frame worth of input. Call once per present, on the GL thread.
 * onlyVk != 0 => poll just that virtual key (cheap path used while the menu is
 * closed); onlyVk == 0 => full keyboard/mouse snapshot. */
void Input_Collect(InputFrame* out, int onlyVk);

/* True once we own the window's WndProc. */
bool Input_IsAttached(void);

/* While the menu is open the emulator's mouse clip has to be released,
 * otherwise the cursor stays locked to the game view. */
void Input_ReleaseCursorForUI(bool uiOpen);

/* Rectangle (client coords) of the menu window; clicks inside it are swallowed
 * so they never reach the emulator/game underneath. */
void Input_SetUiRect(float x, float y, float w, float h);

/* While true, WM_INPUT (raw mouse, used for the game camera) is suppressed. */
void Input_SetBlockGameInput(bool block);

/* Creates the dedicated thread that installs WH_MOUSE_LL (call from the first
 * present, not from DllMain). Idempotent. */
void Input_StartLowLevelHook(void);

/* True while the menu drives the pointer from raw deltas (game has grabbed the
 * cursor, so the OS cursor position is useless). */
bool Input_VirtualCursorActive(void);

/* Raw mouse counts are not always screen pixels (high-DPI / high-poll mice).
 * Tune until the virtual cursor tracks the physical one. */
void Input_SetSensitivity(float s);

#endif /* INPUT_HOOK_H */
