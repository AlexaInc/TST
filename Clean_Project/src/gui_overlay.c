/**
 * gui_overlay.c - In-game menu (EXT X CHEATS) via the C wrapper
 *
 * [English] Changes vs the previous version:
 *   - toggle comes from the debounced rising edge built in input_hook.c
 *     (GetAsyncKeyState & 1 was being eaten by BlueStacks' own polling),
 *   - window position/size is clamped inside the client area whenever the
 *     emulator window is resized (part of the "black box in the corner" fix),
 *   - the emulator's mouse clip is released while the menu is open so the
 *     cursor can actually reach the widgets,
 *   - NewFrame() is always paired with Render(), even when the menu is closed.
 *
 * [සිංහල] Insert toggle එක දැන් input_hook.c එකේ හදන debounced rising edge
 *         එකෙන් එනවා. Window resize වුණාම menu position/size එක client area
 *         ඇතුළට clamp කරනවා (black box issue එකේ කොටසක්). Menu open ඉද්දී
 *         emulator ගේ mouse clip එක release කරනවා.
 */

#include <windows.h>
#include <stdbool.h>
#include <shellapi.h>
#include "../include/config.h"
#include "../include/gui_overlay.h"
#include "../include/imgui_wrapper.h"
#include "../include/input_hook.h"
#include "../include/overlay_state.h"

bool g_bMenuOpen = true;

static bool s_placed = false;

void GUI_InitTheme(void) { /* handled in ImGuiW_Init */ }

static float MinF(float a, float b) { return a < b ? a : b; }

bool GUI_HandleHotkeys(const InputFrame* in)
{
    /* Debounced rising edge from input_hook.c - never GetAsyncKeyState & 1 */
    int menuKey = g_Config.menuKey > 0 ? g_Config.menuKey : VK_INSERT;
    if (in && in->keyPressed[menuKey])
        g_bMenuOpen = !g_bMenuOpen;

    /* While the menu is open the emulator must not trap the pointer. It re-does
     * ClipCursor() every frame, so keep releasing it. */
    Input_ReleaseCursorForUI(g_bMenuOpen);

    /* Open menu => swallow the game's raw mouse so the camera does not spin
     * while the user works the menu. Closing it restores the game instantly. */
    Input_SetBlockGameInput(g_bMenuOpen);

    return g_bMenuOpen;
}

void GUI_Render(const InputFrame* in, const OverlayFrame* f)
{
    if (!ImGuiW_IsInitialized()) return;

    /* ---- 1. Feed input + start the frame ---------------------------- */
    ImGuiW_FeedInput(in);
    ImGuiW_NewFrame();

    float cw = (float)(f ? f->clientW : 1280);
    float ch = (float)(f ? f->clientH : 720);

    /* Fit the window in small emulator windows; never let it hang off
     * the edge after a resize. */
    float w = MinF(480.0f, cw - 24.0f);
    float h = MinF(520.0f, ch - 24.0f);
    if (w < 240.0f) w = 240.0f;
    if (h < 220.0f) h = 220.0f;

    bool relayout = (!s_placed) || (f && (f->resized || f->firstFrame));
    if (relayout)
    {
        ImGuiW_SetNextWindowSize(w, h, false);
        float x = 60.0f, y = 60.0f;
        if (x + w > cw - 8.0f) x = cw - w - 8.0f;
        if (y + h > ch - 8.0f) y = ch - h - 8.0f;
        if (x < 8.0f) x = 8.0f;
        if (y < 8.0f) y = 8.0f;
        ImGuiW_SetNextWindowPos(x, y);
        s_placed = true;
    }
    else
    {
        ImGuiW_SetNextWindowSize(w, h, true);
    }

    bool visible = ImGuiW_Begin("EXT X CHEATS 64BIT CHAMS", &g_bMenuOpen);

    /* Tell the input hook where the menu is, so clicks inside it are consumed
     * by the overlay instead of reaching the emulator/game underneath. */
    {
        float rect[4] = { 0, 0, 0, 0 };
        ImGuiW_GetCurrentWindowRect(rect);
        Input_SetUiRect(rect[0], rect[1], rect[2], rect[3]);
    }

    if (visible)
    {
        if (ImGuiW_BeginTabBar("#tabs"))
        {
            /* ---------------- TAB 1: Chams ---------------- */
            if (ImGuiW_BeginTabItem("Chams"))
            {
                ImGuiW_BeginChild("chams_child");

                ImGuiW_Text("=== Master Visibility Chams ===");
                ImGuiW_Checkbox("Enable Chams (Master Switch)", &g_Config.bVisibilityChams);

                if (g_Config.bVisibilityChams)
                {
                    ImGuiW_Separator();
                    ImGuiW_Text("Behind Wall Visuals:");

                    ImGuiW_Checkbox("1. Solid Highlight (Fill)", &g_Config.bBehindWallHighlight);
                    if (g_Config.bBehindWallHighlight)
                        ImGuiW_ColorEdit4("Highlight Color##solid", g_Config.colBehindHighlight);

                    ImGuiW_Separator();
                    ImGuiW_Checkbox("2. Stroke & Glow Effect", &g_Config.bBehindWallStroke);
                    if (g_Config.bBehindWallStroke)
                    {
                        ImGuiW_ColorEdit4("Stroke & Glow Color", g_Config.colBehindStroke);
                        ImGuiW_SliderFloat("Stroke Size", &g_Config.fStrokeSize, 0.5f, 10.0f, "%.1f px");
                        ImGuiW_SliderFloat("Glow Intensity", &g_Config.fGlowIntensity, 0.1f, 2.0f, "%.2f x");
                        {
                            const char* modes[] = { "Outer Glow", "Center Stroke", "Inner Glow" };
                            int m = (int)g_Config.glowMode;
                            if (ImGuiW_Combo("Glow Position", &m, modes, 3))
                                g_Config.glowMode = (GlowPositionMode)m;
                        }
                    }

                    ImGuiW_Separator();
                    ImGuiW_Text("In Front of Wall:");
                    ImGuiW_Checkbox("Color Override (Front)", &g_Config.bVisibleColorOverride);
                    if (g_Config.bVisibleColorOverride)
                        ImGuiW_ColorEdit4("Visible Color", g_Config.colVisible);
                    else
                        ImGuiW_TextDisabled("  -> 100% normal textures when visible");
                }

                ImGuiW_Separator();
                ImGuiW_Text("Standalone:");
                ImGuiW_Checkbox("Wireframe Chams", &g_Config.bWireframeChams);
                ImGuiW_Checkbox("Base Chams", &g_Config.bBaseChams);

                ImGuiW_EndChild();
                ImGuiW_EndTabItem();
            }

            /* ---------------- TAB 2: Information ---------------- */
            if (ImGuiW_BeginTabItem("Infomation"))
            {
                ImGuiW_BeginChild("info_child");
                ImGuiW_Text("EXT X CHEATS 64BIT CHAMS");
                ImGuiW_Text("Support x32 x64 Player");
                ImGuiW_Text("Paid DLL - FF Emulator");
                ImGuiW_Text("Provide by: EXT SHEFAT");
                ImGuiW_Separator();
                ImGuiW_TextDisabled("Menu key: INSERT (config: g_Config.menuKey)");
                if (ImGuiW_Button("Join Discord"))
                    ShellExecuteW(NULL, L"open", L"https://discord.gg/nhA2ynFvwS",
                                  NULL, NULL, SW_SHOWNORMAL);
                ImGuiW_EndChild();
                ImGuiW_EndTabItem();
            }

            ImGuiW_EndTabBar();
        }
    }

    ImGuiW_End();   /* must always be paired */

    /* ---- 2. Submit (always paired with NewFrame above) -------------- */
    ImGuiW_Render();
}
