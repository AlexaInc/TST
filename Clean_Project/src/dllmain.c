/**
 * dllmain.c - DLL entry point
 *
 * [English] Differences vs the previous build:
 *   - remembers our own HINSTANCE so opengl_hooks.c can prove that the
 *     "System32\opengl32.dll" it loaded is really a *different* module,
 *   - does not hard-fail the process when the real DLL cannot be loaded yet
 *     (the swap hook retries lazily), which avoids a broken emulator start.
 *
 * [සිංහල] අපේම HINSTANCE එක මතක තබාගන්නවා - System32 එකෙන් load කරන DLL එක
 *         අපේම DLL එකද කියලා චෙක් කරන්න. Load fail වුණත් process එක
 *         කඩා නොවැටෙන්න retry කරනවා.
 */

#include <windows.h>
#include "../include/config.h"
#include "../include/opengl_hooks.h"
#include "../include/log.h"

BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpReserved)
{
    (void)lpReserved;

    switch (fdwReason)
    {
    case DLL_PROCESS_ATTACH:
        DisableThreadLibraryCalls(hinstDLL);
        OpenGL_SetSelfModule(hinstDLL);

        /* First thing: create the log. If no opengl32_proxy.log appears next
         * to the DLL, the DLL was never loaded by the emulator at all. */
        Log_Init(hinstDLL);
        Logf("DllMain PROCESS_ATTACH (hinst=%p, main=%p)", (void*)hinstDLL, (void*)GetModuleHandleW(NULL));

        Config_InitDefaults();

        /* NOTHING ELSE HAPPENS HERE ON PURPOSE.
         *
         * We must not call LoadLibrary() from DllMain: this DLL is named
         * opengl32.dll and we need System32\opengl32.dll, so the loader may
         * still be holding the loader lock for this very module - that is the
         * classic circular-load deadlock / silent failure that makes the
         * emulator fall back to the genuine DLL and never load our hooks.
         *
         * The real DLL is bound lazily instead:
         *   - the exported hooks call OpenGL_InitHooks() themselves, and
         *   - every GL forwarder stub binds itself on first use
         *     (GL_LazyBind in gl_forwarders.c).                              */
        Logf("DllMain attach complete - real opengl32.dll will be bound lazily");
        break;

    case DLL_PROCESS_DETACH:
        /* Deliberately minimal: ImGui_Shutdown would call glDeleteTextures on
         * a context that is usually already destroyed (that is a classic crash
         * on emulator exit). The OS reclaims everything anyway. */
        break;
    }

    return TRUE;
}
