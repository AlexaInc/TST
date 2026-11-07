/**
 * config.c - Global Configuration Implementation (Photoshop-style Glow Defaults)
 * 
 * [English] Sets up default settings for Photoshop-like Stroke & Glow:
 *           - Default Glow Mode: GLOW_OUTER
 *           - Default Stroke Size: 2.5 pixels
 *           - Default Glow Intensity: 1.0x (100%)
 *           - Default Stroke Color: Vibrant Golden Yellow (RGBA: 1.0, 0.85, 0.0, 0.95)
 * [සිංහල] Photoshop Stroke & Glow සඳහා default අගයන්:
 *         - Glow Mode: GLOW_OUTER (පිටතට පැතිරෙන Glow එක)
 *         - Stroke Size: 2.5 pixels
 *         - Glow Intensity: 1.0x
 *         - Stroke Color: දීප්තිමත් රන්වන් කහ පාට
 */

#include "../include/config.h"

// Global config instance
CheatConfig g_Config;

void Config_InitDefaults(void)
{
    // [Overlay]
    g_Config.menuKey                = VK_INSERT; // 0x2D - same as the original build
    g_Config.bDebugMarker           = true;      // magenta marker; false when done
    g_Config.diagMode               = 0;         // F10 cycles 0 -> 1 -> 2 (0 = no marker)
    g_Config.fMouseSensitivity      = 1.0f;      // tune in the menu if the cursor races
    g_Config.bOverlayUseBoundFBO    = true;      // ReShade behaviour: keep bound FBO

    // [Master Toggles]
    g_Config.bVisibilityChams       = false; // OFF by default: the DLL must not touch the scene until you enable it
    g_Config.bVisibleColorOverride  = false; // false = Normal textures in front of wall

    // [Behind Wall - Highlight]
    g_Config.bBehindWallHighlight   = false; // Switch 1: Solid Fill (Highlight)

    // [Behind Wall - Photoshop-Style Stroke & Glow]
    g_Config.bBehindWallStroke      = false; // Switch 2: Stroke / Glow Enable Switch
    g_Config.glowMode               = GLOW_OUTER; // Default: Outer Glow
    g_Config.fStrokeSize            = 2.5f;  // Default line width: 2.5px
    g_Config.fGlowIntensity         = 1.0f;  // Default glow intensity: 100%

    // Other Standalone Modes
    g_Config.bBaseChams             = false;
    g_Config.bWireframeChams        = false;
    g_Config.bBorderChams           = false;

    // =========================================================================
    // Color Configurations (RGBA)
    // =========================================================================

    // Behind Wall - Highlight Fill: Vibrant Red (රතු පාට)
    g_Config.colBehindHighlight[0] = 1.0f;
    g_Config.colBehindHighlight[1] = 0.1f;
    g_Config.colBehindHighlight[2] = 0.1f;
    g_Config.colBehindHighlight[3] = 0.8f;

    // Behind Wall - Stroke & Glow: Vibrant Golden Yellow (රන්වන් කහ පාට)
    g_Config.colBehindStroke[0]    = 1.0f;
    g_Config.colBehindStroke[1]    = 0.85f;
    g_Config.colBehindStroke[2]    = 0.0f;
    g_Config.colBehindStroke[3]    = 0.95f;

    // In Front of Wall: Neon Green (කොළ පාට)
    g_Config.colVisible[0]         = 0.0f;
    g_Config.colVisible[1]         = 1.0f;
    g_Config.colVisible[2]         = 0.2f;
    g_Config.colVisible[3]         = 1.0f;

    // Base Chams: Cyan / Blue (නිල් පාට)
    g_Config.colBase[0]            = 0.0f;
    g_Config.colBase[1]            = 0.6f;
    g_Config.colBase[2]            = 1.0f;
    g_Config.colBase[3]            = 1.0f;

    // Border Chams: Yellow
    g_Config.colBorder[0]          = 1.0f;
    g_Config.colBorder[1]          = 1.0f;
    g_Config.colBorder[2]          = 0.0f;
    g_Config.colBorder[3]          = 1.0f;

    // Wireframe: Magenta
    g_Config.colWireframe[0]       = 1.0f;
    g_Config.colWireframe[1]       = 0.0f;
    g_Config.colWireframe[2]       = 1.0f;
    g_Config.colWireframe[3]       = 1.0f;
}
