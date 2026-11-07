/**
 * log.h - ReShade-style file logger
 *
 * [English] The proxy is loaded into a process we cannot attach to, so the
 *           only reliable way to know where it stops is a log file written
 *           next to the DLL (like ReShade.log). If this file never appears,
 *           the DLL was never loaded at all - which is itself the answer.
 *
 * [සිංහල] DLL එක load වුණාද, swap hook එක call වෙනවද, overlay එක ඇඳගෙන
 *         යනවද කියලා දැනගන්න log file එකක් ලියනවා (ReShade.log වගේ).
 *         මේ file එකක් හැදුනේ නැත්නම් DLL එක load වෙලාම නෑ.
 */

#ifndef LOG_H
#define LOG_H

#include <windows.h>
#include <stdbool.h>

/* Creates <folder of our DLL>\opengl32_proxy.log (falls back to %TEMP%). */
void Log_Init(HMODULE selfModule);

void Log_Close(void);
bool Log_IsOpen(void);
const wchar_t* Log_Path(void);

void Logf(const char* fmt, ...);

/* Same, but at most once per intervalMs - for per-frame call sites. */
void LogfEvery(const char* tag, unsigned intervalMs, const char* fmt, ...);

#endif /* LOG_H */
