/**
 * log.c - thread-safe, non-recursive, multi-destination file logger
 *
 * [English] "No log file" must never be ambiguous, so we write to TWO places:
 *     1. next to the DLL      (expects admin; may hit UAC VirtualStore)
 *     2. %TEMP%               (always writable)
 *   and every candidate path is echoed through OutputDebugString so DebugView
 *   shows exactly where the log went.
 *
 *   No CRT file I/O: just CreateFileW/WriteFile, safe inside DllMain.
 */

#include <windows.h>
#include <stdio.h>
#include <stdarg.h>
#include <stdbool.h>
#include "../include/log.h"

#define MAX_SINKS 3
static HANDLE s_sink[MAX_SINKS] = { INVALID_HANDLE_VALUE, INVALID_HANDLE_VALUE, INVALID_HANDLE_VALUE };
static int    s_sinkCount = 0;
static CRITICAL_SECTION s_cs;
static bool   s_csInit = false;
static wchar_t s_path[MAX_PATH * 2];
static DWORD  s_startTick = 0;

static bool OpenSink(const wchar_t* fullPath)
{
    if (s_sinkCount >= MAX_SINKS) return false;
    HANDLE h = CreateFileW(fullPath, FILE_APPEND_DATA,
                           FILE_SHARE_READ | FILE_SHARE_WRITE, NULL,
                           CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
    if (h == INVALID_HANDLE_VALUE) return false;
    s_sink[s_sinkCount++] = h;
    if (s_sinkCount == 1) lstrcpynW(s_path, fullPath, MAX_PATH * 2);

    /* Tell DebugView where we are writing, in case the user can't find it. */
    char narrow[MAX_PATH * 2] = "";
    WideCharToMultiByte(CP_ACP, 0, fullPath, -1, narrow, sizeof(narrow) - 1, NULL, NULL);
    OutputDebugStringA("[proxy] log -> ");
    OutputDebugStringA(narrow);
    OutputDebugStringA("\n");
    return true;
}

void Log_Init(HMODULE selfModule)
{
    if (s_sinkCount > 0) return;

    if (!s_csInit) { InitializeCriticalSection(&s_cs); s_csInit = true; }

    wchar_t dir[MAX_PATH * 2] = L"";
    DWORD n = GetModuleFileNameW(selfModule, dir, MAX_PATH * 2);
    if (n > 0 && n < MAX_PATH * 2)
    {
        wchar_t* slash = NULL;
        for (wchar_t* p = dir; *p; p++) if (*p == L'\\' || *p == L'/') slash = p;
        if (slash) *(slash + 1) = L'\0';

        wchar_t full[MAX_PATH * 2];
        lstrcpynW(full, dir, MAX_PATH * 2);
        lstrcatW(full, L"opengl32_proxy.log");
        OpenSink(full);
    }

    /* Always also write to %TEMP% - works even in Program Files with UAC. */
    wchar_t tmp[MAX_PATH * 2] = L"";
    DWORD t = GetTempPathW(MAX_PATH * 2, tmp);
    if (t > 0 && t < MAX_PATH * 2)
    {
        wchar_t full[MAX_PATH * 2];
        lstrcpynW(full, tmp, MAX_PATH * 2);
        lstrcatW(full, L"opengl32_proxy.log");
        OpenSink(full);
    }

    s_startTick = GetTickCount();

    if (s_sinkCount == 0)
    {
        OutputDebugStringA("[proxy] ERROR: cannot create any log file\n");
        return;
    }

    Logf("=== opengl32 proxy loaded ===");
    Logf("pid=%lu  arch=%d-bit  module=%p  main=%p",
         (unsigned long)GetCurrentProcessId(), (int)(sizeof(void*) * 8),
         (void*)selfModule, (void*)GetModuleHandleW(NULL));
    {
        wchar_t exe[MAX_PATH * 2] = L"";
        GetModuleFileNameW(NULL, exe, MAX_PATH * 2);
        char narrow[MAX_PATH * 2] = "";
        WideCharToMultiByte(CP_ACP, 0, exe, -1, narrow, sizeof(narrow) - 1, NULL, NULL);
        Logf("exe=%s", narrow);
    }
}

void Log_Close(void)
{
    for (int i = 0; i < s_sinkCount; i++)
        if (s_sink[i] != INVALID_HANDLE_VALUE) { CloseHandle(s_sink[i]); s_sink[i] = INVALID_HANDLE_VALUE; }
    s_sinkCount = 0;
}

bool Log_IsOpen(void) { return s_sinkCount > 0; }
const wchar_t* Log_Path(void) { return s_path; }

static void WriteLine(const char* line)
{
    DWORD len = (DWORD)lstrlenA(line);
    for (int i = 0; i < s_sinkCount; i++)
    {
        if (s_sink[i] == INVALID_HANDLE_VALUE) continue;
        DWORD wrote = 0;
        WriteFile(s_sink[i], line, len, &wrote, NULL);
        WriteFile(s_sink[i], "\r\n", 2, &wrote, NULL);
    }
}

void Logf(const char* fmt, ...)
{
    char body[1024];
    va_list ap;
    va_start(ap, fmt);
    _vsnprintf(body, sizeof(body) - 1, fmt, ap);
    body[sizeof(body) - 1] = '\0';
    va_end(ap);

    char line[1200];
    DWORD el = GetTickCount() - s_startTick;
    _snprintf(line, sizeof(line) - 1, "[%6lu.%03lu] %s",
              (unsigned long)(el / 1000), (unsigned long)(el % 1000), body);
    line[sizeof(line) - 1] = '\0';

    OutputDebugStringA(line);
    OutputDebugStringA("\n");
    if (s_csInit) EnterCriticalSection(&s_cs);
    WriteLine(line);
    if (s_csInit) LeaveCriticalSection(&s_cs);
}

typedef struct ThrottleRec { const char* tag; DWORD last; } ThrottleRec;
static ThrottleRec s_throttle[32];
static int s_throttleCount = 0;

void LogfEvery(const char* tag, unsigned intervalMs, const char* fmt, ...)
{
    DWORD now = GetTickCount();
    bool due;

    if (s_csInit) EnterCriticalSection(&s_cs);
    ThrottleRec* rec = NULL;
    for (int i = 0; i < s_throttleCount; i++)
        if (s_throttle[i].tag == tag) { rec = &s_throttle[i]; break; }
    if (!rec && s_throttleCount < 32)
    {
        rec = &s_throttle[s_throttleCount++];
        rec->tag = tag; rec->last = 0;
    }
    due = !rec || (DWORD)(now - rec->last) >= intervalMs;
    if (rec && due) rec->last = now ? now : 1;
    if (s_csInit) LeaveCriticalSection(&s_cs);

    if (!due) return;

    char body[1024];
    va_list ap;
    va_start(ap, fmt);
    _vsnprintf(body, sizeof(body) - 1, fmt, ap);
    body[sizeof(body) - 1] = '\0';
    va_end(ap);

    char line[1200];
    DWORD el = now - s_startTick;
    _snprintf(line, sizeof(line) - 1, "[%6lu.%03lu] %s",
              (unsigned long)(el / 1000), (unsigned long)(el % 1000), body);
    line[sizeof(line) - 1] = '\0';

    OutputDebugStringA(line);
    OutputDebugStringA("\n");
    if (s_csInit) EnterCriticalSection(&s_cs);
    WriteLine(line);
    if (s_csInit) LeaveCriticalSection(&s_cs);
}
