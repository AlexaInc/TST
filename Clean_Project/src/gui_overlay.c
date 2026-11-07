/**
 * gui_overlay.c - Full ImGui In-Game Menu (via C wrapper)
 *
 * [English] INSERT key toggles menu. NewFrame+Render called EVERY frame.
 *           ImGui requires NewFrame() always matched with Render().
 * [සිංහල] INSERT key menu toggle. NewFrame+Render frame eke eke call krnna ona.
 */

#include <windows.h>
#include <stdbool.h>
#include <shellapi.h>
#include "../include/config.h"
#include "../include/gui_overlay.h"
#include "../include/imgui_wrapper.h"

bool g_bMenuOpen = true;

static bool KeyPressed(int vKey)
{
    return (GetAsyncKeyState(vKey) & 1) != 0;
}

void GUI_InitTheme(void) { /* handled in ImGuiW_Init */ }

void GUI_Render(void)
{
    // INSERT → Toggle menu
    if (KeyPressed(VK_INSERT))
        g_bMenuOpen = !g_bMenuOpen;

    // ImGui not ready yet — skip
    if (!ImGuiW_IsInitialized())
        return;

    // ALWAYS call NewFrame — ImGui requires every NewFrame() matched with Render()
    ImGuiW_NewFrame();

    // Only build UI when menu is open
    if (g_bMenuOpen)
    {
        ImGuiW_SetNextWindowSize(480, 520);

        // Begin always needs matching End() regardless of return value
        bool visible = ImGuiW_Begin("EXT X CHEATS 64BIT CHAMS    ", &g_bMenuOpen);

        if (visible)
        {
            if (ImGuiW_BeginTabBar("#tabs"))
            {
                // ---- TAB 1: Chams ----
                if (ImGuiW_BeginTabItem("Chams"))
                {
                    ImGuiW_BeginChild("chams_child");

                    ImGuiW_Text("=== Master Visibility Chams ===");
                    ImGuiW_Checkbox("Enable Chams (Master Switch)", &g_Config.bVisibilityChams);

                    if (g_Config.bVisibilityChams)
                    {
                        ImGuiW_Separator();
                        ImGuiW_Text("Behind Wall Visuals:");

                        // 1. Solid Highlight
                        ImGuiW_Checkbox("1. Solid Highlight (Fill)", &g_Config.bBehindWallHighlight);
                        if (g_Config.bBehindWallHighlight)
                            ImGuiW_ColorEdit4("Highlight Color##solid", g_Config.colBehindHighlight);

                        // 2. Stroke & Glow
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

                // ---- TAB 2: Infomation ----
                if (ImGuiW_BeginTabItem("Infomation"))
                {
                    ImGuiW_BeginChild("info_child");
                    ImGuiW_Text("EXT X CHEATS 64BIT CHAMS");
                    ImGuiW_Text("Support x32 x64 Player");
                    ImGuiW_Text("Paid DLL - FF Emulator");
                    ImGuiW_Text("Provide by: EXT SHEFAT");
                    ImGuiW_Separator();
                    if (ImGuiW_Button("Join Discord"))
                        ShellExecuteW(NULL, L"open", L"https://discord.gg/nhA2ynFvwS", NULL, NULL, SW_SHOWNORMAL);
                    ImGuiW_EndChild();
                    ImGuiW_EndTabItem();
                }

                ImGuiW_EndTabBar();
            }
        }

        // End MUST be called even if visible==false
        ImGuiW_End();
    }

    // ALWAYS call Render — matches NewFrame above
    ImGuiW_Render();
}
