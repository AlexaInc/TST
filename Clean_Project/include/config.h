/**
 * config.h - Global Configuration, Types & State (Updated with GL_GREATER Depth Constants)
 * 
 * [English] Added GL_GREATER (0x0204) and GL_LEQUAL (0x0203) for precise per-pixel
 *           depth-tested occlusion rendering (peeking around corners).
 * [සිංහල] සතුරා බිත්තියෙන් බාගයක් එළියේ සහ බාගයක් ඇතුළේ සිටින විට, ඇතුළත කොටසට පමණක්
 *         Highlight/Stroke ලැබීමට අවශ්‍ය GL_GREATER (0x0204) සහ GL_LEQUAL (0x0203) constants.
 */

#ifndef CONFIG_H
#define CONFIG_H

#include <windows.h>
#include <stdbool.h>

// ==============================================================================
// 1. OpenGL Constants (OpenGL සඳහා අවශ්‍ය අගයන්)
// ==============================================================================
#define GL_DEPTH_TEST            0x0B71  // Ghidra: 0xb71  - ගැඹුර පරීක්ෂා කිරීම (Depth testing)
#define GL_LEQUAL                0x0203  // Z-Buffer: Less than or Equal (සාමාන්‍ය ඉදිරිපස පරීක්ෂාව)
#define GL_GREATER               0x0204  // Z-Buffer: Greater than (බිත්තිය පිටුපස පමණක් තෝරාගැනීම!)
#define GL_BLEND                 0x0BE2  // Ghidra: 0xbe2  - විනිවිද පෙනීම (Color blending)
#define GL_CULL_FACE             0x0B44  // Backface culling
#define GL_FRONT_AND_BACK        0x0408  // Ghidra: 0x408  - Polygons දෙපැත්තම
#define GL_FRONT                 0x0404  // ඉදිරිපස
#define GL_BACK                  0x0405  // පසුපස
#define GL_LINE                  0x1B01  // Ghidra: 0x1b01 - Wireframe / Stroke දැලක් ලෙස ඇඳීම
#define GL_FILL                  0x1B02  // Ghidra: 0x1b02 - සාමාන්‍ය solid ලෙස පිරවීම
#define GL_TRIANGLES             0x0004  // Ghidra: 4      - 3D Triangles mesh
#define GL_CURRENT_PROGRAM       0x8B8D  // Ghidra: 0x8b8d - දැනට ක්‍රියාත්මක Shader Program ID එක
#define GL_SRC_ALPHA             0x0302  // Blending source alpha
#define GL_ONE_MINUS_SRC_ALPHA   0x0303  // Blending 1 - source alpha
#define GL_ONE                   1       // Additive blending (Glow effect)

// ==============================================================================
// 2. Photoshop-style Glow Position Enum (Glow පිහිටීම තෝරන Enum එක)
// ==============================================================================
typedef enum {
    GLOW_OUTER  = 0, // [Outer Glow]: Silhouette එකෙන් පිටතට පැතිරෙන Glow එක
    GLOW_CENTER = 1, // [Center Stroke]: Model එකේ දාරය හරි මැද පිහිටන Stroke එක
    GLOW_INNER  = 2  // [Inner Glow]: Model එක ඇතුළට පමණක් විහිදෙන Glow එක
} GlowPositionMode;

// ==============================================================================
// 3. Global Feature Toggles (Features On/Off කරන Flags)
// ==============================================================================
typedef struct {
    // Overlay / menu
    int  menuKey;                // Hotkey that toggles the menu (default VK_INSERT)
    bool bDebugMarker;           // kept for compatibility (see diagMode)
    int  diagMode;               // 0 = off, 1 = magenta marker quad,
                                 // 2 = clear whole frame magenta (proves which
                                 //     surface we are drawing into). F10 cycles.
    float fMouseSensitivity;     // virtual cursor: raw mouse counts -> client px
                                 // 1.0 = 1:1. Lower it if the cursor races.
    bool bOverlayUseBoundFBO;    // true  = draw into whatever framebuffer the
                                 //         emulator had bound at swap time
                                 //         (this is what ReShade does)
                                 // false = force the window backbuffer (FBO 0)

    // Master Chams Switch
    bool bVisibilityChams;       // DAT_1803afe7a: Chams ප්‍රධාන Switch එක

    // Behind-Wall Solid Highlight Switch
    bool bBehindWallHighlight;   // Switch 1: Solid Color Fill (Highlight)
    float colBehindHighlight[4]; // Highlight fill color (RGBA)

    // Photoshop-Style Stroke & Glow Controls
    bool bBehindWallStroke;      // Switch 2: Stroke / Glow Enable Switch
    GlowPositionMode glowMode;   // GLOW_OUTER, GLOW_CENTER, GLOW_INNER
    float fStrokeSize;           // Stroke line thickness (0.5px - 10.0px)
    float fGlowIntensity;        // Glow brightness & alpha multiplier (0.1x - 2.0x)
    float colBehindStroke[4];    // Stroke & Glow RGBA Color

    // In Front of Wall (Line of Sight) Toggle
    bool bVisibleColorOverride;  // false = 100% Normal in-game textures in front of walls!
    float colVisible[4];         // Visible color (RGBA)

    // Other Chams Modes
    bool bBaseChams;
    bool bWireframeChams;
    bool bBorderChams;
    float colBase[4];
    float colBorder[4];
    float colWireframe[4];

} CheatConfig;

// External global instance of config
extern CheatConfig g_Config;

// Initialize default configuration values
void Config_InitDefaults(void);

#endif // CONFIG_H
