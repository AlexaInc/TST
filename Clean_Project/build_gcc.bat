@echo off
:: ============================================================
:: build_gcc.bat - Clean_Project DLL Build Script (w64devkit GCC)
:: Compiles C + C++ (ImGui) + ASM (GL stubs) into opengl32.dll
:: ============================================================

cd /d "C:\Users\ASUS\Desktop\decompile dll\Clean_Project"

set GCC=C:\Users\ASUS\Downloads\ABDM\Programs\w64devkit\bin\gcc.exe
set GPP=C:\Users\ASUS\Downloads\ABDM\Programs\w64devkit\bin\g++.exe

if not exist "%GCC%" (
    echo [ERROR] GCC not found at: %GCC%
    pause
    exit /b 1
)

echo [Step 1/4] Compiling C sources...
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_dllmain.o src\dllmain.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_config.o src\config.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_hooks.o src\opengl_hooks.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_overlay.o src\gui_overlay.c
"%GCC%" -c -m64 -O2 -Wall -I include -I imgui -o obj_fwd_c.o src\gl_forwarders.c
if errorlevel 1 goto :fail

echo [Step 2/4] Compiling ASM stubs...
"%GCC%" -c -m64 -o obj_fwd_s.o src\gl_forwarders.S
if errorlevel 1 goto :fail

echo [Step 3/4] Compiling ImGui C++ sources...
"%GPP%" -c -m64 -O2 -I imgui -o obj_imgui.o imgui\imgui.cpp
"%GPP%" -c -m64 -O2 -I imgui -o obj_imgui_draw.o imgui\imgui_draw.cpp
"%GPP%" -c -m64 -O2 -I imgui -o obj_imgui_tables.o imgui\imgui_tables.cpp
"%GPP%" -c -m64 -O2 -I imgui -o obj_imgui_widgets.o imgui\imgui_widgets.cpp
"%GPP%" -c -m64 -O2 -I imgui -o obj_imgui_gl2.o imgui\imgui_impl_opengl2.cpp
"%GPP%" -c -m64 -O2 -I include -I imgui -o obj_wrapper.o src\imgui_wrapper.cpp
if errorlevel 1 goto :fail

echo [Step 4/4] Linking opengl32_clean.dll...
"%GPP%" -shared -m64 -o opengl32_clean.dll ^
    obj_dllmain.o obj_config.o obj_hooks.o obj_overlay.o obj_fwd_c.o obj_fwd_s.o ^
    obj_imgui.o obj_imgui_draw.o obj_imgui_tables.o obj_imgui_widgets.o ^
    obj_imgui_gl2.o obj_wrapper.o ^
    opengl32.def ^
    -luser32 -lkernel32 -lgdi32 -ldwmapi -lshell32 -lopengl32 ^
    -static-libgcc -static-libstdc++ -Wl,--gc-sections -Wl,--allow-multiple-definition -s
if errorlevel 1 goto :fail

:: Cleanup object files
del /q obj_*.o 2>nul

echo.
echo ============================================================
echo [SUCCESS] opengl32_clean.dll compiled!
dir opengl32_clean.dll
echo.
echo Rename to opengl32.dll and place in BlueStacks folder.
echo ============================================================
pause
exit /b 0

:fail
echo.
echo [ERROR] Compilation FAILED! See errors above.
del /q obj_*.o 2>nul
pause
exit /b 1
