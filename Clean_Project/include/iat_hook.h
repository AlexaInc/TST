/**
 * iat_hook.h - Patch the emulator's import table so BOTH present paths reach us
 *
 * [English] A proxy DLL only sees the calls that go through *its* exports.
 *           BlueStacks/Qt can present in two different ways:
 *
 *             a) opengl32!wglSwapBuffers   -> covered by our .def alias
 *             b) GDI32!SwapBuffers(HDC)    -> goes straight to the display
 *                                             driver, our export is never
 *                                             called  (this is the classic
 *                                             "DLL is loaded but the menu
 *                                             never appears" case)
 *
 *           This module rewrites the IAT entries of every loaded module so
 *           both functions point at our hooks. It is the same idea ReShade
 *           uses for its "swapchain"/swapbuffers layer.
 *
 * [සිංහල] BlueStacks සමහර version වල present කරන්නේ gdi32!SwapBuffers වලින්.
 *         එතකොට අපේ opengl32 export එක call වෙන්නේම නෑ -> menu එක පේන්නේ නෑ.
 *         ඒ නිසා load වී ඇති modules වල IAT entries patch කරලා
 *         SwapBuffers/wglSwapBuffers දෙකම අපේ hook එකට හරවනවා.
 */

#ifndef IAT_HOOK_H
#define IAT_HOOK_H

#include <windows.h>
#include <stdbool.h>

/* Scan all loaded modules and redirect SwapBuffers / wglSwapBuffers.
 * Safe to call repeatedly (skips entries that are already ours).
 * Returns the number of patched entries in this pass. */
int IATHook_InstallAll(void);

/* Number of entries patched in total. */
int IATHook_PatchedCount(void);

/* Was GDI32!SwapBuffers among them? (tells us which present path is in use) */
bool IATHook_GotGDISwap(void);

#endif /* IAT_HOOK_H */
