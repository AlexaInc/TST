/**
 * overlay_state.c - Backbuffer tracking + full GL state save/restore
 *
 * [English] Root cause of the two reported bugs, and the fix.
 *
 * BUG 1 - "Insert does not open the menu"
 *   Not an input problem first, a *state* problem: the ImGui draw was issued
 *   with the game's GLSL program + VAO still bound (ImGui's fixed-pipeline
 *   backend cannot reset glUseProgram/glBindVertexArray - it says so in its
 *   own header). Every ImGui triangle then ran through the emulator's shader
 *   with no vertex attributes -> the window background came out as an opaque
 *   black rectangle and the glyph texture was never sampled. Menu "opened",
 *   it just drew nothing recognisable. Also: the wrapper forced
 *   glDisable(GL_SCISSOR_TEST) / glDisable(GL_DEPTH_TEST) and NEVER restored
 *   them, corrupting the emulator's own next frame.
 *
 * BUG 2 - "black box at the top/right after resizing the window"
 *   DisplaySize was taken from glGetIntegerv(GL_VIEWPORT) at an arbitrary
 *   moment. After a resize BlueStacks has a *new* backbuffer but the guest's
 *   viewport/projection lag by a frame, so ImGui projected its geometry with
 *   a stale size while the scissor rectangles were computed for the new one:
 *   the visible result is a solid rectangle anchored in a corner. If the
 *   viewport read as 0 the code fell back to the *desktop* resolution, which
 *   is even further off. The original DLL never does this - it compares
 *   GetClientRect() with the last known size on every present and rebuilds
 *   the runtime when it changes (decompiled wglSwapBuffers, 0x15f600).
 *
 * FIX: correct DisplaySize / FramebufferScale / viewport every frame,
 *      detect resize + context change, and wrap the UI in a complete
 *      save/restore block with FBO 0 bound.
 */

#include <windows.h>
#include <stdbool.h>
#include "../include/gl_real.h"
#include "../include/overlay_state.h"
#include "../include/log.h"
#include "../include/config.h"

/* ------------------------------------------------------------------------- */
/* Saved GL state                                                            */
/* ------------------------------------------------------------------------- */
typedef struct OverlayGLState {
    GLint   viewport[4];
    GLint   scissorBox[4];
    GLint   blend, depth, cull, scissor, lighting, colorMaterial, alphaTest;
    GLint   stencil, multisample, tex2d, fog, polygonOffsetFill;
    GLint   blendSrc, blendDst, blendEquation;
    GLint   depthFunc, depthMask;
    GLint   cullMode;
    GLint   polygonModeFB, polygonModeF, polygonModeB;
    GLint   shadeModel, texEnvMode;
    GLfloat lineWidth, polyFactor, polyUnits, color[4];
    GLint   activeTexture, clientActiveTexture, texBinding2D;
    GLint   unpackAlign, packAlign;
    GLint   drawBuffer, readBuffer, logicOp, colorMask[4];
    GLint   logicOpEnabled;
    GLint   program, vao, arrayBuffer, elementBuffer, fbo;
    bool    haveProgram, haveVao, haveBuffer, haveFbo, haveBlendEquation;
} OverlayGLState;

static OverlayGLState s_saved;
static bool           s_savedValid = false;
static DWORD          s_savedTick  = 0;
static int            s_savedW = 0, s_savedH = 0;
static void*          s_savedCtx = NULL;
static int            s_profile = -1;

/* Called by the draw hook when the *application* issues a draw: the state we
 * cached is no longer guaranteed to be current. */
void Overlay_InvalidateSavedState(void) { s_savedValid = false; }   /* -1 unknown, 1 core, 2 compat, 0 other */

/* Legacy (fixed-function) enums do not exist in a core profile: calling them
 * is not fatal but it floods glGetError with GL_INVALID_ENUM. */
static bool LegacyAllowed(void) { return s_profile != 1; }

int Overlay_GetProfile(void) { return s_profile; }
static bool           s_drawing = 0;
static HWND           s_lastHwnd = NULL;

/* ------------------------------------------------------------------------- */
/* Small helpers                                                             */
/* ------------------------------------------------------------------------- */
static void ClearGLErrors(void)
{
    if (!glr.GetError) return;
    for (int i = 0; i < 8; i++)
        if (glr.GetError() == GL_NO_ERROR) break;
}

static GLint GetInt(GLenum pname, GLint fallback)
{
    GLint v = fallback;
    if (glr.GetIntegerv) { glr.GetIntegerv(pname, &v); ClearGLErrors(); }
    return v;
}

static float ClampF(float v, float lo, float hi)
{
    return v < lo ? lo : (v > hi ? hi : v);
}

/* ------------------------------------------------------------------------- */
/* Window discovery                                                          */
/* ------------------------------------------------------------------------- */
typedef struct FindWinCtx {
    DWORD pid;
    HWND  best;
    LONG  bestArea;
} FindWinCtx;

static BOOL CALLBACK FindWinProc(HWND w, LPARAM lp)
{
    FindWinCtx* c = (FindWinCtx*)lp;
    DWORD pid = 0;
    GetWindowThreadProcessId(w, &pid);
    if (pid != c->pid) return TRUE;
    if (!IsWindowVisible(w)) return TRUE;
    if (GetWindow(w, GW_OWNER) != NULL) return TRUE;   /* skip tool windows */
    RECT rc;
    if (!GetClientRect(w, &rc)) return TRUE;
    LONG area = (rc.right - rc.left) * (rc.bottom - rc.top);
    if (area > c->bestArea) { c->bestArea = area; c->best = w; }
    return TRUE;
}

/* BlueStacks may present through an offscreen/hidden window: WindowFromDC then
 * gives us something useless. Walk up to the root, then fall back to the
 * biggest visible window of this process. */
static HWND ResolveWindow(HDC hdc)
{
    HWND w = NULL;

    if (hdc) {
        w = WindowFromDC(hdc);
        if (w) {
            HWND root = GetAncestor(w, GA_ROOT);
            if (root) w = root;
        }
    }
    if (w && IsWindow(w)) {
        RECT rc;
        if (GetClientRect(w, &rc) && (rc.right - rc.left) > 0 && (rc.bottom - rc.top) > 0)
            return w;
    }

    FindWinCtx c;
    c.pid = GetCurrentProcessId();
    c.best = NULL;
    c.bestArea = 0;
    EnumWindows(FindWinProc, (LPARAM)&c);
    if (c.best) return c.best;

    if (w && IsWindow(w)) return w;      /* last resort: the odd window we had */

    w = GetForegroundWindow();
    return w;
}

/* ------------------------------------------------------------------------- */
/* Overlay_Prepare - per-present size discovery / resize detection            */
/* ------------------------------------------------------------------------- */
bool Overlay_Prepare(HDC hdc, OverlayFrame* f)
{
    static int   lastClientW = 0, lastClientH = 0;
    static int   lastFbW = 0, lastFbH = 0;
    static HGLRC lastCtx = NULL;
    static HWND  lastWin = NULL;
    static bool  first = true;
    static bool  warnedNoWindow = false;
    static bool  warnedNoSize = false;

    if (!f) return false;
    memset(f, 0, sizeof(*f));
    f->hdc = hdc;

    if (!hdc) return false;
    if (!glr.ready) { LogfEvery("prep_noapi", 2000, "prepare: gl_real table not ready"); return false; }

    HWND w = ResolveWindow(hdc);
    if (!w || !IsWindow(w))
    {
        if (!warnedNoWindow) { warnedNoWindow = true;
            Logf("prepare: NO WINDOW for hdc=%p (foreground=%p)", (void*)hdc, (void*)GetForegroundWindow()); }
        return false;
    }
    if (IsIconic(w))
    {
        LogfEvery("prep_iconic", 5000, "prepare: window %p is minimized - skipping", (void*)w);
        return false;
    }

    /* ---- logical (client) size ---------------------------------------- */
    RECT rc = { 0, 0, 0, 0 };
    GetClientRect(w, &rc);
    int cw = rc.right - rc.left;
    int ch = rc.bottom - rc.top;

    /* ---- drawable size ------------------------------------------------- */
    GLint vp[4] = { 0, 0, 0, 0 };
    glr.GetIntegerv(GL_VIEWPORT, vp);
    ClearGLErrors();
    int vpw = vp[2] > 0 ? vp[2] : 0;
    int vph = vp[3] > 0 ? vp[3] : 0;

    int fbW = 0, fbH = 0;

    if (cw > 0 && ch > 0) { fbW = cw; fbH = ch; }

    /* The drawable is bigger than the client rect (DPI virtualisation or an
     * offscreen surface): trust the drawable. */
    if (vpw > 0 && vph > 0 && (fbW == 0 || (vpw >= cw && vph >= ch)))
    {
        fbW = vpw;
        fbH = vph;
    }
    if (cw <= 0 || ch <= 0) { cw = fbW; ch = fbH; }   /* offscreen: logical == drawable */

    if (cw <= 0 || ch <= 0)
    {
        if (!warnedNoSize) { warnedNoSize = true;
            Logf("prepare: no usable size (client=%dx%d viewport=%dx%d) hwnd=%p",
                 (int)(rc.right - rc.left), (int)(rc.bottom - rc.top), vpw, vph, (void*)w); }
        return false;
    }
    warnedNoSize = false;

    float sx = (float)fbW / (float)cw;
    float sy = (float)fbH / (float)ch;
    sx = ClampF(sx, 0.5f, 4.0f);
    sy = ClampF(sy, 0.5f, 4.0f);
    if (sx == 1.0f) fbW = cw;
    if (sy == 1.0f) fbH = ch;

    HGLRC ctx = glr.wglGetCurrentContext ? glr.wglGetCurrentContext() : NULL;

    f->hwnd       = w;
    f->hglrc      = ctx;
    f->clientW    = cw;
    f->clientH    = ch;
    f->fbW        = fbW;
    f->fbH        = fbH;
    f->scaleX     = sx;
    f->scaleY     = sy;
    f->firstFrame = first;
    f->newWindow  = (w != lastWin);
    f->newContext = (ctx != lastCtx);
    f->resized    = (cw != lastClientW || ch != lastClientH ||
                     fbW != lastFbW   || fbH != lastFbH);
    f->valid      = true;

    if (f->firstFrame || f->newWindow || f->newContext || f->resized)
        Logf("prepare: hwnd=%p ctx=%p client=%dx%d fb=%dx%d scale=%.2fx%.2f%s%s%s",
             (void*)w, (void*)ctx, cw, ch, fbW, fbH, sx, sy,
             f->firstFrame ? " FIRST" : "", f->newWindow ? " NEWWIN" : "",
             f->resized ? " RESIZED" : "");

    lastClientW = cw; lastClientH = ch;
    lastFbW = fbW;    lastFbH = fbH;
    lastCtx = ctx;
    lastWin = w;
    s_lastHwnd = w;
    first = false;
    return true;
}

HWND Overlay_GetWindow(void) { return s_lastHwnd; }
bool Overlay_IsDrawing(void) { return s_drawing; }

/* ------------------------------------------------------------------------- */
/* Overlay_BeginDraw - save state, make the GL sane for fixed-pipeline ImGui  */
/* ------------------------------------------------------------------------- */
void Overlay_BeginDraw(const OverlayFrame* f)
{
    if (!glr.ready) return;

    if (s_profile < 0)
    {
        GLint mask = 0;
        glr.GetIntegerv(GL_CONTEXT_PROFILE_MASK, &mask);
        ClearGLErrors();
        s_profile = (mask & 0x1) ? 1 : ((mask & 0x2) ? 2 : 0);
        Logf("GL profile: %s (mask=0x%X) - legacy fixed-function calls %s",
             s_profile == 1 ? "CORE" : (s_profile == 2 ? "COMPATIBILITY" : "unknown"),
             mask, LegacyAllowed() ? "allowed" : "SKIPPED");
    }
    OverlayGLState* s = &s_saved;

    void* curCtx = glr.wglGetCurrentContext ? (void*)glr.wglGetCurrentContext() : NULL;
    DWORD nowTick = GetTickCount();
    bool reuse = s_savedValid && (DWORD)(nowTick - s_savedTick) <= 4 &&
                 s_savedCtx == curCtx && s_savedW == f->fbW && s_savedH == f->fbH;

    ClearGLErrors();

    if (reuse)
    {
        /* Second (third, ...) present of the same frame: the state was restored
         * to exactly these values by the previous EndDraw, so skip ~50 queries. */
        LogfEvery("savereuse", 4000, "GL state save reused for the extra present");
        goto neutralize;
    }

    memset(s, 0, sizeof(*s));

    /* ---------- 1. SAVE ------------------------------------------------- */
    glr.GetIntegerv(GL_VIEWPORT, s->viewport);
    glr.GetIntegerv(GL_SCISSOR_BOX, s->scissorBox);

    s->blend        = GetInt(GL_BLEND, 0);
    s->depth        = GetInt(GL_DEPTH_TEST, 0);
    s->cull         = GetInt(GL_CULL_FACE, 0);
    s->scissor      = GetInt(GL_SCISSOR_TEST, 0);
    if (LegacyAllowed())
    {
        s->lighting      = GetInt(GL_LIGHTING, 0);
        s->colorMaterial = GetInt(GL_COLOR_MATERIAL, 0);
        s->alphaTest     = GetInt(GL_ALPHA_TEST, 0);
        s->tex2d         = GetInt(GL_TEXTURE_2D, 0);
        s->fog           = GetInt(GL_FOG, 0);
        s->texEnvMode    = GetInt(GL_TEXTURE_ENV_MODE, GL_MODULATE);
        s->shadeModel    = GetInt(GL_SHADE_MODEL, GL_SMOOTH);
    }
    s->stencil      = GetInt(GL_STENCIL_TEST, 0);
    s->multisample  = GetInt(GL_MULTISAMPLE, 0);

    s->polygonOffsetFill = GetInt(GL_POLYGON_OFFSET_FILL, 0);

    s->blendSrc     = GetInt(GL_BLEND_SRC, GL_ONE);
    s->blendDst     = GetInt(GL_BLEND_DST, GL_ZERO);
    s->depthFunc    = GetInt(GL_DEPTH_FUNC, GL_LESS);
    s->depthMask    = GetInt(GL_DEPTH_WRITEMASK, GL_TRUE);
    s->cullMode     = GetInt(GL_CULL_FACE_MODE, GL_BACK);


    GLint polyMode[2] = { GL_FILL, GL_FILL };
    glr.GetIntegerv(GL_POLYGON_MODE, polyMode);
    s->polygonModeFB = polyMode[1];   /* front == back in practice */
    s->polygonModeF  = polyMode[0];
    s->polygonModeB  = polyMode[1];

    GLfloat lw = 1.0f;
    glr.GetFloatv(GL_LINE_WIDTH, &lw);            s->lineWidth = lw;
    GLfloat of = 0.0f, ou = 0.0f;
    glr.GetFloatv(GL_POLYGON_OFFSET_FACTOR, &of);  s->polyFactor = of;
    glr.GetFloatv(GL_POLYGON_OFFSET_UNITS, &ou);   s->polyUnits = ou;
    glr.GetFloatv(GL_CURRENT_COLOR, s->color);

    if (glr.ActiveTexture)       { glr.ActiveTexture(GL_TEXTURE0);
                                   s->activeTexture = GetInt(GL_ACTIVE_TEXTURE, GL_TEXTURE0); }
    if (glr.ClientActiveTexture) { s->clientActiveTexture = GetInt(GL_CLIENT_ACTIVE_TEXTURE, GL_TEXTURE0); }
    s->texBinding2D = GetInt(GL_TEXTURE_BINDING_2D, 0);
    s->unpackAlign  = GetInt(GL_UNPACK_ALIGNMENT, 4);
    s->packAlign    = GetInt(GL_PACK_ALIGNMENT, 4);

    if (glr.BlendEquation) { s->haveBlendEquation = true;
                             s->blendEquation = GetInt(GL_BLEND_EQUATION, GL_FUNC_ADD); }

    if (glr.UseProgram)
    {
        GLint prog = 0;
        glr.GetIntegerv(GL_CURRENT_PROGRAM, &prog);
        ClearGLErrors();
        s->program = prog; s->haveProgram = true;
    }
    if (glr.BindVertexArray)
    {
        GLint vao = 0;
        glr.GetIntegerv(GL_VERTEX_ARRAY_BINDING, &vao);
        ClearGLErrors();
        s->vao = vao; s->haveVao = true;
    }
    if (glr.BindBuffer)
    {
        s->arrayBuffer   = GetInt(GL_ARRAY_BUFFER_BINDING, 0);
        s->elementBuffer = GetInt(GL_ELEMENT_ARRAY_BUFFER_BINDING, 0);
        s->haveBuffer = true;
    }
    if (glr.BindFramebuffer)
    {
        GLint fbo = 0;
        glr.GetIntegerv(GL_FRAMEBUFFER_BINDING, &fbo);
        ClearGLErrors();
        s->fbo = fbo; s->haveFbo = true;
    }

    /* The classic "it drew but nothing is visible" suspects. */
    s->drawBuffer      = GetInt(GL_DRAW_BUFFER, GL_BACK);
    s->readBuffer      = GetInt(GL_READ_BUFFER, GL_BACK);
    s->logicOp         = GetInt(GL_LOGIC_OP_MODE, GL_COPY);
    s->logicOpEnabled  = GetInt(GL_COLOR_LOGIC_OP, 0);
    s->colorMask[0] = s->colorMask[1] = s->colorMask[2] = s->colorMask[3] = 1;
    glr.GetIntegerv(GL_COLOR_WRITEMASK, s->colorMask);

    s_savedValid = true;
    s_savedTick  = nowTick;
    s_savedCtx   = curCtx;
    s_savedW     = f->fbW;
    s_savedH     = f->fbH;

neutralize:
    /* ---------- 2. NEUTRALISE ------------------------------------------- */
    /* The single most important line: without this the UI is drawn through
       the emulator's own GLSL program (no attributes) => black rectangles. */
    if (glr.UseProgram)        glr.UseProgram(0);
    if (glr.BindVertexArray)   glr.BindVertexArray(0);
    if (glr.BindBuffer)
    {
        glr.BindBuffer(GL_ARRAY_BUFFER, 0);
        glr.BindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    }
    /* ReShade draws into whatever framebuffer the app had bound at swap time;
     * if the emulator composes its frame in an FBO and presents that, forcing
     * FBO 0 here would paint the overlay into a surface nobody sees.
     * g_Config.bOverlayUseBoundFBO selects the behaviour. */
    if (glr.BindFramebuffer && !g_Config.bOverlayUseBoundFBO)
        glr.BindFramebuffer(GL_FRAMEBUFFER, 0);

    /* Colour writes / logic op / draw buffer are the three states that make a
     * perfectly good draw call completely invisible. Force them sane. */
    if (glr.ColorMask) glr.ColorMask(GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE);
    glr.Disable(GL_COLOR_LOGIC_OP);
    if (glr.LogicOp) glr.LogicOp(GL_COPY);
    {
        bool targetIsDefault = true;
        if (glr.BindFramebuffer)
        {
            GLint curFbo = 0;
            glr.GetIntegerv(GL_FRAMEBUFFER_BINDING, &curFbo);
            ClearGLErrors();
            targetIsDefault = (curFbo == 0);
        }
        if (targetIsDefault)
        {
            if (glr.DrawBuffer) glr.DrawBuffer(GL_BACK);
            if (glr.ReadBuffer) glr.ReadBuffer(GL_BACK);
        }
    }

    if (glr.ActiveTexture)     glr.ActiveTexture(GL_TEXTURE0);
    if (glr.ClientActiveTexture) glr.ClientActiveTexture(GL_TEXTURE0);
    if (glr.BindTexture)       glr.BindTexture(GL_TEXTURE_2D, 0);

    glr.Viewport(0, 0, f->fbW, f->fbH);

    glr.Disable(GL_SCISSOR_TEST);
    glr.Disable(GL_DEPTH_TEST);
    glr.DepthMask(GL_FALSE);          /* never write into the game's Z-buffer */
    glr.DepthFunc(GL_LEQUAL);
    glr.Disable(GL_CULL_FACE);
    if (LegacyAllowed())
    {
        glr.Disable(GL_LIGHTING);
        glr.Disable(GL_COLOR_MATERIAL);
        glr.Disable(GL_ALPHA_TEST);
        glr.Disable(GL_FOG);
        glr.Disable(GL_TEXTURE_2D);
        glr.ShadeModel(GL_SMOOTH);
        glr.TexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
        glr.Disable(GL_POLYGON_OFFSET_LINE);
        glr.Disable(GL_POLYGON_OFFSET_POINT);
    }
    glr.Disable(GL_STENCIL_TEST);
    glr.Disable(GL_POLYGON_OFFSET_FILL);
    glr.PolygonMode(GL_FRONT_AND_BACK, GL_FILL);
    glr.PolygonOffset(0.0f, 0.0f);
    glr.LineWidth(1.0f);
    glr.Color4f(1.0f, 1.0f, 1.0f, 1.0f);

    glr.Enable(GL_BLEND);
    glr.BlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    if (glr.BlendEquation) glr.BlendEquation(GL_FUNC_ADD);
    glr.PixelStorei(GL_UNPACK_ALIGNMENT, 4);
    glr.PixelStorei(GL_PACK_ALIGNMENT, 4);

    ClearGLErrors();
    s_drawing = true;
}

/* ------------------------------------------------------------------------- */
/* Overlay_EndDraw - put every value back                                     */
/* ------------------------------------------------------------------------- */
void Overlay_EndDraw(void)
{
    if (!glr.ready) return;
    if (!s_drawing) return;              /* BeginDraw bailed out: don't touch */
    const OverlayGLState* s = &s_saved;

    if (glr.BindFramebuffer && s->haveFbo)
        glr.BindFramebuffer(GL_FRAMEBUFFER, (GLuint)s->fbo);
    if (glr.BindVertexArray && s->haveVao)
        glr.BindVertexArray((GLuint)s->vao);
    if (glr.UseProgram && s->haveProgram)
        glr.UseProgram((GLuint)s->program);
    if (glr.BindBuffer && s->haveBuffer)
    {
        glr.BindBuffer(GL_ARRAY_BUFFER, (GLuint)s->arrayBuffer);
        glr.BindBuffer(GL_ELEMENT_ARRAY_BUFFER, (GLuint)s->elementBuffer);
    }
    if (glr.ActiveTexture && s->activeTexture)
        glr.ActiveTexture((GLenum)s->activeTexture);
    if (glr.ClientActiveTexture && s->clientActiveTexture)
        glr.ClientActiveTexture((GLenum)s->clientActiveTexture);
    if (glr.BindTexture)
        glr.BindTexture(GL_TEXTURE_2D, (GLuint)s->texBinding2D);

    glr.Viewport(s->viewport[0], s->viewport[1], s->viewport[2], s->viewport[3]);
    glr.Scissor(s->scissorBox[0], s->scissorBox[1], s->scissorBox[2], s->scissorBox[3]);

    if (glr.BlendEquation && s->haveBlendEquation)
        glr.BlendEquation((GLenum)s->blendEquation);
    glr.BlendFunc((GLenum)s->blendSrc, (GLenum)s->blendDst);
    glr.DepthFunc((GLenum)s->depthFunc);
    glr.DepthMask((GLboolean)(s->depthMask ? GL_TRUE : GL_FALSE));
    glr.CullFace((GLenum)s->cullMode);
    if (LegacyAllowed())
    {
        glr.PolygonMode(GL_FRONT, (GLenum)s->polygonModeF);
        glr.PolygonMode(GL_BACK,  (GLenum)s->polygonModeB);
        glr.ShadeModel((GLenum)s->shadeModel);
        glr.TexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, s->texEnvMode);
    }
    else
    {
        glr.PolygonMode(GL_FRONT_AND_BACK, GL_FILL);
    }
    glr.PolygonOffset(s->polyFactor, s->polyUnits);
    glr.LineWidth(s->lineWidth);
    glr.Color4f(s->color[0], s->color[1], s->color[2], s->color[3]);
    glr.PixelStorei(GL_UNPACK_ALIGNMENT, s->unpackAlign);
    glr.PixelStorei(GL_PACK_ALIGNMENT, s->packAlign);
    if (glr.ColorMask)
        glr.ColorMask((GLboolean)s->colorMask[0], (GLboolean)s->colorMask[1],
                      (GLboolean)s->colorMask[2], (GLboolean)s->colorMask[3]);
    if (glr.LogicOp) glr.LogicOp((GLenum)s->logicOp);
    if (s->logicOpEnabled) glr.Enable(GL_COLOR_LOGIC_OP); else glr.Disable(GL_COLOR_LOGIC_OP);
    if (glr.DrawBuffer && s->haveFbo && s->fbo == 0 && s->drawBuffer)
        glr.DrawBuffer((GLenum)s->drawBuffer);
    if (glr.ReadBuffer && s->haveFbo && s->fbo == 0 && s->readBuffer)
        glr.ReadBuffer((GLenum)s->readBuffer);

    /* Enable bits last: if the game had these off/on, they must come back. */
    {
        struct { GLint on; GLenum cap; } caps[] = {
            { s->polygonOffsetFill, GL_POLYGON_OFFSET_FILL },
            { s->multisample,       GL_MULTISAMPLE        },
            { s->stencil,           GL_STENCIL_TEST       },
            { s->cull,              GL_CULL_FACE          },
            { s->blend,             GL_BLEND              },
            { s->depth,             GL_DEPTH_TEST         },
            { s->scissor,           GL_SCISSOR_TEST       },
        };
        for (int i = 0; i < (int)(sizeof(caps) / sizeof(caps[0])); i++)
        {
            if (caps[i].on) glr.Enable(caps[i].cap);
            else            glr.Disable(caps[i].cap);
        }
        if (LegacyAllowed())
        {
            struct { GLint on; GLenum cap; } legacy[] = {
                { s->tex2d,         GL_TEXTURE_2D     },
                { s->fog,           GL_FOG            },
                { s->alphaTest,     GL_ALPHA_TEST     },
                { s->colorMaterial, GL_COLOR_MATERIAL },
                { s->lighting,      GL_LIGHTING       },
            };
            for (int i = 0; i < (int)(sizeof(legacy) / sizeof(legacy[0])); i++)
            {
                if (legacy[i].on) glr.Enable(legacy[i].cap);
                else              glr.Disable(legacy[i].cap);
            }
        }
    }

    ClearGLErrors();
    s_drawing = false;
    s_savedTick = GetTickCount();   /* the restored state is the cached state */
}

/* ------------------------------------------------------------------------- */
/* Overlay_DrawMarker - raw immediate-mode quad (diagnostics)                 */
/* ------------------------------------------------------------------------- */
void Overlay_DrawMarker(int x, int y, int size, const float rgba[4])
{
    /* Core-profile safe marker: scissor + colour clear. No glBegin, no client
     * arrays, no shaders - nothing a 4.5 core context can reject. y is measured
     * from the TOP of the window, like ImGui coordinates. */
    if (!s_drawing || !glr.Clear || !glr.ClearColor || !glr.Scissor) return;

    GLint vp[4] = { 0, 0, 0, 0 };
    glr.GetIntegerv(GL_VIEWPORT, vp);
    if (vp[2] <= 0 || vp[3] <= 0) return;

    int px = x;
    int py = vp[3] - y - size;          /* GL origin is bottom-left */
    if (px < 0) px = 0;
    if (py < 0) py = 0;

    glr.Enable(GL_SCISSOR_TEST);
    glr.Scissor(px, py, size, size);
    glr.Disable(GL_DEPTH_TEST);
    if (glr.ColorMask) glr.ColorMask(GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE);
    glr.Disable(GL_COLOR_LOGIC_OP);
    glr.ClearColor(rgba[0], rgba[1], rgba[2], rgba[3]);
    glr.Clear(GL_COLOR_BUFFER_BIT);
    glr.Disable(GL_SCISSOR_TEST);

    ClearGLErrors();
}

/* ------------------------------------------------------------------------- */
/* Overlay_ClearFrame - paint the whole target (decisive surface test)        */
/* ------------------------------------------------------------------------- */
void Overlay_ClearFrame(const float rgba[4])
{
    if (!s_drawing) return;
    if (!glr.Clear || !glr.ClearColor || !glr.Scissor) return;
    {
        GLint vp[4] = { 0, 0, 0, 0 };
        glr.GetIntegerv(GL_VIEWPORT, vp);
        if (vp[2] > 0 && vp[3] > 0) glr.Scissor(0, 0, vp[2], vp[3]);
    }

    glr.Disable(GL_SCISSOR_TEST);
    glr.Disable(GL_DEPTH_TEST);
    if (glr.ColorMask) glr.ColorMask(GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE);
    glr.Disable(GL_COLOR_LOGIC_OP);
    glr.ClearColor(rgba[0], rgba[1], rgba[2], rgba[3]);
    glr.Clear(GL_COLOR_BUFFER_BIT);
    ClearGLErrors();
}

/* ------------------------------------------------------------------------- */
/* Overlay_LogDiagState - the facts we need to explain an invisible overlay   */
/* ------------------------------------------------------------------------- */
void Overlay_LogDiagState(void)
{
    if (!glr.ready) return;

    static bool loggedIdentity = false;
    if (!loggedIdentity && glr.GetString)
    {
        loggedIdentity = true;
        const char* ven  = (const char*)glr.GetString(GL_VENDOR);
        const char* ren  = (const char*)glr.GetString(GL_RENDERER);
        const char* ver  = (const char*)glr.GetString(GL_VERSION);
        const char* glsl = (const char*)glr.GetString(GL_SHADING_LANGUAGE_VERSION);
        GLint profileMask = 0;
        glr.GetIntegerv(GL_CONTEXT_PROFILE_MASK, &profileMask);
        ClearGLErrors();
        Logf("GL_VENDOR=%s | GL_RENDERER=%s | GL_VERSION=%s | GLSL=%s | PROFILE=%s",
             ven ? ven : "?", ren ? ren : "?", ver ? ver : "?", glsl ? glsl : "?",
             (profileMask & 0x1) ? "CORE" : ((profileMask & 0x2) ? "COMPAT" : "unknown"));
    }

    /* Window / DC identity: is the surface we draw into even the visible one? */
    {
        RECT wr = { 0, 0, 0, 0 };
        GetWindowRect(s_lastHwnd, &wr);
        HDC cur = glr.wglGetCurrentDC ? glr.wglGetCurrentDC() : NULL;
        PIXELFORMATDESCRIPTOR pfd;
        memset(&pfd, 0, sizeof(pfd));
        int pf = cur ? GetPixelFormat(cur) : 0;
        if (cur && pf) DescribePixelFormat(cur, pf, sizeof(pfd), &pfd);
        LogfEvery("diagwin", 4000,
                  "WINDOW: hwnd=%p visible=%d rect=%ld,%ld %ldx%ld | curDC=%p pf=%d doubleBuf=%d",
                  (void*)s_lastHwnd, (int)IsWindowVisible(s_lastHwnd),
                  (long)wr.left, (long)wr.top, (long)(wr.right - wr.left), (long)(wr.bottom - wr.top),
                  (void*)cur, pf, (pfd.dwFlags & PFD_DOUBLEBUFFER) ? 1 : 0);
    }

    GLint fbo = -1, drawBuf = -1, logic = -1, logicEn = -1;
    GLint cmask[4] = { -1, -1, -1, -1 };
    GLint vp[4] = { 0, 0, 0, 0 };
    if (glr.BindFramebuffer) glr.GetIntegerv(GL_FRAMEBUFFER_BINDING, &fbo);
    glr.GetIntegerv(GL_DRAW_BUFFER, &drawBuf);
    glr.GetIntegerv(GL_LOGIC_OP_MODE, &logic);
    glr.GetIntegerv(GL_COLOR_LOGIC_OP, &logicEn);
    glr.GetIntegerv(GL_COLOR_WRITEMASK, cmask);
    glr.GetIntegerv(GL_VIEWPORT, vp);
    ClearGLErrors();

    LogfEvery("diagstate", 4000,
              "STATE at swap: fbo=%d drawBuf=0x%04X colorMask=%d%d%d%d logicOp=0x%04X viewport=%d,%d %dx%d",
              fbo, drawBuf, cmask[0], cmask[1], cmask[2], cmask[3], logic,
              vp[0], vp[1], vp[2], vp[3]);
}
