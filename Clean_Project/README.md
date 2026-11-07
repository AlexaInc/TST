# TST — BlueStacks `opengl32.dll` proxy (FIXED)

Re-implementation of the proxy/hook architecture of the original ReShade-based
`opengl32.dll`, with the two reported defects fixed:

* **INSERT now opens the menu** — real edge-detected input instead of
  `GetAsyncKeyState() & 1`, and the UI is drawn with the game's GLSL program /
  VAO unbound (that is why the old menu was an invisible black rectangle).
* **No more black box after resizing the emulator window** — backbuffer size is
  re-measured from `WindowFromDC` + `GetClientRect` on every present,
  `DisplaySize`/`FramebufferScale` are correct, the overlay draws into FBO 0,
  and the whole GL state block is saved and restored.

Full root-cause write-up with decompiled line references: **[ANALYSIS.md](ANALYSIS.md)**

---

## Files

```
opengl32.dll            <- ready-to-use 64-bit build (this is the fixed DLL)
opengl32_clean.dll      <- same file, output name of the build scripts
opengl32.def            <- export list (362 original + Hooked_* aliases)

src/dllmain.c           entry point, remembers own HINSTANCE (anti-recursion)
src/opengl_hooks.c      swap hooks, overlay pipeline, chams (state-safe)
src/gl_real.c           runtime loader for the genuine System32 driver procs
src/overlay_state.c     size tracking, DPI scale, full GL state save/restore
src/input_hook.c        WndProc subclass + cached key table + edge detection
src/gui_overlay.c       the menu
src/imgui_wrapper.cpp   ImGui (OpenGL2 renderer) + event-queue input
src/gl_forwarders.c/.S  358 naked-jmp stubs to the real opengl32.dll

include/                headers (see ANALYSIS.md for what each change is)
imgui/                  Dear ImGui 1.93.1 WIP
build_mingw.sh          Linux/macOS cross build (mingw-w64)
build_gcc.bat           Windows build (w64devkit or any mingw-w64)
```

## Build

```bash
# Linux / macOS
sudo apt install mingw-w64
./build_mingw.sh

# Windows (w64devkit shell)
build_gcc.bat
```

Verified output: `1,032,704` bytes, **363 exports**, 0 warnings, and every
`OPENGL32.dll` self-import is satisfied by one of our own exports (otherwise the
DLL would refuse to load with `ERROR_PROC_NOT_FOUND`).

## Install

1. Close BlueStacks completely (`HD-Player.exe`, `HD-Frontend.exe`, `BstkSVC.exe`).
2. Copy `opengl32.dll` next to `HD-Player.exe` (`C:\Program Files\BlueStacks_nxt\`).
3. Start the emulator and the game, press **INSERT**.
4. Debug logging: run **DebugView** and look for `[Clean_Project]`.

Change the hotkey in `include/config.h` / `src/config.c` (`g_Config.menuKey`,
default `VK_INSERT`) if BlueStacks itself swallows Insert.

## Test checklist

1. INSERT toggles the menu; text is sharp; the cursor is visible and clickable.
2. Resize the window repeatedly (tiny, large, maximized) → no black box, menu
   stays inside the client area.
3. Alt+Enter fullscreen (context re-creation) → menu returns next frame.
4. Minimize/restore → no crash.
5. Menu closed → game renders exactly as vanilla.

## Troubleshooting (v2)

The DLL writes **`opengl32_proxy.log`** next to itself (or in `%TEMP%`) and draws
a **16×16 magenta square** in the top-left corner on every present.

| Symptom | Cause |
|---|---|
| no `opengl32_proxy.log` | DLL never loaded — wrong folder, 32-bit player, or BlueStacks was still running when you copied it |
| log stops after `DllMain PROCESS_ATTACH` | emulator doesn't present through `wglSwapBuffers` / `gdi32!SwapBuffers` |
| `present #…` lines but no magenta square | hook runs, nothing reaches the backbuffer |
| magenta square, no menu | ImGui side — read the `UI drawn:` / `WARNING: … 0 vertices` line |
| everything logs, no menu on screen | window off-screen — the log prints `display=WxH` |
