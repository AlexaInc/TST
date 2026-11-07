/**
 * opengl_hooks.h - Proxy plumbing (real DLL handle, hooks, chams)
 *
 * [English] Adds the pieces the original ReShade proxy has and the custom
 *           build was missing:
 *             - GL_GetRealModule()  : the genuine System32\opengl32.dll handle
 *             - GL_CurrentContextIsValid()
 *             - Hooked_wglSwapLayerBuffers (layer swaps must reach the overlay)
 *           All GL calls now go through the gl_real.h pointer table, so this
 *           DLL only ever imports symbols it actually exports.
 */

#ifndef OPENGL_HOOKS_H
#define OPENGL_HOOKS_H

#include <windows.h>
#include <stdbool.h>

/* Told by DllMain which module we are, so the real DLL can be verified to be
 * a *different* module (prevents infinite self-recursion). */
void OpenGL_SetSelfModule(HMODULE h);

/* Handle of the genuine C:\Windows\System32\opengl32.dll (never ourselves). */
HMODULE GL_GetRealModule(void);

/* Is there a current GL context on this thread? (needed before resolving
 * extension entry points through wglGetProcAddress) */
bool GL_CurrentContextIsValid(void);

/* Present-path entry points (also used as thunk-hook targets) */
BOOL WINAPI Proxy_wglSwapBuffers(HDC hdc);
BOOL WINAPI Proxy_wglSwapLayerBuffers(HDC hdc, UINT fuPlanes);
BOOL WINAPI Proxy_SwapBuffers(HDC hdc);
void Proxy_SetGdiOriginal(void* p);

bool OpenGL_InitHooks(void);
void OpenGL_ShutdownHooks(void);

/* ---- exported hooks (aliased in opengl32.def) ---- */
BOOL WINAPI Hooked_wglSwapBuffers(HDC hdc);
BOOL WINAPI Hooked_wglSwapLayerBuffers(HDC hdc, UINT fuPlanes);
void WINAPI Hooked_glDrawElements(unsigned int mode, int count, unsigned int type, const void* indices);

#endif /* OPENGL_HOOKS_H */
