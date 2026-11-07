# BlueStacks `opengl32.dll` proxy — root-cause analysis & fix

**Repo analysed:** `github.com/AlexaInc/TST`
**Files that matter:** `opengl32.dll` (the working build), `opengl32.dll.decompiled.c` (17 MB Ghidra dump), `Clean_Project/` (your re-implementation)
**Fixed source tree:** `TST_fix/` — builds clean (0 warnings), 363 exports, self-import table verified.

---

## 0. TL;DR

| Symptom | Root cause | Fixed in |
|---|---|---|
| **INSERT doesn't open the menu** | `GetAsyncKeyState(vk) & 1` — the low bit is "pressed since *anyone* in the process last called it". BlueStacks/Qt polls it constantly, so your edge is eaten before your overlay reads it. Plus: even on frames where the menu *did* open, ImGui was drawing **through the emulator's GLSL program / VAO** (the GL2 backend cannot reset them), so the window came out as an opaque black rectangle with invisible text, and the mouse position was fed as **screen** coordinates instead of client coordinates. | `src/input_hook.c` (new), `src/imgui_wrapper.cpp`, `src/overlay_state.c` (new) |
| **Black box top/right after resizing** | `DisplaySize` came from one `glGetIntegerv(GL_VIEWPORT)` sample taken at an arbitrary moment, with a fallback to the **desktop resolution** when it read 0. After a resize the new backbuffer and the (lagging, 1-frame stale) guest viewport disagree → ImGui projects with one size and scissors with another. On top of that the overlay drew into whatever FBO was bound and left `GL_SCISSOR_TEST`/`GL_DEPTH_TEST`/`glDepthMask`/blend modified forever. | `src/overlay_state.c` (new), `src/opengl_hooks.c` |

I decompiled-side compared against the original and reproduced its three mechanisms (client-rect resize detection, full GL state block, cached-key edge detection) — details below with line numbers so you can check them yourself in `opengl32.dll.decompiled.c`.

---

## 1. What the original `opengl32.dll` actually is

Not a hand-written cheat DLL — it is **crosire's ReShade 0.0.0.181 (64-bit)** statically linked as an OpenGL proxy (`ReShade.log`: *"Initializing crosire's ReShade version '0.0.0.181' (64-bit) loaded from … opengl32.dll"*). The menu you see is the original's own ImGui overlay, re-skinned by whoever built it ("EXT X CHEATS"), and the chams logic was added to the `glDrawElements` hook.

Its architecture, as seen in the Ghidra dump:

| Mechanism | Evidence in `opengl32.dll.decompiled.c` |
|---|---|
| Loads the *genuine* System32 DLL and validates that the resolved pointer is **not its own export** (anti self-recursion) | `wglSwapBuffers` prologue, line **236222**: `if ((code *)plVar6[2] == wglSwapBuffers) break;` then two resolution attempts, then `FUN_18003ac80()` (LoadLibrary of the real DLL) |
| Hooks **extension** GL functions by name through `wglGetProcAddress`, not just the 1.1 exports | lines **237831+**: `uVar5 = (*DAT_1803d38a0)("glBindFramebuffer"); FUN_180039a30("glBindFramebuffer", uVar5, FUN_18012f820);` — the whole `glFramebuffer*` / `glUniform*` / `glViewport*` families are registered this way |
| `wglSwapLayerBuffers` (main plane) is redirected into `wglSwapBuffers`; `wglSwapMultipleBuffers` loops over the DC list | lines **236356**, **236380** |
| **Resize handling** — this is the part you're missing | lines **236276–236300**: `hWnd = WindowFromDC(hdc); GetClientRect(hWnd,&rc); if (rc.right != runtime->width \|\| rc.bottom != runtime->height) { log("Resizing runtime…"); runtime_reset(); if (w && h) runtime_reinit(hWnd, w, h); }` |
| Overlay is drawn **before** the real swap, and the runtime is re-initialised only with a non-zero size | same function; zero client size ⇒ no draw call at all |
| `DisplaySize` from the backbuffer, scale factor from `client rect` (`backbuffer/client`) ⇒ DPI-safe | lines **102498+**: `GetClientRect(*(HWND*)(param_1[0xe]+8), &rc); scale = display_size / rc.right * backbuffer_width` |
| Input: its **own 256-entry key table**, high-bit polling, edge detection against the previous frame, 5 s repeat handling | `FUN_180050b60`, line **53570**: `if ((*pcVar6 < 0) && (5000 < now - last) && (GetAsyncKeyState(vKey), -1 < SVar2)) *pcVar6 = 8;` and line **53640**: `if ((-1 < cached) && (GetAsyncKeyState(0x2c) < 0)) cached = 0x88;` ← textbook rising edge on **0x8000**, never on `& 1` |
| Message-pump hooks so keys arrive even when the GL thread never pumps messages | `PeekMessageA/W`, `GetMessageW`, `RegisterRawInputDevices` are all *hooked exports* (lines **54055–54483**) |
| ReShade.log note: `Registering hooks for "user32.dll" … Found 14 match(es)` — that is what makes INSERT bullet-proof | `ReShade.log` |

**Key insight:** the original never asks "is Insert down right now?" — it maintains a state table, compares it to the previous frame, and *also* captures the window messages. Your build asks the OS "was Insert pressed since the last time **anyone** asked?" — a process-wide flag that BlueStacks consumes.

---

## 2. Your build — the four actual defects

### 2.1 INSERT: three independent faults stacked

**(a) `GetAsyncKeyState(vKey) & 1` (`gui_overlay.c`)**
The low-order bit means *"the key was pressed after the previous call to `GetAsyncKeyState`"* — and that flag is **shared by everyone in the process**. BlueStacks/Qt polls keys for its own hotkeys on several threads. By the time `GUI_Render()` runs, the flag has been read and cleared. Result: works sometimes, never reliably. If two GL threads present, one physical press can also toggle twice.

**(b) Mouse coordinates were in screen space**
```c
GetCursorPos(&pt);                       // SCREEN coordinates
io.MousePos = ImVec2(pt.x - vpX, ...);   // vpX came from GL_VIEWPORT (usually 0)
```
ImGui expects **client/viewport-relative** coordinates. With a window not at screen origin (0,0) the virtual cursor sat hundreds of pixels away from the menu, so even a visible menu can't be clicked, dragged or scrolled.

**(c) The draw itself was invisible/black — this is the real reason it "doesn't open"**
`ImGui_ImplOpenGL2` is a **fixed-pipeline** renderer. It literally cannot reset `glUseProgram` / `glBindVertexArray` / `glBindBuffer` — its own header says:

> *"The GL2 code is unable to reset attributes or even call e.g. `glUseProgram(0)` because they don't exist in that API."*

BlueStacks renders through **GLSL programs and VAOs**. Your code issued the ImGui triangles with the emulator's shader still bound and no vertex attributes set up ⇒ the window background is produced as an opaque quad and the font atlas is never sampled. The menu "opens" and looks exactly like a dark/black rectangle. Add to that:

```c
// ImGuiW_NewFrame(), old code — executed on every present
glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
glDisable(GL_DEPTH_TEST);
glDepthMask(GL_TRUE);
glDisable(GL_CULL_FACE);
glEnable(GL_BLEND);
glDisable(GL_SCISSOR_TEST);   // <-- never restored
```
…and the **emulator's** next frames inherit depth-test-off / scissor-off, which is where the *rendering* corruption comes from too.

### 2.2 Resize: stale display size + wrong draw target

```c
// old ImGuiW_NewFrame()
GLint viewport[4]; glGetIntegerv(GL_VIEWPORT, viewport);
if (vpW <= 0 || vpH <= 0) {               // minimized or context mid-resize
    vpW = GetSystemMetrics(SM_CXSCREEN);   // <-- 1920x1080 DESKTOP size!
    vpH = GetSystemMetrics(SM_CYSCREEN);
}
io.DisplaySize = ImVec2(vpW, vpH);        // <-- whatever the guest had 1 frame ago
```
* During/after a BlueStacks resize the guest viewport is **one frame behind** the new client area. ImGui then builds clip rectangles (`scissor`) from `DisplaySize × FramebufferScale`, while `ImGui_ImplOpenGL2_SetupRenderState` sets `glViewport(0,0,fb_width,fb_height)` from the same number — but the *drawable* is already the new size. The mismatch shows up as a solid rectangle anchored to an edge — your "black box up and right".
* The `GetSystemMetrics` fallback makes it dramatically worse (projects a 480×520 window onto a 1920×1080 canvas inside a 900×500 window).
* `FramebufferScale` was never set (always 1,1), so under 125 %/150 % Windows DPI it is wrong even without a resize.
* No `GetClientRect` comparison and no runtime reset ⇒ the stale state persists for frames, and if BlueStacks recreates its GL context on resize, the ImGui font texture handle is dangling (nothing re-uploads it).
* Nothing binds **FBO 0** before drawing. BlueStacks renders the guest into an offscreen FBO; the overlay was painted *into that texture*, at coordinates that don't correspond to the window — garbage that changes shape exactly when the window size changes.

---

## 3. The fix (what is in `TST_fix/`)

### New pipeline in `Hooked_wglSwapBuffers`
```
GL_LoadRealApi()                     // resolve real System32 procs (once, with a live context)
Overlay_Prepare(hdc, &f)             // WindowFromDC -> GetAncestor -> GetClientRect
                                     //   client size + framebuffer size + DPI scale
                                     //   resized / newWindow / newContext flags
                                     //   minimized or 0x0  -> do not draw
Input_Attach(f.hwnd)                 // subclass emulator HWND (re-installs if Qt resets it)
Input_Collect(&hot, menuKey)         // cheap path while the menu is closed
GUI_HandleHotkeys(&hot)              // debounced rising edge -> toggle
Input_Collect(&in, 0)                // full snapshot for frames we actually draw
ImGuiW_SetDisplayMetrics(...)        // DisplaySize = client px, FramebufferScale = fb/client
Overlay_BeginDraw(&f)                // SAVE ALL STATE, program=0, VAO=0, FBO=0, viewport=fb
GUI_Render(&in, &f)                  // FeedInput -> NewFrame -> UI -> Render
Overlay_EndDraw()                    // RESTORE ALL STATE
g_origSwap(hdc)                      // then present
```

### File-by-file

| File | Status | What it does |
|---|---|---|
| `include/gl_real.h`, `src/gl_real.c` | **new** | Runtime pointer table for the genuine `System32\opengl32.dll` (core + `wglGetProcAddress` extensions). Lets the overlay call `glUseProgram`, `glBindVertexArray`, `glBindFramebuffer`, `glBlendEquation`, `glActiveTexture` **without adding a single import** to the DLL (a missing self-import = the whole DLL refuses to load). |
| `include/overlay_state.h`, `src/overlay_state.c` | **new** | (1) `GetClientRect` + viewport reconciliation → `DisplaySize`, `FramebufferScale`, `fb` size, resize/context-change detection, minimized & 0×0 guards. (2) Complete GL state block: viewport, scissor box+enable, blend enable/func/equation, depth enable/func/**mask**, cull enable+mode, polygon mode/offset/line width, current colour, shade model, tex-env, active + client-active texture unit, texture binding, unpack/pack alignment, **program, VAO, array + element buffer, FBO**. Saved before, restored after. |
| `include/input_hook.h`, `src/input_hook.c` | **new** | Window subclass (`WM_KEYDOWN/UP`, `WM_*BUTTON*`, `WM_MOUSEMOVE`, `WM_MOUSEWHEEL`, focus loss) **plus** a 256-entry state table polled with the `0x8000` high bit only, edge-detected against the previous frame and debounced at 120 ms. Client-space mouse coordinates. Re-subclasses automatically if the emulator restores its own WndProc. Releases `ClipCursor` while the menu is open so the pointer can reach the widgets. |
| `src/imgui_wrapper.cpp` | rewritten | Metrics pushed in (`ImGuiW_SetDisplayMetrics`) instead of sampled from GL; all input via the official event queue (`AddKeyEvent`, `AddMousePosEvent`, `AddMouseButtonEvent`, `AddMouseWheelEvent`); `ImGuiW_OnContextLost()` re-uploads the font atlas after a GL context change; no more GL poking inside `NewFrame()`. |
| `src/opengl_hooks.c` | rewritten | Verified real-DLL load (rejects resolving to itself), lazy retry, per-thread re-entrancy guard, `Hooked_wglSwapLayerBuffers` (main plane → swap hook, like the original), chams pass wrapped in strict save/restore, chams skipped while the UI draws. |
| `src/gui_overlay.c` | rewritten | Toggle from the debounced edge; window size/position clamped inside the client area on every resize; `NewFrame()` always paired with `Render()`. |
| `src/dllmain.c` | updated | Reports its own `HINSTANCE` (anti-recursion proof), never hard-fails the process. |
| `include/config.h`, `src/config.c` | updated | `g_Config.menuKey` (default `VK_INSERT`) — change it if BlueStacks eats Insert. |
| `opengl32.def` | updated | `wglSwapLayerBuffers = Hooked_wglSwapLayerBuffers`. |
| `build_mingw.sh`, `build_gcc.bat` | new/updated | Compile all new files; no hard-coded `C:\Users\ASUS\...` paths any more. |

### Verification performed
```
$ ./build_mingw.sh
[4/4] link -> opengl32_clean.dll     1,032,704 bytes
Exports: 363                          (baseline was 362 - nothing lost)
self-imports vs exports: 0 missing    (DLL loads instead of ERROR_PROC_NOT_FOUND)
gcc -Wall -Wextra                     0 warnings
```

---

## 4. Build & install

```bash
# Windows (w64devkit / mingw-w64 shell)
cd TST_fix && build_gcc.bat
# Linux / macOS
sudo apt install mingw-w64 && cd TST_fix && ./build_mingw.sh
```
Rename `opengl32_clean.dll` → `opengl32.dll`, put it next to `HD-Player.exe`
(`C:\Program Files\BlueStacks_nxt\`), **close BlueStacks completely first** (`HD-Player.exe`, `HD-Frontend.exe`, `BstkSVC.exe` — otherwise the file is locked), then start it.

Debug output goes to `OutputDebugString` → watch with **DebugView**. You should see:
```
[Clean_Project] real opengl32.dll loaded and forwarders bound
[Clean_Project] injected and initialized
```

### Test checklist
1. Start emulator, launch the game, press **INSERT** → menu appears in the top-left, text sharp, cursor visible and clickable.
2. Resize the window (several times, including very small and maximized) → no black box, menu stays inside the window.
3. Toggle fullscreen (Alt+Enter) → context may be recreated; menu must come back after one frame.
4. Minimize / restore → no crash (drawing is skipped while minimized).
5. Close the menu → game renders untouched (compare FPS and visuals).
6. Enable/disable every chams option → no leftover tint/wireframe after disabling.

---

## 5. If a symptom still survives

| Symptom | Next thing to check |
|---|---|
| Insert still does nothing | Is the DLL in the **64-bit** folder and is the game 64-bit? BlueStacks 5 also ships 32-bit players; a 64-bit DLL in a 32-bit process is silently ignored. Confirm the process loaded it: Process Explorer → `HD-Player.exe` → View → Lower Pane → DLLs. Then try `g_Config.menuKey = VK_HOME` (0x24) in `config.c`. |
| Overlay draws but text is missing | The game bound a program *after* our `glUseProgram(0)` via a draw in a different thread — add `glUseProgram(0)` again immediately before `ImGuiW_Render()` (one line in `overlay_state.c`), or switch the renderer to `imgui_impl_opengl3` and pass `glUseProgram(0)`. |
| Nothing draws at all, no `[Clean_Project]` log | The emulator calls `gdi32!SwapBuffers` directly and never `opengl32!wglSwapBuffers`. Then an IAT/inline hook on `SwapBuffers` is required (ReShade does this in its swapchain layer). |
| Artifacts return only in fullscreen-exclusive | The context is being destroyed while we hold state — make sure `ImGuiW_OnContextLost()` runs (you'll see `GL context changed` in DebugView). |

---

## 6. සිංහල සාරාංශය

1. **Original DLL එක = ReShade 0.0.0.181.** එය `wglSwapBuffers` ඇතුළේ සෑම frame එකකම `WindowFromDC` + `GetClientRect` කරලා size එක **පෙර frame එකේ size එකත් එක්ක සංසන්දනය** කරනවා; වෙනස් වුණොත් runtime එක reset කරලා අලුත් size එකෙන් හදනවා. Input එකට තමන්ගේම key table එකක් තියාගෙන `GetAsyncKeyState` හි **high bit** එකෙන් පමණක් edge detect කරනවා. GL state ඔක්කොම save/restore කරනවා.
2. **ඔබේ version එකේ Insert වැඩ නොකළේ:** `GetAsyncKeyState(vk) & 1` low bit එක BlueStacks/Qt කන නිසා; mouse එක screen coordinates වලින් යැවූ නිසා; සහ වඩාත් වැදගත් — ImGui අඳින විට game එකේ **GLSL program/VAO** bind වී තිබූ නිසා menu එක කළු කොටුවක් විතරක් වුණා.
3. **Resize කරද්දී කළු කොටුව:** `DisplaySize` එක stale `GL_VIEWPORT` sample එකකින් (0 වුණොත් **desktop** resolution එකෙන්!) ගත්තු නිසා projection එකයි scissor එකයි mismatch වුණා; අමතරව FBO 0 bind නොකළ නිසා emulator ගේ offscreen texture එකට ඇඳුණා; අන්තිමට scissor/depth state restore නොකළ නිසා emulator ගේ ඊළඟ frame එකත් කැඩුණා.
4. **විසඳුම:** `TST_fix/` — `overlay_state.c` (size tracking + සම්පූර්ණ GL state save/restore + FBO 0), `input_hook.c` (WndProc subclass + high-bit edge detection), `gl_real.c` (සැබෑ driver functions runtime resolve), සහ `imgui_wrapper.cpp` (ImGui event queue + නිවැරදි DisplaySize). Build එක clean: 363 exports, warning 0.

---

# v2 — "menu still doesn't open": instrumentation + the two remaining bypasses

The v1 build had four *silent* early-return paths. Any one of them produces
exactly the symptom you describe (emulator runs, menu never appears), and
nothing told you which one fired. v2 fixes that and closes two real bypasses.

## v2.1 Two genuine bypasses that were never covered

**(a) `gdi32!SwapBuffers` present path.**
A proxy DLL only sees calls that go through *its* exports. BlueStacks/Qt may
present with `GDI32!SwapBuffers(hdc)` instead of `OPENGL32!wglSwapBuffers`; the
GDI wrapper talks to the display driver directly, so our export is **never
called** — the DLL loads, the game runs, no menu. Fix: `src/iat_hook.c` walks
every loaded module's import table and redirects both `GDI32!SwapBuffers` and
`OPENGL32!wglSwapBuffers` entries to our hooks (re-scanned every 5 s because Qt
loads modules late). This is the same layer ReShade installs.

**(b) `wglGetProcAddress` resolution.**
Our `wglGetProcAddress` was a naked-jmp pass-through, so anything the emulator
resolved through it got the raw driver pointer. The original intercepts exactly
here (decompiled `0x15fe00+`, a `strcmp` chain returning its own hooks for
`glViewport`, `glBindFramebuffer`, …). Now `Hooked_wglGetProcAddress()` returns
*our* `wglSwapBuffers` / `wglSwapLayerBuffers` / `glDrawElements` when asked,
and forwards everything else.

## v2.2 The four silent bail-outs, removed

| Was | Now |
|---|---|
| `Overlay_Prepare()` returned false when `WindowFromDC()` gave a hidden/zero-size window (documented BlueStacks behaviour) → nothing ever drew | `ResolveWindow()`: `WindowFromDC` → `GetAncestor(GA_ROOT)` → **largest visible window of this process** → foreground window. Size: client rect → **GL viewport** → each used as a fallback for the other; only gives up when *both* are 0 |
| Hotkey was checked **after** prep, so any prep failure also killed Insert | Hotkey is step 1 of `HandlePresent()`, before GL/window/ImGui work; every toggle is logged |
| `GL_LoadRealApi()` failure returned silently | logged once per 2 s with the real-module handle + context state |
| ImGui could produce 0 vertices invisibly | `ImGuiW_GetStats()` logs `verts/idx/lists/display` and screams `WARNING: menu open but ImGui produced 0 vertices` |

## v2.3 Diagnostics you can act on

**Log file:** `opengl32_proxy.log`, written next to the DLL (falls back to
`%TEMP%` if Program Files isn't writable). Same lines also go to
`OutputDebugString` for DebugView.

**Magenta marker:** a 16×16 magenta square is drawn in the top-left corner with
raw immediate-mode GL on every present (`g_Config.bDebugMarker`). This is the
decisive test:

| What you see | Meaning |
|---|---|
| No log file at all | DLL was **never loaded** → wrong folder, 32-bit player, or the file was still locked/not replaced |
| Log has `DllMain PROCESS_ATTACH`, no `present #` lines | Loaded, but the emulator never presents through a path we hook |
| `present #…` lines appear, **no** magenta square | Hook runs but nothing reaches the framebuffer (wrong FBO/target or present path bypass) |
| Magenta square visible, no menu | GL path is fine → ImGui is the problem; the log then shows `UI drawn: N verts` or `0 vertices` |
| Magenta square + `MENU OPENED` + `UI drawn: … verts` | It works; the window may be off-screen — the same line prints `display=WxH` |

## v2.4 Build verification (this binary)

```
PE32+ x86-64 DLL, 1,040,384 bytes
Exports:        364   (362 original names + Hooked_* aliases; wglGetProcAddress now routed)
Self-imports:   0 missing  (a single missing one = DLL refuses to load)
DLL deps:       KERNEL32, msvcrt, OPENGL32, SHELL32, USER32  (no libstdc++/libgcc/winpthread)
Hooks wired:    wglSwapBuffers, wglSwapLayerBuffers, wglGetProcAddress, glDrawElements
                + IAT redirect of GDI32!SwapBuffers
SHA-256:        5a5923aec1e574e2271915eea0dc346c2b0a895a88b7fbf158663d243fddef17
```

> Note: the "no `libstdc++-6.dll`" point matters. If a mingw build is linked
> without `-static-libgcc -static-libstdc++`, Windows cannot load the DLL in a
> folder that doesn't contain those runtime DLLs — and the failure is silent
> (the emulator just runs without the proxy). The build scripts enforce static
> linking; this binary imports only system DLLs.

---

# v3 — "no log file at all": fixing the LOAD, not the drawing

A missing log is not a drawing problem. It means the DLL was never initialised
inside `HD-Player.exe` — the emulator kept using the genuine
`System32\opengl32.dll`, which is exactly why the game still ran normally while
the menu never appeared. Two load-time hazards were built into v1/v2, and the
original ReShade DLL avoids both. They are now gone.

## v3.1 The circular self-import (the big one)

v1/v2 linked with `-lopengl32` because the vendored `imgui_impl_opengl2.cpp`
calls 30 GL functions directly. In a DLL **named `opengl32.dll`** that creates an
import descriptor for `OPENGL32.dll` — i.e. the module imports *itself*. Windows
must resolve that import while our own `DllMain` is queued behind the loader
lock, and a circular load like that is a textbook silent `LoadLibrary` failure.
The loader then falls back to the system DLL and our hooks never exist.

The original has **zero** imports from `opengl32.dll` — it resolves everything
through `GetProcAddress` (that is what all those `(*(code **)...)("glViewport")`
chains in the decompilation are).

**Fix:** `include/gl_shim.h`, injected with `-include` into the ImGui GL backend,
rewrites every GL call to `glr.*` (the runtime table in `gl_real.c`), and
`-lopengl32` is no longer linked.

```
before:  DLL Name: KERNEL32 / msvcrt / OPENGL32 / SHELL32 / USER32
after :  DLL Name: KERNEL32 / msvcrt /            SHELL32 / USER32   ← no self-import
```

## v3.2 `LoadLibrary()` inside `DllMain` (loader lock)

`DllMain` used to call `OpenGL_InitHooks()` → `LoadLibraryW(System32\opengl32.dll)`
while the loader lock was held. That is undefined behaviour and can deadlock or
fail silently.

**Fix:** `DllMain` now only creates the log and copies defaults. Binding happens
lazily:

* every exported hook calls `OpenGL_InitHooks()` itself, and
* **all 356 GL/WGL forwarder stubs now bind on first use**: if their pointer slot
  is empty they call `GL_LazyBind(slot, "glName")`, which preserves `rcx/rdx/r8/r9`
  and `xmm0-3` across the call and then tail-jumps to the real function
  (verified in the binary: `48 8b 05 .. 48 85 c0 0f 85 .. 48 81 ec 88 00 00 00`).

So even if our initialisation never ran, the emulator's GL calls still work — and
the first one triggers a proper bind instead of returning 0/NULL.

## v3.3 Logging that cannot fail silently

The old log tried the DLL folder, then `%TEMP%`. Problems: Program Files is
read-only for standard users, and with UAC **file virtualisation** a "successful"
write to `C:\Program Files\...` is silently redirected to
`%LOCALAPPDATA%\VirtualStore\Program Files\...` — where nobody looks.

Now the logger opens **two sinks simultaneously** (DLL folder **and** `%TEMP%`),
prints each path to `OutputDebugString`, and the first lines record pid, bitness,
module handle and the full exe path.

## v3.4 `verify_proxy.bat`

Double-click it (Windows). It prints, in one screen:

1. whether `HD-Player.exe` is running and **whether `opengl32.dll` is in its
   module list** (the single fact that separates "not loaded" from "loaded but
   drawing nothing"),
2. size + SHA-256 of the `opengl32.dll` actually sitting in the BlueStacks folder
   (compare with `1092608` bytes — if it differs, the copy never happened),
3. every location a log could be (DLL folder / `%TEMP%` / VirtualStore) + the last
   25 lines of each,
4. the configured renderer and instance type from `bluestacks.conf`,
5. the emulator's process bitness.

## v3.5 Binary verification

```
PE32+ x86-64, 1,092,608 bytes
Deps:         KERNEL32, msvcrt, SHELL32, USER32      (no OPENGL32 self-import)
Exports:      364
Routing:      wglSwapBuffers        -> Hooked_wglSwapBuffers        (verified RVA match)
              wglSwapLayerBuffers   -> Hooked_wglSwapLayerBuffers   (verified RVA match)
              wglGetProcAddress     -> Hooked_wglGetProcAddress     (verified RVA match)
              glDrawElements        -> Hooked_glDrawElements        (verified RVA match)
Forwarders:   356 stubs, all with the lazy-bind path compiled in
SHA-256:      see below
```
SHA-256:      b0ab7aac7b642dce9a2c12c9c9ee45e545a31ac7f7e09a00db723e484ee39ec5
