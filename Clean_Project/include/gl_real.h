/**
 * gl_real.h - Runtime-loaded pointer table for the REAL System32\opengl32.dll
 *
 * [English] WHY THIS EXISTS
 *   The proxy DLL is itself named opengl32.dll. Any symbol it links against
 *   "-lopengl32" becomes a SELF-import: Windows resolves it back into our own
 *   DLL. That is fine for the 31 functions we already export, but it means we
 *   can never call a GL function we do not export, and a single missing export
 *   makes the whole DLL fail to load (ERROR_PROC_NOT_FOUND).
 *
 *   This file resolves every GL entry point we need at runtime, by name, from
 *   the genuine C:\Windows\System32\opengl32.dll + wglGetProcAddress().
 *   => overlay code can freely use glUseProgram / glBindVertexArray /
 *      glBlendEquation / glBindFramebuffer without adding exports.
 *
 * [සිංහල] මෙම ගොනුවෙන් සැබෑ System32 opengl32.dll හි function pointers
 *         runtime එකේදී resolve කරගන්නවා. එවිට proxy එකේ exports වැඩිකරන්නේ
 *         නැතුව glUseProgram, glBindFramebuffer වගේ functions call කරන්න පුළුවන්.
 */

#ifndef GL_REAL_H
#define GL_REAL_H

#include <windows.h>
#include <GL/gl.h>
#include <stdbool.h>

/* ---- GL constants that may be missing from an old <GL/gl.h> ---- */
#ifndef GL_TEXTURE_BINDING_2D
#define GL_TEXTURE_BINDING_2D      0x8069
#endif
#ifndef GL_POLYGON_MODE
#define GL_POLYGON_MODE            0x0B40
#endif
#ifndef GL_POLYGON_OFFSET_FACTOR
#define GL_POLYGON_OFFSET_FACTOR   0x8038
#endif
#ifndef GL_POLYGON_OFFSET_UNITS
#define GL_POLYGON_OFFSET_UNITS    0x2A00
#endif
#ifndef GL_POLYGON_OFFSET_FILL
#define GL_POLYGON_OFFSET_FILL     0x8037
#endif
#ifndef GL_POLYGON_OFFSET_LINE
#define GL_POLYGON_OFFSET_LINE     0x2A02
#endif
#ifndef GL_POLYGON_OFFSET_POINT
#define GL_POLYGON_OFFSET_POINT    0x2A01
#endif
#ifndef GL_BLEND_SRC
#define GL_BLEND_SRC               0x0BE1
#endif
#ifndef GL_BLEND_DST
#define GL_BLEND_DST               0x0BE0
#endif
#ifndef GL_BLEND_EQUATION
#define GL_BLEND_EQUATION          0x8009
#endif
#ifndef GL_FUNC_ADD
#define GL_FUNC_ADD                0x8006
#endif
#ifndef GL_DEPTH_FUNC
#define GL_DEPTH_FUNC              0x0B74
#endif
#ifndef GL_DEPTH_WRITEMASK
#define GL_DEPTH_WRITEMASK         0x0B72
#endif
#ifndef GL_CULL_FACE_MODE
#define GL_CULL_FACE_MODE          0x0B45
#endif
#ifndef GL_LINE_WIDTH
#define GL_LINE_WIDTH              0x0B21
#endif
#ifndef GL_CURRENT_COLOR
#define GL_CURRENT_COLOR           0x0B00
#endif
#ifndef GL_SHADE_MODEL
#define GL_SHADE_MODEL             0x0B52
#endif
#ifndef GL_TEXTURE_ENV
#define GL_TEXTURE_ENV             0x2300
#endif
#ifndef GL_TEXTURE_ENV_MODE
#define GL_TEXTURE_ENV_MODE        0x2200
#endif
#ifndef GL_ACTIVE_TEXTURE
#define GL_ACTIVE_TEXTURE          0x84E0
#endif
#ifndef GL_CLIENT_ACTIVE_TEXTURE
#define GL_CLIENT_ACTIVE_TEXTURE   0x84E1
#endif
#ifndef GL_TEXTURE0
#define GL_TEXTURE0                0x84C0
#endif
#ifndef GL_CURRENT_PROGRAM
#define GL_CURRENT_PROGRAM         0x8B8D
#endif
#ifndef GL_VERTEX_ARRAY_BINDING
#define GL_VERTEX_ARRAY_BINDING    0x85B5
#endif
#ifndef GL_ARRAY_BUFFER
#define GL_ARRAY_BUFFER            0x8892
#endif
#ifndef GL_ELEMENT_ARRAY_BUFFER
#define GL_ELEMENT_ARRAY_BUFFER    0x8893
#endif
#ifndef GL_FRAMEBUFFER
#define GL_FRAMEBUFFER             0x8D40
#endif
#ifndef GL_FRAMEBUFFER_BINDING
#define GL_FRAMEBUFFER_BINDING     0x8CA6
#endif
#ifndef GL_ARRAY_BUFFER_BINDING
#define GL_ARRAY_BUFFER_BINDING    0x8894
#endif
#ifndef GL_ELEMENT_ARRAY_BUFFER_BINDING
#define GL_ELEMENT_ARRAY_BUFFER_BINDING 0x8895
#endif
#ifndef GL_FOG
#define GL_FOG                     0x0B60
#endif
#ifndef GL_CONTEXT_PROFILE_MASK
#define GL_CONTEXT_PROFILE_MASK    0x9126
#endif
#ifndef GL_SHADING_LANGUAGE_VERSION
#define GL_SHADING_LANGUAGE_VERSION 0x8B8C
#endif
#ifndef GL_MULTISAMPLE
#define GL_MULTISAMPLE             0x809D
#endif
#ifndef GL_DRAW_BUFFER
#define GL_DRAW_BUFFER             0x0C01
#endif
#ifndef GL_READ_BUFFER
#define GL_READ_BUFFER             0x0C02
#endif
#ifndef GL_COLOR_LOGIC_OP
#define GL_COLOR_LOGIC_OP          0x0BF2
#endif
#ifndef GL_LOGIC_OP_MODE
#define GL_LOGIC_OP_MODE           0x0BF0
#endif
#ifndef GL_COLOR_WRITEMASK
#define GL_COLOR_WRITEMASK         0x0C23
#endif
#ifndef GL_COPY
#define GL_COPY                    0x1503
#endif
#ifndef GL_FRONT
#define GL_FRONT                   0x0404
#endif
#ifndef GL_BACK
#define GL_BACK                    0x0405
#endif
#ifndef GL_FRONT_LEFT
#define GL_FRONT_LEFT              0x0400
#endif
#ifndef GL_BACK_LEFT
#define GL_BACK_LEFT               0x0402
#endif

/* ---- Function pointer types (all WINAPI = __stdcall on x86-64 no-ops) ---- */
typedef void (APIENTRY *PFN_glGetIntegerv)(GLenum pname, GLint* data);
typedef void (APIENTRY *PFN_glGetFloatv)(GLenum pname, GLfloat* data);
typedef void (APIENTRY *PFN_glGetBooleanv)(GLenum pname, GLboolean* data);
typedef void (APIENTRY *PFN_glGetTexEnviv)(GLenum target, GLenum pname, GLint* data);
typedef GLenum (APIENTRY *PFN_glGetError)(void);
typedef void (APIENTRY *PFN_glEnable)(GLenum cap);
typedef void (APIENTRY *PFN_glDisable)(GLenum cap);
typedef GLboolean (APIENTRY *PFN_glIsEnabled)(GLenum cap);
typedef void (APIENTRY *PFN_glBlendFunc)(GLenum sfactor, GLenum dfactor);
typedef void (APIENTRY *PFN_glBlendEquation)(GLenum mode);
typedef void (APIENTRY *PFN_glDepthFunc)(GLenum func);
typedef void (APIENTRY *PFN_glDepthMask)(GLboolean flag);
typedef void (APIENTRY *PFN_glCullFace)(GLenum mode);
typedef void (APIENTRY *PFN_glPolygonMode)(GLenum face, GLenum mode);
typedef void (APIENTRY *PFN_glPolygonOffset)(GLfloat factor, GLfloat units);
typedef void (APIENTRY *PFN_glLineWidth)(GLfloat width);
typedef void (APIENTRY *PFN_glColor4f)(GLfloat r, GLfloat g, GLfloat b, GLfloat a);
typedef void (APIENTRY *PFN_glShadeModel)(GLenum mode);
typedef void (APIENTRY *PFN_glTexEnvi)(GLenum target, GLenum pname, GLint param);
typedef void (APIENTRY *PFN_glBindTexture)(GLenum target, GLuint texture);
typedef void (APIENTRY *PFN_glViewport)(GLint x, GLint y, GLsizei w, GLsizei h);
typedef void (APIENTRY *PFN_glScissor)(GLint x, GLint y, GLsizei w, GLsizei h);
typedef void (APIENTRY *PFN_glPixelStorei)(GLenum pname, GLint param);
typedef void (APIENTRY *PFN_glDrawElements)(GLenum mode, GLsizei count, GLenum type, const void* indices);
typedef void (APIENTRY *PFN_glActiveTexture)(GLenum texture);
typedef void (APIENTRY *PFN_glClientActiveTexture)(GLenum texture);
typedef void (APIENTRY *PFN_glUseProgram)(GLuint program);
typedef void (APIENTRY *PFN_glBindVertexArray)(GLuint array);
typedef void (APIENTRY *PFN_glBindBuffer)(GLenum target, GLuint buffer);
typedef void (APIENTRY *PFN_glBindFramebuffer)(GLenum target, GLuint framebuffer);
typedef GLint (APIENTRY *PFN_glGetUniformLocation)(GLuint program, const char* name);
/* immediate mode - only used for the diagnostic marker quad */
typedef void (APIENTRY *PFN_glMatrixMode)(GLenum mode);
typedef void (APIENTRY *PFN_glLoadIdentity)(void);
typedef void (APIENTRY *PFN_glOrtho)(GLdouble l, GLdouble r, GLdouble b, GLdouble t, GLdouble n, GLdouble f);
typedef void (APIENTRY *PFN_glBegin)(GLenum mode);
typedef void (APIENTRY *PFN_glEnd)(void);
typedef void (APIENTRY *PFN_glVertex2f)(GLfloat x, GLfloat y);
/* fixed-function bits used by imgui_impl_opengl2 (kept import-free) */
typedef void (APIENTRY *PFN_glPushAttrib)(GLbitfield mask);
typedef void (APIENTRY *PFN_glPopAttrib)(void);
typedef void (APIENTRY *PFN_glPushMatrix)(void);
typedef void (APIENTRY *PFN_glPopMatrix)(void);
typedef void (APIENTRY *PFN_glGenTextures)(GLsizei n, GLuint* textures);
typedef void (APIENTRY *PFN_glDeleteTextures)(GLsizei n, const GLuint* textures);
typedef void (APIENTRY *PFN_glGetTexParameteriv)(GLenum target, GLenum pname, GLint* params);
typedef void (APIENTRY *PFN_glTexParameteri)(GLenum target, GLenum pname, GLint param);
typedef void (APIENTRY *PFN_glTexImage2D)(GLenum target, GLint level, GLint internalformat,
        GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void* pixels);
typedef void (APIENTRY *PFN_glTexSubImage2D)(GLenum target, GLint level, GLint xoffset, GLint yoffset,
        GLsizei width, GLsizei height, GLenum format, GLenum type, const void* pixels);
typedef void (APIENTRY *PFN_glEnableClientState)(GLenum cap);
typedef void (APIENTRY *PFN_glDisableClientState)(GLenum cap);
typedef void (APIENTRY *PFN_glVertexPointer)(GLint size, GLenum type, GLsizei stride, const void* ptr);
typedef void (APIENTRY *PFN_glColorPointer)(GLint size, GLenum type, GLsizei stride, const void* ptr);
typedef void (APIENTRY *PFN_glTexCoordPointer)(GLint size, GLenum type, GLsizei stride, const void* ptr);
typedef void (APIENTRY *PFN_glColorMask)(GLboolean r, GLboolean g, GLboolean b, GLboolean a);
typedef void (APIENTRY *PFN_glDrawBuffer)(GLenum mode);
typedef void (APIENTRY *PFN_glReadBuffer)(GLenum mode);
typedef void (APIENTRY *PFN_glLogicOp)(GLenum opcode);
typedef const GLubyte* (APIENTRY *PFN_glGetString)(GLenum name);
typedef void (APIENTRY *PFN_glClear)(GLbitfield mask);
typedef void (APIENTRY *PFN_glClearColor)(GLclampf r, GLclampf g, GLclampf b, GLclampf a);
typedef PROC  (WINAPI *PFN_wglGPA)(LPCSTR);
typedef HGLRC (WINAPI *PFN_wglGetCurrentContext)(void);
typedef HDC   (WINAPI *PFN_wglGetCurrentDC)(void);

/* ---- The table. Zero-initialised; call GL_LoadRealApi() first. ---- */
typedef struct GlRealApi {
    bool ready;

    PFN_glGetIntegerv        GetIntegerv;
    PFN_glGetFloatv          GetFloatv;
    PFN_glGetBooleanv        GetBooleanv;
    PFN_glGetTexEnviv        GetTexEnviv;
    PFN_glGetError           GetError;
    PFN_glEnable             Enable;
    PFN_glDisable            Disable;
    PFN_glIsEnabled          IsEnabled;
    PFN_glBlendFunc          BlendFunc;
    PFN_glBlendEquation      BlendEquation;      /* GL 1.4, may be NULL */
    PFN_glDepthFunc          DepthFunc;
    PFN_glDepthMask          DepthMask;
    PFN_glCullFace           CullFace;
    PFN_glPolygonMode        PolygonMode;
    PFN_glPolygonOffset      PolygonOffset;
    PFN_glLineWidth          LineWidth;
    PFN_glColor4f            Color4f;
    PFN_glShadeModel         ShadeModel;
    PFN_glTexEnvi            TexEnvi;
    PFN_glBindTexture        BindTexture;
    PFN_glViewport           Viewport;
    PFN_glScissor            Scissor;
    PFN_glPixelStorei        PixelStorei;
    PFN_glDrawElements       DrawElements;
    PFN_glActiveTexture      ActiveTexture;      /* GL 1.3, may be NULL */
    PFN_glClientActiveTexture ClientActiveTexture;
    PFN_glUseProgram         UseProgram;         /* GL 2.0, may be NULL */
    PFN_glBindVertexArray    BindVertexArray;    /* GL 3.0 / ARB, may be NULL */
    PFN_glBindBuffer         BindBuffer;
    PFN_glBindFramebuffer    BindFramebuffer;    /* GL 3.0 / ARB, may be NULL */
    PFN_glGetUniformLocation GetUniformLocation;
    PFN_glMatrixMode         MatrixMode;
    PFN_glLoadIdentity       LoadIdentity;
    PFN_glOrtho              Ortho;
    PFN_glBegin              Begin;
    PFN_glEnd                End;
    PFN_glVertex2f           Vertex2f;
    PFN_glPushAttrib         PushAttrib;
    PFN_glPopAttrib          PopAttrib;
    PFN_glPushMatrix         PushMatrix;
    PFN_glPopMatrix          PopMatrix;
    PFN_glGenTextures        GenTextures;
    PFN_glDeleteTextures     DeleteTextures;
    PFN_glGetTexParameteriv  GetTexParameteriv;
    PFN_glTexParameteri      TexParameteri;
    PFN_glTexImage2D         TexImage2D;
    PFN_glTexSubImage2D      TexSubImage2D;
    PFN_glEnableClientState  EnableClientState;
    PFN_glDisableClientState DisableClientState;
    PFN_glVertexPointer      VertexPointer;
    PFN_glColorPointer       ColorPointer;
    PFN_glTexCoordPointer    TexCoordPointer;
    PFN_glColorMask          ColorMask;
    PFN_glDrawBuffer         DrawBuffer;
    PFN_glReadBuffer         ReadBuffer;
    PFN_glLogicOp            LogicOp;
    PFN_glGetString          GetString;
    PFN_glClear              Clear;
    PFN_glClearColor         ClearColor;
    PFN_wglGetCurrentContext wglGetCurrentContext;
    PFN_wglGetCurrentDC      wglGetCurrentDC;
} GlRealApi;

extern GlRealApi glr;

/* Resolve everything. Safe to call many times (does the work once).
 * Must be called with a current GL context for the extension functions. */
bool GL_LoadRealApi(void);

/* Fetch any real GL entry point: GetProcAddress(System32) first, then
 * the REAL wglGetProcAddress (never our own, so no recursion). */
void* GL_GetRealProc(const char* name);

#endif /* GL_REAL_H */
