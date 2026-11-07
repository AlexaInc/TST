/* gl_forwarders.S - GL/WGL forwarder stubs (x86-64 Windows)
 *
 * [English] Each stub does a tail-jump to the genuine System32\opengl32.dll
 *           entry point. If the pointer is not bound yet it calls
 *           GL_LazyBind(slot, name) first, preserving *all* Win64 argument
 *           registers (rcx/rdx/r8/r9 + xmm0-3) across that call.
 *           Consequence: GL works correctly even if our DllMain never
 *           had a chance to initialise anything (loader-lock safe).
 *
 * [සිංහල] සෑම stub එකක්ම සැබෑ System32 function එකට tail-jump කරනවා.
 *         pointer එක තාම bind වෙලා නැත්නම් GL_LazyBind() call කරනවා.
 */
.intel_syntax noprefix

.text

    .global glAccum
glAccum:
    mov rax, QWORD PTR [rip + _pfn_glAccum]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glAccum]
    lea rdx, [rip + _name_glAccum]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glAlphaFunc
glAlphaFunc:
    mov rax, QWORD PTR [rip + _pfn_glAlphaFunc]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glAlphaFunc]
    lea rdx, [rip + _name_glAlphaFunc]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glAreTexturesResident
glAreTexturesResident:
    mov rax, QWORD PTR [rip + _pfn_glAreTexturesResident]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glAreTexturesResident]
    lea rdx, [rip + _name_glAreTexturesResident]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glArrayElement
glArrayElement:
    mov rax, QWORD PTR [rip + _pfn_glArrayElement]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glArrayElement]
    lea rdx, [rip + _name_glArrayElement]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glBegin
glBegin:
    mov rax, QWORD PTR [rip + _pfn_glBegin]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glBegin]
    lea rdx, [rip + _name_glBegin]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glBindTexture
glBindTexture:
    mov rax, QWORD PTR [rip + _pfn_glBindTexture]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glBindTexture]
    lea rdx, [rip + _name_glBindTexture]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glBitmap
glBitmap:
    mov rax, QWORD PTR [rip + _pfn_glBitmap]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glBitmap]
    lea rdx, [rip + _name_glBitmap]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glBlendFunc
glBlendFunc:
    mov rax, QWORD PTR [rip + _pfn_glBlendFunc]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glBlendFunc]
    lea rdx, [rip + _name_glBlendFunc]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glCallList
glCallList:
    mov rax, QWORD PTR [rip + _pfn_glCallList]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glCallList]
    lea rdx, [rip + _name_glCallList]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glCallLists
glCallLists:
    mov rax, QWORD PTR [rip + _pfn_glCallLists]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glCallLists]
    lea rdx, [rip + _name_glCallLists]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glClear
glClear:
    mov rax, QWORD PTR [rip + _pfn_glClear]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glClear]
    lea rdx, [rip + _name_glClear]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glClearAccum
glClearAccum:
    mov rax, QWORD PTR [rip + _pfn_glClearAccum]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glClearAccum]
    lea rdx, [rip + _name_glClearAccum]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glClearColor
glClearColor:
    mov rax, QWORD PTR [rip + _pfn_glClearColor]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glClearColor]
    lea rdx, [rip + _name_glClearColor]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glClearDepth
glClearDepth:
    mov rax, QWORD PTR [rip + _pfn_glClearDepth]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glClearDepth]
    lea rdx, [rip + _name_glClearDepth]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glClearIndex
glClearIndex:
    mov rax, QWORD PTR [rip + _pfn_glClearIndex]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glClearIndex]
    lea rdx, [rip + _name_glClearIndex]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glClearStencil
glClearStencil:
    mov rax, QWORD PTR [rip + _pfn_glClearStencil]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glClearStencil]
    lea rdx, [rip + _name_glClearStencil]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glClipPlane
glClipPlane:
    mov rax, QWORD PTR [rip + _pfn_glClipPlane]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glClipPlane]
    lea rdx, [rip + _name_glClipPlane]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3b
glColor3b:
    mov rax, QWORD PTR [rip + _pfn_glColor3b]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3b]
    lea rdx, [rip + _name_glColor3b]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3bv
glColor3bv:
    mov rax, QWORD PTR [rip + _pfn_glColor3bv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3bv]
    lea rdx, [rip + _name_glColor3bv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3d
glColor3d:
    mov rax, QWORD PTR [rip + _pfn_glColor3d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3d]
    lea rdx, [rip + _name_glColor3d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3dv
glColor3dv:
    mov rax, QWORD PTR [rip + _pfn_glColor3dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3dv]
    lea rdx, [rip + _name_glColor3dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3f
glColor3f:
    mov rax, QWORD PTR [rip + _pfn_glColor3f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3f]
    lea rdx, [rip + _name_glColor3f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3fv
glColor3fv:
    mov rax, QWORD PTR [rip + _pfn_glColor3fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3fv]
    lea rdx, [rip + _name_glColor3fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3i
glColor3i:
    mov rax, QWORD PTR [rip + _pfn_glColor3i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3i]
    lea rdx, [rip + _name_glColor3i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3iv
glColor3iv:
    mov rax, QWORD PTR [rip + _pfn_glColor3iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3iv]
    lea rdx, [rip + _name_glColor3iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3s
glColor3s:
    mov rax, QWORD PTR [rip + _pfn_glColor3s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3s]
    lea rdx, [rip + _name_glColor3s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3sv
glColor3sv:
    mov rax, QWORD PTR [rip + _pfn_glColor3sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3sv]
    lea rdx, [rip + _name_glColor3sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3ub
glColor3ub:
    mov rax, QWORD PTR [rip + _pfn_glColor3ub]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3ub]
    lea rdx, [rip + _name_glColor3ub]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3ubv
glColor3ubv:
    mov rax, QWORD PTR [rip + _pfn_glColor3ubv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3ubv]
    lea rdx, [rip + _name_glColor3ubv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3ui
glColor3ui:
    mov rax, QWORD PTR [rip + _pfn_glColor3ui]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3ui]
    lea rdx, [rip + _name_glColor3ui]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3uiv
glColor3uiv:
    mov rax, QWORD PTR [rip + _pfn_glColor3uiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3uiv]
    lea rdx, [rip + _name_glColor3uiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3us
glColor3us:
    mov rax, QWORD PTR [rip + _pfn_glColor3us]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3us]
    lea rdx, [rip + _name_glColor3us]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor3usv
glColor3usv:
    mov rax, QWORD PTR [rip + _pfn_glColor3usv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor3usv]
    lea rdx, [rip + _name_glColor3usv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4b
glColor4b:
    mov rax, QWORD PTR [rip + _pfn_glColor4b]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4b]
    lea rdx, [rip + _name_glColor4b]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4bv
glColor4bv:
    mov rax, QWORD PTR [rip + _pfn_glColor4bv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4bv]
    lea rdx, [rip + _name_glColor4bv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4d
glColor4d:
    mov rax, QWORD PTR [rip + _pfn_glColor4d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4d]
    lea rdx, [rip + _name_glColor4d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4dv
glColor4dv:
    mov rax, QWORD PTR [rip + _pfn_glColor4dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4dv]
    lea rdx, [rip + _name_glColor4dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4f
glColor4f:
    mov rax, QWORD PTR [rip + _pfn_glColor4f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4f]
    lea rdx, [rip + _name_glColor4f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4fv
glColor4fv:
    mov rax, QWORD PTR [rip + _pfn_glColor4fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4fv]
    lea rdx, [rip + _name_glColor4fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4i
glColor4i:
    mov rax, QWORD PTR [rip + _pfn_glColor4i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4i]
    lea rdx, [rip + _name_glColor4i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4iv
glColor4iv:
    mov rax, QWORD PTR [rip + _pfn_glColor4iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4iv]
    lea rdx, [rip + _name_glColor4iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4s
glColor4s:
    mov rax, QWORD PTR [rip + _pfn_glColor4s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4s]
    lea rdx, [rip + _name_glColor4s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4sv
glColor4sv:
    mov rax, QWORD PTR [rip + _pfn_glColor4sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4sv]
    lea rdx, [rip + _name_glColor4sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4ub
glColor4ub:
    mov rax, QWORD PTR [rip + _pfn_glColor4ub]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4ub]
    lea rdx, [rip + _name_glColor4ub]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4ubv
glColor4ubv:
    mov rax, QWORD PTR [rip + _pfn_glColor4ubv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4ubv]
    lea rdx, [rip + _name_glColor4ubv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4ui
glColor4ui:
    mov rax, QWORD PTR [rip + _pfn_glColor4ui]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4ui]
    lea rdx, [rip + _name_glColor4ui]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4uiv
glColor4uiv:
    mov rax, QWORD PTR [rip + _pfn_glColor4uiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4uiv]
    lea rdx, [rip + _name_glColor4uiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4us
glColor4us:
    mov rax, QWORD PTR [rip + _pfn_glColor4us]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4us]
    lea rdx, [rip + _name_glColor4us]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColor4usv
glColor4usv:
    mov rax, QWORD PTR [rip + _pfn_glColor4usv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColor4usv]
    lea rdx, [rip + _name_glColor4usv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColorMask
glColorMask:
    mov rax, QWORD PTR [rip + _pfn_glColorMask]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColorMask]
    lea rdx, [rip + _name_glColorMask]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColorMaterial
glColorMaterial:
    mov rax, QWORD PTR [rip + _pfn_glColorMaterial]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColorMaterial]
    lea rdx, [rip + _name_glColorMaterial]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glColorPointer
glColorPointer:
    mov rax, QWORD PTR [rip + _pfn_glColorPointer]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glColorPointer]
    lea rdx, [rip + _name_glColorPointer]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glCopyPixels
glCopyPixels:
    mov rax, QWORD PTR [rip + _pfn_glCopyPixels]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glCopyPixels]
    lea rdx, [rip + _name_glCopyPixels]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glCopyTexImage1D
glCopyTexImage1D:
    mov rax, QWORD PTR [rip + _pfn_glCopyTexImage1D]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glCopyTexImage1D]
    lea rdx, [rip + _name_glCopyTexImage1D]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glCopyTexImage2D
glCopyTexImage2D:
    mov rax, QWORD PTR [rip + _pfn_glCopyTexImage2D]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glCopyTexImage2D]
    lea rdx, [rip + _name_glCopyTexImage2D]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glCopyTexSubImage1D
glCopyTexSubImage1D:
    mov rax, QWORD PTR [rip + _pfn_glCopyTexSubImage1D]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glCopyTexSubImage1D]
    lea rdx, [rip + _name_glCopyTexSubImage1D]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glCopyTexSubImage2D
glCopyTexSubImage2D:
    mov rax, QWORD PTR [rip + _pfn_glCopyTexSubImage2D]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glCopyTexSubImage2D]
    lea rdx, [rip + _name_glCopyTexSubImage2D]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glCullFace
glCullFace:
    mov rax, QWORD PTR [rip + _pfn_glCullFace]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glCullFace]
    lea rdx, [rip + _name_glCullFace]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glDeleteLists
glDeleteLists:
    mov rax, QWORD PTR [rip + _pfn_glDeleteLists]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glDeleteLists]
    lea rdx, [rip + _name_glDeleteLists]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glDeleteTextures
glDeleteTextures:
    mov rax, QWORD PTR [rip + _pfn_glDeleteTextures]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glDeleteTextures]
    lea rdx, [rip + _name_glDeleteTextures]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glDepthFunc
glDepthFunc:
    mov rax, QWORD PTR [rip + _pfn_glDepthFunc]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glDepthFunc]
    lea rdx, [rip + _name_glDepthFunc]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glDepthMask
glDepthMask:
    mov rax, QWORD PTR [rip + _pfn_glDepthMask]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glDepthMask]
    lea rdx, [rip + _name_glDepthMask]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glDepthRange
glDepthRange:
    mov rax, QWORD PTR [rip + _pfn_glDepthRange]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glDepthRange]
    lea rdx, [rip + _name_glDepthRange]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glDisable
glDisable:
    mov rax, QWORD PTR [rip + _pfn_glDisable]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glDisable]
    lea rdx, [rip + _name_glDisable]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glDisableClientState
glDisableClientState:
    mov rax, QWORD PTR [rip + _pfn_glDisableClientState]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glDisableClientState]
    lea rdx, [rip + _name_glDisableClientState]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glDrawArrays
glDrawArrays:
    mov rax, QWORD PTR [rip + _pfn_glDrawArrays]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glDrawArrays]
    lea rdx, [rip + _name_glDrawArrays]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glDrawBuffer
glDrawBuffer:
    mov rax, QWORD PTR [rip + _pfn_glDrawBuffer]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glDrawBuffer]
    lea rdx, [rip + _name_glDrawBuffer]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glDrawPixels
glDrawPixels:
    mov rax, QWORD PTR [rip + _pfn_glDrawPixels]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glDrawPixels]
    lea rdx, [rip + _name_glDrawPixels]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEdgeFlag
glEdgeFlag:
    mov rax, QWORD PTR [rip + _pfn_glEdgeFlag]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEdgeFlag]
    lea rdx, [rip + _name_glEdgeFlag]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEdgeFlagPointer
glEdgeFlagPointer:
    mov rax, QWORD PTR [rip + _pfn_glEdgeFlagPointer]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEdgeFlagPointer]
    lea rdx, [rip + _name_glEdgeFlagPointer]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEdgeFlagv
glEdgeFlagv:
    mov rax, QWORD PTR [rip + _pfn_glEdgeFlagv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEdgeFlagv]
    lea rdx, [rip + _name_glEdgeFlagv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEnable
glEnable:
    mov rax, QWORD PTR [rip + _pfn_glEnable]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEnable]
    lea rdx, [rip + _name_glEnable]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEnableClientState
glEnableClientState:
    mov rax, QWORD PTR [rip + _pfn_glEnableClientState]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEnableClientState]
    lea rdx, [rip + _name_glEnableClientState]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEnd
glEnd:
    mov rax, QWORD PTR [rip + _pfn_glEnd]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEnd]
    lea rdx, [rip + _name_glEnd]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEndList
glEndList:
    mov rax, QWORD PTR [rip + _pfn_glEndList]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEndList]
    lea rdx, [rip + _name_glEndList]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalCoord1d
glEvalCoord1d:
    mov rax, QWORD PTR [rip + _pfn_glEvalCoord1d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalCoord1d]
    lea rdx, [rip + _name_glEvalCoord1d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalCoord1dv
glEvalCoord1dv:
    mov rax, QWORD PTR [rip + _pfn_glEvalCoord1dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalCoord1dv]
    lea rdx, [rip + _name_glEvalCoord1dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalCoord1f
glEvalCoord1f:
    mov rax, QWORD PTR [rip + _pfn_glEvalCoord1f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalCoord1f]
    lea rdx, [rip + _name_glEvalCoord1f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalCoord1fv
glEvalCoord1fv:
    mov rax, QWORD PTR [rip + _pfn_glEvalCoord1fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalCoord1fv]
    lea rdx, [rip + _name_glEvalCoord1fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalCoord2d
glEvalCoord2d:
    mov rax, QWORD PTR [rip + _pfn_glEvalCoord2d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalCoord2d]
    lea rdx, [rip + _name_glEvalCoord2d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalCoord2dv
glEvalCoord2dv:
    mov rax, QWORD PTR [rip + _pfn_glEvalCoord2dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalCoord2dv]
    lea rdx, [rip + _name_glEvalCoord2dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalCoord2f
glEvalCoord2f:
    mov rax, QWORD PTR [rip + _pfn_glEvalCoord2f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalCoord2f]
    lea rdx, [rip + _name_glEvalCoord2f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalCoord2fv
glEvalCoord2fv:
    mov rax, QWORD PTR [rip + _pfn_glEvalCoord2fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalCoord2fv]
    lea rdx, [rip + _name_glEvalCoord2fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalMesh1
glEvalMesh1:
    mov rax, QWORD PTR [rip + _pfn_glEvalMesh1]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalMesh1]
    lea rdx, [rip + _name_glEvalMesh1]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalMesh2
glEvalMesh2:
    mov rax, QWORD PTR [rip + _pfn_glEvalMesh2]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalMesh2]
    lea rdx, [rip + _name_glEvalMesh2]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalPoint1
glEvalPoint1:
    mov rax, QWORD PTR [rip + _pfn_glEvalPoint1]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalPoint1]
    lea rdx, [rip + _name_glEvalPoint1]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glEvalPoint2
glEvalPoint2:
    mov rax, QWORD PTR [rip + _pfn_glEvalPoint2]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glEvalPoint2]
    lea rdx, [rip + _name_glEvalPoint2]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glFeedbackBuffer
glFeedbackBuffer:
    mov rax, QWORD PTR [rip + _pfn_glFeedbackBuffer]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glFeedbackBuffer]
    lea rdx, [rip + _name_glFeedbackBuffer]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glFinish
glFinish:
    mov rax, QWORD PTR [rip + _pfn_glFinish]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glFinish]
    lea rdx, [rip + _name_glFinish]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glFlush
glFlush:
    mov rax, QWORD PTR [rip + _pfn_glFlush]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glFlush]
    lea rdx, [rip + _name_glFlush]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glFogf
glFogf:
    mov rax, QWORD PTR [rip + _pfn_glFogf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glFogf]
    lea rdx, [rip + _name_glFogf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glFogfv
glFogfv:
    mov rax, QWORD PTR [rip + _pfn_glFogfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glFogfv]
    lea rdx, [rip + _name_glFogfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glFogi
glFogi:
    mov rax, QWORD PTR [rip + _pfn_glFogi]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glFogi]
    lea rdx, [rip + _name_glFogi]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glFogiv
glFogiv:
    mov rax, QWORD PTR [rip + _pfn_glFogiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glFogiv]
    lea rdx, [rip + _name_glFogiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glFrontFace
glFrontFace:
    mov rax, QWORD PTR [rip + _pfn_glFrontFace]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glFrontFace]
    lea rdx, [rip + _name_glFrontFace]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glFrustum
glFrustum:
    mov rax, QWORD PTR [rip + _pfn_glFrustum]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glFrustum]
    lea rdx, [rip + _name_glFrustum]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGenLists
glGenLists:
    mov rax, QWORD PTR [rip + _pfn_glGenLists]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGenLists]
    lea rdx, [rip + _name_glGenLists]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGenTextures
glGenTextures:
    mov rax, QWORD PTR [rip + _pfn_glGenTextures]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGenTextures]
    lea rdx, [rip + _name_glGenTextures]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetBooleanv
glGetBooleanv:
    mov rax, QWORD PTR [rip + _pfn_glGetBooleanv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetBooleanv]
    lea rdx, [rip + _name_glGetBooleanv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetClipPlane
glGetClipPlane:
    mov rax, QWORD PTR [rip + _pfn_glGetClipPlane]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetClipPlane]
    lea rdx, [rip + _name_glGetClipPlane]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetDoublev
glGetDoublev:
    mov rax, QWORD PTR [rip + _pfn_glGetDoublev]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetDoublev]
    lea rdx, [rip + _name_glGetDoublev]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetError
glGetError:
    mov rax, QWORD PTR [rip + _pfn_glGetError]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetError]
    lea rdx, [rip + _name_glGetError]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetFloatv
glGetFloatv:
    mov rax, QWORD PTR [rip + _pfn_glGetFloatv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetFloatv]
    lea rdx, [rip + _name_glGetFloatv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetIntegerv
glGetIntegerv:
    mov rax, QWORD PTR [rip + _pfn_glGetIntegerv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetIntegerv]
    lea rdx, [rip + _name_glGetIntegerv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetLightfv
glGetLightfv:
    mov rax, QWORD PTR [rip + _pfn_glGetLightfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetLightfv]
    lea rdx, [rip + _name_glGetLightfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetLightiv
glGetLightiv:
    mov rax, QWORD PTR [rip + _pfn_glGetLightiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetLightiv]
    lea rdx, [rip + _name_glGetLightiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetMapdv
glGetMapdv:
    mov rax, QWORD PTR [rip + _pfn_glGetMapdv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetMapdv]
    lea rdx, [rip + _name_glGetMapdv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetMapfv
glGetMapfv:
    mov rax, QWORD PTR [rip + _pfn_glGetMapfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetMapfv]
    lea rdx, [rip + _name_glGetMapfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetMapiv
glGetMapiv:
    mov rax, QWORD PTR [rip + _pfn_glGetMapiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetMapiv]
    lea rdx, [rip + _name_glGetMapiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetMaterialfv
glGetMaterialfv:
    mov rax, QWORD PTR [rip + _pfn_glGetMaterialfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetMaterialfv]
    lea rdx, [rip + _name_glGetMaterialfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetMaterialiv
glGetMaterialiv:
    mov rax, QWORD PTR [rip + _pfn_glGetMaterialiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetMaterialiv]
    lea rdx, [rip + _name_glGetMaterialiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetPixelMapfv
glGetPixelMapfv:
    mov rax, QWORD PTR [rip + _pfn_glGetPixelMapfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetPixelMapfv]
    lea rdx, [rip + _name_glGetPixelMapfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetPixelMapuiv
glGetPixelMapuiv:
    mov rax, QWORD PTR [rip + _pfn_glGetPixelMapuiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetPixelMapuiv]
    lea rdx, [rip + _name_glGetPixelMapuiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetPixelMapusv
glGetPixelMapusv:
    mov rax, QWORD PTR [rip + _pfn_glGetPixelMapusv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetPixelMapusv]
    lea rdx, [rip + _name_glGetPixelMapusv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetPointerv
glGetPointerv:
    mov rax, QWORD PTR [rip + _pfn_glGetPointerv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetPointerv]
    lea rdx, [rip + _name_glGetPointerv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetPolygonStipple
glGetPolygonStipple:
    mov rax, QWORD PTR [rip + _pfn_glGetPolygonStipple]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetPolygonStipple]
    lea rdx, [rip + _name_glGetPolygonStipple]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetString
glGetString:
    mov rax, QWORD PTR [rip + _pfn_glGetString]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetString]
    lea rdx, [rip + _name_glGetString]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetTexEnvfv
glGetTexEnvfv:
    mov rax, QWORD PTR [rip + _pfn_glGetTexEnvfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetTexEnvfv]
    lea rdx, [rip + _name_glGetTexEnvfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetTexEnviv
glGetTexEnviv:
    mov rax, QWORD PTR [rip + _pfn_glGetTexEnviv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetTexEnviv]
    lea rdx, [rip + _name_glGetTexEnviv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetTexGendv
glGetTexGendv:
    mov rax, QWORD PTR [rip + _pfn_glGetTexGendv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetTexGendv]
    lea rdx, [rip + _name_glGetTexGendv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetTexGenfv
glGetTexGenfv:
    mov rax, QWORD PTR [rip + _pfn_glGetTexGenfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetTexGenfv]
    lea rdx, [rip + _name_glGetTexGenfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetTexGeniv
glGetTexGeniv:
    mov rax, QWORD PTR [rip + _pfn_glGetTexGeniv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetTexGeniv]
    lea rdx, [rip + _name_glGetTexGeniv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetTexImage
glGetTexImage:
    mov rax, QWORD PTR [rip + _pfn_glGetTexImage]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetTexImage]
    lea rdx, [rip + _name_glGetTexImage]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetTexLevelParameterfv
glGetTexLevelParameterfv:
    mov rax, QWORD PTR [rip + _pfn_glGetTexLevelParameterfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetTexLevelParameterfv]
    lea rdx, [rip + _name_glGetTexLevelParameterfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetTexLevelParameteriv
glGetTexLevelParameteriv:
    mov rax, QWORD PTR [rip + _pfn_glGetTexLevelParameteriv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetTexLevelParameteriv]
    lea rdx, [rip + _name_glGetTexLevelParameteriv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetTexParameterfv
glGetTexParameterfv:
    mov rax, QWORD PTR [rip + _pfn_glGetTexParameterfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetTexParameterfv]
    lea rdx, [rip + _name_glGetTexParameterfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glGetTexParameteriv
glGetTexParameteriv:
    mov rax, QWORD PTR [rip + _pfn_glGetTexParameteriv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glGetTexParameteriv]
    lea rdx, [rip + _name_glGetTexParameteriv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glHint
glHint:
    mov rax, QWORD PTR [rip + _pfn_glHint]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glHint]
    lea rdx, [rip + _name_glHint]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexMask
glIndexMask:
    mov rax, QWORD PTR [rip + _pfn_glIndexMask]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexMask]
    lea rdx, [rip + _name_glIndexMask]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexPointer
glIndexPointer:
    mov rax, QWORD PTR [rip + _pfn_glIndexPointer]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexPointer]
    lea rdx, [rip + _name_glIndexPointer]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexd
glIndexd:
    mov rax, QWORD PTR [rip + _pfn_glIndexd]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexd]
    lea rdx, [rip + _name_glIndexd]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexdv
glIndexdv:
    mov rax, QWORD PTR [rip + _pfn_glIndexdv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexdv]
    lea rdx, [rip + _name_glIndexdv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexf
glIndexf:
    mov rax, QWORD PTR [rip + _pfn_glIndexf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexf]
    lea rdx, [rip + _name_glIndexf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexfv
glIndexfv:
    mov rax, QWORD PTR [rip + _pfn_glIndexfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexfv]
    lea rdx, [rip + _name_glIndexfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexi
glIndexi:
    mov rax, QWORD PTR [rip + _pfn_glIndexi]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexi]
    lea rdx, [rip + _name_glIndexi]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexiv
glIndexiv:
    mov rax, QWORD PTR [rip + _pfn_glIndexiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexiv]
    lea rdx, [rip + _name_glIndexiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexs
glIndexs:
    mov rax, QWORD PTR [rip + _pfn_glIndexs]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexs]
    lea rdx, [rip + _name_glIndexs]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexsv
glIndexsv:
    mov rax, QWORD PTR [rip + _pfn_glIndexsv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexsv]
    lea rdx, [rip + _name_glIndexsv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexub
glIndexub:
    mov rax, QWORD PTR [rip + _pfn_glIndexub]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexub]
    lea rdx, [rip + _name_glIndexub]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIndexubv
glIndexubv:
    mov rax, QWORD PTR [rip + _pfn_glIndexubv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIndexubv]
    lea rdx, [rip + _name_glIndexubv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glInitNames
glInitNames:
    mov rax, QWORD PTR [rip + _pfn_glInitNames]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glInitNames]
    lea rdx, [rip + _name_glInitNames]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glInterleavedArrays
glInterleavedArrays:
    mov rax, QWORD PTR [rip + _pfn_glInterleavedArrays]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glInterleavedArrays]
    lea rdx, [rip + _name_glInterleavedArrays]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIsEnabled
glIsEnabled:
    mov rax, QWORD PTR [rip + _pfn_glIsEnabled]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIsEnabled]
    lea rdx, [rip + _name_glIsEnabled]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIsList
glIsList:
    mov rax, QWORD PTR [rip + _pfn_glIsList]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIsList]
    lea rdx, [rip + _name_glIsList]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glIsTexture
glIsTexture:
    mov rax, QWORD PTR [rip + _pfn_glIsTexture]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glIsTexture]
    lea rdx, [rip + _name_glIsTexture]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLightModelf
glLightModelf:
    mov rax, QWORD PTR [rip + _pfn_glLightModelf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLightModelf]
    lea rdx, [rip + _name_glLightModelf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLightModelfv
glLightModelfv:
    mov rax, QWORD PTR [rip + _pfn_glLightModelfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLightModelfv]
    lea rdx, [rip + _name_glLightModelfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLightModeli
glLightModeli:
    mov rax, QWORD PTR [rip + _pfn_glLightModeli]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLightModeli]
    lea rdx, [rip + _name_glLightModeli]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLightModeliv
glLightModeliv:
    mov rax, QWORD PTR [rip + _pfn_glLightModeliv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLightModeliv]
    lea rdx, [rip + _name_glLightModeliv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLightf
glLightf:
    mov rax, QWORD PTR [rip + _pfn_glLightf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLightf]
    lea rdx, [rip + _name_glLightf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLightfv
glLightfv:
    mov rax, QWORD PTR [rip + _pfn_glLightfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLightfv]
    lea rdx, [rip + _name_glLightfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLighti
glLighti:
    mov rax, QWORD PTR [rip + _pfn_glLighti]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLighti]
    lea rdx, [rip + _name_glLighti]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLightiv
glLightiv:
    mov rax, QWORD PTR [rip + _pfn_glLightiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLightiv]
    lea rdx, [rip + _name_glLightiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLineStipple
glLineStipple:
    mov rax, QWORD PTR [rip + _pfn_glLineStipple]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLineStipple]
    lea rdx, [rip + _name_glLineStipple]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLineWidth
glLineWidth:
    mov rax, QWORD PTR [rip + _pfn_glLineWidth]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLineWidth]
    lea rdx, [rip + _name_glLineWidth]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glListBase
glListBase:
    mov rax, QWORD PTR [rip + _pfn_glListBase]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glListBase]
    lea rdx, [rip + _name_glListBase]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLoadIdentity
glLoadIdentity:
    mov rax, QWORD PTR [rip + _pfn_glLoadIdentity]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLoadIdentity]
    lea rdx, [rip + _name_glLoadIdentity]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLoadMatrixd
glLoadMatrixd:
    mov rax, QWORD PTR [rip + _pfn_glLoadMatrixd]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLoadMatrixd]
    lea rdx, [rip + _name_glLoadMatrixd]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLoadMatrixf
glLoadMatrixf:
    mov rax, QWORD PTR [rip + _pfn_glLoadMatrixf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLoadMatrixf]
    lea rdx, [rip + _name_glLoadMatrixf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLoadName
glLoadName:
    mov rax, QWORD PTR [rip + _pfn_glLoadName]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLoadName]
    lea rdx, [rip + _name_glLoadName]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glLogicOp
glLogicOp:
    mov rax, QWORD PTR [rip + _pfn_glLogicOp]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glLogicOp]
    lea rdx, [rip + _name_glLogicOp]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMap1d
glMap1d:
    mov rax, QWORD PTR [rip + _pfn_glMap1d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMap1d]
    lea rdx, [rip + _name_glMap1d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMap1f
glMap1f:
    mov rax, QWORD PTR [rip + _pfn_glMap1f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMap1f]
    lea rdx, [rip + _name_glMap1f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMap2d
glMap2d:
    mov rax, QWORD PTR [rip + _pfn_glMap2d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMap2d]
    lea rdx, [rip + _name_glMap2d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMap2f
glMap2f:
    mov rax, QWORD PTR [rip + _pfn_glMap2f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMap2f]
    lea rdx, [rip + _name_glMap2f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMapGrid1d
glMapGrid1d:
    mov rax, QWORD PTR [rip + _pfn_glMapGrid1d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMapGrid1d]
    lea rdx, [rip + _name_glMapGrid1d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMapGrid1f
glMapGrid1f:
    mov rax, QWORD PTR [rip + _pfn_glMapGrid1f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMapGrid1f]
    lea rdx, [rip + _name_glMapGrid1f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMapGrid2d
glMapGrid2d:
    mov rax, QWORD PTR [rip + _pfn_glMapGrid2d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMapGrid2d]
    lea rdx, [rip + _name_glMapGrid2d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMapGrid2f
glMapGrid2f:
    mov rax, QWORD PTR [rip + _pfn_glMapGrid2f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMapGrid2f]
    lea rdx, [rip + _name_glMapGrid2f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMaterialf
glMaterialf:
    mov rax, QWORD PTR [rip + _pfn_glMaterialf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMaterialf]
    lea rdx, [rip + _name_glMaterialf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMaterialfv
glMaterialfv:
    mov rax, QWORD PTR [rip + _pfn_glMaterialfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMaterialfv]
    lea rdx, [rip + _name_glMaterialfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMateriali
glMateriali:
    mov rax, QWORD PTR [rip + _pfn_glMateriali]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMateriali]
    lea rdx, [rip + _name_glMateriali]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMaterialiv
glMaterialiv:
    mov rax, QWORD PTR [rip + _pfn_glMaterialiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMaterialiv]
    lea rdx, [rip + _name_glMaterialiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMatrixMode
glMatrixMode:
    mov rax, QWORD PTR [rip + _pfn_glMatrixMode]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMatrixMode]
    lea rdx, [rip + _name_glMatrixMode]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMultMatrixd
glMultMatrixd:
    mov rax, QWORD PTR [rip + _pfn_glMultMatrixd]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMultMatrixd]
    lea rdx, [rip + _name_glMultMatrixd]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glMultMatrixf
glMultMatrixf:
    mov rax, QWORD PTR [rip + _pfn_glMultMatrixf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glMultMatrixf]
    lea rdx, [rip + _name_glMultMatrixf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNewList
glNewList:
    mov rax, QWORD PTR [rip + _pfn_glNewList]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNewList]
    lea rdx, [rip + _name_glNewList]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNormal3b
glNormal3b:
    mov rax, QWORD PTR [rip + _pfn_glNormal3b]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNormal3b]
    lea rdx, [rip + _name_glNormal3b]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNormal3bv
glNormal3bv:
    mov rax, QWORD PTR [rip + _pfn_glNormal3bv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNormal3bv]
    lea rdx, [rip + _name_glNormal3bv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNormal3d
glNormal3d:
    mov rax, QWORD PTR [rip + _pfn_glNormal3d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNormal3d]
    lea rdx, [rip + _name_glNormal3d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNormal3dv
glNormal3dv:
    mov rax, QWORD PTR [rip + _pfn_glNormal3dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNormal3dv]
    lea rdx, [rip + _name_glNormal3dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNormal3f
glNormal3f:
    mov rax, QWORD PTR [rip + _pfn_glNormal3f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNormal3f]
    lea rdx, [rip + _name_glNormal3f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNormal3fv
glNormal3fv:
    mov rax, QWORD PTR [rip + _pfn_glNormal3fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNormal3fv]
    lea rdx, [rip + _name_glNormal3fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNormal3i
glNormal3i:
    mov rax, QWORD PTR [rip + _pfn_glNormal3i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNormal3i]
    lea rdx, [rip + _name_glNormal3i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNormal3iv
glNormal3iv:
    mov rax, QWORD PTR [rip + _pfn_glNormal3iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNormal3iv]
    lea rdx, [rip + _name_glNormal3iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNormal3s
glNormal3s:
    mov rax, QWORD PTR [rip + _pfn_glNormal3s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNormal3s]
    lea rdx, [rip + _name_glNormal3s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNormal3sv
glNormal3sv:
    mov rax, QWORD PTR [rip + _pfn_glNormal3sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNormal3sv]
    lea rdx, [rip + _name_glNormal3sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glNormalPointer
glNormalPointer:
    mov rax, QWORD PTR [rip + _pfn_glNormalPointer]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glNormalPointer]
    lea rdx, [rip + _name_glNormalPointer]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glOrtho
glOrtho:
    mov rax, QWORD PTR [rip + _pfn_glOrtho]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glOrtho]
    lea rdx, [rip + _name_glOrtho]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPassThrough
glPassThrough:
    mov rax, QWORD PTR [rip + _pfn_glPassThrough]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPassThrough]
    lea rdx, [rip + _name_glPassThrough]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPixelMapfv
glPixelMapfv:
    mov rax, QWORD PTR [rip + _pfn_glPixelMapfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPixelMapfv]
    lea rdx, [rip + _name_glPixelMapfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPixelMapuiv
glPixelMapuiv:
    mov rax, QWORD PTR [rip + _pfn_glPixelMapuiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPixelMapuiv]
    lea rdx, [rip + _name_glPixelMapuiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPixelMapusv
glPixelMapusv:
    mov rax, QWORD PTR [rip + _pfn_glPixelMapusv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPixelMapusv]
    lea rdx, [rip + _name_glPixelMapusv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPixelStoref
glPixelStoref:
    mov rax, QWORD PTR [rip + _pfn_glPixelStoref]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPixelStoref]
    lea rdx, [rip + _name_glPixelStoref]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPixelStorei
glPixelStorei:
    mov rax, QWORD PTR [rip + _pfn_glPixelStorei]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPixelStorei]
    lea rdx, [rip + _name_glPixelStorei]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPixelTransferf
glPixelTransferf:
    mov rax, QWORD PTR [rip + _pfn_glPixelTransferf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPixelTransferf]
    lea rdx, [rip + _name_glPixelTransferf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPixelTransferi
glPixelTransferi:
    mov rax, QWORD PTR [rip + _pfn_glPixelTransferi]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPixelTransferi]
    lea rdx, [rip + _name_glPixelTransferi]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPixelZoom
glPixelZoom:
    mov rax, QWORD PTR [rip + _pfn_glPixelZoom]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPixelZoom]
    lea rdx, [rip + _name_glPixelZoom]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPointSize
glPointSize:
    mov rax, QWORD PTR [rip + _pfn_glPointSize]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPointSize]
    lea rdx, [rip + _name_glPointSize]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPolygonMode
glPolygonMode:
    mov rax, QWORD PTR [rip + _pfn_glPolygonMode]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPolygonMode]
    lea rdx, [rip + _name_glPolygonMode]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPolygonOffset
glPolygonOffset:
    mov rax, QWORD PTR [rip + _pfn_glPolygonOffset]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPolygonOffset]
    lea rdx, [rip + _name_glPolygonOffset]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPolygonStipple
glPolygonStipple:
    mov rax, QWORD PTR [rip + _pfn_glPolygonStipple]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPolygonStipple]
    lea rdx, [rip + _name_glPolygonStipple]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPopAttrib
glPopAttrib:
    mov rax, QWORD PTR [rip + _pfn_glPopAttrib]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPopAttrib]
    lea rdx, [rip + _name_glPopAttrib]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPopClientAttrib
glPopClientAttrib:
    mov rax, QWORD PTR [rip + _pfn_glPopClientAttrib]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPopClientAttrib]
    lea rdx, [rip + _name_glPopClientAttrib]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPopMatrix
glPopMatrix:
    mov rax, QWORD PTR [rip + _pfn_glPopMatrix]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPopMatrix]
    lea rdx, [rip + _name_glPopMatrix]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPopName
glPopName:
    mov rax, QWORD PTR [rip + _pfn_glPopName]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPopName]
    lea rdx, [rip + _name_glPopName]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPrioritizeTextures
glPrioritizeTextures:
    mov rax, QWORD PTR [rip + _pfn_glPrioritizeTextures]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPrioritizeTextures]
    lea rdx, [rip + _name_glPrioritizeTextures]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPushAttrib
glPushAttrib:
    mov rax, QWORD PTR [rip + _pfn_glPushAttrib]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPushAttrib]
    lea rdx, [rip + _name_glPushAttrib]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPushClientAttrib
glPushClientAttrib:
    mov rax, QWORD PTR [rip + _pfn_glPushClientAttrib]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPushClientAttrib]
    lea rdx, [rip + _name_glPushClientAttrib]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPushMatrix
glPushMatrix:
    mov rax, QWORD PTR [rip + _pfn_glPushMatrix]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPushMatrix]
    lea rdx, [rip + _name_glPushMatrix]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glPushName
glPushName:
    mov rax, QWORD PTR [rip + _pfn_glPushName]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glPushName]
    lea rdx, [rip + _name_glPushName]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos2d
glRasterPos2d:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos2d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos2d]
    lea rdx, [rip + _name_glRasterPos2d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos2dv
glRasterPos2dv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos2dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos2dv]
    lea rdx, [rip + _name_glRasterPos2dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos2f
glRasterPos2f:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos2f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos2f]
    lea rdx, [rip + _name_glRasterPos2f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos2fv
glRasterPos2fv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos2fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos2fv]
    lea rdx, [rip + _name_glRasterPos2fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos2i
glRasterPos2i:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos2i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos2i]
    lea rdx, [rip + _name_glRasterPos2i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos2iv
glRasterPos2iv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos2iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos2iv]
    lea rdx, [rip + _name_glRasterPos2iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos2s
glRasterPos2s:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos2s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos2s]
    lea rdx, [rip + _name_glRasterPos2s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos2sv
glRasterPos2sv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos2sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos2sv]
    lea rdx, [rip + _name_glRasterPos2sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos3d
glRasterPos3d:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos3d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos3d]
    lea rdx, [rip + _name_glRasterPos3d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos3dv
glRasterPos3dv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos3dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos3dv]
    lea rdx, [rip + _name_glRasterPos3dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos3f
glRasterPos3f:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos3f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos3f]
    lea rdx, [rip + _name_glRasterPos3f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos3fv
glRasterPos3fv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos3fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos3fv]
    lea rdx, [rip + _name_glRasterPos3fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos3i
glRasterPos3i:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos3i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos3i]
    lea rdx, [rip + _name_glRasterPos3i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos3iv
glRasterPos3iv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos3iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos3iv]
    lea rdx, [rip + _name_glRasterPos3iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos3s
glRasterPos3s:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos3s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos3s]
    lea rdx, [rip + _name_glRasterPos3s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos3sv
glRasterPos3sv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos3sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos3sv]
    lea rdx, [rip + _name_glRasterPos3sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos4d
glRasterPos4d:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos4d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos4d]
    lea rdx, [rip + _name_glRasterPos4d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos4dv
glRasterPos4dv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos4dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos4dv]
    lea rdx, [rip + _name_glRasterPos4dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos4f
glRasterPos4f:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos4f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos4f]
    lea rdx, [rip + _name_glRasterPos4f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos4fv
glRasterPos4fv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos4fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos4fv]
    lea rdx, [rip + _name_glRasterPos4fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos4i
glRasterPos4i:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos4i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos4i]
    lea rdx, [rip + _name_glRasterPos4i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos4iv
glRasterPos4iv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos4iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos4iv]
    lea rdx, [rip + _name_glRasterPos4iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos4s
glRasterPos4s:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos4s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos4s]
    lea rdx, [rip + _name_glRasterPos4s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRasterPos4sv
glRasterPos4sv:
    mov rax, QWORD PTR [rip + _pfn_glRasterPos4sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRasterPos4sv]
    lea rdx, [rip + _name_glRasterPos4sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glReadBuffer
glReadBuffer:
    mov rax, QWORD PTR [rip + _pfn_glReadBuffer]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glReadBuffer]
    lea rdx, [rip + _name_glReadBuffer]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glReadPixels
glReadPixels:
    mov rax, QWORD PTR [rip + _pfn_glReadPixels]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glReadPixels]
    lea rdx, [rip + _name_glReadPixels]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRectd
glRectd:
    mov rax, QWORD PTR [rip + _pfn_glRectd]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRectd]
    lea rdx, [rip + _name_glRectd]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRectdv
glRectdv:
    mov rax, QWORD PTR [rip + _pfn_glRectdv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRectdv]
    lea rdx, [rip + _name_glRectdv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRectf
glRectf:
    mov rax, QWORD PTR [rip + _pfn_glRectf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRectf]
    lea rdx, [rip + _name_glRectf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRectfv
glRectfv:
    mov rax, QWORD PTR [rip + _pfn_glRectfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRectfv]
    lea rdx, [rip + _name_glRectfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRecti
glRecti:
    mov rax, QWORD PTR [rip + _pfn_glRecti]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRecti]
    lea rdx, [rip + _name_glRecti]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRectiv
glRectiv:
    mov rax, QWORD PTR [rip + _pfn_glRectiv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRectiv]
    lea rdx, [rip + _name_glRectiv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRects
glRects:
    mov rax, QWORD PTR [rip + _pfn_glRects]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRects]
    lea rdx, [rip + _name_glRects]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRectsv
glRectsv:
    mov rax, QWORD PTR [rip + _pfn_glRectsv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRectsv]
    lea rdx, [rip + _name_glRectsv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRenderMode
glRenderMode:
    mov rax, QWORD PTR [rip + _pfn_glRenderMode]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRenderMode]
    lea rdx, [rip + _name_glRenderMode]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRotated
glRotated:
    mov rax, QWORD PTR [rip + _pfn_glRotated]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRotated]
    lea rdx, [rip + _name_glRotated]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glRotatef
glRotatef:
    mov rax, QWORD PTR [rip + _pfn_glRotatef]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glRotatef]
    lea rdx, [rip + _name_glRotatef]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glScaled
glScaled:
    mov rax, QWORD PTR [rip + _pfn_glScaled]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glScaled]
    lea rdx, [rip + _name_glScaled]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glScalef
glScalef:
    mov rax, QWORD PTR [rip + _pfn_glScalef]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glScalef]
    lea rdx, [rip + _name_glScalef]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glScissor
glScissor:
    mov rax, QWORD PTR [rip + _pfn_glScissor]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glScissor]
    lea rdx, [rip + _name_glScissor]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glSelectBuffer
glSelectBuffer:
    mov rax, QWORD PTR [rip + _pfn_glSelectBuffer]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glSelectBuffer]
    lea rdx, [rip + _name_glSelectBuffer]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glShadeModel
glShadeModel:
    mov rax, QWORD PTR [rip + _pfn_glShadeModel]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glShadeModel]
    lea rdx, [rip + _name_glShadeModel]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glStencilFunc
glStencilFunc:
    mov rax, QWORD PTR [rip + _pfn_glStencilFunc]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glStencilFunc]
    lea rdx, [rip + _name_glStencilFunc]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glStencilMask
glStencilMask:
    mov rax, QWORD PTR [rip + _pfn_glStencilMask]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glStencilMask]
    lea rdx, [rip + _name_glStencilMask]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glStencilOp
glStencilOp:
    mov rax, QWORD PTR [rip + _pfn_glStencilOp]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glStencilOp]
    lea rdx, [rip + _name_glStencilOp]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord1d
glTexCoord1d:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord1d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord1d]
    lea rdx, [rip + _name_glTexCoord1d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord1dv
glTexCoord1dv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord1dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord1dv]
    lea rdx, [rip + _name_glTexCoord1dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord1f
glTexCoord1f:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord1f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord1f]
    lea rdx, [rip + _name_glTexCoord1f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord1fv
glTexCoord1fv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord1fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord1fv]
    lea rdx, [rip + _name_glTexCoord1fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord1i
glTexCoord1i:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord1i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord1i]
    lea rdx, [rip + _name_glTexCoord1i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord1iv
glTexCoord1iv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord1iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord1iv]
    lea rdx, [rip + _name_glTexCoord1iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord1s
glTexCoord1s:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord1s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord1s]
    lea rdx, [rip + _name_glTexCoord1s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord1sv
glTexCoord1sv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord1sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord1sv]
    lea rdx, [rip + _name_glTexCoord1sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord2d
glTexCoord2d:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord2d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord2d]
    lea rdx, [rip + _name_glTexCoord2d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord2dv
glTexCoord2dv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord2dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord2dv]
    lea rdx, [rip + _name_glTexCoord2dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord2f
glTexCoord2f:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord2f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord2f]
    lea rdx, [rip + _name_glTexCoord2f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord2fv
glTexCoord2fv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord2fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord2fv]
    lea rdx, [rip + _name_glTexCoord2fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord2i
glTexCoord2i:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord2i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord2i]
    lea rdx, [rip + _name_glTexCoord2i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord2iv
glTexCoord2iv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord2iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord2iv]
    lea rdx, [rip + _name_glTexCoord2iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord2s
glTexCoord2s:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord2s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord2s]
    lea rdx, [rip + _name_glTexCoord2s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord2sv
glTexCoord2sv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord2sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord2sv]
    lea rdx, [rip + _name_glTexCoord2sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord3d
glTexCoord3d:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord3d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord3d]
    lea rdx, [rip + _name_glTexCoord3d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord3dv
glTexCoord3dv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord3dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord3dv]
    lea rdx, [rip + _name_glTexCoord3dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord3f
glTexCoord3f:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord3f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord3f]
    lea rdx, [rip + _name_glTexCoord3f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord3fv
glTexCoord3fv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord3fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord3fv]
    lea rdx, [rip + _name_glTexCoord3fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord3i
glTexCoord3i:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord3i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord3i]
    lea rdx, [rip + _name_glTexCoord3i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord3iv
glTexCoord3iv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord3iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord3iv]
    lea rdx, [rip + _name_glTexCoord3iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord3s
glTexCoord3s:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord3s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord3s]
    lea rdx, [rip + _name_glTexCoord3s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord3sv
glTexCoord3sv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord3sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord3sv]
    lea rdx, [rip + _name_glTexCoord3sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord4d
glTexCoord4d:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord4d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord4d]
    lea rdx, [rip + _name_glTexCoord4d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord4dv
glTexCoord4dv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord4dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord4dv]
    lea rdx, [rip + _name_glTexCoord4dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord4f
glTexCoord4f:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord4f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord4f]
    lea rdx, [rip + _name_glTexCoord4f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord4fv
glTexCoord4fv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord4fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord4fv]
    lea rdx, [rip + _name_glTexCoord4fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord4i
glTexCoord4i:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord4i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord4i]
    lea rdx, [rip + _name_glTexCoord4i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord4iv
glTexCoord4iv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord4iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord4iv]
    lea rdx, [rip + _name_glTexCoord4iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord4s
glTexCoord4s:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord4s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord4s]
    lea rdx, [rip + _name_glTexCoord4s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoord4sv
glTexCoord4sv:
    mov rax, QWORD PTR [rip + _pfn_glTexCoord4sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoord4sv]
    lea rdx, [rip + _name_glTexCoord4sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexCoordPointer
glTexCoordPointer:
    mov rax, QWORD PTR [rip + _pfn_glTexCoordPointer]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexCoordPointer]
    lea rdx, [rip + _name_glTexCoordPointer]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexEnvf
glTexEnvf:
    mov rax, QWORD PTR [rip + _pfn_glTexEnvf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexEnvf]
    lea rdx, [rip + _name_glTexEnvf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexEnvfv
glTexEnvfv:
    mov rax, QWORD PTR [rip + _pfn_glTexEnvfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexEnvfv]
    lea rdx, [rip + _name_glTexEnvfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexEnvi
glTexEnvi:
    mov rax, QWORD PTR [rip + _pfn_glTexEnvi]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexEnvi]
    lea rdx, [rip + _name_glTexEnvi]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexEnviv
glTexEnviv:
    mov rax, QWORD PTR [rip + _pfn_glTexEnviv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexEnviv]
    lea rdx, [rip + _name_glTexEnviv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexGend
glTexGend:
    mov rax, QWORD PTR [rip + _pfn_glTexGend]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexGend]
    lea rdx, [rip + _name_glTexGend]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexGendv
glTexGendv:
    mov rax, QWORD PTR [rip + _pfn_glTexGendv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexGendv]
    lea rdx, [rip + _name_glTexGendv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexGenf
glTexGenf:
    mov rax, QWORD PTR [rip + _pfn_glTexGenf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexGenf]
    lea rdx, [rip + _name_glTexGenf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexGenfv
glTexGenfv:
    mov rax, QWORD PTR [rip + _pfn_glTexGenfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexGenfv]
    lea rdx, [rip + _name_glTexGenfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexGeni
glTexGeni:
    mov rax, QWORD PTR [rip + _pfn_glTexGeni]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexGeni]
    lea rdx, [rip + _name_glTexGeni]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexGeniv
glTexGeniv:
    mov rax, QWORD PTR [rip + _pfn_glTexGeniv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexGeniv]
    lea rdx, [rip + _name_glTexGeniv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexImage1D
glTexImage1D:
    mov rax, QWORD PTR [rip + _pfn_glTexImage1D]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexImage1D]
    lea rdx, [rip + _name_glTexImage1D]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexImage2D
glTexImage2D:
    mov rax, QWORD PTR [rip + _pfn_glTexImage2D]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexImage2D]
    lea rdx, [rip + _name_glTexImage2D]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexParameterf
glTexParameterf:
    mov rax, QWORD PTR [rip + _pfn_glTexParameterf]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexParameterf]
    lea rdx, [rip + _name_glTexParameterf]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexParameterfv
glTexParameterfv:
    mov rax, QWORD PTR [rip + _pfn_glTexParameterfv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexParameterfv]
    lea rdx, [rip + _name_glTexParameterfv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexParameteri
glTexParameteri:
    mov rax, QWORD PTR [rip + _pfn_glTexParameteri]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexParameteri]
    lea rdx, [rip + _name_glTexParameteri]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexParameteriv
glTexParameteriv:
    mov rax, QWORD PTR [rip + _pfn_glTexParameteriv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexParameteriv]
    lea rdx, [rip + _name_glTexParameteriv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexSubImage1D
glTexSubImage1D:
    mov rax, QWORD PTR [rip + _pfn_glTexSubImage1D]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexSubImage1D]
    lea rdx, [rip + _name_glTexSubImage1D]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTexSubImage2D
glTexSubImage2D:
    mov rax, QWORD PTR [rip + _pfn_glTexSubImage2D]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTexSubImage2D]
    lea rdx, [rip + _name_glTexSubImage2D]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTranslated
glTranslated:
    mov rax, QWORD PTR [rip + _pfn_glTranslated]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTranslated]
    lea rdx, [rip + _name_glTranslated]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glTranslatef
glTranslatef:
    mov rax, QWORD PTR [rip + _pfn_glTranslatef]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glTranslatef]
    lea rdx, [rip + _name_glTranslatef]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex2d
glVertex2d:
    mov rax, QWORD PTR [rip + _pfn_glVertex2d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex2d]
    lea rdx, [rip + _name_glVertex2d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex2dv
glVertex2dv:
    mov rax, QWORD PTR [rip + _pfn_glVertex2dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex2dv]
    lea rdx, [rip + _name_glVertex2dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex2f
glVertex2f:
    mov rax, QWORD PTR [rip + _pfn_glVertex2f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex2f]
    lea rdx, [rip + _name_glVertex2f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex2fv
glVertex2fv:
    mov rax, QWORD PTR [rip + _pfn_glVertex2fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex2fv]
    lea rdx, [rip + _name_glVertex2fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex2i
glVertex2i:
    mov rax, QWORD PTR [rip + _pfn_glVertex2i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex2i]
    lea rdx, [rip + _name_glVertex2i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex2iv
glVertex2iv:
    mov rax, QWORD PTR [rip + _pfn_glVertex2iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex2iv]
    lea rdx, [rip + _name_glVertex2iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex2s
glVertex2s:
    mov rax, QWORD PTR [rip + _pfn_glVertex2s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex2s]
    lea rdx, [rip + _name_glVertex2s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex2sv
glVertex2sv:
    mov rax, QWORD PTR [rip + _pfn_glVertex2sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex2sv]
    lea rdx, [rip + _name_glVertex2sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex3d
glVertex3d:
    mov rax, QWORD PTR [rip + _pfn_glVertex3d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex3d]
    lea rdx, [rip + _name_glVertex3d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex3dv
glVertex3dv:
    mov rax, QWORD PTR [rip + _pfn_glVertex3dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex3dv]
    lea rdx, [rip + _name_glVertex3dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex3f
glVertex3f:
    mov rax, QWORD PTR [rip + _pfn_glVertex3f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex3f]
    lea rdx, [rip + _name_glVertex3f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex3fv
glVertex3fv:
    mov rax, QWORD PTR [rip + _pfn_glVertex3fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex3fv]
    lea rdx, [rip + _name_glVertex3fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex3i
glVertex3i:
    mov rax, QWORD PTR [rip + _pfn_glVertex3i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex3i]
    lea rdx, [rip + _name_glVertex3i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex3iv
glVertex3iv:
    mov rax, QWORD PTR [rip + _pfn_glVertex3iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex3iv]
    lea rdx, [rip + _name_glVertex3iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex3s
glVertex3s:
    mov rax, QWORD PTR [rip + _pfn_glVertex3s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex3s]
    lea rdx, [rip + _name_glVertex3s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex3sv
glVertex3sv:
    mov rax, QWORD PTR [rip + _pfn_glVertex3sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex3sv]
    lea rdx, [rip + _name_glVertex3sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex4d
glVertex4d:
    mov rax, QWORD PTR [rip + _pfn_glVertex4d]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex4d]
    lea rdx, [rip + _name_glVertex4d]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex4dv
glVertex4dv:
    mov rax, QWORD PTR [rip + _pfn_glVertex4dv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex4dv]
    lea rdx, [rip + _name_glVertex4dv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex4f
glVertex4f:
    mov rax, QWORD PTR [rip + _pfn_glVertex4f]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex4f]
    lea rdx, [rip + _name_glVertex4f]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex4fv
glVertex4fv:
    mov rax, QWORD PTR [rip + _pfn_glVertex4fv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex4fv]
    lea rdx, [rip + _name_glVertex4fv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex4i
glVertex4i:
    mov rax, QWORD PTR [rip + _pfn_glVertex4i]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex4i]
    lea rdx, [rip + _name_glVertex4i]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex4iv
glVertex4iv:
    mov rax, QWORD PTR [rip + _pfn_glVertex4iv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex4iv]
    lea rdx, [rip + _name_glVertex4iv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex4s
glVertex4s:
    mov rax, QWORD PTR [rip + _pfn_glVertex4s]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex4s]
    lea rdx, [rip + _name_glVertex4s]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertex4sv
glVertex4sv:
    mov rax, QWORD PTR [rip + _pfn_glVertex4sv]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertex4sv]
    lea rdx, [rip + _name_glVertex4sv]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glVertexPointer
glVertexPointer:
    mov rax, QWORD PTR [rip + _pfn_glVertexPointer]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glVertexPointer]
    lea rdx, [rip + _name_glVertexPointer]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global glViewport
glViewport:
    mov rax, QWORD PTR [rip + _pfn_glViewport]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_glViewport]
    lea rdx, [rip + _name_glViewport]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglChoosePixelFormat
wglChoosePixelFormat:
    mov rax, QWORD PTR [rip + _pfn_wglChoosePixelFormat]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglChoosePixelFormat]
    lea rdx, [rip + _name_wglChoosePixelFormat]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglCopyContext
wglCopyContext:
    mov rax, QWORD PTR [rip + _pfn_wglCopyContext]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglCopyContext]
    lea rdx, [rip + _name_wglCopyContext]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglCreateContext
wglCreateContext:
    mov rax, QWORD PTR [rip + _pfn_wglCreateContext]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglCreateContext]
    lea rdx, [rip + _name_wglCreateContext]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglCreateLayerContext
wglCreateLayerContext:
    mov rax, QWORD PTR [rip + _pfn_wglCreateLayerContext]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglCreateLayerContext]
    lea rdx, [rip + _name_wglCreateLayerContext]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglDeleteContext
wglDeleteContext:
    mov rax, QWORD PTR [rip + _pfn_wglDeleteContext]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglDeleteContext]
    lea rdx, [rip + _name_wglDeleteContext]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglDescribeLayerPlane
wglDescribeLayerPlane:
    mov rax, QWORD PTR [rip + _pfn_wglDescribeLayerPlane]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglDescribeLayerPlane]
    lea rdx, [rip + _name_wglDescribeLayerPlane]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglDescribePixelFormat
wglDescribePixelFormat:
    mov rax, QWORD PTR [rip + _pfn_wglDescribePixelFormat]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglDescribePixelFormat]
    lea rdx, [rip + _name_wglDescribePixelFormat]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglGetCurrentContext
wglGetCurrentContext:
    mov rax, QWORD PTR [rip + _pfn_wglGetCurrentContext]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglGetCurrentContext]
    lea rdx, [rip + _name_wglGetCurrentContext]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglGetCurrentDC
wglGetCurrentDC:
    mov rax, QWORD PTR [rip + _pfn_wglGetCurrentDC]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglGetCurrentDC]
    lea rdx, [rip + _name_wglGetCurrentDC]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglGetLayerPaletteEntries
wglGetLayerPaletteEntries:
    mov rax, QWORD PTR [rip + _pfn_wglGetLayerPaletteEntries]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglGetLayerPaletteEntries]
    lea rdx, [rip + _name_wglGetLayerPaletteEntries]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglGetPixelFormat
wglGetPixelFormat:
    mov rax, QWORD PTR [rip + _pfn_wglGetPixelFormat]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglGetPixelFormat]
    lea rdx, [rip + _name_wglGetPixelFormat]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglMakeCurrent
wglMakeCurrent:
    mov rax, QWORD PTR [rip + _pfn_wglMakeCurrent]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglMakeCurrent]
    lea rdx, [rip + _name_wglMakeCurrent]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglRealizeLayerPalette
wglRealizeLayerPalette:
    mov rax, QWORD PTR [rip + _pfn_wglRealizeLayerPalette]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglRealizeLayerPalette]
    lea rdx, [rip + _name_wglRealizeLayerPalette]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglSetLayerPaletteEntries
wglSetLayerPaletteEntries:
    mov rax, QWORD PTR [rip + _pfn_wglSetLayerPaletteEntries]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglSetLayerPaletteEntries]
    lea rdx, [rip + _name_wglSetLayerPaletteEntries]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglSetPixelFormat
wglSetPixelFormat:
    mov rax, QWORD PTR [rip + _pfn_wglSetPixelFormat]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglSetPixelFormat]
    lea rdx, [rip + _name_wglSetPixelFormat]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglShareLists
wglShareLists:
    mov rax, QWORD PTR [rip + _pfn_wglShareLists]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglShareLists]
    lea rdx, [rip + _name_wglShareLists]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglSwapMultipleBuffers
wglSwapMultipleBuffers:
    mov rax, QWORD PTR [rip + _pfn_wglSwapMultipleBuffers]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglSwapMultipleBuffers]
    lea rdx, [rip + _name_wglSwapMultipleBuffers]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglUseFontBitmapsA
wglUseFontBitmapsA:
    mov rax, QWORD PTR [rip + _pfn_wglUseFontBitmapsA]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglUseFontBitmapsA]
    lea rdx, [rip + _name_wglUseFontBitmapsA]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglUseFontBitmapsW
wglUseFontBitmapsW:
    mov rax, QWORD PTR [rip + _pfn_wglUseFontBitmapsW]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglUseFontBitmapsW]
    lea rdx, [rip + _name_wglUseFontBitmapsW]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglUseFontOutlinesA
wglUseFontOutlinesA:
    mov rax, QWORD PTR [rip + _pfn_wglUseFontOutlinesA]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglUseFontOutlinesA]
    lea rdx, [rip + _name_wglUseFontOutlinesA]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

    .global wglUseFontOutlinesW
wglUseFontOutlinesW:
    mov rax, QWORD PTR [rip + _pfn_wglUseFontOutlinesW]
    test rax, rax
    jnz 1f
    /* --- lazy bind (preserve argument registers) --- */
    sub rsp, 0x88
    mov [rsp+0x20], rcx
    mov [rsp+0x28], rdx
    mov [rsp+0x30], r8
    mov [rsp+0x38], r9
    movdqu [rsp+0x40], xmm0
    movdqu [rsp+0x50], xmm1
    movdqu [rsp+0x60], xmm2
    movdqu [rsp+0x70], xmm3
    lea rcx, [rip + _pfn_wglUseFontOutlinesW]
    lea rdx, [rip + _name_wglUseFontOutlinesW]
    call GL_LazyBind
    mov rcx, [rsp+0x20]
    mov rdx, [rsp+0x28]
    mov r8,  [rsp+0x30]
    mov r9,  [rsp+0x38]
    movdqu xmm0, [rsp+0x40]
    movdqu xmm1, [rsp+0x50]
    movdqu xmm2, [rsp+0x60]
    movdqu xmm3, [rsp+0x70]
    add rsp, 0x88
    test rax, rax
    jz 2f
    jmp rax
1:  jmp rax
2:  xor eax, eax
    ret

.section .rdata,"dr"

_name_glAccum: .asciz "glAccum"
_name_glAlphaFunc: .asciz "glAlphaFunc"
_name_glAreTexturesResident: .asciz "glAreTexturesResident"
_name_glArrayElement: .asciz "glArrayElement"
_name_glBegin: .asciz "glBegin"
_name_glBindTexture: .asciz "glBindTexture"
_name_glBitmap: .asciz "glBitmap"
_name_glBlendFunc: .asciz "glBlendFunc"
_name_glCallList: .asciz "glCallList"
_name_glCallLists: .asciz "glCallLists"
_name_glClear: .asciz "glClear"
_name_glClearAccum: .asciz "glClearAccum"
_name_glClearColor: .asciz "glClearColor"
_name_glClearDepth: .asciz "glClearDepth"
_name_glClearIndex: .asciz "glClearIndex"
_name_glClearStencil: .asciz "glClearStencil"
_name_glClipPlane: .asciz "glClipPlane"
_name_glColor3b: .asciz "glColor3b"
_name_glColor3bv: .asciz "glColor3bv"
_name_glColor3d: .asciz "glColor3d"
_name_glColor3dv: .asciz "glColor3dv"
_name_glColor3f: .asciz "glColor3f"
_name_glColor3fv: .asciz "glColor3fv"
_name_glColor3i: .asciz "glColor3i"
_name_glColor3iv: .asciz "glColor3iv"
_name_glColor3s: .asciz "glColor3s"
_name_glColor3sv: .asciz "glColor3sv"
_name_glColor3ub: .asciz "glColor3ub"
_name_glColor3ubv: .asciz "glColor3ubv"
_name_glColor3ui: .asciz "glColor3ui"
_name_glColor3uiv: .asciz "glColor3uiv"
_name_glColor3us: .asciz "glColor3us"
_name_glColor3usv: .asciz "glColor3usv"
_name_glColor4b: .asciz "glColor4b"
_name_glColor4bv: .asciz "glColor4bv"
_name_glColor4d: .asciz "glColor4d"
_name_glColor4dv: .asciz "glColor4dv"
_name_glColor4f: .asciz "glColor4f"
_name_glColor4fv: .asciz "glColor4fv"
_name_glColor4i: .asciz "glColor4i"
_name_glColor4iv: .asciz "glColor4iv"
_name_glColor4s: .asciz "glColor4s"
_name_glColor4sv: .asciz "glColor4sv"
_name_glColor4ub: .asciz "glColor4ub"
_name_glColor4ubv: .asciz "glColor4ubv"
_name_glColor4ui: .asciz "glColor4ui"
_name_glColor4uiv: .asciz "glColor4uiv"
_name_glColor4us: .asciz "glColor4us"
_name_glColor4usv: .asciz "glColor4usv"
_name_glColorMask: .asciz "glColorMask"
_name_glColorMaterial: .asciz "glColorMaterial"
_name_glColorPointer: .asciz "glColorPointer"
_name_glCopyPixels: .asciz "glCopyPixels"
_name_glCopyTexImage1D: .asciz "glCopyTexImage1D"
_name_glCopyTexImage2D: .asciz "glCopyTexImage2D"
_name_glCopyTexSubImage1D: .asciz "glCopyTexSubImage1D"
_name_glCopyTexSubImage2D: .asciz "glCopyTexSubImage2D"
_name_glCullFace: .asciz "glCullFace"
_name_glDeleteLists: .asciz "glDeleteLists"
_name_glDeleteTextures: .asciz "glDeleteTextures"
_name_glDepthFunc: .asciz "glDepthFunc"
_name_glDepthMask: .asciz "glDepthMask"
_name_glDepthRange: .asciz "glDepthRange"
_name_glDisable: .asciz "glDisable"
_name_glDisableClientState: .asciz "glDisableClientState"
_name_glDrawArrays: .asciz "glDrawArrays"
_name_glDrawBuffer: .asciz "glDrawBuffer"
_name_glDrawPixels: .asciz "glDrawPixels"
_name_glEdgeFlag: .asciz "glEdgeFlag"
_name_glEdgeFlagPointer: .asciz "glEdgeFlagPointer"
_name_glEdgeFlagv: .asciz "glEdgeFlagv"
_name_glEnable: .asciz "glEnable"
_name_glEnableClientState: .asciz "glEnableClientState"
_name_glEnd: .asciz "glEnd"
_name_glEndList: .asciz "glEndList"
_name_glEvalCoord1d: .asciz "glEvalCoord1d"
_name_glEvalCoord1dv: .asciz "glEvalCoord1dv"
_name_glEvalCoord1f: .asciz "glEvalCoord1f"
_name_glEvalCoord1fv: .asciz "glEvalCoord1fv"
_name_glEvalCoord2d: .asciz "glEvalCoord2d"
_name_glEvalCoord2dv: .asciz "glEvalCoord2dv"
_name_glEvalCoord2f: .asciz "glEvalCoord2f"
_name_glEvalCoord2fv: .asciz "glEvalCoord2fv"
_name_glEvalMesh1: .asciz "glEvalMesh1"
_name_glEvalMesh2: .asciz "glEvalMesh2"
_name_glEvalPoint1: .asciz "glEvalPoint1"
_name_glEvalPoint2: .asciz "glEvalPoint2"
_name_glFeedbackBuffer: .asciz "glFeedbackBuffer"
_name_glFinish: .asciz "glFinish"
_name_glFlush: .asciz "glFlush"
_name_glFogf: .asciz "glFogf"
_name_glFogfv: .asciz "glFogfv"
_name_glFogi: .asciz "glFogi"
_name_glFogiv: .asciz "glFogiv"
_name_glFrontFace: .asciz "glFrontFace"
_name_glFrustum: .asciz "glFrustum"
_name_glGenLists: .asciz "glGenLists"
_name_glGenTextures: .asciz "glGenTextures"
_name_glGetBooleanv: .asciz "glGetBooleanv"
_name_glGetClipPlane: .asciz "glGetClipPlane"
_name_glGetDoublev: .asciz "glGetDoublev"
_name_glGetError: .asciz "glGetError"
_name_glGetFloatv: .asciz "glGetFloatv"
_name_glGetIntegerv: .asciz "glGetIntegerv"
_name_glGetLightfv: .asciz "glGetLightfv"
_name_glGetLightiv: .asciz "glGetLightiv"
_name_glGetMapdv: .asciz "glGetMapdv"
_name_glGetMapfv: .asciz "glGetMapfv"
_name_glGetMapiv: .asciz "glGetMapiv"
_name_glGetMaterialfv: .asciz "glGetMaterialfv"
_name_glGetMaterialiv: .asciz "glGetMaterialiv"
_name_glGetPixelMapfv: .asciz "glGetPixelMapfv"
_name_glGetPixelMapuiv: .asciz "glGetPixelMapuiv"
_name_glGetPixelMapusv: .asciz "glGetPixelMapusv"
_name_glGetPointerv: .asciz "glGetPointerv"
_name_glGetPolygonStipple: .asciz "glGetPolygonStipple"
_name_glGetString: .asciz "glGetString"
_name_glGetTexEnvfv: .asciz "glGetTexEnvfv"
_name_glGetTexEnviv: .asciz "glGetTexEnviv"
_name_glGetTexGendv: .asciz "glGetTexGendv"
_name_glGetTexGenfv: .asciz "glGetTexGenfv"
_name_glGetTexGeniv: .asciz "glGetTexGeniv"
_name_glGetTexImage: .asciz "glGetTexImage"
_name_glGetTexLevelParameterfv: .asciz "glGetTexLevelParameterfv"
_name_glGetTexLevelParameteriv: .asciz "glGetTexLevelParameteriv"
_name_glGetTexParameterfv: .asciz "glGetTexParameterfv"
_name_glGetTexParameteriv: .asciz "glGetTexParameteriv"
_name_glHint: .asciz "glHint"
_name_glIndexMask: .asciz "glIndexMask"
_name_glIndexPointer: .asciz "glIndexPointer"
_name_glIndexd: .asciz "glIndexd"
_name_glIndexdv: .asciz "glIndexdv"
_name_glIndexf: .asciz "glIndexf"
_name_glIndexfv: .asciz "glIndexfv"
_name_glIndexi: .asciz "glIndexi"
_name_glIndexiv: .asciz "glIndexiv"
_name_glIndexs: .asciz "glIndexs"
_name_glIndexsv: .asciz "glIndexsv"
_name_glIndexub: .asciz "glIndexub"
_name_glIndexubv: .asciz "glIndexubv"
_name_glInitNames: .asciz "glInitNames"
_name_glInterleavedArrays: .asciz "glInterleavedArrays"
_name_glIsEnabled: .asciz "glIsEnabled"
_name_glIsList: .asciz "glIsList"
_name_glIsTexture: .asciz "glIsTexture"
_name_glLightModelf: .asciz "glLightModelf"
_name_glLightModelfv: .asciz "glLightModelfv"
_name_glLightModeli: .asciz "glLightModeli"
_name_glLightModeliv: .asciz "glLightModeliv"
_name_glLightf: .asciz "glLightf"
_name_glLightfv: .asciz "glLightfv"
_name_glLighti: .asciz "glLighti"
_name_glLightiv: .asciz "glLightiv"
_name_glLineStipple: .asciz "glLineStipple"
_name_glLineWidth: .asciz "glLineWidth"
_name_glListBase: .asciz "glListBase"
_name_glLoadIdentity: .asciz "glLoadIdentity"
_name_glLoadMatrixd: .asciz "glLoadMatrixd"
_name_glLoadMatrixf: .asciz "glLoadMatrixf"
_name_glLoadName: .asciz "glLoadName"
_name_glLogicOp: .asciz "glLogicOp"
_name_glMap1d: .asciz "glMap1d"
_name_glMap1f: .asciz "glMap1f"
_name_glMap2d: .asciz "glMap2d"
_name_glMap2f: .asciz "glMap2f"
_name_glMapGrid1d: .asciz "glMapGrid1d"
_name_glMapGrid1f: .asciz "glMapGrid1f"
_name_glMapGrid2d: .asciz "glMapGrid2d"
_name_glMapGrid2f: .asciz "glMapGrid2f"
_name_glMaterialf: .asciz "glMaterialf"
_name_glMaterialfv: .asciz "glMaterialfv"
_name_glMateriali: .asciz "glMateriali"
_name_glMaterialiv: .asciz "glMaterialiv"
_name_glMatrixMode: .asciz "glMatrixMode"
_name_glMultMatrixd: .asciz "glMultMatrixd"
_name_glMultMatrixf: .asciz "glMultMatrixf"
_name_glNewList: .asciz "glNewList"
_name_glNormal3b: .asciz "glNormal3b"
_name_glNormal3bv: .asciz "glNormal3bv"
_name_glNormal3d: .asciz "glNormal3d"
_name_glNormal3dv: .asciz "glNormal3dv"
_name_glNormal3f: .asciz "glNormal3f"
_name_glNormal3fv: .asciz "glNormal3fv"
_name_glNormal3i: .asciz "glNormal3i"
_name_glNormal3iv: .asciz "glNormal3iv"
_name_glNormal3s: .asciz "glNormal3s"
_name_glNormal3sv: .asciz "glNormal3sv"
_name_glNormalPointer: .asciz "glNormalPointer"
_name_glOrtho: .asciz "glOrtho"
_name_glPassThrough: .asciz "glPassThrough"
_name_glPixelMapfv: .asciz "glPixelMapfv"
_name_glPixelMapuiv: .asciz "glPixelMapuiv"
_name_glPixelMapusv: .asciz "glPixelMapusv"
_name_glPixelStoref: .asciz "glPixelStoref"
_name_glPixelStorei: .asciz "glPixelStorei"
_name_glPixelTransferf: .asciz "glPixelTransferf"
_name_glPixelTransferi: .asciz "glPixelTransferi"
_name_glPixelZoom: .asciz "glPixelZoom"
_name_glPointSize: .asciz "glPointSize"
_name_glPolygonMode: .asciz "glPolygonMode"
_name_glPolygonOffset: .asciz "glPolygonOffset"
_name_glPolygonStipple: .asciz "glPolygonStipple"
_name_glPopAttrib: .asciz "glPopAttrib"
_name_glPopClientAttrib: .asciz "glPopClientAttrib"
_name_glPopMatrix: .asciz "glPopMatrix"
_name_glPopName: .asciz "glPopName"
_name_glPrioritizeTextures: .asciz "glPrioritizeTextures"
_name_glPushAttrib: .asciz "glPushAttrib"
_name_glPushClientAttrib: .asciz "glPushClientAttrib"
_name_glPushMatrix: .asciz "glPushMatrix"
_name_glPushName: .asciz "glPushName"
_name_glRasterPos2d: .asciz "glRasterPos2d"
_name_glRasterPos2dv: .asciz "glRasterPos2dv"
_name_glRasterPos2f: .asciz "glRasterPos2f"
_name_glRasterPos2fv: .asciz "glRasterPos2fv"
_name_glRasterPos2i: .asciz "glRasterPos2i"
_name_glRasterPos2iv: .asciz "glRasterPos2iv"
_name_glRasterPos2s: .asciz "glRasterPos2s"
_name_glRasterPos2sv: .asciz "glRasterPos2sv"
_name_glRasterPos3d: .asciz "glRasterPos3d"
_name_glRasterPos3dv: .asciz "glRasterPos3dv"
_name_glRasterPos3f: .asciz "glRasterPos3f"
_name_glRasterPos3fv: .asciz "glRasterPos3fv"
_name_glRasterPos3i: .asciz "glRasterPos3i"
_name_glRasterPos3iv: .asciz "glRasterPos3iv"
_name_glRasterPos3s: .asciz "glRasterPos3s"
_name_glRasterPos3sv: .asciz "glRasterPos3sv"
_name_glRasterPos4d: .asciz "glRasterPos4d"
_name_glRasterPos4dv: .asciz "glRasterPos4dv"
_name_glRasterPos4f: .asciz "glRasterPos4f"
_name_glRasterPos4fv: .asciz "glRasterPos4fv"
_name_glRasterPos4i: .asciz "glRasterPos4i"
_name_glRasterPos4iv: .asciz "glRasterPos4iv"
_name_glRasterPos4s: .asciz "glRasterPos4s"
_name_glRasterPos4sv: .asciz "glRasterPos4sv"
_name_glReadBuffer: .asciz "glReadBuffer"
_name_glReadPixels: .asciz "glReadPixels"
_name_glRectd: .asciz "glRectd"
_name_glRectdv: .asciz "glRectdv"
_name_glRectf: .asciz "glRectf"
_name_glRectfv: .asciz "glRectfv"
_name_glRecti: .asciz "glRecti"
_name_glRectiv: .asciz "glRectiv"
_name_glRects: .asciz "glRects"
_name_glRectsv: .asciz "glRectsv"
_name_glRenderMode: .asciz "glRenderMode"
_name_glRotated: .asciz "glRotated"
_name_glRotatef: .asciz "glRotatef"
_name_glScaled: .asciz "glScaled"
_name_glScalef: .asciz "glScalef"
_name_glScissor: .asciz "glScissor"
_name_glSelectBuffer: .asciz "glSelectBuffer"
_name_glShadeModel: .asciz "glShadeModel"
_name_glStencilFunc: .asciz "glStencilFunc"
_name_glStencilMask: .asciz "glStencilMask"
_name_glStencilOp: .asciz "glStencilOp"
_name_glTexCoord1d: .asciz "glTexCoord1d"
_name_glTexCoord1dv: .asciz "glTexCoord1dv"
_name_glTexCoord1f: .asciz "glTexCoord1f"
_name_glTexCoord1fv: .asciz "glTexCoord1fv"
_name_glTexCoord1i: .asciz "glTexCoord1i"
_name_glTexCoord1iv: .asciz "glTexCoord1iv"
_name_glTexCoord1s: .asciz "glTexCoord1s"
_name_glTexCoord1sv: .asciz "glTexCoord1sv"
_name_glTexCoord2d: .asciz "glTexCoord2d"
_name_glTexCoord2dv: .asciz "glTexCoord2dv"
_name_glTexCoord2f: .asciz "glTexCoord2f"
_name_glTexCoord2fv: .asciz "glTexCoord2fv"
_name_glTexCoord2i: .asciz "glTexCoord2i"
_name_glTexCoord2iv: .asciz "glTexCoord2iv"
_name_glTexCoord2s: .asciz "glTexCoord2s"
_name_glTexCoord2sv: .asciz "glTexCoord2sv"
_name_glTexCoord3d: .asciz "glTexCoord3d"
_name_glTexCoord3dv: .asciz "glTexCoord3dv"
_name_glTexCoord3f: .asciz "glTexCoord3f"
_name_glTexCoord3fv: .asciz "glTexCoord3fv"
_name_glTexCoord3i: .asciz "glTexCoord3i"
_name_glTexCoord3iv: .asciz "glTexCoord3iv"
_name_glTexCoord3s: .asciz "glTexCoord3s"
_name_glTexCoord3sv: .asciz "glTexCoord3sv"
_name_glTexCoord4d: .asciz "glTexCoord4d"
_name_glTexCoord4dv: .asciz "glTexCoord4dv"
_name_glTexCoord4f: .asciz "glTexCoord4f"
_name_glTexCoord4fv: .asciz "glTexCoord4fv"
_name_glTexCoord4i: .asciz "glTexCoord4i"
_name_glTexCoord4iv: .asciz "glTexCoord4iv"
_name_glTexCoord4s: .asciz "glTexCoord4s"
_name_glTexCoord4sv: .asciz "glTexCoord4sv"
_name_glTexCoordPointer: .asciz "glTexCoordPointer"
_name_glTexEnvf: .asciz "glTexEnvf"
_name_glTexEnvfv: .asciz "glTexEnvfv"
_name_glTexEnvi: .asciz "glTexEnvi"
_name_glTexEnviv: .asciz "glTexEnviv"
_name_glTexGend: .asciz "glTexGend"
_name_glTexGendv: .asciz "glTexGendv"
_name_glTexGenf: .asciz "glTexGenf"
_name_glTexGenfv: .asciz "glTexGenfv"
_name_glTexGeni: .asciz "glTexGeni"
_name_glTexGeniv: .asciz "glTexGeniv"
_name_glTexImage1D: .asciz "glTexImage1D"
_name_glTexImage2D: .asciz "glTexImage2D"
_name_glTexParameterf: .asciz "glTexParameterf"
_name_glTexParameterfv: .asciz "glTexParameterfv"
_name_glTexParameteri: .asciz "glTexParameteri"
_name_glTexParameteriv: .asciz "glTexParameteriv"
_name_glTexSubImage1D: .asciz "glTexSubImage1D"
_name_glTexSubImage2D: .asciz "glTexSubImage2D"
_name_glTranslated: .asciz "glTranslated"
_name_glTranslatef: .asciz "glTranslatef"
_name_glVertex2d: .asciz "glVertex2d"
_name_glVertex2dv: .asciz "glVertex2dv"
_name_glVertex2f: .asciz "glVertex2f"
_name_glVertex2fv: .asciz "glVertex2fv"
_name_glVertex2i: .asciz "glVertex2i"
_name_glVertex2iv: .asciz "glVertex2iv"
_name_glVertex2s: .asciz "glVertex2s"
_name_glVertex2sv: .asciz "glVertex2sv"
_name_glVertex3d: .asciz "glVertex3d"
_name_glVertex3dv: .asciz "glVertex3dv"
_name_glVertex3f: .asciz "glVertex3f"
_name_glVertex3fv: .asciz "glVertex3fv"
_name_glVertex3i: .asciz "glVertex3i"
_name_glVertex3iv: .asciz "glVertex3iv"
_name_glVertex3s: .asciz "glVertex3s"
_name_glVertex3sv: .asciz "glVertex3sv"
_name_glVertex4d: .asciz "glVertex4d"
_name_glVertex4dv: .asciz "glVertex4dv"
_name_glVertex4f: .asciz "glVertex4f"
_name_glVertex4fv: .asciz "glVertex4fv"
_name_glVertex4i: .asciz "glVertex4i"
_name_glVertex4iv: .asciz "glVertex4iv"
_name_glVertex4s: .asciz "glVertex4s"
_name_glVertex4sv: .asciz "glVertex4sv"
_name_glVertexPointer: .asciz "glVertexPointer"
_name_glViewport: .asciz "glViewport"
_name_wglChoosePixelFormat: .asciz "wglChoosePixelFormat"
_name_wglCopyContext: .asciz "wglCopyContext"
_name_wglCreateContext: .asciz "wglCreateContext"
_name_wglCreateLayerContext: .asciz "wglCreateLayerContext"
_name_wglDeleteContext: .asciz "wglDeleteContext"
_name_wglDescribeLayerPlane: .asciz "wglDescribeLayerPlane"
_name_wglDescribePixelFormat: .asciz "wglDescribePixelFormat"
_name_wglGetCurrentContext: .asciz "wglGetCurrentContext"
_name_wglGetCurrentDC: .asciz "wglGetCurrentDC"
_name_wglGetLayerPaletteEntries: .asciz "wglGetLayerPaletteEntries"
_name_wglGetPixelFormat: .asciz "wglGetPixelFormat"
_name_wglMakeCurrent: .asciz "wglMakeCurrent"
_name_wglRealizeLayerPalette: .asciz "wglRealizeLayerPalette"
_name_wglSetLayerPaletteEntries: .asciz "wglSetLayerPaletteEntries"
_name_wglSetPixelFormat: .asciz "wglSetPixelFormat"
_name_wglShareLists: .asciz "wglShareLists"
_name_wglSwapMultipleBuffers: .asciz "wglSwapMultipleBuffers"
_name_wglUseFontBitmapsA: .asciz "wglUseFontBitmapsA"
_name_wglUseFontBitmapsW: .asciz "wglUseFontBitmapsW"
_name_wglUseFontOutlinesA: .asciz "wglUseFontOutlinesA"
_name_wglUseFontOutlinesW: .asciz "wglUseFontOutlinesW"

.data

    .global _pfn_glAccum
    _pfn_glAccum : .quad 0
    .global _pfn_glAlphaFunc
    _pfn_glAlphaFunc : .quad 0
    .global _pfn_glAreTexturesResident
    _pfn_glAreTexturesResident : .quad 0
    .global _pfn_glArrayElement
    _pfn_glArrayElement : .quad 0
    .global _pfn_glBegin
    _pfn_glBegin : .quad 0
    .global _pfn_glBindTexture
    _pfn_glBindTexture : .quad 0
    .global _pfn_glBitmap
    _pfn_glBitmap : .quad 0
    .global _pfn_glBlendFunc
    _pfn_glBlendFunc : .quad 0
    .global _pfn_glCallList
    _pfn_glCallList : .quad 0
    .global _pfn_glCallLists
    _pfn_glCallLists : .quad 0
    .global _pfn_glClear
    _pfn_glClear : .quad 0
    .global _pfn_glClearAccum
    _pfn_glClearAccum : .quad 0
    .global _pfn_glClearColor
    _pfn_glClearColor : .quad 0
    .global _pfn_glClearDepth
    _pfn_glClearDepth : .quad 0
    .global _pfn_glClearIndex
    _pfn_glClearIndex : .quad 0
    .global _pfn_glClearStencil
    _pfn_glClearStencil : .quad 0
    .global _pfn_glClipPlane
    _pfn_glClipPlane : .quad 0
    .global _pfn_glColor3b
    _pfn_glColor3b : .quad 0
    .global _pfn_glColor3bv
    _pfn_glColor3bv : .quad 0
    .global _pfn_glColor3d
    _pfn_glColor3d : .quad 0
    .global _pfn_glColor3dv
    _pfn_glColor3dv : .quad 0
    .global _pfn_glColor3f
    _pfn_glColor3f : .quad 0
    .global _pfn_glColor3fv
    _pfn_glColor3fv : .quad 0
    .global _pfn_glColor3i
    _pfn_glColor3i : .quad 0
    .global _pfn_glColor3iv
    _pfn_glColor3iv : .quad 0
    .global _pfn_glColor3s
    _pfn_glColor3s : .quad 0
    .global _pfn_glColor3sv
    _pfn_glColor3sv : .quad 0
    .global _pfn_glColor3ub
    _pfn_glColor3ub : .quad 0
    .global _pfn_glColor3ubv
    _pfn_glColor3ubv : .quad 0
    .global _pfn_glColor3ui
    _pfn_glColor3ui : .quad 0
    .global _pfn_glColor3uiv
    _pfn_glColor3uiv : .quad 0
    .global _pfn_glColor3us
    _pfn_glColor3us : .quad 0
    .global _pfn_glColor3usv
    _pfn_glColor3usv : .quad 0
    .global _pfn_glColor4b
    _pfn_glColor4b : .quad 0
    .global _pfn_glColor4bv
    _pfn_glColor4bv : .quad 0
    .global _pfn_glColor4d
    _pfn_glColor4d : .quad 0
    .global _pfn_glColor4dv
    _pfn_glColor4dv : .quad 0
    .global _pfn_glColor4f
    _pfn_glColor4f : .quad 0
    .global _pfn_glColor4fv
    _pfn_glColor4fv : .quad 0
    .global _pfn_glColor4i
    _pfn_glColor4i : .quad 0
    .global _pfn_glColor4iv
    _pfn_glColor4iv : .quad 0
    .global _pfn_glColor4s
    _pfn_glColor4s : .quad 0
    .global _pfn_glColor4sv
    _pfn_glColor4sv : .quad 0
    .global _pfn_glColor4ub
    _pfn_glColor4ub : .quad 0
    .global _pfn_glColor4ubv
    _pfn_glColor4ubv : .quad 0
    .global _pfn_glColor4ui
    _pfn_glColor4ui : .quad 0
    .global _pfn_glColor4uiv
    _pfn_glColor4uiv : .quad 0
    .global _pfn_glColor4us
    _pfn_glColor4us : .quad 0
    .global _pfn_glColor4usv
    _pfn_glColor4usv : .quad 0
    .global _pfn_glColorMask
    _pfn_glColorMask : .quad 0
    .global _pfn_glColorMaterial
    _pfn_glColorMaterial : .quad 0
    .global _pfn_glColorPointer
    _pfn_glColorPointer : .quad 0
    .global _pfn_glCopyPixels
    _pfn_glCopyPixels : .quad 0
    .global _pfn_glCopyTexImage1D
    _pfn_glCopyTexImage1D : .quad 0
    .global _pfn_glCopyTexImage2D
    _pfn_glCopyTexImage2D : .quad 0
    .global _pfn_glCopyTexSubImage1D
    _pfn_glCopyTexSubImage1D : .quad 0
    .global _pfn_glCopyTexSubImage2D
    _pfn_glCopyTexSubImage2D : .quad 0
    .global _pfn_glCullFace
    _pfn_glCullFace : .quad 0
    .global _pfn_glDeleteLists
    _pfn_glDeleteLists : .quad 0
    .global _pfn_glDeleteTextures
    _pfn_glDeleteTextures : .quad 0
    .global _pfn_glDepthFunc
    _pfn_glDepthFunc : .quad 0
    .global _pfn_glDepthMask
    _pfn_glDepthMask : .quad 0
    .global _pfn_glDepthRange
    _pfn_glDepthRange : .quad 0
    .global _pfn_glDisable
    _pfn_glDisable : .quad 0
    .global _pfn_glDisableClientState
    _pfn_glDisableClientState : .quad 0
    .global _pfn_glDrawArrays
    _pfn_glDrawArrays : .quad 0
    .global _pfn_glDrawBuffer
    _pfn_glDrawBuffer : .quad 0
    .global _pfn_glDrawPixels
    _pfn_glDrawPixels : .quad 0
    .global _pfn_glEdgeFlag
    _pfn_glEdgeFlag : .quad 0
    .global _pfn_glEdgeFlagPointer
    _pfn_glEdgeFlagPointer : .quad 0
    .global _pfn_glEdgeFlagv
    _pfn_glEdgeFlagv : .quad 0
    .global _pfn_glEnable
    _pfn_glEnable : .quad 0
    .global _pfn_glEnableClientState
    _pfn_glEnableClientState : .quad 0
    .global _pfn_glEnd
    _pfn_glEnd : .quad 0
    .global _pfn_glEndList
    _pfn_glEndList : .quad 0
    .global _pfn_glEvalCoord1d
    _pfn_glEvalCoord1d : .quad 0
    .global _pfn_glEvalCoord1dv
    _pfn_glEvalCoord1dv : .quad 0
    .global _pfn_glEvalCoord1f
    _pfn_glEvalCoord1f : .quad 0
    .global _pfn_glEvalCoord1fv
    _pfn_glEvalCoord1fv : .quad 0
    .global _pfn_glEvalCoord2d
    _pfn_glEvalCoord2d : .quad 0
    .global _pfn_glEvalCoord2dv
    _pfn_glEvalCoord2dv : .quad 0
    .global _pfn_glEvalCoord2f
    _pfn_glEvalCoord2f : .quad 0
    .global _pfn_glEvalCoord2fv
    _pfn_glEvalCoord2fv : .quad 0
    .global _pfn_glEvalMesh1
    _pfn_glEvalMesh1 : .quad 0
    .global _pfn_glEvalMesh2
    _pfn_glEvalMesh2 : .quad 0
    .global _pfn_glEvalPoint1
    _pfn_glEvalPoint1 : .quad 0
    .global _pfn_glEvalPoint2
    _pfn_glEvalPoint2 : .quad 0
    .global _pfn_glFeedbackBuffer
    _pfn_glFeedbackBuffer : .quad 0
    .global _pfn_glFinish
    _pfn_glFinish : .quad 0
    .global _pfn_glFlush
    _pfn_glFlush : .quad 0
    .global _pfn_glFogf
    _pfn_glFogf : .quad 0
    .global _pfn_glFogfv
    _pfn_glFogfv : .quad 0
    .global _pfn_glFogi
    _pfn_glFogi : .quad 0
    .global _pfn_glFogiv
    _pfn_glFogiv : .quad 0
    .global _pfn_glFrontFace
    _pfn_glFrontFace : .quad 0
    .global _pfn_glFrustum
    _pfn_glFrustum : .quad 0
    .global _pfn_glGenLists
    _pfn_glGenLists : .quad 0
    .global _pfn_glGenTextures
    _pfn_glGenTextures : .quad 0
    .global _pfn_glGetBooleanv
    _pfn_glGetBooleanv : .quad 0
    .global _pfn_glGetClipPlane
    _pfn_glGetClipPlane : .quad 0
    .global _pfn_glGetDoublev
    _pfn_glGetDoublev : .quad 0
    .global _pfn_glGetError
    _pfn_glGetError : .quad 0
    .global _pfn_glGetFloatv
    _pfn_glGetFloatv : .quad 0
    .global _pfn_glGetIntegerv
    _pfn_glGetIntegerv : .quad 0
    .global _pfn_glGetLightfv
    _pfn_glGetLightfv : .quad 0
    .global _pfn_glGetLightiv
    _pfn_glGetLightiv : .quad 0
    .global _pfn_glGetMapdv
    _pfn_glGetMapdv : .quad 0
    .global _pfn_glGetMapfv
    _pfn_glGetMapfv : .quad 0
    .global _pfn_glGetMapiv
    _pfn_glGetMapiv : .quad 0
    .global _pfn_glGetMaterialfv
    _pfn_glGetMaterialfv : .quad 0
    .global _pfn_glGetMaterialiv
    _pfn_glGetMaterialiv : .quad 0
    .global _pfn_glGetPixelMapfv
    _pfn_glGetPixelMapfv : .quad 0
    .global _pfn_glGetPixelMapuiv
    _pfn_glGetPixelMapuiv : .quad 0
    .global _pfn_glGetPixelMapusv
    _pfn_glGetPixelMapusv : .quad 0
    .global _pfn_glGetPointerv
    _pfn_glGetPointerv : .quad 0
    .global _pfn_glGetPolygonStipple
    _pfn_glGetPolygonStipple : .quad 0
    .global _pfn_glGetString
    _pfn_glGetString : .quad 0
    .global _pfn_glGetTexEnvfv
    _pfn_glGetTexEnvfv : .quad 0
    .global _pfn_glGetTexEnviv
    _pfn_glGetTexEnviv : .quad 0
    .global _pfn_glGetTexGendv
    _pfn_glGetTexGendv : .quad 0
    .global _pfn_glGetTexGenfv
    _pfn_glGetTexGenfv : .quad 0
    .global _pfn_glGetTexGeniv
    _pfn_glGetTexGeniv : .quad 0
    .global _pfn_glGetTexImage
    _pfn_glGetTexImage : .quad 0
    .global _pfn_glGetTexLevelParameterfv
    _pfn_glGetTexLevelParameterfv : .quad 0
    .global _pfn_glGetTexLevelParameteriv
    _pfn_glGetTexLevelParameteriv : .quad 0
    .global _pfn_glGetTexParameterfv
    _pfn_glGetTexParameterfv : .quad 0
    .global _pfn_glGetTexParameteriv
    _pfn_glGetTexParameteriv : .quad 0
    .global _pfn_glHint
    _pfn_glHint : .quad 0
    .global _pfn_glIndexMask
    _pfn_glIndexMask : .quad 0
    .global _pfn_glIndexPointer
    _pfn_glIndexPointer : .quad 0
    .global _pfn_glIndexd
    _pfn_glIndexd : .quad 0
    .global _pfn_glIndexdv
    _pfn_glIndexdv : .quad 0
    .global _pfn_glIndexf
    _pfn_glIndexf : .quad 0
    .global _pfn_glIndexfv
    _pfn_glIndexfv : .quad 0
    .global _pfn_glIndexi
    _pfn_glIndexi : .quad 0
    .global _pfn_glIndexiv
    _pfn_glIndexiv : .quad 0
    .global _pfn_glIndexs
    _pfn_glIndexs : .quad 0
    .global _pfn_glIndexsv
    _pfn_glIndexsv : .quad 0
    .global _pfn_glIndexub
    _pfn_glIndexub : .quad 0
    .global _pfn_glIndexubv
    _pfn_glIndexubv : .quad 0
    .global _pfn_glInitNames
    _pfn_glInitNames : .quad 0
    .global _pfn_glInterleavedArrays
    _pfn_glInterleavedArrays : .quad 0
    .global _pfn_glIsEnabled
    _pfn_glIsEnabled : .quad 0
    .global _pfn_glIsList
    _pfn_glIsList : .quad 0
    .global _pfn_glIsTexture
    _pfn_glIsTexture : .quad 0
    .global _pfn_glLightModelf
    _pfn_glLightModelf : .quad 0
    .global _pfn_glLightModelfv
    _pfn_glLightModelfv : .quad 0
    .global _pfn_glLightModeli
    _pfn_glLightModeli : .quad 0
    .global _pfn_glLightModeliv
    _pfn_glLightModeliv : .quad 0
    .global _pfn_glLightf
    _pfn_glLightf : .quad 0
    .global _pfn_glLightfv
    _pfn_glLightfv : .quad 0
    .global _pfn_glLighti
    _pfn_glLighti : .quad 0
    .global _pfn_glLightiv
    _pfn_glLightiv : .quad 0
    .global _pfn_glLineStipple
    _pfn_glLineStipple : .quad 0
    .global _pfn_glLineWidth
    _pfn_glLineWidth : .quad 0
    .global _pfn_glListBase
    _pfn_glListBase : .quad 0
    .global _pfn_glLoadIdentity
    _pfn_glLoadIdentity : .quad 0
    .global _pfn_glLoadMatrixd
    _pfn_glLoadMatrixd : .quad 0
    .global _pfn_glLoadMatrixf
    _pfn_glLoadMatrixf : .quad 0
    .global _pfn_glLoadName
    _pfn_glLoadName : .quad 0
    .global _pfn_glLogicOp
    _pfn_glLogicOp : .quad 0
    .global _pfn_glMap1d
    _pfn_glMap1d : .quad 0
    .global _pfn_glMap1f
    _pfn_glMap1f : .quad 0
    .global _pfn_glMap2d
    _pfn_glMap2d : .quad 0
    .global _pfn_glMap2f
    _pfn_glMap2f : .quad 0
    .global _pfn_glMapGrid1d
    _pfn_glMapGrid1d : .quad 0
    .global _pfn_glMapGrid1f
    _pfn_glMapGrid1f : .quad 0
    .global _pfn_glMapGrid2d
    _pfn_glMapGrid2d : .quad 0
    .global _pfn_glMapGrid2f
    _pfn_glMapGrid2f : .quad 0
    .global _pfn_glMaterialf
    _pfn_glMaterialf : .quad 0
    .global _pfn_glMaterialfv
    _pfn_glMaterialfv : .quad 0
    .global _pfn_glMateriali
    _pfn_glMateriali : .quad 0
    .global _pfn_glMaterialiv
    _pfn_glMaterialiv : .quad 0
    .global _pfn_glMatrixMode
    _pfn_glMatrixMode : .quad 0
    .global _pfn_glMultMatrixd
    _pfn_glMultMatrixd : .quad 0
    .global _pfn_glMultMatrixf
    _pfn_glMultMatrixf : .quad 0
    .global _pfn_glNewList
    _pfn_glNewList : .quad 0
    .global _pfn_glNormal3b
    _pfn_glNormal3b : .quad 0
    .global _pfn_glNormal3bv
    _pfn_glNormal3bv : .quad 0
    .global _pfn_glNormal3d
    _pfn_glNormal3d : .quad 0
    .global _pfn_glNormal3dv
    _pfn_glNormal3dv : .quad 0
    .global _pfn_glNormal3f
    _pfn_glNormal3f : .quad 0
    .global _pfn_glNormal3fv
    _pfn_glNormal3fv : .quad 0
    .global _pfn_glNormal3i
    _pfn_glNormal3i : .quad 0
    .global _pfn_glNormal3iv
    _pfn_glNormal3iv : .quad 0
    .global _pfn_glNormal3s
    _pfn_glNormal3s : .quad 0
    .global _pfn_glNormal3sv
    _pfn_glNormal3sv : .quad 0
    .global _pfn_glNormalPointer
    _pfn_glNormalPointer : .quad 0
    .global _pfn_glOrtho
    _pfn_glOrtho : .quad 0
    .global _pfn_glPassThrough
    _pfn_glPassThrough : .quad 0
    .global _pfn_glPixelMapfv
    _pfn_glPixelMapfv : .quad 0
    .global _pfn_glPixelMapuiv
    _pfn_glPixelMapuiv : .quad 0
    .global _pfn_glPixelMapusv
    _pfn_glPixelMapusv : .quad 0
    .global _pfn_glPixelStoref
    _pfn_glPixelStoref : .quad 0
    .global _pfn_glPixelStorei
    _pfn_glPixelStorei : .quad 0
    .global _pfn_glPixelTransferf
    _pfn_glPixelTransferf : .quad 0
    .global _pfn_glPixelTransferi
    _pfn_glPixelTransferi : .quad 0
    .global _pfn_glPixelZoom
    _pfn_glPixelZoom : .quad 0
    .global _pfn_glPointSize
    _pfn_glPointSize : .quad 0
    .global _pfn_glPolygonMode
    _pfn_glPolygonMode : .quad 0
    .global _pfn_glPolygonOffset
    _pfn_glPolygonOffset : .quad 0
    .global _pfn_glPolygonStipple
    _pfn_glPolygonStipple : .quad 0
    .global _pfn_glPopAttrib
    _pfn_glPopAttrib : .quad 0
    .global _pfn_glPopClientAttrib
    _pfn_glPopClientAttrib : .quad 0
    .global _pfn_glPopMatrix
    _pfn_glPopMatrix : .quad 0
    .global _pfn_glPopName
    _pfn_glPopName : .quad 0
    .global _pfn_glPrioritizeTextures
    _pfn_glPrioritizeTextures : .quad 0
    .global _pfn_glPushAttrib
    _pfn_glPushAttrib : .quad 0
    .global _pfn_glPushClientAttrib
    _pfn_glPushClientAttrib : .quad 0
    .global _pfn_glPushMatrix
    _pfn_glPushMatrix : .quad 0
    .global _pfn_glPushName
    _pfn_glPushName : .quad 0
    .global _pfn_glRasterPos2d
    _pfn_glRasterPos2d : .quad 0
    .global _pfn_glRasterPos2dv
    _pfn_glRasterPos2dv : .quad 0
    .global _pfn_glRasterPos2f
    _pfn_glRasterPos2f : .quad 0
    .global _pfn_glRasterPos2fv
    _pfn_glRasterPos2fv : .quad 0
    .global _pfn_glRasterPos2i
    _pfn_glRasterPos2i : .quad 0
    .global _pfn_glRasterPos2iv
    _pfn_glRasterPos2iv : .quad 0
    .global _pfn_glRasterPos2s
    _pfn_glRasterPos2s : .quad 0
    .global _pfn_glRasterPos2sv
    _pfn_glRasterPos2sv : .quad 0
    .global _pfn_glRasterPos3d
    _pfn_glRasterPos3d : .quad 0
    .global _pfn_glRasterPos3dv
    _pfn_glRasterPos3dv : .quad 0
    .global _pfn_glRasterPos3f
    _pfn_glRasterPos3f : .quad 0
    .global _pfn_glRasterPos3fv
    _pfn_glRasterPos3fv : .quad 0
    .global _pfn_glRasterPos3i
    _pfn_glRasterPos3i : .quad 0
    .global _pfn_glRasterPos3iv
    _pfn_glRasterPos3iv : .quad 0
    .global _pfn_glRasterPos3s
    _pfn_glRasterPos3s : .quad 0
    .global _pfn_glRasterPos3sv
    _pfn_glRasterPos3sv : .quad 0
    .global _pfn_glRasterPos4d
    _pfn_glRasterPos4d : .quad 0
    .global _pfn_glRasterPos4dv
    _pfn_glRasterPos4dv : .quad 0
    .global _pfn_glRasterPos4f
    _pfn_glRasterPos4f : .quad 0
    .global _pfn_glRasterPos4fv
    _pfn_glRasterPos4fv : .quad 0
    .global _pfn_glRasterPos4i
    _pfn_glRasterPos4i : .quad 0
    .global _pfn_glRasterPos4iv
    _pfn_glRasterPos4iv : .quad 0
    .global _pfn_glRasterPos4s
    _pfn_glRasterPos4s : .quad 0
    .global _pfn_glRasterPos4sv
    _pfn_glRasterPos4sv : .quad 0
    .global _pfn_glReadBuffer
    _pfn_glReadBuffer : .quad 0
    .global _pfn_glReadPixels
    _pfn_glReadPixels : .quad 0
    .global _pfn_glRectd
    _pfn_glRectd : .quad 0
    .global _pfn_glRectdv
    _pfn_glRectdv : .quad 0
    .global _pfn_glRectf
    _pfn_glRectf : .quad 0
    .global _pfn_glRectfv
    _pfn_glRectfv : .quad 0
    .global _pfn_glRecti
    _pfn_glRecti : .quad 0
    .global _pfn_glRectiv
    _pfn_glRectiv : .quad 0
    .global _pfn_glRects
    _pfn_glRects : .quad 0
    .global _pfn_glRectsv
    _pfn_glRectsv : .quad 0
    .global _pfn_glRenderMode
    _pfn_glRenderMode : .quad 0
    .global _pfn_glRotated
    _pfn_glRotated : .quad 0
    .global _pfn_glRotatef
    _pfn_glRotatef : .quad 0
    .global _pfn_glScaled
    _pfn_glScaled : .quad 0
    .global _pfn_glScalef
    _pfn_glScalef : .quad 0
    .global _pfn_glScissor
    _pfn_glScissor : .quad 0
    .global _pfn_glSelectBuffer
    _pfn_glSelectBuffer : .quad 0
    .global _pfn_glShadeModel
    _pfn_glShadeModel : .quad 0
    .global _pfn_glStencilFunc
    _pfn_glStencilFunc : .quad 0
    .global _pfn_glStencilMask
    _pfn_glStencilMask : .quad 0
    .global _pfn_glStencilOp
    _pfn_glStencilOp : .quad 0
    .global _pfn_glTexCoord1d
    _pfn_glTexCoord1d : .quad 0
    .global _pfn_glTexCoord1dv
    _pfn_glTexCoord1dv : .quad 0
    .global _pfn_glTexCoord1f
    _pfn_glTexCoord1f : .quad 0
    .global _pfn_glTexCoord1fv
    _pfn_glTexCoord1fv : .quad 0
    .global _pfn_glTexCoord1i
    _pfn_glTexCoord1i : .quad 0
    .global _pfn_glTexCoord1iv
    _pfn_glTexCoord1iv : .quad 0
    .global _pfn_glTexCoord1s
    _pfn_glTexCoord1s : .quad 0
    .global _pfn_glTexCoord1sv
    _pfn_glTexCoord1sv : .quad 0
    .global _pfn_glTexCoord2d
    _pfn_glTexCoord2d : .quad 0
    .global _pfn_glTexCoord2dv
    _pfn_glTexCoord2dv : .quad 0
    .global _pfn_glTexCoord2f
    _pfn_glTexCoord2f : .quad 0
    .global _pfn_glTexCoord2fv
    _pfn_glTexCoord2fv : .quad 0
    .global _pfn_glTexCoord2i
    _pfn_glTexCoord2i : .quad 0
    .global _pfn_glTexCoord2iv
    _pfn_glTexCoord2iv : .quad 0
    .global _pfn_glTexCoord2s
    _pfn_glTexCoord2s : .quad 0
    .global _pfn_glTexCoord2sv
    _pfn_glTexCoord2sv : .quad 0
    .global _pfn_glTexCoord3d
    _pfn_glTexCoord3d : .quad 0
    .global _pfn_glTexCoord3dv
    _pfn_glTexCoord3dv : .quad 0
    .global _pfn_glTexCoord3f
    _pfn_glTexCoord3f : .quad 0
    .global _pfn_glTexCoord3fv
    _pfn_glTexCoord3fv : .quad 0
    .global _pfn_glTexCoord3i
    _pfn_glTexCoord3i : .quad 0
    .global _pfn_glTexCoord3iv
    _pfn_glTexCoord3iv : .quad 0
    .global _pfn_glTexCoord3s
    _pfn_glTexCoord3s : .quad 0
    .global _pfn_glTexCoord3sv
    _pfn_glTexCoord3sv : .quad 0
    .global _pfn_glTexCoord4d
    _pfn_glTexCoord4d : .quad 0
    .global _pfn_glTexCoord4dv
    _pfn_glTexCoord4dv : .quad 0
    .global _pfn_glTexCoord4f
    _pfn_glTexCoord4f : .quad 0
    .global _pfn_glTexCoord4fv
    _pfn_glTexCoord4fv : .quad 0
    .global _pfn_glTexCoord4i
    _pfn_glTexCoord4i : .quad 0
    .global _pfn_glTexCoord4iv
    _pfn_glTexCoord4iv : .quad 0
    .global _pfn_glTexCoord4s
    _pfn_glTexCoord4s : .quad 0
    .global _pfn_glTexCoord4sv
    _pfn_glTexCoord4sv : .quad 0
    .global _pfn_glTexCoordPointer
    _pfn_glTexCoordPointer : .quad 0
    .global _pfn_glTexEnvf
    _pfn_glTexEnvf : .quad 0
    .global _pfn_glTexEnvfv
    _pfn_glTexEnvfv : .quad 0
    .global _pfn_glTexEnvi
    _pfn_glTexEnvi : .quad 0
    .global _pfn_glTexEnviv
    _pfn_glTexEnviv : .quad 0
    .global _pfn_glTexGend
    _pfn_glTexGend : .quad 0
    .global _pfn_glTexGendv
    _pfn_glTexGendv : .quad 0
    .global _pfn_glTexGenf
    _pfn_glTexGenf : .quad 0
    .global _pfn_glTexGenfv
    _pfn_glTexGenfv : .quad 0
    .global _pfn_glTexGeni
    _pfn_glTexGeni : .quad 0
    .global _pfn_glTexGeniv
    _pfn_glTexGeniv : .quad 0
    .global _pfn_glTexImage1D
    _pfn_glTexImage1D : .quad 0
    .global _pfn_glTexImage2D
    _pfn_glTexImage2D : .quad 0
    .global _pfn_glTexParameterf
    _pfn_glTexParameterf : .quad 0
    .global _pfn_glTexParameterfv
    _pfn_glTexParameterfv : .quad 0
    .global _pfn_glTexParameteri
    _pfn_glTexParameteri : .quad 0
    .global _pfn_glTexParameteriv
    _pfn_glTexParameteriv : .quad 0
    .global _pfn_glTexSubImage1D
    _pfn_glTexSubImage1D : .quad 0
    .global _pfn_glTexSubImage2D
    _pfn_glTexSubImage2D : .quad 0
    .global _pfn_glTranslated
    _pfn_glTranslated : .quad 0
    .global _pfn_glTranslatef
    _pfn_glTranslatef : .quad 0
    .global _pfn_glVertex2d
    _pfn_glVertex2d : .quad 0
    .global _pfn_glVertex2dv
    _pfn_glVertex2dv : .quad 0
    .global _pfn_glVertex2f
    _pfn_glVertex2f : .quad 0
    .global _pfn_glVertex2fv
    _pfn_glVertex2fv : .quad 0
    .global _pfn_glVertex2i
    _pfn_glVertex2i : .quad 0
    .global _pfn_glVertex2iv
    _pfn_glVertex2iv : .quad 0
    .global _pfn_glVertex2s
    _pfn_glVertex2s : .quad 0
    .global _pfn_glVertex2sv
    _pfn_glVertex2sv : .quad 0
    .global _pfn_glVertex3d
    _pfn_glVertex3d : .quad 0
    .global _pfn_glVertex3dv
    _pfn_glVertex3dv : .quad 0
    .global _pfn_glVertex3f
    _pfn_glVertex3f : .quad 0
    .global _pfn_glVertex3fv
    _pfn_glVertex3fv : .quad 0
    .global _pfn_glVertex3i
    _pfn_glVertex3i : .quad 0
    .global _pfn_glVertex3iv
    _pfn_glVertex3iv : .quad 0
    .global _pfn_glVertex3s
    _pfn_glVertex3s : .quad 0
    .global _pfn_glVertex3sv
    _pfn_glVertex3sv : .quad 0
    .global _pfn_glVertex4d
    _pfn_glVertex4d : .quad 0
    .global _pfn_glVertex4dv
    _pfn_glVertex4dv : .quad 0
    .global _pfn_glVertex4f
    _pfn_glVertex4f : .quad 0
    .global _pfn_glVertex4fv
    _pfn_glVertex4fv : .quad 0
    .global _pfn_glVertex4i
    _pfn_glVertex4i : .quad 0
    .global _pfn_glVertex4iv
    _pfn_glVertex4iv : .quad 0
    .global _pfn_glVertex4s
    _pfn_glVertex4s : .quad 0
    .global _pfn_glVertex4sv
    _pfn_glVertex4sv : .quad 0
    .global _pfn_glVertexPointer
    _pfn_glVertexPointer : .quad 0
    .global _pfn_glViewport
    _pfn_glViewport : .quad 0
    .global _pfn_wglChoosePixelFormat
    _pfn_wglChoosePixelFormat : .quad 0
    .global _pfn_wglCopyContext
    _pfn_wglCopyContext : .quad 0
    .global _pfn_wglCreateContext
    _pfn_wglCreateContext : .quad 0
    .global _pfn_wglCreateLayerContext
    _pfn_wglCreateLayerContext : .quad 0
    .global _pfn_wglDeleteContext
    _pfn_wglDeleteContext : .quad 0
    .global _pfn_wglDescribeLayerPlane
    _pfn_wglDescribeLayerPlane : .quad 0
    .global _pfn_wglDescribePixelFormat
    _pfn_wglDescribePixelFormat : .quad 0
    .global _pfn_wglGetCurrentContext
    _pfn_wglGetCurrentContext : .quad 0
    .global _pfn_wglGetCurrentDC
    _pfn_wglGetCurrentDC : .quad 0
    .global _pfn_wglGetLayerPaletteEntries
    _pfn_wglGetLayerPaletteEntries : .quad 0
    .global _pfn_wglGetPixelFormat
    _pfn_wglGetPixelFormat : .quad 0
    .global _pfn_wglMakeCurrent
    _pfn_wglMakeCurrent : .quad 0
    .global _pfn_wglRealizeLayerPalette
    _pfn_wglRealizeLayerPalette : .quad 0
    .global _pfn_wglSetLayerPaletteEntries
    _pfn_wglSetLayerPaletteEntries : .quad 0
    .global _pfn_wglSetPixelFormat
    _pfn_wglSetPixelFormat : .quad 0
    .global _pfn_wglShareLists
    _pfn_wglShareLists : .quad 0
    .global _pfn_wglSwapMultipleBuffers
    _pfn_wglSwapMultipleBuffers : .quad 0
    .global _pfn_wglUseFontBitmapsA
    _pfn_wglUseFontBitmapsA : .quad 0
    .global _pfn_wglUseFontBitmapsW
    _pfn_wglUseFontBitmapsW : .quad 0
    .global _pfn_wglUseFontOutlinesA
    _pfn_wglUseFontOutlinesA : .quad 0
    .global _pfn_wglUseFontOutlinesW
    _pfn_wglUseFontOutlinesW : .quad 0
    .global _pfn_wglGetProcAddress
    _pfn_wglGetProcAddress : .quad 0
    .global _pfn_wglSwapLayerBuffers
    _pfn_wglSwapLayerBuffers : .quad 0
