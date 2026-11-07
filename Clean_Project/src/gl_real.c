/**
 * gl_real.c - Resolve the genuine OpenGL entry points at runtime.
 *
 * [English] Every pointer is taken from C:\Windows\System32\opengl32.dll
 *           (core GL 1.1 + wgl*) or from its wglGetProcAddress() for the
 *           modern entry points (glUseProgram, glBindVertexArray,
 *           glBindFramebuffer, glBlendEquation...).
 *
 *           IMPORTANT: we never use *our own* wglGetProcAddress export to
 *           resolve, because that one is a pass-through stub whose pointer
 *           table lives in gl_forwarders.S. Using the genuine one keeps this
 *           file free of circular dependencies.
 */

#include <windows.h>
#include "../include/gl_real.h"
#include "../include/opengl_hooks.h"

GlRealApi glr;

static void* RealProcByName(const char* name)
{
    HMODULE hReal = GL_GetRealModule();
    if (!hReal) return NULL;

    /* 1) Core GL 1.1 / WGL functions are real exports of opengl32.dll */
    void* p = (void*)GetProcAddress(hReal, name);
    if (p) return p;

    /* 2) Everything above GL 1.1 only exists behind wglGetProcAddress */
    PFN_wglGPA wglGPA =
        (PFN_wglGPA)(void*)GetProcAddress(hReal, "wglGetProcAddress");
    if (wglGPA)
    {
        p = (void*)wglGPA(name);
        /* The spec allows returning 1,2,3,-1 as "not supported" sentinels */
        if (p == (void*)1 || p == (void*)2 || p == (void*)3 || p == (void*)-1)
            p = NULL;
    }
    return p;
}

void* GL_GetRealProc(const char* name)
{
    return RealProcByName(name);
}

bool GL_LoadRealApi(void)
{
    if (glr.ready) return true;
    if (!GL_GetRealModule()) return false;
    if (!GL_CurrentContextIsValid()) return false;   /* ext procs need a context */

    glr.GetIntegerv          = (PFN_glGetIntegerv)RealProcByName("glGetIntegerv");
    glr.GetFloatv            = (PFN_glGetFloatv)RealProcByName("glGetFloatv");
    glr.GetBooleanv          = (PFN_glGetBooleanv)RealProcByName("glGetBooleanv");
    glr.GetTexEnviv          = (PFN_glGetTexEnviv)RealProcByName("glGetTexEnviv");
    glr.GetError             = (PFN_glGetError)RealProcByName("glGetError");
    glr.Enable               = (PFN_glEnable)RealProcByName("glEnable");
    glr.Disable              = (PFN_glDisable)RealProcByName("glDisable");
    glr.IsEnabled            = (PFN_glIsEnabled)RealProcByName("glIsEnabled");
    glr.BlendFunc            = (PFN_glBlendFunc)RealProcByName("glBlendFunc");
    glr.BlendEquation        = (PFN_glBlendEquation)RealProcByName("glBlendEquation");
    if (!glr.BlendEquation)
        glr.BlendEquation    = (PFN_glBlendEquation)RealProcByName("glBlendEquationEXT");
    glr.DepthFunc            = (PFN_glDepthFunc)RealProcByName("glDepthFunc");
    glr.DepthMask            = (PFN_glDepthMask)RealProcByName("glDepthMask");
    glr.CullFace             = (PFN_glCullFace)RealProcByName("glCullFace");
    glr.PolygonMode          = (PFN_glPolygonMode)RealProcByName("glPolygonMode");
    glr.PolygonOffset        = (PFN_glPolygonOffset)RealProcByName("glPolygonOffset");
    glr.LineWidth            = (PFN_glLineWidth)RealProcByName("glLineWidth");
    glr.Color4f              = (PFN_glColor4f)RealProcByName("glColor4f");
    glr.ShadeModel           = (PFN_glShadeModel)RealProcByName("glShadeModel");
    glr.TexEnvi              = (PFN_glTexEnvi)RealProcByName("glTexEnvi");
    glr.BindTexture          = (PFN_glBindTexture)RealProcByName("glBindTexture");
    glr.Viewport             = (PFN_glViewport)RealProcByName("glViewport");
    glr.Scissor              = (PFN_glScissor)RealProcByName("glScissor");
    glr.PixelStorei          = (PFN_glPixelStorei)RealProcByName("glPixelStorei");
    glr.DrawElements         = (PFN_glDrawElements)RealProcByName("glDrawElements");
    glr.ActiveTexture        = (PFN_glActiveTexture)RealProcByName("glActiveTexture");
    glr.ClientActiveTexture  = (PFN_glClientActiveTexture)RealProcByName("glClientActiveTexture");
    glr.UseProgram           = (PFN_glUseProgram)RealProcByName("glUseProgram");
    glr.BindVertexArray      = (PFN_glBindVertexArray)RealProcByName("glBindVertexArray");
    glr.BindBuffer           = (PFN_glBindBuffer)RealProcByName("glBindBuffer");
    glr.BindFramebuffer      = (PFN_glBindFramebuffer)RealProcByName("glBindFramebuffer");
    if (!glr.BindFramebuffer)
        glr.BindFramebuffer  = (PFN_glBindFramebuffer)RealProcByName("glBindFramebufferEXT");
    glr.GetUniformLocation   = (PFN_glGetUniformLocation)RealProcByName("glGetUniformLocation");
    glr.MatrixMode           = (PFN_glMatrixMode)RealProcByName("glMatrixMode");
    glr.LoadIdentity         = (PFN_glLoadIdentity)RealProcByName("glLoadIdentity");
    glr.Ortho                = (PFN_glOrtho)RealProcByName("glOrtho");
    glr.Begin                = (PFN_glBegin)RealProcByName("glBegin");
    glr.End                  = (PFN_glEnd)RealProcByName("glEnd");
    glr.Vertex2f             = (PFN_glVertex2f)RealProcByName("glVertex2f");
    glr.PushAttrib           = (PFN_glPushAttrib)RealProcByName("glPushAttrib");
    glr.PopAttrib            = (PFN_glPopAttrib)RealProcByName("glPopAttrib");
    glr.PushMatrix           = (PFN_glPushMatrix)RealProcByName("glPushMatrix");
    glr.PopMatrix            = (PFN_glPopMatrix)RealProcByName("glPopMatrix");
    glr.GenTextures          = (PFN_glGenTextures)RealProcByName("glGenTextures");
    glr.DeleteTextures       = (PFN_glDeleteTextures)RealProcByName("glDeleteTextures");
    glr.GetTexParameteriv    = (PFN_glGetTexParameteriv)RealProcByName("glGetTexParameteriv");
    glr.TexParameteri        = (PFN_glTexParameteri)RealProcByName("glTexParameteri");
    glr.TexImage2D           = (PFN_glTexImage2D)RealProcByName("glTexImage2D");
    glr.TexSubImage2D        = (PFN_glTexSubImage2D)RealProcByName("glTexSubImage2D");
    glr.EnableClientState    = (PFN_glEnableClientState)RealProcByName("glEnableClientState");
    glr.DisableClientState   = (PFN_glDisableClientState)RealProcByName("glDisableClientState");
    glr.VertexPointer        = (PFN_glVertexPointer)RealProcByName("glVertexPointer");
    glr.ColorPointer         = (PFN_glColorPointer)RealProcByName("glColorPointer");
    glr.TexCoordPointer      = (PFN_glTexCoordPointer)RealProcByName("glTexCoordPointer");
    glr.ColorMask            = (PFN_glColorMask)RealProcByName("glColorMask");
    glr.DrawBuffer           = (PFN_glDrawBuffer)RealProcByName("glDrawBuffer");
    glr.ReadBuffer           = (PFN_glReadBuffer)RealProcByName("glReadBuffer");
    glr.LogicOp              = (PFN_glLogicOp)RealProcByName("glLogicOp");
    glr.GetString            = (PFN_glGetString)RealProcByName("glGetString");
    glr.Clear                = (PFN_glClear)RealProcByName("glClear");
    glr.ClearColor           = (PFN_glClearColor)RealProcByName("glClearColor");
    glr.wglGetCurrentContext = (PFN_wglGetCurrentContext)RealProcByName("wglGetCurrentContext");
    glr.wglGetCurrentDC      = (PFN_wglGetCurrentDC)RealProcByName("wglGetCurrentDC");

    /* GL 1.1 core is non-negotiable; the rest degrade gracefully. */
    if (!glr.GetIntegerv || !glr.Enable || !glr.Disable || !glr.Viewport)
        return false;

    glr.ready = true;
    return true;
}
