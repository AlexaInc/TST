/**
 * opengl_hooks.h - OpenGL Hooking Engine Prototypes & Function Pointers
 * 
 * [English] Added glDepthFunc and glDepthMask prototypes for per-pixel occlusion
 *           filtering so only the occluded half of a peeking enemy is highlighted.
 * [සිංහල] බිත්තියෙන් බාගයක් එළියේ සිටින සතුරෙකුගේ ඇතුළත කොටස පමණක් නිවැරදිව
 *         තෝරාගැනීමට අවශ්‍ය glDepthFunc සහ glDepthMask ප්‍රකාශ කිරීම්.
 */

#ifndef OPENGL_HOOKS_H
#define OPENGL_HOOKS_H

#include <windows.h>

// ==============================================================================
// Function Pointer Types for Genuine OpenGL (මුල් OpenGL Functions වල Pointers)
// ==============================================================================
typedef BOOL (WINAPI *pfn_wglSwapBuffers)(HDC hdc);
typedef PROC (WINAPI *pfn_wglGetProcAddress)(LPCSTR lpszProc);
typedef void (WINAPI *pfn_glDrawElements)(unsigned int mode, int count, unsigned int type, const void* indices);
typedef void (WINAPI *pfn_glEnable)(unsigned int cap);
typedef void (WINAPI *pfn_glDisable)(unsigned int cap);
typedef void (WINAPI *pfn_glColor4f)(float r, float g, float b, float a);
typedef void (WINAPI *pfn_glPolygonMode)(unsigned int face, unsigned int mode);
typedef void (WINAPI *pfn_glLineWidth)(float width);
typedef void (WINAPI *pfn_glPolygonOffset)(float factor, float units);
typedef void (WINAPI *pfn_glCullFace)(unsigned int mode);
typedef void (WINAPI *pfn_glBlendFunc)(unsigned int sfactor, unsigned int dfactor);
typedef void (WINAPI *pfn_glDepthFunc)(unsigned int func);
typedef void (WINAPI *pfn_glDepthMask)(unsigned char flag);
typedef int  (WINAPI *pfn_glGetUniformLocation)(unsigned int program, const char* name);
typedef void (WINAPI *pfn_glGetIntegerv)(unsigned int pname, int* params);

// Original function pointers from System32\opengl32.dll
extern pfn_wglSwapBuffers       g_orig_wglSwapBuffers;
extern pfn_wglGetProcAddress    g_orig_wglGetProcAddress;
extern pfn_glDrawElements       g_orig_glDrawElements;
extern pfn_glEnable             g_orig_glEnable;
extern pfn_glDisable            g_orig_glDisable;
extern pfn_glColor4f            g_orig_glColor4f;
extern pfn_glPolygonMode        g_orig_glPolygonMode;
extern pfn_glLineWidth          g_orig_glLineWidth;
extern pfn_glPolygonOffset      g_orig_glPolygonOffset;
extern pfn_glCullFace           g_orig_glCullFace;
extern pfn_glBlendFunc          g_orig_glBlendFunc;
extern pfn_glDepthFunc          g_orig_glDepthFunc;
extern pfn_glDepthMask          g_orig_glDepthMask;
extern pfn_glGetUniformLocation g_orig_glGetUniformLocation;
extern pfn_glGetIntegerv        g_orig_glGetIntegerv;

// ==============================================================================
// Hook Function Declarations
// ==============================================================================
bool OpenGL_InitHooks(void);
void OpenGL_ShutdownHooks(void);
BOOL WINAPI Hooked_wglSwapBuffers(HDC hdc);
void WINAPI Hooked_glDrawElements(unsigned int mode, int count, unsigned int type, const void* indices);

#endif // OPENGL_HOOKS_H
