@echo off
setlocal enabledelayedexpansion
title opengl32 proxy - diagnostics
color 0B

echo ==========================================================
echo   opengl32.dll proxy - one-shot diagnostics
echo ==========================================================
echo.

echo [1] Is the emulator running, and is OUR opengl32.dll loaded?
echo ----------------------------------------------------------
tasklist /m /fi "imagename eq HD-Player.exe" /fo list 2>nul | findstr /i "Image PID Modules" 
echo.
echo   Looking for "opengl32.dll" in the module list above:
tasklist /m opengl32.dll 2>nul | findstr /i "HD-Player" >nul && (
    echo   RESULT: opengl32.dll IS loaded in HD-Player.exe
) || (
    echo   RESULT: opengl32.dll is NOT loaded in HD-Player.exe  ^(proxy inactive^)
)
echo.

echo [2] Which opengl32.dll sits next to HD-Player.exe?
echo ----------------------------------------------------------
set "BS=%ProgramFiles%\BlueStacks_nxt"
if not exist "%BS%\HD-Player.exe" set "BS=%ProgramFiles%\BlueStacks"
if not exist "%BS%\HD-Player.exe" set "BS=C:\Program Files\BlueStacks_nxt"
echo   folder: %BS%
if exist "%BS%\opengl32.dll" (
    for %%F in ("%BS%\opengl32.dll") do echo   size  : %%~zF bytes   ^(mine = 1092608^)
    certutil -hashfile "%BS%\opengl32.dll" SHA256 2>nul | findstr /v ":"
) else (
    echo   no opengl32.dll in that folder!
)
dir /b "%BS%\opengl32*.dll*" 2>nul
echo.

echo [3] Where did the proxy write its log?
echo ----------------------------------------------------------
set FOUND=0
if exist "%BS%\opengl32_proxy.log" (
    echo   [DLL folder] %BS%\opengl32_proxy.log
    set FOUND=1
)
if exist "%TEMP%\opengl32_proxy.log" (
    echo   [TEMP]  %TEMP%\opengl32_proxy.log
    set FOUND=1
)
if exist "%LOCALAPPDATA%\VirtualStore\Program Files\BlueStacks_nxt\opengl32_proxy.log" (
    echo   [VirtualStore] %LOCALAPPDATA%\VirtualStore\Program Files\BlueStacks_nxt\opengl32_proxy.log
    set FOUND=1
)
if "%FOUND%"=="0" echo   no log file found anywhere - the DLL was never loaded
echo.
echo   ---- last 25 log lines ----
for %%L in ("%BS%\opengl32_proxy.log" "%TEMP%\opengl32_proxy.log") do (
    if exist %%L (
        echo   ^(%%~L^)
        powershell -nop -c "Get-Content -LiteralPath '%%~L' -Tail 25" 2>nul
    )
)
echo.

echo [4] What renderer / instance type is configured?
echo ----------------------------------------------------------
set "CONF=%ProgramData%\BlueStacks_nxt\bluestacks.conf"
if exist "%CONF%" (
    findstr /i "renderer vulkan graphics_engine abi_list display_name" "%CONF%" 2>nul | more +0
) else (
    echo   bluestacks.conf not found at %CONF%
)
echo.

echo [5] 32-bit or 64-bit emulator process?
echo ----------------------------------------------------------
powershell -nop -c "Get-Process HD-Player -ErrorAction SilentlyContinue | Select-Object Id,ProcessName,@{n='64bit';e={[Environment]::Is64BitProcess}} | Format-List" 2>nul
echo.
echo ==========================================================
echo   Done. Copy everything above into the chat.
echo ==========================================================
pause
