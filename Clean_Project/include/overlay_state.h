/**
 * overlay_state.h - Backbuffer tracking + full OpenGL state save/restore
 *
 * [English] This is the part the "original" (ReShade) DLL does inside its
 *           wglSwapBuffers hook and that the custom build was missing:
 *
 *   1) GetClientRect(WindowFromDC(hdc)) every present  -> if the size changed
 *      it resets the overlay runtime (see decompiled 0x15f600).
 *   2) ImGui DisplaySize  = window client size (logical units)
 *      ImGui FramebufferScale = framebuffer size / client size   (DPI safe)
 *   3) bind FBO 0, unset the game's shader program / VAO / array buffers,
 *      draw the UI, then put EVERY state value back exactly as it was.
 *
 * [සිංහල] Emulator window resize වෙද්දී backbuffer එකේ size එක හරියට
 *         track කරලා, ImGui DisplaySize/FramebufferScale හරියට set කරනවා.
 *         ඊට පස්සේ FBO 0 bind කරලා, game එකේ shader program/VAO අයින් කරලා
 *         UI එක අඳිනවා. අඳින්න කලින් GL state ඔක්කොම save කරලා,
 *         අඳිලා ඉවර වුණාම 100% restore කරනවා.
 */

#ifndef OVERLAY_STATE_H
#define OVERLAY_STATE_H

#include <windows.h>
#include <stdbool.h>

typedef struct OverlayFrame {
    HWND  hwnd;         /* top-level emulator window                     */
    HDC   hdc;          /* device context used by the game               */
    HGLRC hglrc;        /* GL context (to detect context re-creation)    */

    int   clientW;      /* logical size  -> ImGui DisplaySize            */
    int   clientH;
    int   fbW;          /* framebuffer size -> glViewport(0,0,fbW,fbH)   */
    int   fbH;
    float scaleX;       /* framebuffer / logical -> FramebufferScale     */
    float scaleY;

    bool  firstFrame;   /* first present we ever saw                     */
    bool  resized;      /* client or framebuffer size changed            */
    bool  newWindow;    /* different HWND than the previous frame        */
    bool  newContext;   /* different HGLRC -> GL objects are all gone    */
    bool  valid;        /* false => do not draw this frame               */
} OverlayFrame;

/* Inspect the current present. Returns f->valid. */
bool Overlay_Prepare(HDC hdc, OverlayFrame* f);

/* Save GL state, neutralise it for ImGui, bind the default framebuffer. */
void Overlay_BeginDraw(const OverlayFrame* f);

/* Restore everything Overlay_BeginDraw touched. */
void Overlay_EndDraw(void);

/* True while the overlay is inside BeginDraw..EndDraw (used by the chams hook
 * so our own draw calls are never re-processed by the wallhack code). */
bool Overlay_IsDrawing(void);

/* Last known window (for the input hook). May be NULL. */
HWND Overlay_GetWindow(void);

/* Diagnostic marker: a raw-GL quad drawn straight into the backbuffer while
 * the GL state is neutralised. If you can see it, the swap hook + GL path are
 * alive and only the ImGui part is at fault. Toggle with g_Config.bDebugMarker. */
void Overlay_DrawMarker(int x, int y, int size, const float rgba[4]);

/* Wipes the whole target with one colour. Diagnostic: if the screen does NOT
 * turn magenta, we are drawing into a surface that is never presented. */
void Overlay_ClearFrame(const float rgba[4]);

/* Logs renderer identity + the draw-state facts that make an overlay
 * invisible (fbo, draw/read buffer, colour mask, logic op, viewport). */
void Overlay_LogDiagState(void);

/* -1 unknown, 1 core profile, 2 compatibility profile, 0 other */
int Overlay_GetProfile(void);

/* Drop the cached GL state save (called when the app issues its own draws). */
void Overlay_InvalidateSavedState(void);

#endif /* OVERLAY_STATE_H */
