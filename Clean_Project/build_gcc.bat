@echo off
:: ============================================================
:: build_gcc.bat - Windows build (w64devkit / any mingw-w64 GCC)
:: Builds C + C++ (ImGui) + ASM (GL stubs) into opengl32.dll
:: ============================================================
setlocal
cd /d "%~dp0"

:: --- point these at your toolchain (w64devkit example) -------
if "%GCC%"=="" set GCC=gcc
if "%GPP%"=="" set GPP=g++

echo [Step 1/4] Compiling C sources...
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_dllmain.o     src\dllmain.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_config.o      src\config.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_log.o         src\log.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_iat.o         src\iat_hook.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_thunk.o       src\thunk_hook.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_gl_real.o     src\gl_real.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_hooks.o       src\opengl_hooks.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_overlay.o     src\overlay_state.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_input.o       src\input_hook.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_gui.o         src\gui_overlay.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_fwd_c.o       src\gl_forwarders.c
if errorlevel 1 goto :fail

echo [Step 2/4] Compiling ASM stubs...
"%GCC%" -c -m64 -o obj_fwd_s.o src\gl_forwarders.S
if errorlevel 1 goto :fail

echo [Step 3/4] Compiling ImGui C++ sources...
"%GPP%" -c -m64 -O2 -I imgui -o obj_imgui.o        imgui\imgui.cpp
"%GPP%" -c -m64 -O2 -I imgui -o obj_imgui_draw.o   imgui\imgui_draw.cpp
"%GPP%" -c -m64 -O2 -I imgui -o obj_imgui_tables.o imgui\imgui_tables.cpp
"%GPP%" -c -m64 -O2 -I imgui -o obj_imgui_widgets.o imgui\imgui_widgets.cpp
"%GPP%" -c -m64 -O2 -I imgui -o obj_imgui_gl3.o imgui\imgui_impl_opengl3.cpp
"%GPP%" -c -m64 -O2 -I include -I imgui -o obj_wrapper.o src\imgui_wrapper.cpp
if errorlevel 1 goto :fail

echo [Step 4/4] Linking opengl32_clean.dll...
"%GPP%" -shared -m64 -o opengl32_clean.dll ^
    obj_*.o ^
    opengl32.def ^
    -luser32 -lkernel32 -lgdi32 -ldwmapi -lshell32 ^
    -static-libgcc -static-libstdc++ -Wl,--gc-sections -Wl,--allow-multiple-definition -s
if errorlevel 1 goto :fail

del /q obj_*.o 2>nul
echo.
echo ============================================================
echo [SUCCESS] opengl32_clean.dll built.
dir /b opengl32_clean.dll
echo Rename to opengl32.dll and place it in the BlueStacks folder.
echo ============================================================
exit /b 0

:fail
echo.
echo [ERROR] Build FAILED.
del /q obj_*.o 2>nul
exit /b 1
