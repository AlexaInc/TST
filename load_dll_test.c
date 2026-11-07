/**
 * load_dll_test.c - Dynamic C Loader & Export Tester
 * 
 * Demonstrates how to dynamically load opengl32.dll (or ReShade64.dll)
 * without executing risky initialization routines, query exported functions,
 * and interact with the library safely in pure C.
 */

#include <windows.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
    const char* dllPath = (argc > 1) ? argv[1] : "opengl32.dll";

    printf("========================================================\n");
    printf("   C Native DLL Loader & Export Tester\n");
    printf("   Target: %s\n", dllPath);
    printf("========================================================\n\n");

    // Load with DONT_RESOLVE_DLL_REFERENCES to avoid running DllMain hooks
    HMODULE hMod = LoadLibraryExA(dllPath, NULL, DONT_RESOLVE_DLL_REFERENCES);
    if (!hMod)
    {
        printf("[-] Failed to load DLL. Error code: %lu\n", GetLastError());
        return 1;
    }

    printf("[+] Successfully loaded %s at address: 0x%p\n\n", dllPath, (void*)hMod);

    // List of notable exports to query
    const char* testExports[] = {
        "ReShadeVersion",
        "ReShadeRegisterAddon",
        "ReShadeLogMessage",
        "wglSwapBuffers",
        "wglGetProcAddress",
        "glBegin",
        "glEnd",
        "Direct3DCreate9",
        "D3D11CreateDevice",
        "CreateDXGIFactory",
        "vkCreateInstance"
    };

    int count = sizeof(testExports) / sizeof(testExports[0]);
    printf("Querying key exported function entrypoints:\n");
    printf("--------------------------------------------------------\n");
    printf("%-25s | %-18s\n", "Function Name", "Function Pointer");
    printf("--------------------------------------------------------\n");

    for (int i = 0; i < count; i++)
    {
        FARPROC pProc = GetProcAddress(hMod, testExports[i]);
        if (pProc)
        {
            printf("%-25s | 0x%p [Found]\n", testExports[i], (void*)pProc);
        }
        else
        {
            printf("%-25s | (Not Exported)\n", testExports[i]);
        }
    }
    printf("--------------------------------------------------------\n");

    FreeLibrary(hMod);
    printf("\n[+] Library successfully unloaded.\n");
    return 0;
}
