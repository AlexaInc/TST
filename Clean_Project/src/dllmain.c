/**
 * dllmain.c - DLL Entry Point & Proxy Initialization (Cleaned)
 * 
 * [English] Handles process attach/detach events, loads the genuine Windows
 *           System32\opengl32.dll library, and initializes OpenGL hooks.
 * [සිංහල] DLL එක Process එකට attach වීමේදී සැබෑ System32\opengl32.dll එක load කර
 *         OpenGL hooks සකස් කිරීම සිදුකරයි.
 */

#include <windows.h>
#include <stdio.h>
#include "../include/config.h"
#include "../include/opengl_hooks.h"

BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpReserved)
{
    switch (fdwReason)
    {
    case DLL_PROCESS_ATTACH:
        DisableThreadLibraryCalls(hinstDLL);

        // Initialize default configuration (colors, flags)
        Config_InitDefaults();

        // Load genuine system opengl32.dll and prepare hooks
        if (!OpenGL_InitHooks())
        {
            OutputDebugStringA("[Clean_Project] Failed to initialize OpenGL hooks!\n");
            return FALSE;
        }

        OutputDebugStringA("[Clean_Project] Injected and initialized successfully.\n");
        break;

    case DLL_PROCESS_DETACH:
        // Unload genuine DLL and restore state
        OpenGL_ShutdownHooks();
        break;
    }

    return TRUE;
}
