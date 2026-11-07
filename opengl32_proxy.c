/**
 * opengl32_proxy.c - Demonstration & Structure of an OpenGL Proxy DLL in C
 * 
 * Background:
 *   The uploaded "opengl32.dll" is a 64-bit native build of crosire's ReShade (ReShade64.dll).
 *   ReShade uses the "DLL Search Order Hijacking / Proxy DLL" technique. When an application
 *   or game calls OpenGL / DirectX functions, Windows loads "opengl32.dll" from the local
 *   folder first instead of "C:\Windows\System32\opengl32.dll".
 * 
 *   The proxy intercepts key graphics APIs (e.g., wglSwapBuffers, glDrawArrays), renders
 *   its overlay/post-processing shaders, and forwards the calls to the genuine system DLL.
 * 
 * This C program demonstrates the exact architecture used to build such a proxy DLL in C.
 */

#include <windows.h>
#include <stdio.h>

// Handle to the genuine Windows system opengl32.dll
static HMODULE g_hOriginalDll = NULL;

// Function pointer definitions for intercepted OpenGL functions
typedef BOOL (WINAPI *pfn_wglSwapBuffers)(HDC hdc);
typedef PROC (WINAPI *pfn_wglGetProcAddress)(LPCSTR lpszProc);
typedef void (WINAPI *pfn_glClearColor)(float red, float green, float blue, float alpha);
typedef void (WINAPI *pfn_glClear)(UINT mask);

static pfn_wglSwapBuffers    orig_wglSwapBuffers    = NULL;
static pfn_wglGetProcAddress  orig_wglGetProcAddress  = NULL;
static pfn_glClearColor      orig_glClearColor      = NULL;
static pfn_glClear           orig_glClear           = NULL;

// Frame counter example
static unsigned long long g_frameCount = 0;

/**
 * Load the genuine system DLL from System32 to prevent infinite recursion
 */
static void LoadOriginalDll(void)
{
    if (g_hOriginalDll != NULL)
        return;

    char systemPath[MAX_PATH];
    GetSystemDirectoryA(systemPath, MAX_PATH);
    strcat_s(systemPath, sizeof(systemPath), "\\opengl32.dll");

    g_hOriginalDll = LoadLibraryA(systemPath);
    if (!g_hOriginalDll)
    {
        OutputDebugStringA("[Proxy] Failed to load genuine opengl32.dll from System32!\n");
        return;
    }

    // Resolve original function addresses
    orig_wglSwapBuffers    = (pfn_wglSwapBuffers)GetProcAddress(g_hOriginalDll, "wglSwapBuffers");
    orig_wglGetProcAddress = (pfn_wglGetProcAddress)GetProcAddress(g_hOriginalDll, "wglGetProcAddress");
    orig_glClearColor      = (pfn_glClearColor)GetProcAddress(g_hOriginalDll, "glClearColor");
    orig_glClear           = (pfn_glClear)GetProcAddress(g_hOriginalDll, "glClear");
}

/**
 * Intercepted wglSwapBuffers:
 * Called on every frame buffer swap. This is where overlays (like ReShade ImGui)
 * render post-processing shaders before presenting the frame.
 */
__declspec(dllexport) BOOL WINAPI wglSwapBuffers(HDC hdc)
{
    LoadOriginalDll();

    g_frameCount++;
    // Example: custom logic per frame
    if (g_frameCount % 60 == 0)
    {
        // Debug message or overlay render step
        char msg[128];
        sprintf_s(msg, sizeof(msg), "[Proxy] Hooked wglSwapBuffers called: Frame %llu\n", g_frameCount);
        OutputDebugStringA(msg);
    }

    // Forward to the genuine system opengl32.dll
    if (orig_wglSwapBuffers)
    {
        return orig_wglSwapBuffers(hdc);
    }
    return FALSE;
}

/**
 * Intercepted wglGetProcAddress:
 * Modern OpenGL extensions (GL 2.0+) are resolved through this function.
 */
__declspec(dllexport) PROC WINAPI wglGetProcAddress(LPCSTR lpszProc)
{
    LoadOriginalDll();

    // ReShade intercepts extension functions here to hook shaders and draw calls
    if (orig_wglGetProcAddress)
    {
        return orig_wglGetProcAddress(lpszProc);
    }
    return NULL;
}

/**
 * Example intercepted glClear
 */
__declspec(dllexport) void WINAPI glClear(UINT mask)
{
    LoadOriginalDll();
    if (orig_glClear)
    {
        orig_glClear(mask);
    }
}

/**
 * Example intercepted glClearColor
 */
__declspec(dllexport) void WINAPI glClearColor(float red, float green, float blue, float alpha)
{
    LoadOriginalDll();
    if (orig_glClearColor)
    {
        orig_glClearColor(red, green, blue, alpha);
    }
}

/**
 * DLL Entry Point
 */
BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpReserved)
{
    switch (fdwReason)
    {
    case DLL_PROCESS_ATTACH:
        DisableThreadLibraryCalls(hinstDLL);
        OutputDebugStringA("[Proxy] opengl32.dll proxy injected successfully.\n");
        break;

    case DLL_PROCESS_DETACH:
        if (g_hOriginalDll)
        {
            FreeLibrary(g_hOriginalDll);
            g_hOriginalDll = NULL;
        }
        break;
    }
    return TRUE;
}
