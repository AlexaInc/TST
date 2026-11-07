# Changes vs. your original repo (`AlexaInc/TST` → `Clean_Project/`)

This package is the **overlay/proxy engineering** part: loading, rendering in an
OpenGL 4.5 core-profile context, present-path hooking, input, logging, resizing.
It contains **no chams / wallhack logic** — those switches are present in the menu
but the feature is off by default and was not developed here.

## Files that are NEW

| File | Purpose |
|---|---|
| `src/gl_real.c` / `include/gl_real.h` | Resolves the genuine System32 `opengl32.dll` entry points at runtime (core GL + `wglGetProcAddress` extensions) so the DLL never imports `OPENGL32.dll` from itself. |
| `src/log.c` / `include/log.h` | ReShade-style file logger: writes to the DLL folder **and** `%TEMP%`, plus `OutputDebugString`. Makes "does it load?" answerable. |
| `src/overlay_state.c` / `include/overlay_state.h` | Per-present window/backbuffer measurement, DPI scale, resize + context-change detection, full GL state save/restore, GL profile detection, diagnostics. |
| `src/input_hook.c` / `include/input_hook.h` | Window subclass + cached key table with edge detection, raw-input virtual cursor, `WH_MOUSE_LL` click blocking, menu-rect publishing. |
| `src/iat_hook.c` / `include/iat_hook.h` | Redirects `GDI32!SwapBuffers` / `OPENGL32!wglSwapBuffers` import entries of loaded modules to the proxy. |
| `src/thunk_hook.c` / `include/thunk_hook.h` | Hijacks the pointer cell behind System32 export thunks (`FF 25 disp32`), so callers that bypass the proxy still reach the overlay. |
| `include/gl_shim.h` | Rewrites fixed-function GL calls to the runtime table (used when building a GL2 backend without a self-import). |
| `build_mingw.sh` | Linux/macOS cross build with mingw-w64 (no hard-coded `C:\Users\ASUS\...` paths). |
| `verify_proxy.bat` | One-shot diagnostics: is the DLL loaded, is the file the right one, where is the log, which renderer/bitness. |
| `imgui/imgui_impl_opengl3.cpp/.h/_loader.h` | Official shader-based renderer backend (works in a core profile). |

## Files that were REWRITTEN

| File | What changed |
|---|---|
| `src/dllmain.c` | No `LoadLibrary()` under the loader lock; creates the log, stores own HINSTANCE, bind is lazy. |
| `src/opengl_hooks.c` | Verified real-DLL load (rejects self-resolution), re-entrancy guards on every present path, single overlay draw per frame, `wglSwapLayerBuffers`/`wglGetProcAddress` hooks, GDI present path, diagnostics. |
| `src/imgui_wrapper.cpp` | GL3 (shader) backend, GLSL version chosen from the real context, event-queue input, correct `DisplaySize`/`FramebufferScale`, context-loss recovery, window-rect snapshot taken inside `Begin()` (crash fix for the `0x26` null-window read). |
| `src/gui_overlay.c` | Debounced hotkey from the input module, menu clamped inside the client area on resize, GUI rect published for click blocking, sensitivity slider. |
| `src/config.c` / `include/config.h` | `menuKey`, `diagMode`, `fMouseSensitivity`, `bOverlayUseBoundFBO`; **chams defaults now off**. |
| `opengl32.def` | `wglSwapLayerBuffers` and `wglGetProcAddress` routed to the hook implementations. |
| `src/gl_forwarders.c` / `.S` | All 356 stubs gained a lazy-bind path that preserves `rcx/rdx/r8/r9` + `xmm0-3`, so GL works even if initialisation never ran. |
| `build_gcc.bat` | Portable toolchain paths, new sources, no `-lopengl32`. |

## Build / verify

```
./build_mingw.sh          # or build_gcc.bat
Exports: 364              # original export set preserved + Hooked_* aliases
Deps:    KERNEL32, USER32, GDI32, SHELL32, msvcrt   (no OPENGL32 self-import)
```

`opengl32.dll` in this folder is that build (1,113,088 bytes,
SHA-256 `e314c02d5e8b7cacac2282c29e32cca9a95ad6b9b534fdd6d63b5f457f1d7fb4`).

See `ANALYSIS.md` for the full root-cause write-up with decompiled line references
and `README.md` for install/test steps.
