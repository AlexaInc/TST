/**
 * opengl_hooks.c - OpenGL Hooking Engine with Per-Pixel Depth-Tested Occlusion
 * 
 * [English] Implements precise per-pixel depth testing:
 *           - Uses glDepthFunc(GL_GREATER) so the Highlight & Stroke render ONLY
 *             on the pixels hidden BEHIND walls!
 *           - If a player is peeking around a corner (half inside, half outside),
 *             the outside part FAILS the GL_GREATER test, leaving it 100% normal,
 *             while the inside part PASSES and renders the Highlight/Stroke!
 * [සිංහල] සතුරා බිත්තියකින් බාගයක් එළියේ සහ බාගයක් ඇතුළේ සිටින විට (Peeking):
 *         - glDepthFunc(GL_GREATER) මඟින් බිත්තිය පිටුපස ඇති පික්සල් වලට පමණක්
 *           Highlight සහ Stroke යොදයි!
 *         - එළියේ ඇති කොටස GL_GREATER පරීක්ෂාවෙන් Fail වන නිසා, එහි කිසිදු Stroke එකක්
 *           හෝ පාටක් නොවැටී Game එකේ 100% Normal Textures ඒ ආකාරයෙන්ම පවතී!
 */

#include <windows.h>
#include <stdio.h>
#include "../include/config.h"
#include "../include/opengl_hooks.h"
#include "../include/gui_overlay.h"
#include "../include/gl_forwarders.h"
#include "../include/imgui_wrapper.h"

// Handle to the genuine Windows system opengl32.dll
static HMODULE g_hOriginalDll = NULL;

// Function pointers to genuine system routines
pfn_wglSwapBuffers       g_orig_wglSwapBuffers       = NULL;
pfn_wglGetProcAddress    g_orig_wglGetProcAddress    = NULL;
pfn_glDrawElements       g_orig_glDrawElements       = NULL;
pfn_glEnable             g_orig_glEnable             = NULL;
pfn_glDisable            g_orig_glDisable            = NULL;
pfn_glColor4f            g_orig_glColor4f            = NULL;
pfn_glPolygonMode        g_orig_glPolygonMode        = NULL;
pfn_glLineWidth          g_orig_glLineWidth          = NULL;
pfn_glPolygonOffset      g_orig_glPolygonOffset      = NULL;
pfn_glCullFace           g_orig_glCullFace           = NULL;
pfn_glBlendFunc          g_orig_glBlendFunc          = NULL;
pfn_glDepthFunc          g_orig_glDepthFunc          = NULL;
pfn_glDepthMask          g_orig_glDepthMask          = NULL;
pfn_glGetUniformLocation g_orig_glGetUniformLocation = NULL;
pfn_glGetIntegerv        g_orig_glGetIntegerv        = NULL;

/**
 * OpenGL_InitHooks:
 * Resolves all core OpenGL routines from C:\Windows\System32\opengl32.dll
 */
bool OpenGL_InitHooks(void)
{
    if (g_hOriginalDll != NULL)
        return true;

    char systemPath[MAX_PATH];
    GetSystemDirectoryA(systemPath, MAX_PATH);
    strcat_s(systemPath, sizeof(systemPath), "\\opengl32.dll");

    g_hOriginalDll = LoadLibraryA(systemPath);
    if (!g_hOriginalDll)
    {
        return false;
    }

    // Resolve essential OpenGL entry points
    g_orig_wglSwapBuffers       = (pfn_wglSwapBuffers)GetProcAddress(g_hOriginalDll, "wglSwapBuffers");
    g_orig_wglGetProcAddress    = (pfn_wglGetProcAddress)GetProcAddress(g_hOriginalDll, "wglGetProcAddress");
    g_orig_glDrawElements       = (pfn_glDrawElements)GetProcAddress(g_hOriginalDll, "glDrawElements");
    g_orig_glEnable             = (pfn_glEnable)GetProcAddress(g_hOriginalDll, "glEnable");
    g_orig_glDisable            = (pfn_glDisable)GetProcAddress(g_hOriginalDll, "glDisable");
    g_orig_glColor4f            = (pfn_glColor4f)GetProcAddress(g_hOriginalDll, "glColor4f");
    g_orig_glPolygonMode        = (pfn_glPolygonMode)GetProcAddress(g_hOriginalDll, "glPolygonMode");
    g_orig_glLineWidth          = (pfn_glLineWidth)GetProcAddress(g_hOriginalDll, "glLineWidth");
    g_orig_glPolygonOffset      = (pfn_glPolygonOffset)GetProcAddress(g_hOriginalDll, "glPolygonOffset");
    g_orig_glCullFace           = (pfn_glCullFace)GetProcAddress(g_hOriginalDll, "glCullFace");
    g_orig_glBlendFunc          = (pfn_glBlendFunc)GetProcAddress(g_hOriginalDll, "glBlendFunc");
    g_orig_glDepthFunc          = (pfn_glDepthFunc)GetProcAddress(g_hOriginalDll, "glDepthFunc");
    g_orig_glDepthMask          = (pfn_glDepthMask)GetProcAddress(g_hOriginalDll, "glDepthMask");
    g_orig_glGetIntegerv        = (pfn_glGetIntegerv)GetProcAddress(g_hOriginalDll, "glGetIntegerv");

    // glGetUniformLocation extension
    if (g_orig_wglGetProcAddress)
    {
        g_orig_glGetUniformLocation = (pfn_glGetUniformLocation)g_orig_wglGetProcAddress("glGetUniformLocation");
    }

    // Initialize all 358 GL/WGL forwarder stubs (no DEF circular dependency)
    // [සිංහල] Circular dependency fix: DEF file forward bedalu C naked stubs 358 load
    GL_ForwardersInit(g_hOriginalDll);

    return true;
}

void OpenGL_ShutdownHooks(void)
{
    if (g_hOriginalDll)
    {
        FreeLibrary(g_hOriginalDll);
        g_hOriginalDll = NULL;
    }
}

__declspec(dllexport) BOOL WINAPI Hooked_wglSwapBuffers(HDC hdc)
{
    if (!g_orig_wglSwapBuffers)
    {
        OpenGL_InitHooks();
    }

    // Initialize ImGui on first frame (needs valid HDC/OpenGL context)
    // [සිංහල] Palaweni frame-edi ImGui init karanawa (HDC/OpenGL context onna)
    if (!ImGuiW_IsInitialized())
    {
        ImGuiW_Init(hdc);
    }

    // Render the Dear ImGui in-game menu
    GUI_Render();

    // Call genuine wglSwapBuffers to present the final frame
    if (g_orig_wglSwapBuffers)
    {
        return g_orig_wglSwapBuffers(hdc);
    }

    return FALSE;
}

/**
 * Hooked_glDrawElements:
 * Intercepts Unity Engine player models using "_CharaLightIntensity" uniform.
 * Uses GL_GREATER depth testing to selectively affect ONLY occluded pixels behind walls!
 */
__declspec(dllexport) void WINAPI Hooked_glDrawElements(unsigned int mode, int count, unsigned int type, const void* indices)
{
    // [Step 1]: Call original draw call first with default game state.
    // This draws the player normally. If the player is partially in front of a wall (peeking),
    // the visible part renders with normal game textures, lighting, and materials!
    if (g_orig_glDrawElements)
    {
        g_orig_glDrawElements(mode, count, type, indices);
    }

    // Filter: Triangles (mode 4) and vertex count > 1000 (character meshes)
    if (mode == GL_TRIANGLES && count >= 1000)
    {
        int currentProgram = 0;
        if (g_orig_glGetIntegerv)
        {
            g_orig_glGetIntegerv(GL_CURRENT_PROGRAM, &currentProgram);
        }

        // Unity Shader Identification for Free Fire Character Model
        int charaUniformLoc = -1;
        if (g_orig_glGetUniformLocation && currentProgram != 0)
        {
            charaUniformLoc = g_orig_glGetUniformLocation(currentProgram, "_CharaLightIntensity");
        }

        // Only apply Chams if it is confirmed to be a Player Character Model
        if (charaUniformLoc != -1)
        {
            // ==============================================================
            // Visibility Chams Engine
            // ==============================================================
            if (g_Config.bVisibilityChams)
            {
                if (g_orig_glEnable && g_orig_glColor4f && g_orig_glPolygonMode && g_orig_glDepthFunc && g_orig_glDepthMask)
                {
                    g_orig_glEnable(GL_BLEND);
                    g_orig_glEnable(GL_DEPTH_TEST); // Keep depth test ENABLED!

                    // ==========================================================
                    // CRUCIAL COMPUTER SCIENCE GRAPHICS STEP:
                    // glDepthFunc(GL_GREATER):
                    // Pixels where Depth(Player) > Depth(Wall) PASS (Behind Wall).
                    // Pixels where Depth(Player) <= Depth(Scene) FAIL (In Front of Wall).
                    // This guarantees that if a player is peeking around a wall,
                    // ONLY the hidden part behind the wall receives the Highlight / Stroke!
                    // ==========================================================
                    g_orig_glDepthFunc(GL_GREATER); // 0x0204
                    g_orig_glDepthMask(0);          // Disable depth buffer writing so wall depth is preserved

                    // ----------------------------------------------------------
                    // [Switch 1]: Behind Wall - Solid Color Highlight / Fill
                    // ----------------------------------------------------------
                    if (g_Config.bBehindWallHighlight)
                    {
                        g_orig_glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
                        if (g_orig_glBlendFunc)
                        {
                            g_orig_glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                        }
                        g_orig_glColor4f(g_Config.colBehindHighlight[0],
                                         g_Config.colBehindHighlight[1],
                                         g_Config.colBehindHighlight[2],
                                         g_Config.colBehindHighlight[3]);
                        g_orig_glDrawElements(mode, count, type, indices);
                    }

                    // ----------------------------------------------------------
                    // [Switch 2]: Photoshop-style Stroke & Glow (Outer / Center / Inner)
                    // ----------------------------------------------------------
                    if (g_Config.bBehindWallStroke)
                    {
                        float finalAlpha = g_Config.colBehindStroke[3] * g_Config.fGlowIntensity;
                        if (finalAlpha > 1.0f) finalAlpha = 1.0f;

                        if (g_orig_glLineWidth)
                        {
                            g_orig_glLineWidth(g_Config.fStrokeSize);
                        }

                        g_orig_glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

                        switch (g_Config.glowMode)
                        {
                        case GLOW_OUTER:
                            if (g_orig_glPolygonOffset)
                            {
                                g_orig_glPolygonOffset(-2.0f * g_Config.fStrokeSize, -2.0f * g_Config.fStrokeSize);
                            }
                            if (g_orig_glBlendFunc)
                            {
                                g_orig_glBlendFunc(GL_SRC_ALPHA, GL_ONE); // Additive bloom
                            }
                            break;

                        case GLOW_CENTER:
                            if (g_orig_glPolygonOffset)
                            {
                                g_orig_glPolygonOffset(0.0f, 0.0f);
                            }
                            if (g_orig_glBlendFunc)
                            {
                                g_orig_glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                            }
                            break;

                        case GLOW_INNER:
                            if (g_orig_glPolygonOffset)
                            {
                                g_orig_glPolygonOffset(1.5f * g_Config.fStrokeSize, 1.5f * g_Config.fStrokeSize);
                            }
                            if (g_orig_glBlendFunc)
                            {
                                g_orig_glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                            }
                            break;
                        }

                        g_orig_glColor4f(g_Config.colBehindStroke[0],
                                         g_Config.colBehindStroke[1],
                                         g_Config.colBehindStroke[2],
                                         finalAlpha);
                        g_orig_glDrawElements(mode, count, type, indices);

                        if (g_orig_glPolygonOffset)
                        {
                            g_orig_glPolygonOffset(0.0f, 0.0f);
                        }
                        g_orig_glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
                        if (g_orig_glBlendFunc)
                        {
                            g_orig_glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                        }
                    }

                    // ==========================================================
                    // [Pass 2]: In Front of Wall (Line of Sight - GL_LEQUAL)
                    // ==========================================================
                    g_orig_glDepthFunc(GL_LEQUAL); // 0x0203 (Reset to normal front depth test)
                    g_orig_glDepthMask(1);          // Re-enable depth writing

                    if (g_Config.bVisibleColorOverride)
                    {
                        // Custom green color override for visible parts
                        g_orig_glColor4f(g_Config.colVisible[0], g_Config.colVisible[1], g_Config.colVisible[2], g_Config.colVisible[3]);
                        g_orig_glDrawElements(mode, count, type, indices);
                    }
                    // Else: bVisibleColorOverride is FALSE!
                    // Nothing is drawn here! The visible peeking half of the enemy
                    // has ALREADY been rendered in Step 1 with its 100% normal,
                    // unmodified game textures, lighting, and skin!

                    g_orig_glDisable(GL_BLEND);
                }
                return;
            }

            // Standalone Wireframe mode...
            if (g_Config.bWireframeChams)
            {
                if (g_orig_glPolygonMode && g_orig_glDisable && g_orig_glEnable && g_orig_glColor4f)
                {
                    g_orig_glDisable(GL_DEPTH_TEST);
                    g_orig_glEnable(GL_BLEND);
                    g_orig_glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
                    g_orig_glColor4f(g_Config.colWireframe[0], g_Config.colWireframe[1], g_Config.colWireframe[2], 1.0f);
                    g_orig_glDrawElements(mode, count, type, indices);
                    g_orig_glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
                    g_orig_glEnable(GL_DEPTH_TEST);
                    g_orig_glDisable(GL_BLEND);
                }
                return;
            }

            // Standalone Base mode...
            if (g_Config.bBaseChams)
            {
                if (g_orig_glDisable && g_orig_glEnable && g_orig_glColor4f)
                {
                    g_orig_glDisable(GL_DEPTH_TEST);
                    g_orig_glColor4f(g_Config.colBase[0], g_Config.colBase[1], g_Config.colBase[2], 1.0f);
                    g_orig_glDrawElements(mode, count, type, indices);
                    g_orig_glEnable(GL_DEPTH_TEST);
                }
                return;
            }
        }
    }
}
