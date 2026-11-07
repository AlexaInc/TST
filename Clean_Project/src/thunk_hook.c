/**
 * thunk_hook.c - rewrite the pointer cell behind an export jmp-thunk
 *
 * Windows x64 export thunks look like one of:
 *      FF 25 xx xx xx xx        jmp qword ptr [rip+disp32]
 *      48 FF 25 xx xx xx xx     jmp qword ptr [rip+disp32]   (REX.W prefix)
 * Both mean "jump to the 8-byte pointer stored at rip+disp32". We replace that
 * stored pointer, so callers keep jumping - just into our function - and we
 * still know the genuine target for chaining.
 */

#include <windows.h>
#include <stdbool.h>
#include "../include/thunk_hook.h"
#include "../include/log.h"

/* Build-independent memory helpers */
static void** ResolveJumpCell(PROC fn, int* outThunkLen)
{
    if (!fn) return NULL;
    BYTE* p = (BYTE*)fn;

    /* 48 FF 25 disp32 */
    if (p[0] == 0x48 && p[1] == 0xFF && p[2] == 0x25)
    {
        INT32 disp = *(INT32*)(p + 3);
        if (outThunkLen) *outThunkLen = 7;
        return (void**)(p + 7 + disp);
    }
    /* FF 25 disp32 */
    if (p[0] == 0xFF && p[1] == 0x25)
    {
        INT32 disp = *(INT32*)(p + 2);
        if (outThunkLen) *outThunkLen = 6;
        return (void**)(p + 6 + disp);
    }
    /* 48 8B 05 disp32 ; FF E0   (mov rax,[rip+x]; jmp rax) */
    if (p[0] == 0x48 && p[1] == 0x8B && p[2] == 0x05 && p[7] == 0xFF && p[8] == 0xE0)
    {
        INT32 disp = *(INT32*)(p + 3);
        if (outThunkLen) *outThunkLen = 9;
        return (void**)(p + 7 + disp);
    }
    return NULL;
}

bool ThunkHook_Install(const char* moduleName, const char* funcName,
                       void* replacement, ThunkHook* out)
{
    if (out) { memset(out, 0, sizeof(*out)); }
    if (!moduleName || !funcName || !replacement) return false;

    HMODULE mod = GetModuleHandleA(moduleName);
    if (!mod) return false;

    PROC fn = GetProcAddress(mod, funcName);
    if (!fn) return false;

    /* Already redirected? (idempotent) */
    int thunkLen = 0;
    void** cell = ResolveJumpCell(fn, &thunkLen);
    if (!cell)
    {
        BYTE* p = (BYTE*)fn;
        Logf("THUNK %s!%s: not a jmp-thunk (bytes %02X %02X %02X %02X %02X %02X %02X %02X)"
             " - inline hook would be required",
             moduleName, funcName, p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
        return false;
    }

    void* cur = *cell;
    if (cur == replacement)
    {
        if (out) { out->cell = cell; out->original = cur; out->replacement = replacement; out->installed = true; }
        return true;
    }

    DWORD oldProt = 0;
    if (!VirtualProtect(cell, sizeof(void*), PAGE_READWRITE, &oldProt))
    {
        Logf("THUNK %s!%s: VirtualProtect failed (%lu)", moduleName, funcName,
             (unsigned long)GetLastError());
        return false;
    }
    *cell = replacement;
    DWORD tmp = 0;
    VirtualProtect(cell, sizeof(void*), oldProt, &tmp);

    if (out)
    {
        out->cell = cell;
        out->original = cur;
        out->replacement = replacement;
        out->installed = true;
    }

    Logf("THUNK %s!%s redirected: %p -> %p (genuine impl %p kept for chaining)",
         moduleName, funcName, (void*)fn, replacement, cur);
    return true;
}
