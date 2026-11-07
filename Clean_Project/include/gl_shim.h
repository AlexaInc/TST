/**
 * gl_shim.h - Force every GL call to go through the runtime pointer table
 *
 * [English] WHY: a DLL named opengl32.dll that *imports* OPENGL32.dll has a
 *           circular dependency on itself. Windows has to resolve that import
 *           while our own DllMain is running under the loader lock, and that is
 *           exactly the kind of circular load that can make LoadLibrary() of
 *           the proxy fail silently - the emulator then keeps rendering with
 *           the genuine System32\opengl32.dll and our hooks are never loaded
 *           (no menu, no log file).
 *
 *           The original ReShade build has ZERO imports from opengl32.dll; it
 *           resolves everything through GetProcAddress. This header does the
 *           same for our vendored imgui_impl_opengl2.cpp: the GL calls are
 *           rewritten to `glr.*` (resolved from the real driver at runtime), so
 *           the finished DLL imports only KERNEL32/USER32/SHELL32/msvcrt.
 *
 *           It is injected with `-include include/gl_shim.h`, i.e. it runs
 *           *before* the translation unit - which is why <GL/gl.h> is included
 *           here first: the prototypes are declared, and only afterwards are
 *           the names turned into macros.
 *
 * [සිංහල] opengl32.dll නමින් තියෙන DLL එකක් ඇතුළෙම OPENGL32.dll import කරන
 *         එක circular dependency එකක්. ඒක loader lock එක යටතේ resolve වෙද්දී
 *         LoadLibrary fail වෙලා, emulator එක system opengl32.dll එකෙන් දිගටම
 *         වැඩකරන්න පුළුවන් (menu නෑ, log නෑ). ඒ නිසා ImGui backend එකේ GL calls
 *         ඔක්කොම `glr.*` (runtime resolve) හරහා යවනවා.
 */

#ifndef GL_SHIM_H
#define GL_SHIM_H

#include <windows.h>
#include <GL/gl.h>
#include "gl_real.h"

/* --- enable / disable / client state --- */
#define glEnable               (glr.Enable)
#define glDisable              (glr.Disable)
#define glEnableClientState    (glr.EnableClientState)
#define glDisableClientState   (glr.DisableClientState)

/* --- drawing --- */
#define glDrawElements         (glr.DrawElements)
#define glViewport             (glr.Viewport)
#define glScissor              (glr.Scissor)

/* --- blending / depth / raster --- */
#define glBlendFunc            (glr.BlendFunc)
#define glPolygonMode          (glr.PolygonMode)
#define glShadeModel           (glr.ShadeModel)
#define glPixelStorei          (glr.PixelStorei)

/* --- matrices --- */
#define glMatrixMode           (glr.MatrixMode)
#define glLoadIdentity         (glr.LoadIdentity)
#define glOrtho                (glr.Ortho)
#define glPushMatrix           (glr.PushMatrix)
#define glPopMatrix            (glr.PopMatrix)
#define glPushAttrib           (glr.PushAttrib)
#define glPopAttrib            (glr.PopAttrib)

/* --- textures --- */
#define glGenTextures          (glr.GenTextures)
#define glDeleteTextures       (glr.DeleteTextures)
#define glBindTexture          (glr.BindTexture)
#define glTexParameteri        (glr.TexParameteri)
#define glTexImage2D           (glr.TexImage2D)
#define glTexSubImage2D        (glr.TexSubImage2D)
#define glTexEnvi              (glr.TexEnvi)
#define glGetTexEnviv          (glr.GetTexEnviv)
#define glGetTexParameteriv    (glr.GetTexParameteriv)

/* --- vertex arrays --- */
#define glVertexPointer        (glr.VertexPointer)
#define glColorPointer         (glr.ColorPointer)
#define glTexCoordPointer      (glr.TexCoordPointer)

/* --- clear / strings --- */
#define glClear                (glr.Clear)
#define glClearColor           (glr.ClearColor)
#define glGetString            (glr.GetString)

/* --- queries --- */
#define glGetIntegerv          (glr.GetIntegerv)
#define glGetError             (glr.GetError)

#endif /* GL_SHIM_H */
