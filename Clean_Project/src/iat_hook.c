/**
 * iat_hook.c - Import Address Table redirection for SwapBuffers / wglSwapBuffers
 *
 * See iat_hook.h for the reason. Implementation notes:
 *   - walks the PE import directory of every module (Toolhelp32 snapshot),
 *   - matches by DLL name AND function name (ordinal-only imports are skipped),
 *   - VirtualProtect the IAT page, swap the pointer, restore protection,
 *   - never patches our own module (that would recurse).
 */

#include <windows.h>
#include <tlhelp32.h>
#include <stdbool.h>
#include "../include/iat_hook.h"
#include "../include/log.h"

/* Implemented in opengl_hooks.c */
BOOL WINAPI Proxy_SwapBuffers(HDC hdc);
BOOL WINAPI Proxy_wglSwapBuffers(HDC hdc);

static int  s_patched = 0;
static bool s_gotGdiSwap = false;
static bool s_scanBusy = false;

int  IATHook_PatchedCount(void) { return s_patched; }
bool IATHook_GotGDISwap(void)   { return s_gotGdiSwap; }

/* ------------------------------------------------------------------------- */
static bool NameIs(const char* a, const char* b)
{
    if (!a || !b) return false;
    while (*a && *b)
    {
        char ca = (*a >= 'A' && *a <= 'Z') ? (char)(*a + 32) : *a;
        char cb = (*b >= 'A' && *b <= 'Z') ? (char)(*b + 32) : *b;
        if (ca != cb) return false;
        a++; b++;
    }
    return *a == '\0' && *b == '\0';
}

static void PatchSlot(IMAGE_THUNK_DATA64* slot, void* replacement,
                      const char* moduleName, const char* funcName)
{
    void* cur = (void*)(uintptr_t)slot->u1.Function;
    if (cur == replacement) return;             /* already ours */

    DWORD oldProt = 0;
    if (!VirtualProtect(slot, sizeof(*slot), PAGE_READWRITE, &oldProt))
        return;

    slot->u1.Function = (ULONGLONG)(uintptr_t)replacement;

    DWORD tmp = 0;
    VirtualProtect(slot, sizeof(*slot), oldProt, &tmp);

    s_patched++;
    if (funcName && funcName[0] == 'S') s_gotGdiSwap = true;
    Logf("IAT: patched %s!%s -> proxy", moduleName, funcName);
}

static void ScanModule(HMODULE mod, void* selfBase, const wchar_t* modName)
{
    if (!mod) return;
    BYTE* base = (BYTE*)mod;
    if (base == (BYTE*)selfBase) return;

    IMAGE_DOS_HEADER* dos = (IMAGE_DOS_HEADER*)base;
    if (dos->e_magic != IMAGE_DOS_SIGNATURE) return;
    IMAGE_NT_HEADERS64* nt = (IMAGE_NT_HEADERS64*)(base + dos->e_lfanew);
    if (nt->Signature != IMAGE_NT_SIGNATURE) return;
    if (nt->OptionalHeader.Magic != IMAGE_NT_OPTIONAL_HDR64_MAGIC) return;
    if (nt->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress == 0)
        return;

    IMAGE_IMPORT_DESCRIPTOR* imp =
        (IMAGE_IMPORT_DESCRIPTOR*)(base +
            nt->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress);

    for (; imp->Name; imp++)
    {
        const char* dllName = (const char*)(base + imp->Name);
        bool isGdi    = NameIs(dllName, "GDI32.dll")    || NameIs(dllName, "GDI32");
        bool isOpenGL = NameIs(dllName, "OPENGL32.dll") || NameIs(dllName, "OPENGL32");
        if (!isGdi && !isOpenGL) continue;
        if (!imp->FirstThunk || !imp->OriginalFirstThunk) continue;

        IMAGE_THUNK_DATA64* first  = (IMAGE_THUNK_DATA64*)(base + imp->FirstThunk);
        IMAGE_THUNK_DATA64* orig   = (IMAGE_THUNK_DATA64*)(base + imp->OriginalFirstThunk);

        for (; orig->u1.AddressOfData; orig++, first++)
        {
            if (IMAGE_SNAP_BY_ORDINAL64(orig->u1.Ordinal)) continue;

            IMAGE_IMPORT_BY_NAME* ibn =
                (IMAGE_IMPORT_BY_NAME*)(base + (ULONG_PTR)orig->u1.AddressOfData);
            const char* fn = (const char*)ibn->Name;

            if (isGdi && NameIs(fn, "SwapBuffers"))
                PatchSlot(first, (void*)&Proxy_SwapBuffers, "GDI32.dll", "SwapBuffers");
            else if (isOpenGL && NameIs(fn, "wglSwapBuffers"))
                PatchSlot(first, (void*)&Proxy_wglSwapBuffers, "OPENGL32.dll", "wglSwapBuffers");
        }
        (void)modName;
    }
}

int IATHook_InstallAll(void)
{
    if (s_scanBusy) return 0;
    s_scanBusy = true;

    HMODULE selfBase = NULL;
    GetModuleHandleExW(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
                       GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                       (LPCWSTR)(const void*)&IATHook_InstallAll, &selfBase);

    int before = s_patched;

    HANDLE snap = CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, GetCurrentProcessId());
    if (snap == INVALID_HANDLE_VALUE)
    {
        s_scanBusy = false;
        return 0;
    }

    MODULEENTRY32W me;
    me.dwSize = sizeof(me);
    if (Module32FirstW(snap, &me))
    {
        do { ScanModule((HMODULE)me.modBaseAddr, (void*)selfBase, me.szModule); }
        while (Module32NextW(snap, &me));
    }
    CloseHandle(snap);

    s_scanBusy = false;
    return s_patched - before;
}
