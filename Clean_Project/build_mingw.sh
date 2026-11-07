#!/usr/bin/env bash
# =============================================================================
# build_mingw.sh - build opengl32.dll (64-bit) with mingw-w64 / w64devkit
#
#   Linux :  sudo apt install mingw-w64 && ./build_mingw.sh
#   Windows (w64devkit or any mingw-w64 shell):  sh ./build_mingw.sh
#
# Output: opengl32_clean.dll  ->  rename to opengl32.dll and drop it in the
#         BlueStacks install folder (next to HD-Player.exe).
# =============================================================================
set -e
cd "$(dirname "$0")"

CC=${CC:-x86_64-w64-mingw32-gcc}
CXX=${CXX:-x86_64-w64-mingw32-g++}
OUT=opengl32_clean.dll

CFLAGS="-c -m64 -O2 -Wall -Wextra -Wno-unused-parameter -I include -I imgui"
LDFLAGS="-shared -m64 -static-libgcc -static-libstdc++ -Wl,--gc-sections -Wl,--allow-multiple-definition -s"

rm -f obj_*.o "$OUT"

echo "[1/4] C sources"
for f in dllmain config log gl_real thunk_hook opengl_hooks overlay_state input_hook iat_hook gui_overlay gl_forwarders; do
    echo "      $f.c"
    $CC $CFLAGS -o "obj_$f.o" "src/$f.c"
done

echo "[2/4] ASM forwarders"
$CC -c -m64 -o obj_fwd_s.o src/gl_forwarders.S

echo "[3/4] ImGui (C++)"
for f in imgui imgui_draw imgui_tables imgui_widgets; do
    echo "      $f.cpp"
    $CXX -c -m64 -O2 -I imgui -o "obj_$f.o" "imgui/$f.cpp"
done
# OpenGL3 backend: shaders + VAO/VBO (works in a core profile) and it brings its
# own GL loader, so we still never import OPENGL32.dll.
echo "      imgui_impl_opengl3.cpp (shader renderer, own GL loader)"
$CXX -c -m64 -O2 -I imgui -o obj_imgui_impl_opengl3.o imgui/imgui_impl_opengl3.cpp
$CXX $CFLAGS -o obj_wrapper.o src/imgui_wrapper.cpp

echo "[4/4] link -> $OUT"
$CXX -o "$OUT" obj_*.o opengl32.def \
    -luser32 -lkernel32 -lgdi32 -ldwmapi -lshell32 $LDFLAGS

rm -f obj_*.o
ls -l "$OUT"
echo
EXP=$(x86_64-w64-mingw32-objdump -p "$OUT" 2>/dev/null | grep -oE "base\[[ 0-9]+\][[:space:]]+[0-9a-f]+[[:space:]]+[A-Za-z_0-9]+$" | awk '{print $NF}' | sort -u | wc -l)
echo "Exports: $EXP"
echo "Done. Rename to opengl32.dll and copy into the BlueStacks folder."
