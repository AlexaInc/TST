/**
 * thunk_hook.h - Hijack the real System32 export *pointer*, not our own export
 *
 * [English] WHY THIS IS NEEDED
 *   A proxy DLL only receives calls that go through an import that resolves to
 *   *our* module. BlueStacks' Qt 6.7 renderer also loads
 *   C:\Windows\System32\opengl32.dll explicitly (full path / dynamic
 *   GetProcAddress), so its canvas presents through the REAL wglSwapBuffers and
 *   never reaches our export. Result: our hook runs (we see presents, ImGui
 *   builds thousands of vertices, state is perfect) but the pixels land on a
 *   surface nobody displays.
 *
 *   Windows' opengl32.dll exports are thin jmp-thunks:
 *        FF 25 xx xx xx xx   jmp qword ptr [rip+disp32]   -> ICD implementation
 *   So instead of patching code bytes (fragile) we rewrite the *pointer cell*
 *   that the thunk jumps through. Every caller in the process - no matter how
 *   it resolved the function - then lands in our hook, and we keep the original
 *   pointer in the cell to call through. No trampoline, no byte copying, no
 *   relocation problems. This is the same effect ReShade gets with its detour.
 *
 * [සිංහල] proxy DLL එකකට ලැබෙන්නේ අපේ module එකට resolve වෙන imports විතරයි.
 *         BlueStacks ගේ canvas එක System32 opengl32.dll එක කෙලින්ම load කරන
 *         නිසා ඒ presents අපිට එන්නේ නෑ. System32 export එක යනු
 *         `FF 25 ..` jmp-thunk එකක් නිසා, ඒක ජම්ප් වෙන *pointer cell* එක
 *         අපේ hook එකට හරවනවා - code bytes අල්ලන්නේ නැතුව.
 */

#ifndef THUNK_HOOK_H
#define THUNK_HOOK_H

#include <windows.h>
#include <stdbool.h>

typedef struct ThunkHook {
    void** cell;        /* the pointer the export thunk jumps through */
    void*  original;    /* what it pointed to before we changed it    */
    void*  replacement;
    bool   installed;
} ThunkHook;

/* Redirect module!func so every caller in the process reaches `replacement`.
 * The genuine implementation is returned in `out->original` and MUST be used by
 * the replacement function (never call the export again -> infinite loop). */
bool ThunkHook_Install(const char* moduleName, const char* funcName,
                       void* replacement, ThunkHook* out);

/* Explain *why* an install failed (prints the leading bytes). */
void ThunkHook_LogFailure(const char* moduleName, const char* funcName);

#endif /* THUNK_HOOK_H */
