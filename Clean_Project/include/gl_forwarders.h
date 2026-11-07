/**
 * gl_forwarders.h - GL/WGL Proxy Stub Declarations
 *
 * [English] Auto-generated header for 358 naked-jmp forwarder stubs.
 *           Call GL_ForwardersInit() once after loading System32\opengl32.dll.
 * [සිංහල] Naked jmp stub 358k declare karanawa.
 *         System32 DLL load kala passe GL_ForwardersInit() ekama call krnna.
 */

#ifndef GL_FORWARDERS_H
#define GL_FORWARDERS_H

#include <windows.h>

// [English] Call this once from OpenGL_InitHooks() after g_hOriginalDll is loaded.
// [සිංහල] g_hOriginalDll load una gaman ekama me function call krnna.
void GL_ForwardersInit(HMODULE hReal);

#endif // GL_FORWARDERS_H
