# ReShade 64-bit Proxy & OpenGL Architecture (Cleaned)
**Target Binary:** `opengl32.dll` (crosire ReShade 64-bit Mod for Unity / Free Fire Emulator)  
**Status:** **Per-Pixel `GL_GREATER` Occlusion Testing (Corner Peeking) Implemented**  
**Documentation:** Bilingual (සිංහල & English)

---

## 🎯 සතුරා බිත්තියකින් බාගයක් එළියේ සහ බාගයක් ඇතුළේ සිටින විට (Partial Occlusion / Peeking):

ඔබ පෙන්වා දුන් කරුණ 3D Graphics වල ඉතා වැදගත් ගැටලුවකි. සාමාන්‍යයෙන් `glDisable(GL_DEPTH_TEST)` කළ විට Highlight සහ Stroke මුළු model එක මතම ඇඳෙන නිසා, බිත්තියෙන් එළියේ ඇති කොටසටත් එය වැටේ.

මෙය 100% ක් නිවැරදි කිරීමට **OpenGL හි `glDepthFunc(GL_GREATER)`** යොදා ගන්නා ලදී:

```
                  [ CAMERA ]
                      │
            ──────────┼──────────
                      │
           [ WALL ]   │   [ OPEN AIR ]
           (Z = 10)   │
              │       │        │
              ▼       │        ▼
         [ Enemy Part 1 ]  [ Enemy Part 2 ]
        (Hidden Behind)    (Visible Peeking)
           (Z = 20)           (Z = 20)
              │                    │
              ▼                    ▼
     Z(Enemy) > Z(Wall)    Z(Enemy) <= Z(Scene)
      (20 > 10) -> TRUE!   (20 <= 20) -> FALSE!
              │                    │
              ▼                    ▼
       [ PASSES TEST ]       [ FAILS TEST ]
      Renders Highlight     NOTHING Drawn!
          & Stroke!         100% Normal Textures!
```

---

### ක්‍රියාත්මක වන ආකාරය:

1. **`glDepthFunc(GL_GREATER)`:**
   * සතුරාගේ පික්සල් එකේ ගැඹුර (Z-Depth) ඉදිරියෙන් ඇති බිත්තියේ ගැඹුරට වඩා වැඩි නම් පමණක් (එනම් බිත්තිය පිටුපස සඟවා ඇති පික්සල් වලට පමණක්) Highlight සහ Stroke යොදයි.
   * බිත්තියෙන් එළියේ (Open air) ඇති පික්සල් `GL_GREATER` පරීක්ෂාවෙන් **Fail** වේ!
2. **`bVisibleColorOverride = false`:**
   * එළියේ ඇති පික්සල් වලට කිසිදු override එකක් නොවන නිසා, Game එකේ සැබෑ **Normal Textures, Skins, සහ Lighting** 100% ක්ම ඒ ආකාරයෙන්ම පෙනේ!
   * Highlight සහ Stroke එක පික්සල් එකක්වත් එළියේ ඇති කොටසට බේරී එන්නේ (bleed වෙන්නේ) නැත!
