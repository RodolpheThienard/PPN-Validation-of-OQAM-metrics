	.file	"gauss_elimination.c"
	.text
.Ltext0:
	.file 1 "gauss_elimination.c"
	.p2align 4
	.globl	remontee
	.type	remontee, @function
remontee:
.LVL0:
.LFB11:
	.loc 1 4 89 view -0
	.cfi_startproc
	.loc 1 4 89 is_stmt 0 view .LVU1
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	.loc 1 7 5 view .LVU2
	leaq	0(,%rdx,8), %r12
	.loc 1 4 89 view .LVU3
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	.loc 1 7 5 view .LVU4
	movl	$32, %esi
.LVL1:
	.loc 1 4 89 view .LVU5
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdx, %rbx
	.loc 1 7 5 view .LVU6
	movq	%r12, %rdx
.LVL2:
	.loc 1 4 89 view .LVU7
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	.loc 1 4 89 view .LVU8
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	.loc 1 6 5 is_stmt 1 view .LVU9
.LVL3:
	.loc 1 7 5 view .LVU10
	movq	%rsp, %rdi
.LVL4:
	.loc 1 7 5 is_stmt 0 view .LVU11
	call	posix_memalign@PLT
.LVL5:
	xorl	%edx, %edx
	testl	%eax, %eax
	jne	.L2
	movq	(%rsp), %rdx
.LVL6:
.L2:
	.loc 1 8 5 is_stmt 1 view .LVU12
	.loc 1 9 5 view .LVU13
	.loc 1 10 5 view .LVU14
	.loc 1 12 5 view .LVU15
	.loc 1 12 36 is_stmt 0 view .LVU16
	leaq	1(%rbx), %rdi
	.loc 1 12 31 view .LVU17
	leaq	-1(%rbx), %rax
	.loc 1 12 24 view .LVU18
	vmovsd	-8(%rbp,%r12), %xmm0
	.loc 1 12 36 view .LVU19
	imulq	%rdi, %rax
.LBB2:
	.loc 1 14 19 view .LVU20
	leaq	-2(%rbx), %rcx
.LBE2:
	.loc 1 12 24 view .LVU21
	vdivsd	0(%r13,%rax,8), %xmm0, %xmm1
	.loc 1 12 14 view .LVU22
	vmovsd	%xmm1, -8(%rdx,%r12)
	.loc 1 14 5 is_stmt 1 view .LVU23
.LBB4:
	.loc 1 14 9 view .LVU24
.LVL7:
	.loc 1 14 30 view .LVU25
	testq	%rcx, %rcx
	jle	.L1
	movq	%r12, %rsi
	movq	$-8, %r9
	subq	%rdi, %rax
	imulq	%rcx, %rsi
	subq	%r12, %r9
	leaq	0(%r13,%rax,8), %r8
	addq	%r13, %rsi
	.p2align 4,,10
	.p2align 3
.L8:
	.loc 1 15 9 view .LVU26
.LBB3:
	.loc 1 15 13 view .LVU27
.LVL8:
	.loc 1 15 29 view .LVU28
	cmpq	%rbx, %rcx
	jnb	.L4
	.loc 1 15 29 is_stmt 0 view .LVU29
	movq	%rbx, %r10
	.loc 1 16 26 view .LVU30
	vmovsd	0(%rbp,%rcx,8), %xmm3
	.loc 1 16 58 view .LVU31
	vmovsd	(%r8), %xmm4
	.loc 1 15 20 view .LVU32
	movq	%rcx, %r11
	subq	%rcx, %r10
	andl	$7, %r10d
	je	.L5
	cmpq	$1, %r10
	je	.L35
	cmpq	$2, %r10
	je	.L36
	cmpq	$3, %r10
	je	.L37
	cmpq	$4, %r10
	je	.L38
	cmpq	$5, %r10
	je	.L39
	cmpq	$6, %r10
	je	.L40
	.loc 1 16 13 is_stmt 1 view .LVU33
	.loc 1 16 30 is_stmt 0 view .LVU34
	vmovsd	(%rsi,%rcx,8), %xmm2
	vfnmadd132sd	(%rdx,%rcx,8), %xmm3, %xmm2
	.loc 1 15 35 view .LVU35
	leaq	1(%rcx), %r11
	.loc 1 16 53 view .LVU36
	vdivsd	%xmm4, %xmm2, %xmm5
	.loc 1 16 20 view .LVU37
	vmovsd	%xmm5, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 view .LVU38
.LVL9:
	.loc 1 15 29 view .LVU39
.L40:
	.loc 1 16 13 view .LVU40
	.loc 1 16 30 is_stmt 0 view .LVU41
	vmovsd	(%rsi,%r11,8), %xmm6
	vfnmadd132sd	(%rdx,%r11,8), %xmm3, %xmm6
	.loc 1 15 35 view .LVU42
	incq	%r11
.LVL10:
	.loc 1 16 53 view .LVU43
	vdivsd	%xmm4, %xmm6, %xmm7
	.loc 1 16 20 view .LVU44
	vmovsd	%xmm7, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 view .LVU45
.LVL11:
	.loc 1 15 29 view .LVU46
.L39:
	.loc 1 16 13 view .LVU47
	.loc 1 16 30 is_stmt 0 view .LVU48
	vmovsd	(%rsi,%r11,8), %xmm8
	vfnmadd132sd	(%rdx,%r11,8), %xmm3, %xmm8
	.loc 1 15 35 view .LVU49
	incq	%r11
	.loc 1 16 53 view .LVU50
	vdivsd	%xmm4, %xmm8, %xmm9
	.loc 1 16 20 view .LVU51
	vmovsd	%xmm9, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 view .LVU52
	.loc 1 15 29 view .LVU53
.LVL12:
.L38:
	.loc 1 16 13 view .LVU54
	.loc 1 16 30 is_stmt 0 view .LVU55
	vmovsd	(%rsi,%r11,8), %xmm10
	vfnmadd132sd	(%rdx,%r11,8), %xmm3, %xmm10
	.loc 1 15 35 view .LVU56
	incq	%r11
	.loc 1 16 53 view .LVU57
	vdivsd	%xmm4, %xmm10, %xmm11
	.loc 1 16 20 view .LVU58
	vmovsd	%xmm11, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 view .LVU59
	.loc 1 15 29 view .LVU60
.LVL13:
.L37:
	.loc 1 16 13 view .LVU61
	.loc 1 16 30 is_stmt 0 view .LVU62
	vmovsd	(%rsi,%r11,8), %xmm12
	vfnmadd132sd	(%rdx,%r11,8), %xmm3, %xmm12
	.loc 1 15 35 view .LVU63
	incq	%r11
	.loc 1 16 53 view .LVU64
	vdivsd	%xmm4, %xmm12, %xmm13
	.loc 1 16 20 view .LVU65
	vmovsd	%xmm13, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 view .LVU66
	.loc 1 15 29 view .LVU67
.LVL14:
.L36:
	.loc 1 16 13 view .LVU68
	.loc 1 16 30 is_stmt 0 view .LVU69
	vmovsd	(%rsi,%r11,8), %xmm14
	vfnmadd132sd	(%rdx,%r11,8), %xmm3, %xmm14
	.loc 1 15 35 view .LVU70
	incq	%r11
	.loc 1 16 53 view .LVU71
	vdivsd	%xmm4, %xmm14, %xmm15
	.loc 1 16 20 view .LVU72
	vmovsd	%xmm15, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 view .LVU73
	.loc 1 15 29 view .LVU74
.LVL15:
.L35:
	.loc 1 16 13 view .LVU75
	.loc 1 16 30 is_stmt 0 view .LVU76
	vmovsd	(%rsi,%r11,8), %xmm0
	vfnmadd132sd	(%rdx,%r11,8), %xmm3, %xmm0
	.loc 1 15 35 view .LVU77
	incq	%r11
	.loc 1 16 53 view .LVU78
	vdivsd	%xmm4, %xmm0, %xmm1
	.loc 1 16 20 view .LVU79
	vmovsd	%xmm1, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 view .LVU80
	.loc 1 15 29 view .LVU81
	cmpq	%r11, %rbx
	je	.L50
.LVL16:
.L5:
	.loc 1 16 13 discriminator 3 view .LVU82
	.loc 1 16 30 is_stmt 0 discriminator 3 view .LVU83
	vmovsd	(%rsi,%r11,8), %xmm2
	vfnmadd132sd	(%rdx,%r11,8), %xmm3, %xmm2
	vmovsd	8(%rsi,%r11,8), %xmm6
	vmovsd	16(%rsi,%r11,8), %xmm8
	vmovsd	24(%rsi,%r11,8), %xmm10
	vmovsd	32(%rsi,%r11,8), %xmm12
	vmovsd	40(%rsi,%r11,8), %xmm14
	vmovsd	48(%rsi,%r11,8), %xmm0
	.loc 1 16 53 discriminator 3 view .LVU84
	vdivsd	%xmm4, %xmm2, %xmm5
	.loc 1 16 30 discriminator 3 view .LVU85
	vmovsd	56(%rsi,%r11,8), %xmm2
	.loc 1 16 20 discriminator 3 view .LVU86
	vmovsd	%xmm5, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 discriminator 3 view .LVU87
	.loc 1 15 29 discriminator 3 view .LVU88
	.loc 1 16 13 discriminator 3 view .LVU89
	.loc 1 16 30 is_stmt 0 discriminator 3 view .LVU90
	vfnmadd132sd	8(%rdx,%r11,8), %xmm3, %xmm6
	.loc 1 16 53 discriminator 3 view .LVU91
	vdivsd	%xmm4, %xmm6, %xmm7
	.loc 1 16 20 discriminator 3 view .LVU92
	vmovsd	%xmm7, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 discriminator 3 view .LVU93
	.loc 1 15 29 discriminator 3 view .LVU94
	.loc 1 16 13 discriminator 3 view .LVU95
	.loc 1 16 30 is_stmt 0 discriminator 3 view .LVU96
	vfnmadd132sd	16(%rdx,%r11,8), %xmm3, %xmm8
	.loc 1 16 53 discriminator 3 view .LVU97
	vdivsd	%xmm4, %xmm8, %xmm9
	.loc 1 16 20 discriminator 3 view .LVU98
	vmovsd	%xmm9, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 discriminator 3 view .LVU99
	.loc 1 15 29 discriminator 3 view .LVU100
	.loc 1 16 13 discriminator 3 view .LVU101
	.loc 1 16 30 is_stmt 0 discriminator 3 view .LVU102
	vfnmadd132sd	24(%rdx,%r11,8), %xmm3, %xmm10
	.loc 1 16 53 discriminator 3 view .LVU103
	vdivsd	%xmm4, %xmm10, %xmm11
	.loc 1 16 20 discriminator 3 view .LVU104
	vmovsd	%xmm11, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 discriminator 3 view .LVU105
	.loc 1 15 29 discriminator 3 view .LVU106
	.loc 1 16 13 discriminator 3 view .LVU107
	.loc 1 16 30 is_stmt 0 discriminator 3 view .LVU108
	vfnmadd132sd	32(%rdx,%r11,8), %xmm3, %xmm12
	.loc 1 16 53 discriminator 3 view .LVU109
	vdivsd	%xmm4, %xmm12, %xmm13
	.loc 1 16 20 discriminator 3 view .LVU110
	vmovsd	%xmm13, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 discriminator 3 view .LVU111
	.loc 1 15 29 discriminator 3 view .LVU112
	.loc 1 16 13 discriminator 3 view .LVU113
	.loc 1 16 30 is_stmt 0 discriminator 3 view .LVU114
	vfnmadd132sd	40(%rdx,%r11,8), %xmm3, %xmm14
	.loc 1 16 53 discriminator 3 view .LVU115
	vdivsd	%xmm4, %xmm14, %xmm15
	.loc 1 16 20 discriminator 3 view .LVU116
	vmovsd	%xmm15, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 discriminator 3 view .LVU117
	.loc 1 15 29 discriminator 3 view .LVU118
	.loc 1 16 13 discriminator 3 view .LVU119
	.loc 1 16 30 is_stmt 0 discriminator 3 view .LVU120
	vfnmadd132sd	48(%rdx,%r11,8), %xmm3, %xmm0
	.loc 1 16 53 discriminator 3 view .LVU121
	vdivsd	%xmm4, %xmm0, %xmm1
	.loc 1 16 20 discriminator 3 view .LVU122
	vmovsd	%xmm1, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 discriminator 3 view .LVU123
	.loc 1 15 29 discriminator 3 view .LVU124
	.loc 1 16 13 discriminator 3 view .LVU125
	.loc 1 16 30 is_stmt 0 discriminator 3 view .LVU126
	vfnmadd132sd	56(%rdx,%r11,8), %xmm3, %xmm2
	.loc 1 15 35 discriminator 3 view .LVU127
	addq	$8, %r11
	.loc 1 16 53 discriminator 3 view .LVU128
	vdivsd	%xmm4, %xmm2, %xmm5
	.loc 1 16 20 discriminator 3 view .LVU129
	vmovsd	%xmm5, (%rdx,%rcx,8)
	.loc 1 15 35 is_stmt 1 discriminator 3 view .LVU130
.LVL17:
	.loc 1 15 29 discriminator 3 view .LVU131
	cmpq	%r11, %rbx
	jne	.L5
.LVL18:
.L50:
	.loc 1 15 29 is_stmt 0 discriminator 3 view .LVU132
.LBE3:
	.loc 1 14 36 is_stmt 1 view .LVU133
	.loc 1 14 30 view .LVU134
	subq	%r12, %rsi
	addq	%r9, %r8
	decq	%rcx
.LVL19:
	.loc 1 14 30 is_stmt 0 view .LVU135
	jne	.L8
.LVL20:
.L1:
	.loc 1 14 30 view .LVU136
.LBE4:
	.loc 1 20 1 view .LVU137
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L54
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rdx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
.LVL21:
	.loc 1 20 1 view .LVU138
	popq	%rbp
	.cfi_def_cfa_offset 24
.LVL22:
	.loc 1 20 1 view .LVU139
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
.LVL23:
	.loc 1 20 1 view .LVU140
	ret
.LVL24:
	.p2align 4,,10
	.p2align 3
.L4:
	.cfi_restore_state
.LBB5:
	.loc 1 14 36 is_stmt 1 view .LVU141
	decq	%rcx
.LVL25:
	.loc 1 14 30 view .LVU142
	subq	%r12, %rsi
	addq	%r9, %r8
	jmp	.L8
.LVL26:
.L54:
	.loc 1 14 30 is_stmt 0 view .LVU143
.LBE5:
	.loc 1 20 1 view .LVU144
	call	__stack_chk_fail@PLT
.LVL27:
	.loc 1 20 1 view .LVU145
	.cfi_endproc
.LFE11:
	.size	remontee, .-remontee
	.p2align 4
	.globl	gauss
	.type	gauss, @function
gauss:
.LVL28:
.LFB12:
	.loc 1 23 74 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 25 5 view .LVU147
	.loc 1 26 5 view .LVU148
	.loc 1 28 5 view .LVU149
.LBB6:
	.loc 1 28 9 view .LVU150
	.loc 1 28 25 view .LVU151
.LBE6:
	.loc 1 23 74 is_stmt 0 view .LVU152
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	.cfi_offset 15, -24
	movq	%rdi, %r15
	pushq	%r14
	.cfi_offset 14, -32
	movq	%rdx, %r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
.LBB18:
	.loc 1 28 28 view .LVU153
	leaq	-1(%rdx), %rbx
.LBE18:
	.loc 1 23 74 view .LVU154
	andq	$-32, %rsp
	subq	$104, %rsp
.LBB19:
	.loc 1 28 28 view .LVU155
	movq	%rbx, -56(%rsp)
	.loc 1 28 25 view .LVU156
	cmpq	$1, %rdx
	je	.L56
.LBB7:
.LBB8:
	.loc 1 31 48 view .LVU157
	leaq	1(%rdx), %rax
	salq	$4, %rdx
.LVL29:
	.loc 1 31 48 view .LVU158
	movq	%rdi, 80(%rsp)
	xorl	%r13d, %r13d
	movq	%rax, -48(%rsp)
	salq	$3, %rax
	addq	%rdi, %rdx
	leaq	8(%r15), %r8
	leaq	-8(%rax), %r10
	movq	%rax, -64(%rsp)
	leaq	8(%rsi), %r12
	leaq	(%rsi,%r10), %rcx
	leaq	8(%rdi,%r10), %rdi
.LVL30:
	.loc 1 31 48 view .LVU159
	movq	%rdx, -72(%rsp)
	movq	%rcx, 56(%rsp)
	movq	%r14, 96(%rsp)
	movq	$0, 40(%rsp)
.LBE8:
.LBE7:
	.loc 1 28 16 view .LVU160
	movq	$0, 88(%rsp)
	movq	%rdi, -80(%rsp)
	movq	%r8, -88(%rsp)
	movq	%rbx, 8(%rsp)
	movq	%rsi, -96(%rsp)
.LVL31:
	.p2align 4,,10
	.p2align 3
.L67:
	.loc 1 29 9 is_stmt 1 view .LVU161
.LBB16:
	.loc 1 29 13 view .LVU162
	.loc 1 29 20 is_stmt 0 view .LVU163
	incq	88(%rsp)
.LVL32:
	.loc 1 29 20 view .LVU164
	movq	88(%rsp), %rsi
.LVL33:
	.loc 1 29 31 is_stmt 1 view .LVU165
	cmpq	%r14, %rsi
	jnb	.L164
	movq	40(%rsp), %r11
	movq	96(%rsp), %rsi
.LVL34:
	.loc 1 29 31 is_stmt 0 view .LVU166
	movq	%r14, %rcx
	movq	-72(%rsp), %rax
	movq	-80(%rsp), %rbx
	negq	%rcx
	leaq	0(,%r11,8), %r9
	leaq	-2(%rsi), %r11
	movq	88(%rsp), %rsi
	movq	%r11, 24(%rsp)
	leaq	(%rax,%r13,8), %r8
	addq	%r9, %rbx
	movq	%r9, %rdx
	movq	-88(%rsp), %rax
	movq	8(%rsp), %r11
	negq	%rdx
	movq	%rbx, 48(%rsp)
	subq	%r15, %rdx
	leaq	(%r14,%r13), %rbx
	addq	%rax, %r9
	movq	%r11, %rax
	leaq	-16(%rdx), %rdx
	andq	$-4, %r11
	shrq	$2, %rax
	movq	%rdx, 72(%rsp)
	addq	%r11, %rsi
	movq	%rbx, %rdi
	salq	$5, %rax
	movq	96(%rsp), %rdx
	movq	%r11, -24(%rsp)
	movq	%rax, 64(%rsp)
	movq	96(%rsp), %rax
	subq	%r11, %rdx
	movq	%rbx, -40(%rsp)
	decq	%rax
	leaq	-1(%rdx), %r11
	movq	%rdx, (%rsp)
	movq	%rax, -32(%rsp)
	movq	8(%rsp), %rax
	movq	%r11, -8(%rsp)
	andl	$3, %eax
	movq	%rsi, -16(%rsp)
	movq	%r12, %rsi
	movq	%rax, 16(%rsp)
	movq	48(%rsp), %rax
.LVL35:
	.p2align 4,,10
	.p2align 3
.L66:
.LBB14:
	.loc 1 31 13 is_stmt 1 view .LVU167
	.loc 1 31 26 is_stmt 0 view .LVU168
	movq	80(%rsp), %rbx
	.loc 1 32 20 view .LVU169
	vmovsd	-8(%r12), %xmm1
	.loc 1 31 26 view .LVU170
	vmovsd	-8(%rax), %xmm0
	cmpq	$2, 96(%rsp)
	vdivsd	(%rbx), %xmm0, %xmm5
.LVL36:
	.loc 1 32 13 is_stmt 1 view .LVU171
	.loc 1 32 20 is_stmt 0 view .LVU172
	vfnmadd213sd	(%rsi), %xmm5, %xmm1
	vmovsd	%xmm1, (%rsi)
	.loc 1 34 13 is_stmt 1 view .LVU173
.LBB9:
	.loc 1 34 17 view .LVU174
	.loc 1 34 35 view .LVU175
	je	.L69
	movq	72(%rsp), %rdx
	leaq	(%rdx,%rax), %r11
.LBE9:
	.loc 1 32 20 is_stmt 0 view .LVU176
	movq	%rax, %rdx
	cmpq	$16, %r11
	ja	.L165
.L125:
	movq	%r8, %r11
	subq	%rax, %r11
	subq	$8, %r11
	shrq	$3, %r11
	incq	%r11
	andl	$7, %r11d
	je	.L64
	cmpq	$1, %r11
	je	.L132
	cmpq	$2, %r11
	je	.L133
	cmpq	$3, %r11
	je	.L134
	cmpq	$4, %r11
	je	.L135
	cmpq	$5, %r11
	je	.L136
	cmpq	$6, %r11
	je	.L137
.LBB10:
	.loc 1 36 17 is_stmt 1 view .LVU177
	.loc 1 36 28 is_stmt 0 view .LVU178
	vmovsd	(%rax,%rcx,8), %xmm7
	vfnmadd213sd	(%rax), %xmm5, %xmm7
	.loc 1 34 35 view .LVU179
	leaq	8(%rax), %rdx
	.loc 1 36 28 view .LVU180
	vmovsd	%xmm7, (%rax)
	.loc 1 34 41 is_stmt 1 view .LVU181
	.loc 1 34 35 view .LVU182
.L137:
	.loc 1 36 17 view .LVU183
	.loc 1 36 28 is_stmt 0 view .LVU184
	vmovsd	(%rdx,%rcx,8), %xmm8
	vfnmadd213sd	(%rdx), %xmm5, %xmm8
	.loc 1 34 35 view .LVU185
	addq	$8, %rdx
	.loc 1 36 28 view .LVU186
	vmovsd	%xmm8, -8(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU187
	.loc 1 34 35 view .LVU188
.L136:
	.loc 1 36 17 view .LVU189
	.loc 1 36 28 is_stmt 0 view .LVU190
	vmovsd	(%rdx,%rcx,8), %xmm9
	vfnmadd213sd	(%rdx), %xmm5, %xmm9
	.loc 1 34 35 view .LVU191
	addq	$8, %rdx
	.loc 1 36 28 view .LVU192
	vmovsd	%xmm9, -8(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU193
	.loc 1 34 35 view .LVU194
.L135:
	.loc 1 36 17 view .LVU195
	.loc 1 36 28 is_stmt 0 view .LVU196
	vmovsd	(%rdx,%rcx,8), %xmm10
	vfnmadd213sd	(%rdx), %xmm5, %xmm10
	.loc 1 34 35 view .LVU197
	addq	$8, %rdx
	.loc 1 36 28 view .LVU198
	vmovsd	%xmm10, -8(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU199
	.loc 1 34 35 view .LVU200
.L134:
	.loc 1 36 17 view .LVU201
	.loc 1 36 28 is_stmt 0 view .LVU202
	vmovsd	(%rdx,%rcx,8), %xmm11
	vfnmadd213sd	(%rdx), %xmm5, %xmm11
	.loc 1 34 35 view .LVU203
	addq	$8, %rdx
	.loc 1 36 28 view .LVU204
	vmovsd	%xmm11, -8(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU205
	.loc 1 34 35 view .LVU206
.L133:
	.loc 1 36 17 view .LVU207
	.loc 1 36 28 is_stmt 0 view .LVU208
	vmovsd	(%rdx,%rcx,8), %xmm12
	vfnmadd213sd	(%rdx), %xmm5, %xmm12
	.loc 1 34 35 view .LVU209
	addq	$8, %rdx
	.loc 1 36 28 view .LVU210
	vmovsd	%xmm12, -8(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU211
	.loc 1 34 35 view .LVU212
.L132:
	.loc 1 36 17 view .LVU213
	.loc 1 36 28 is_stmt 0 view .LVU214
	vmovsd	(%rdx,%rcx,8), %xmm13
	vfnmadd213sd	(%rdx), %xmm5, %xmm13
	.loc 1 34 35 view .LVU215
	addq	$8, %rdx
	.loc 1 36 28 view .LVU216
	vmovsd	%xmm13, -8(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU217
	.loc 1 34 35 view .LVU218
	cmpq	%r8, %rdx
	je	.L65
.L64:
	.loc 1 36 17 view .LVU219
	.loc 1 36 28 is_stmt 0 view .LVU220
	vmovsd	(%rdx,%rcx,8), %xmm14
	vfnmadd213sd	(%rdx), %xmm5, %xmm14
	vmovsd	%xmm14, (%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU221
	.loc 1 34 35 view .LVU222
	.loc 1 36 17 view .LVU223
	.loc 1 36 28 is_stmt 0 view .LVU224
	vmovsd	8(%rdx,%rcx,8), %xmm15
	vfnmadd213sd	8(%rdx), %xmm5, %xmm15
	vmovsd	%xmm15, 8(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU225
	.loc 1 34 35 view .LVU226
	.loc 1 36 17 view .LVU227
	.loc 1 36 28 is_stmt 0 view .LVU228
	vmovsd	16(%rdx,%rcx,8), %xmm0
	vfnmadd213sd	16(%rdx), %xmm5, %xmm0
	vmovsd	%xmm0, 16(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU229
	.loc 1 34 35 view .LVU230
	.loc 1 36 17 view .LVU231
	.loc 1 36 28 is_stmt 0 view .LVU232
	vmovsd	24(%rdx,%rcx,8), %xmm1
	vfnmadd213sd	24(%rdx), %xmm5, %xmm1
	vmovsd	%xmm1, 24(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU233
	.loc 1 34 35 view .LVU234
	.loc 1 36 17 view .LVU235
	.loc 1 36 28 is_stmt 0 view .LVU236
	vmovsd	32(%rdx,%rcx,8), %xmm2
	vfnmadd213sd	32(%rdx), %xmm5, %xmm2
	vmovsd	%xmm2, 32(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU237
	.loc 1 34 35 view .LVU238
	.loc 1 36 17 view .LVU239
	.loc 1 36 28 is_stmt 0 view .LVU240
	vmovsd	40(%rdx,%rcx,8), %xmm3
	vfnmadd213sd	40(%rdx), %xmm5, %xmm3
	vmovsd	%xmm3, 40(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU241
	.loc 1 34 35 view .LVU242
	.loc 1 36 17 view .LVU243
	.loc 1 36 28 is_stmt 0 view .LVU244
	vmovsd	48(%rdx,%rcx,8), %xmm4
	vfnmadd213sd	48(%rdx), %xmm5, %xmm4
	vmovsd	%xmm4, 48(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU245
	.loc 1 34 35 view .LVU246
	.loc 1 36 17 view .LVU247
	.loc 1 36 28 is_stmt 0 view .LVU248
	vmovsd	56(%rdx,%rcx,8), %xmm6
	.loc 1 34 35 view .LVU249
	addq	$64, %rdx
	.loc 1 36 28 view .LVU250
	vfnmadd213sd	-8(%rdx), %xmm5, %xmm6
	vmovsd	%xmm6, -8(%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU251
	.loc 1 34 35 view .LVU252
	cmpq	%r8, %rdx
	jne	.L64
.LVL37:
	.p2align 4,,10
	.p2align 3
.L65:
	.loc 1 34 35 is_stmt 0 view .LVU253
.LBE10:
.LBE14:
	.loc 1 29 37 is_stmt 1 discriminator 2 view .LVU254
	.loc 1 29 31 discriminator 2 view .LVU255
	addq	$8, %rsi
	addq	%r10, %rax
	addq	%r14, %rdi
	subq	%r14, %rcx
	addq	%r10, %r8
	cmpq	%rsi, 56(%rsp)
	jne	.L66
	movq	-40(%rsp), %r13
.LVL38:
.L57:
	.loc 1 29 31 is_stmt 0 discriminator 2 view .LVU256
.LBE16:
	.loc 1 28 25 is_stmt 1 view .LVU257
	movq	-32(%rsp), %rdi
	movq	-64(%rsp), %r9
	addq	$8, %r12
	movq	-48(%rsp), %rcx
	addq	%r9, 80(%rsp)
	decq	8(%rsp)
	movq	-56(%rsp), %r8
	addq	%rcx, 40(%rsp)
	movq	%rdi, 96(%rsp)
	cmpq	%r8, 88(%rsp)
	jne	.L67
	movq	-96(%rsp), %rsi
	vzeroupper
.LVL39:
.L56:
	.loc 1 28 25 is_stmt 0 view .LVU258
.LBE19:
	.loc 1 41 5 is_stmt 1 view .LVU259
	.loc 1 43 1 is_stmt 0 view .LVU260
	leaq	-40(%rbp), %rsp
	.loc 1 41 12 view .LVU261
	movq	%r14, %rdx
	movq	%r15, %rdi
	.loc 1 43 1 view .LVU262
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
.LVL40:
	.loc 1 43 1 view .LVU263
	popq	%r15
.LVL41:
	.loc 1 43 1 view .LVU264
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	.loc 1 41 12 view .LVU265
	jmp	remontee
.LVL42:
	.p2align 4,,10
	.p2align 3
.L165:
	.cfi_restore_state
	.loc 1 41 12 view .LVU266
	cmpq	$2, 24(%rsp)
	jbe	.L59
	movq	64(%rsp), %r11
	vbroadcastsd	%xmm5, %ymm3
.LBB20:
.LBB17:
.LBB15:
	.loc 1 32 20 view .LVU267
	xorl	%edx, %edx
	leaq	-32(%r11), %rbx
	shrq	$5, %rbx
	incq	%rbx
	andl	$7, %ebx
	je	.L60
	cmpq	$1, %rbx
	je	.L126
	cmpq	$2, %rbx
	je	.L127
	cmpq	$3, %rbx
	je	.L128
	cmpq	$4, %rbx
	je	.L129
	cmpq	$5, %rbx
	je	.L130
	cmpq	$6, %rbx
	je	.L131
.LBB11:
	.loc 1 36 17 is_stmt 1 view .LVU268
	.loc 1 36 28 is_stmt 0 view .LVU269
	vmovupd	(%r9), %ymm2
	vfnmadd213pd	(%rax), %ymm3, %ymm2
	movl	$32, %edx
	vmovupd	%ymm2, (%rax)
	.loc 1 34 41 is_stmt 1 view .LVU270
	.loc 1 34 35 view .LVU271
.L131:
	.loc 1 36 17 view .LVU272
	.loc 1 36 28 is_stmt 0 view .LVU273
	vmovupd	(%r9,%rdx), %ymm4
	vfnmadd213pd	(%rax,%rdx), %ymm3, %ymm4
	vmovupd	%ymm4, (%rax,%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU274
	.loc 1 34 35 view .LVU275
	addq	$32, %rdx
.L130:
	.loc 1 36 17 view .LVU276
	.loc 1 36 28 is_stmt 0 view .LVU277
	vmovupd	(%r9,%rdx), %ymm6
	vfnmadd213pd	(%rax,%rdx), %ymm3, %ymm6
	vmovupd	%ymm6, (%rax,%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU278
	.loc 1 34 35 view .LVU279
	addq	$32, %rdx
.L129:
	.loc 1 36 17 view .LVU280
	.loc 1 36 28 is_stmt 0 view .LVU281
	vmovupd	(%r9,%rdx), %ymm7
	vfnmadd213pd	(%rax,%rdx), %ymm3, %ymm7
	vmovupd	%ymm7, (%rax,%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU282
	.loc 1 34 35 view .LVU283
	addq	$32, %rdx
.L128:
	.loc 1 36 17 view .LVU284
	.loc 1 36 28 is_stmt 0 view .LVU285
	vmovupd	(%r9,%rdx), %ymm8
	vfnmadd213pd	(%rax,%rdx), %ymm3, %ymm8
	vmovupd	%ymm8, (%rax,%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU286
	.loc 1 34 35 view .LVU287
	addq	$32, %rdx
.L127:
	.loc 1 36 17 view .LVU288
	.loc 1 36 28 is_stmt 0 view .LVU289
	vmovupd	(%r9,%rdx), %ymm9
	vfnmadd213pd	(%rax,%rdx), %ymm3, %ymm9
	vmovupd	%ymm9, (%rax,%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU290
	.loc 1 34 35 view .LVU291
	addq	$32, %rdx
.L126:
	.loc 1 36 17 view .LVU292
	.loc 1 36 28 is_stmt 0 view .LVU293
	vmovupd	(%r9,%rdx), %ymm10
	vfnmadd213pd	(%rax,%rdx), %ymm3, %ymm10
	movq	64(%rsp), %r11
	vmovupd	%ymm10, (%rax,%rdx)
	.loc 1 34 41 is_stmt 1 view .LVU294
	.loc 1 34 35 view .LVU295
	addq	$32, %rdx
	cmpq	%r11, %rdx
	je	.L158
.L60:
	.loc 1 36 17 discriminator 3 view .LVU296
	.loc 1 36 28 is_stmt 0 discriminator 3 view .LVU297
	vmovupd	(%r9,%rdx), %ymm11
	vfnmadd213pd	(%rax,%rdx), %ymm3, %ymm11
	movq	64(%rsp), %rbx
	vmovupd	%ymm11, (%rax,%rdx)
	.loc 1 34 41 is_stmt 1 discriminator 3 view .LVU298
	.loc 1 34 35 discriminator 3 view .LVU299
	.loc 1 36 17 discriminator 3 view .LVU300
	.loc 1 36 28 is_stmt 0 discriminator 3 view .LVU301
	vmovupd	32(%r9,%rdx), %ymm12
	vfnmadd213pd	32(%rax,%rdx), %ymm3, %ymm12
	vmovupd	%ymm12, 32(%rax,%rdx)
	.loc 1 34 41 is_stmt 1 discriminator 3 view .LVU302
	.loc 1 34 35 discriminator 3 view .LVU303
	.loc 1 36 17 discriminator 3 view .LVU304
	.loc 1 36 28 is_stmt 0 discriminator 3 view .LVU305
	vmovupd	64(%r9,%rdx), %ymm13
	vfnmadd213pd	64(%rax,%rdx), %ymm3, %ymm13
	vmovupd	%ymm13, 64(%rax,%rdx)
	.loc 1 34 41 is_stmt 1 discriminator 3 view .LVU306
	.loc 1 34 35 discriminator 3 view .LVU307
	.loc 1 36 17 discriminator 3 view .LVU308
	.loc 1 36 28 is_stmt 0 discriminator 3 view .LVU309
	vmovupd	96(%r9,%rdx), %ymm14
	vfnmadd213pd	96(%rax,%rdx), %ymm3, %ymm14
	vmovupd	%ymm14, 96(%rax,%rdx)
	.loc 1 34 41 is_stmt 1 discriminator 3 view .LVU310
	.loc 1 34 35 discriminator 3 view .LVU311
	.loc 1 36 17 discriminator 3 view .LVU312
	.loc 1 36 28 is_stmt 0 discriminator 3 view .LVU313
	vmovupd	128(%r9,%rdx), %ymm15
	vfnmadd213pd	128(%rax,%rdx), %ymm3, %ymm15
	vmovupd	%ymm15, 128(%rax,%rdx)
	.loc 1 34 41 is_stmt 1 discriminator 3 view .LVU314
	.loc 1 34 35 discriminator 3 view .LVU315
	.loc 1 36 17 discriminator 3 view .LVU316
	.loc 1 36 28 is_stmt 0 discriminator 3 view .LVU317
	vmovupd	160(%r9,%rdx), %ymm0
	vfnmadd213pd	160(%rax,%rdx), %ymm3, %ymm0
	vmovupd	%ymm0, 160(%rax,%rdx)
	.loc 1 34 41 is_stmt 1 discriminator 3 view .LVU318
	.loc 1 34 35 discriminator 3 view .LVU319
	.loc 1 36 17 discriminator 3 view .LVU320
	.loc 1 36 28 is_stmt 0 discriminator 3 view .LVU321
	vmovupd	192(%r9,%rdx), %ymm1
	vfnmadd213pd	192(%rax,%rdx), %ymm3, %ymm1
	vmovupd	%ymm1, 192(%rax,%rdx)
	.loc 1 34 41 is_stmt 1 discriminator 3 view .LVU322
	.loc 1 34 35 discriminator 3 view .LVU323
	.loc 1 36 17 discriminator 3 view .LVU324
	.loc 1 36 28 is_stmt 0 discriminator 3 view .LVU325
	vmovupd	224(%r9,%rdx), %ymm2
	vfnmadd213pd	224(%rax,%rdx), %ymm3, %ymm2
	vmovupd	%ymm2, 224(%rax,%rdx)
	.loc 1 34 41 is_stmt 1 discriminator 3 view .LVU326
	.loc 1 34 35 discriminator 3 view .LVU327
	addq	$256, %rdx
	cmpq	%rbx, %rdx
	jne	.L60
.L158:
	.loc 1 34 35 is_stmt 0 discriminator 3 view .LVU328
	cmpq	$0, 16(%rsp)
	je	.L65
	movq	-8(%rsp), %rdx
	cmpq	$2, (%rsp)
	movq	%rdx, 48(%rsp)
	je	.L71
	.loc 1 34 24 view .LVU329
	movq	-16(%rsp), %r11
	.loc 1 36 28 view .LVU330
	movq	-24(%rsp), %rbx
	.loc 1 34 24 view .LVU331
	movq	%r11, 32(%rsp)
.L68:
	.loc 1 34 24 view .LVU332
	movq	88(%rsp), %rdx
	.loc 1 36 28 view .LVU333
	vmovddup	%xmm5, %xmm3
	addq	%rdi, %rdx
	addq	%rbx, %rdx
	leaq	(%r15,%rdx,8), %r11
	.loc 1 36 17 is_stmt 1 view .LVU334
	.loc 1 36 39 is_stmt 0 view .LVU335
	movq	40(%rsp), %rdx
	.loc 1 36 28 view .LVU336
	vmovupd	(%r11), %xmm4
	.loc 1 36 39 view .LVU337
	leaq	1(%rbx,%rdx), %rbx
	.loc 1 36 28 view .LVU338
	vfnmadd132pd	(%r15,%rbx,8), %xmm4, %xmm3
	vmovupd	%xmm3, (%r11)
	.loc 1 34 41 is_stmt 1 view .LVU339
	.loc 1 34 35 view .LVU340
	movq	48(%rsp), %r11
	testb	$1, %r11b
	je	.L65
	movq	32(%rsp), %rbx
	movq	%r11, %rdx
	andq	$-2, %rdx
	addq	%rbx, %rdx
.L62:
.LVL43:
	.loc 1 36 17 view .LVU341
	.loc 1 36 20 is_stmt 0 view .LVU342
	leaq	(%rdi,%rdx), %r11
	.loc 1 36 39 view .LVU343
	addq	%r13, %rdx
.LVL44:
	.loc 1 36 20 view .LVU344
	leaq	(%r15,%r11,8), %rbx
	.loc 1 36 28 view .LVU345
	vmovsd	(%rbx), %xmm6
	vfnmadd132sd	(%r15,%rdx,8), %xmm6, %xmm5
.LVL45:
	.loc 1 36 28 view .LVU346
	vmovsd	%xmm5, (%rbx)
	.loc 1 34 41 is_stmt 1 view .LVU347
	.loc 1 34 35 view .LVU348
	jmp	.L65
.LVL46:
	.p2align 4,,10
	.p2align 3
.L69:
	.loc 1 34 35 is_stmt 0 view .LVU349
.LBE11:
	.loc 1 32 20 view .LVU350
	movq	%rax, %rdx
	jmp	.L125
.L59:
	.loc 1 32 20 view .LVU351
	movq	-32(%rsp), %rbx
.LBB12:
	.loc 1 34 24 view .LVU352
	movq	88(%rsp), %rdx
	movq	%rbx, 48(%rsp)
.LBE12:
	.loc 1 32 20 view .LVU353
	xorl	%ebx, %ebx
.LBB13:
	.loc 1 34 24 view .LVU354
	movq	%rdx, 32(%rsp)
	jmp	.L68
.L71:
	.loc 1 34 24 view .LVU355
	movq	-16(%rsp), %rdx
	jmp	.L62
.LVL47:
.L164:
	.loc 1 34 24 view .LVU356
	movq	96(%rsp), %r9
	leaq	(%r14,%r13), %r13
	decq	%r9
	movq	%r9, -32(%rsp)
	jmp	.L57
.LBE13:
.LBE15:
.LBE17:
.LBE20:
	.cfi_endproc
.LFE12:
	.size	gauss, .-gauss
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB13:
	.loc 1 46 17 is_stmt 1 view -0
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	.loc 1 51 5 is_stmt 0 view .LVU358
	movl	$536870912, %edx
	movl	$32, %esi
	.loc 1 46 17 view .LVU359
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%ebx, %ebx
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	.loc 1 46 17 view .LVU360
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	.loc 1 48 5 is_stmt 1 view .LVU361
.LVL48:
	.loc 1 49 5 view .LVU362
	.loc 1 51 5 view .LVU363
	leaq	8(%rsp), %rdi
	call	posix_memalign@PLT
.LVL49:
	testl	%eax, %eax
	jne	.L167
	movq	8(%rsp), %rbx
.LVL50:
.L167:
	.loc 1 52 5 view .LVU364
	leaq	16(%rsp), %rdi
	movl	$65536, %edx
	movl	$32, %esi
	.loc 1 49 22 is_stmt 0 view .LVU365
	xorl	%ebp, %ebp
	.loc 1 52 5 view .LVU366
	call	posix_memalign@PLT
.LVL51:
	testl	%eax, %eax
	jne	.L168
	movq	16(%rsp), %rbp
.LVL52:
.L168:
	.loc 1 54 5 is_stmt 1 view .LVU367
	.loc 1 55 5 view .LVU368
	.loc 1 57 5 view .LVU369
.LBB21:
	.loc 1 57 9 view .LVU370
	.loc 1 57 25 view .LVU371
	vmovsd	.LC0(%rip), %xmm7
	vxorps	%xmm3, %xmm3, %xmm3
	movq	%rbx, %rdx
	vmovsd	.LC1(%rip), %xmm1
	vmovsd	.LC2(%rip), %xmm6
	vmovsd	.LC3(%rip), %xmm5
	.loc 1 57 16 is_stmt 0 view .LVU372
	xorl	%ecx, %ecx
.LBB22:
	.loc 1 61 15 view .LVU373
	vxorpd	%xmm4, %xmm4, %xmm4
.LVL53:
	.p2align 4,,10
	.p2align 3
.L174:
	.loc 1 61 15 view .LVU374
.LBE22:
	.loc 1 58 9 is_stmt 1 view .LVU375
	.loc 1 58 19 is_stmt 0 view .LVU376
	vcvtsi2sdq	%rcx, %xmm3, %xmm2
.LBB23:
	.loc 1 59 20 view .LVU377
	xorl	%eax, %eax
	.loc 1 60 27 view .LVU378
	vmulsd	%xmm6, %xmm2, %xmm8
.LBE23:
	.loc 1 58 24 view .LVU379
	vmovsd	%xmm2, %xmm2, %xmm0
	vfmadd132sd	%xmm7, %xmm1, %xmm0
	.loc 1 58 16 view .LVU380
	vmovsd	%xmm0, 0(%rbp,%rcx,8)
	.loc 1 59 9 is_stmt 1 view .LVU381
.LBB24:
	.loc 1 59 13 view .LVU382
.LVL54:
	.loc 1 59 29 view .LVU383
	.p2align 4,,10
	.p2align 3
.L173:
	.loc 1 60 13 view .LVU384
	.loc 1 60 35 is_stmt 0 view .LVU385
	vcvtsi2sdq	%rax, %xmm3, %xmm9
	.loc 1 60 32 view .LVU386
	vfnmadd132sd	%xmm5, %xmm8, %xmm9
	.loc 1 60 41 view .LVU387
	vaddsd	%xmm1, %xmm9, %xmm10
	.loc 1 61 13 is_stmt 1 view .LVU388
	.loc 1 61 15 is_stmt 0 view .LVU389
	vucomisd	%xmm4, %xmm10
	jp	.L169
	jne	.L169
	vmovsd	%xmm1, (%rdx,%rax,8)
	.loc 1 59 35 is_stmt 1 view .LVU390
	incq	%rax
.LVL55:
	.loc 1 59 29 view .LVU391
	cmpq	$8192, %rax
	jne	.L173
.L172:
	.loc 1 59 29 is_stmt 0 view .LVU392
.LBE24:
	.loc 1 57 31 is_stmt 1 view .LVU393
	incq	%rcx
.LVL56:
	.loc 1 57 25 view .LVU394
	addq	$65536, %rdx
	cmpq	$8192, %rcx
	jne	.L174
.LBE21:
	.loc 1 65 5 view .LVU395
	.loc 1 65 17 is_stmt 0 view .LVU396
	movl	$8192, %edx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	gauss
.LVL57:
	.loc 1 67 5 view .LVU397
	movq	%rbx, %rdi
	.loc 1 65 17 view .LVU398
	movq	%rax, %r12
.LVL58:
	.loc 1 67 5 is_stmt 1 view .LVU399
	call	free@PLT
.LVL59:
	.loc 1 67 16 view .LVU400
	.loc 1 68 5 view .LVU401
	movq	%rbp, %rdi
	call	free@PLT
.LVL60:
	.loc 1 68 16 view .LVU402
	.loc 1 69 5 view .LVU403
	movq	%r12, %rdi
	call	free@PLT
.LVL61:
	.loc 1 72 5 view .LVU404
	.loc 1 73 1 is_stmt 0 view .LVU405
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L185
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
.LVL62:
	.loc 1 73 1 view .LVU406
	popq	%rbp
	.cfi_def_cfa_offset 16
.LVL63:
	.loc 1 73 1 view .LVU407
	popq	%r12
	.cfi_def_cfa_offset 8
.LVL64:
	.loc 1 73 1 view .LVU408
	ret
.LVL65:
	.p2align 4,,10
	.p2align 3
.L169:
	.cfi_restore_state
	.loc 1 73 1 view .LVU409
	vmovsd	%xmm10, (%rdx,%rax,8)
.LBB26:
.LBB25:
	.loc 1 59 35 is_stmt 1 view .LVU410
	incq	%rax
.LVL66:
	.loc 1 59 29 view .LVU411
	cmpq	$8192, %rax
	jne	.L173
	jmp	.L172
.LVL67:
.L185:
	.loc 1 59 29 is_stmt 0 view .LVU412
.LBE25:
.LBE26:
	.loc 1 73 1 view .LVU413
	call	__stack_chk_fail@PLT
.LVL68:
	.cfi_endproc
.LFE13:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	-1717986918
	.long	1069128089
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.align 8
.LC2:
	.long	1717986918
	.long	1072064102
	.align 8
.LC3:
	.long	1374389535
	.long	1070931640
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-pc-linux-gnu/12.2.0/include/stddef.h"
	.file 3 "/usr/include/stdlib.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x49c
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF14
	.byte	0xc
	.long	.LASF15
	.long	.LASF16
	.long	.Ldebug_ranges0+0x1f0
	.quad	0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF17
	.byte	0x2
	.byte	0xd6
	.byte	0x17
	.long	0x3a
	.uleb128 0x3
	.long	0x29
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.long	.LASF0
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x4
	.byte	0x8
	.byte	0x5
	.long	.LASF1
	.uleb128 0x4
	.byte	0x8
	.byte	0x5
	.long	.LASF2
	.uleb128 0x4
	.byte	0x1
	.byte	0x8
	.long	.LASF3
	.uleb128 0x4
	.byte	0x2
	.byte	0x7
	.long	.LASF4
	.uleb128 0x4
	.byte	0x4
	.byte	0x7
	.long	.LASF5
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x4
	.byte	0x2
	.byte	0x5
	.long	.LASF7
	.uleb128 0x6
	.byte	0x8
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF8
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.long	.LASF9
	.uleb128 0x7
	.long	.LASF18
	.byte	0x3
	.value	0x238
	.byte	0xd
	.long	0x9c
	.uleb128 0x8
	.long	0x79
	.byte	0
	.uleb128 0x9
	.long	.LASF19
	.byte	0x3
	.value	0x257
	.byte	0xc
	.long	0x41
	.long	0xbd
	.uleb128 0x8
	.long	0xbd
	.uleb128 0x8
	.long	0x29
	.uleb128 0x8
	.long	0x29
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x79
	.uleb128 0xb
	.long	.LASF11
	.byte	0x1
	.byte	0x2e
	.byte	0x5
	.long	0x41
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x248
	.uleb128 0xc
	.string	"n"
	.byte	0x1
	.byte	0x30
	.byte	0x12
	.long	0x35
	.value	0x2000
	.uleb128 0xd
	.string	"A"
	.byte	0x1
	.byte	0x31
	.byte	0xb
	.long	0x79
	.long	.LLST18
	.long	.LVUS18
	.uleb128 0xd
	.string	"b"
	.byte	0x1
	.byte	0x31
	.byte	0x16
	.long	0x79
	.long	.LLST19
	.long	.LVUS19
	.uleb128 0xd
	.string	"p_A"
	.byte	0x1
	.byte	0x36
	.byte	0xd
	.long	0x248
	.long	.LLST20
	.long	.LVUS20
	.uleb128 0xd
	.string	"p_b"
	.byte	0x1
	.byte	0x37
	.byte	0xd
	.long	0x248
	.long	.LLST21
	.long	.LVUS21
	.uleb128 0xd
	.string	"x"
	.byte	0x1
	.byte	0x41
	.byte	0xd
	.long	0x248
	.long	.LLST22
	.long	.LVUS22
	.uleb128 0xe
	.long	.Ldebug_ranges0+0x170
	.long	0x183
	.uleb128 0xd
	.string	"i"
	.byte	0x1
	.byte	0x39
	.byte	0x10
	.long	0x29
	.long	.LLST23
	.long	.LVUS23
	.uleb128 0xf
	.long	.Ldebug_ranges0+0x1a0
	.uleb128 0xd
	.string	"j"
	.byte	0x1
	.byte	0x3b
	.byte	0x14
	.long	0x29
	.long	.LLST24
	.long	.LVUS24
	.byte	0
	.byte	0
	.uleb128 0x10
	.quad	.LVL49
	.long	0x9c
	.long	0x1a8
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x8
	.byte	0x20
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0x40
	.byte	0x49
	.byte	0x24
	.byte	0
	.uleb128 0x10
	.quad	.LVL51
	.long	0x9c
	.long	0x1cd
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x8
	.byte	0x20
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0x40
	.byte	0x3c
	.byte	0x24
	.byte	0
	.uleb128 0x10
	.quad	.LVL57
	.long	0x25f
	.long	0x1f2
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xa
	.value	0x2000
	.byte	0
	.uleb128 0x10
	.quad	.LVL59
	.long	0x89
	.long	0x20a
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x10
	.quad	.LVL60
	.long	0x89
	.long	0x222
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.byte	0
	.uleb128 0x10
	.quad	.LVL61
	.long	0x89
	.long	0x23a
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x12
	.quad	.LVL68
	.long	0x496
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x253
	.uleb128 0x13
	.long	0x248
	.uleb128 0x4
	.byte	0x8
	.byte	0x4
	.long	.LASF10
	.uleb128 0x3
	.long	0x253
	.uleb128 0xb
	.long	.LASF12
	.byte	0x1
	.byte	0x17
	.byte	0x9
	.long	0x248
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0x373
	.uleb128 0x14
	.string	"A"
	.byte	0x1
	.byte	0x17
	.byte	0x22
	.long	0x24e
	.long	.LLST9
	.long	.LVUS9
	.uleb128 0x14
	.string	"b"
	.byte	0x1
	.byte	0x17
	.byte	0x36
	.long	0x24e
	.long	.LLST10
	.long	.LVUS10
	.uleb128 0x14
	.string	"n"
	.byte	0x1
	.byte	0x17
	.byte	0x46
	.long	0x35
	.long	.LLST11
	.long	.LVUS11
	.uleb128 0xd
	.string	"p_A"
	.byte	0x1
	.byte	0x19
	.byte	0xd
	.long	0x248
	.long	.LLST12
	.long	.LVUS12
	.uleb128 0xd
	.string	"p_b"
	.byte	0x1
	.byte	0x1a
	.byte	0xd
	.long	0x248
	.long	.LLST13
	.long	.LVUS13
	.uleb128 0xe
	.long	.Ldebug_ranges0+0x40
	.long	0x343
	.uleb128 0xd
	.string	"k"
	.byte	0x1
	.byte	0x1c
	.byte	0x10
	.long	0x29
	.long	.LLST14
	.long	.LVUS14
	.uleb128 0xf
	.long	.Ldebug_ranges0+0x90
	.uleb128 0xd
	.string	"i"
	.byte	0x1
	.byte	0x1d
	.byte	0x14
	.long	0x29
	.long	.LLST15
	.long	.LVUS15
	.uleb128 0xf
	.long	.Ldebug_ranges0+0xd0
	.uleb128 0xd
	.string	"m"
	.byte	0x1
	.byte	0x1f
	.byte	0x1a
	.long	0x25a
	.long	.LLST16
	.long	.LVUS16
	.uleb128 0xf
	.long	.Ldebug_ranges0+0x110
	.uleb128 0xd
	.string	"j"
	.byte	0x1
	.byte	0x22
	.byte	0x18
	.long	0x29
	.long	.LLST17
	.long	.LVUS17
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x15
	.quad	.LVL39
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x16
	.quad	.LVL42
	.long	0x373
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x51
	.uleb128 0xb
	.byte	0x77
	.sleb128 -48
	.byte	0x9
	.byte	0xe0
	.byte	0x1a
	.byte	0x8
	.byte	0xa0
	.byte	0x1c
	.byte	0x6
	.byte	0x23
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0xb
	.long	.LASF13
	.byte	0x1
	.byte	0x4
	.byte	0x9
	.long	0x248
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x48b
	.uleb128 0x14
	.string	"U"
	.byte	0x1
	.byte	0x4
	.byte	0x2b
	.long	0x491
	.long	.LLST0
	.long	.LVUS0
	.uleb128 0x14
	.string	"b"
	.byte	0x1
	.byte	0x4
	.byte	0x45
	.long	0x491
	.long	.LLST1
	.long	.LVUS1
	.uleb128 0x14
	.string	"n"
	.byte	0x1
	.byte	0x4
	.byte	0x55
	.long	0x35
	.long	.LLST2
	.long	.LVUS2
	.uleb128 0xd
	.string	"x"
	.byte	0x1
	.byte	0x6
	.byte	0xb
	.long	0x79
	.long	.LLST3
	.long	.LVUS3
	.uleb128 0xd
	.string	"p_x"
	.byte	0x1
	.byte	0x8
	.byte	0xd
	.long	0x248
	.long	.LLST4
	.long	.LVUS4
	.uleb128 0xd
	.string	"p_U"
	.byte	0x1
	.byte	0x9
	.byte	0xd
	.long	0x248
	.long	.LLST5
	.long	.LVUS5
	.uleb128 0xd
	.string	"p_b"
	.byte	0x1
	.byte	0xa
	.byte	0xd
	.long	0x248
	.long	.LLST6
	.long	.LVUS6
	.uleb128 0xe
	.long	.Ldebug_ranges0+0
	.long	0x459
	.uleb128 0xd
	.string	"i"
	.byte	0x1
	.byte	0xe
	.byte	0x13
	.long	0x4f
	.long	.LLST7
	.long	.LVUS7
	.uleb128 0x17
	.quad	.LBB3
	.quad	.LBE3-.LBB3
	.uleb128 0xd
	.string	"j"
	.byte	0x1
	.byte	0xf
	.byte	0x14
	.long	0x29
	.long	.LLST8
	.long	.LVUS8
	.byte	0
	.byte	0
	.uleb128 0x10
	.quad	.LVL5
	.long	0x9c
	.long	0x47d
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x8
	.byte	0x20
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x12
	.quad	.LVL27
	.long	0x496
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x25a
	.uleb128 0x13
	.long	0x48b
	.uleb128 0x18
	.long	.LASF20
	.long	.LASF20
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2113
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2115
	.uleb128 0x19
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LVUS18:
	.uleb128 .LVU363
	.uleb128 .LVU364
	.uleb128 .LVU364
	.uleb128 .LVU401
	.uleb128 .LVU401
	.uleb128 .LVU409
	.uleb128 .LVU409
	.uleb128 .LVU412
	.uleb128 .LVU412
	.uleb128 0
.LLST18:
	.quad	.LVL48
	.quad	.LVL50
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL50
	.quad	.LVL59
	.value	0x1
	.byte	0x53
	.quad	.LVL59
	.quad	.LVL65
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL65
	.quad	.LVL67
	.value	0x1
	.byte	0x53
	.quad	.LVL67
	.quad	.LFE13
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS19:
	.uleb128 .LVU363
	.uleb128 .LVU367
	.uleb128 .LVU367
	.uleb128 .LVU403
	.uleb128 .LVU403
	.uleb128 .LVU409
	.uleb128 .LVU409
	.uleb128 .LVU412
	.uleb128 .LVU412
	.uleb128 0
.LLST19:
	.quad	.LVL48
	.quad	.LVL52
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL52
	.quad	.LVL60
	.value	0x1
	.byte	0x56
	.quad	.LVL60
	.quad	.LVL65
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL65
	.quad	.LVL67
	.value	0x1
	.byte	0x56
	.quad	.LVL67
	.quad	.LFE13
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS20:
	.uleb128 .LVU368
	.uleb128 .LVU406
	.uleb128 .LVU409
	.uleb128 0
.LLST20:
	.quad	.LVL52
	.quad	.LVL62
	.value	0x1
	.byte	0x53
	.quad	.LVL65
	.quad	.LFE13
	.value	0x1
	.byte	0x53
	.quad	0
	.quad	0
.LVUS21:
	.uleb128 .LVU369
	.uleb128 .LVU407
	.uleb128 .LVU409
	.uleb128 0
.LLST21:
	.quad	.LVL52
	.quad	.LVL63
	.value	0x1
	.byte	0x56
	.quad	.LVL65
	.quad	.LFE13
	.value	0x1
	.byte	0x56
	.quad	0
	.quad	0
.LVUS22:
	.uleb128 .LVU399
	.uleb128 .LVU400
	.uleb128 .LVU400
	.uleb128 .LVU408
	.uleb128 .LVU412
	.uleb128 0
.LLST22:
	.quad	.LVL58
	.quad	.LVL59-1
	.value	0x1
	.byte	0x50
	.quad	.LVL59-1
	.quad	.LVL64
	.value	0x1
	.byte	0x5c
	.quad	.LVL67
	.quad	.LFE13
	.value	0x1
	.byte	0x5c
	.quad	0
	.quad	0
.LVUS23:
	.uleb128 .LVU371
	.uleb128 .LVU374
	.uleb128 .LVU374
	.uleb128 .LVU397
	.uleb128 .LVU409
	.uleb128 .LVU412
.LLST23:
	.quad	.LVL52
	.quad	.LVL53
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL53
	.quad	.LVL57-1
	.value	0x1
	.byte	0x52
	.quad	.LVL65
	.quad	.LVL67
	.value	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LVUS24:
	.uleb128 .LVU383
	.uleb128 .LVU384
	.uleb128 .LVU384
	.uleb128 .LVU397
	.uleb128 .LVU409
	.uleb128 .LVU412
.LLST24:
	.quad	.LVL54
	.quad	.LVL54
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL54
	.quad	.LVL57-1
	.value	0x1
	.byte	0x50
	.quad	.LVL65
	.quad	.LVL67
	.value	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LVUS9:
	.uleb128 0
	.uleb128 .LVU159
	.uleb128 .LVU159
	.uleb128 .LVU264
	.uleb128 .LVU264
	.uleb128 .LVU266
	.uleb128 .LVU266
	.uleb128 .LVU266
	.uleb128 .LVU266
	.uleb128 0
.LLST9:
	.quad	.LVL28
	.quad	.LVL30
	.value	0x1
	.byte	0x55
	.quad	.LVL30
	.quad	.LVL41
	.value	0x1
	.byte	0x5f
	.quad	.LVL41
	.quad	.LVL42-1
	.value	0x1
	.byte	0x55
	.quad	.LVL42-1
	.quad	.LVL42
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	.LVL42
	.quad	.LFE12
	.value	0x1
	.byte	0x5f
	.quad	0
	.quad	0
.LVUS10:
	.uleb128 0
	.uleb128 .LVU161
	.uleb128 .LVU161
	.uleb128 .LVU258
	.uleb128 .LVU258
	.uleb128 .LVU266
	.uleb128 .LVU266
	.uleb128 0
.LLST10:
	.quad	.LVL28
	.quad	.LVL31
	.value	0x1
	.byte	0x54
	.quad	.LVL31
	.quad	.LVL39
	.value	0x3
	.byte	0x77
	.sleb128 -96
	.quad	.LVL39
	.quad	.LVL42
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.quad	.LVL42
	.quad	.LFE12
	.value	0x3
	.byte	0x77
	.sleb128 -96
	.quad	0
	.quad	0
.LVUS11:
	.uleb128 0
	.uleb128 .LVU158
	.uleb128 .LVU158
	.uleb128 .LVU263
	.uleb128 .LVU263
	.uleb128 .LVU266
	.uleb128 .LVU266
	.uleb128 .LVU266
	.uleb128 .LVU266
	.uleb128 0
.LLST11:
	.quad	.LVL28
	.quad	.LVL29
	.value	0x1
	.byte	0x51
	.quad	.LVL29
	.quad	.LVL40
	.value	0x1
	.byte	0x5e
	.quad	.LVL40
	.quad	.LVL42-1
	.value	0x1
	.byte	0x51
	.quad	.LVL42-1
	.quad	.LVL42
	.value	0xc
	.byte	0x77
	.sleb128 -48
	.byte	0x9
	.byte	0xe0
	.byte	0x1a
	.byte	0x8
	.byte	0xa0
	.byte	0x1c
	.byte	0x6
	.byte	0x23
	.uleb128 0x1
	.byte	0x9f
	.quad	.LVL42
	.quad	.LFE12
	.value	0x1
	.byte	0x5e
	.quad	0
	.quad	0
.LVUS12:
	.uleb128 .LVU148
	.uleb128 .LVU159
	.uleb128 .LVU159
	.uleb128 .LVU264
	.uleb128 .LVU264
	.uleb128 .LVU266
	.uleb128 .LVU266
	.uleb128 .LVU266
	.uleb128 .LVU266
	.uleb128 0
.LLST12:
	.quad	.LVL28
	.quad	.LVL30
	.value	0x1
	.byte	0x55
	.quad	.LVL30
	.quad	.LVL41
	.value	0x1
	.byte	0x5f
	.quad	.LVL41
	.quad	.LVL42-1
	.value	0x1
	.byte	0x55
	.quad	.LVL42-1
	.quad	.LVL42
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	.LVL42
	.quad	.LFE12
	.value	0x1
	.byte	0x5f
	.quad	0
	.quad	0
.LVUS13:
	.uleb128 .LVU149
	.uleb128 .LVU161
	.uleb128 .LVU161
	.uleb128 .LVU258
	.uleb128 .LVU258
	.uleb128 .LVU266
	.uleb128 .LVU266
	.uleb128 0
.LLST13:
	.quad	.LVL28
	.quad	.LVL31
	.value	0x1
	.byte	0x54
	.quad	.LVL31
	.quad	.LVL39
	.value	0x3
	.byte	0x77
	.sleb128 -96
	.quad	.LVL39
	.quad	.LVL42
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.quad	.LVL42
	.quad	.LFE12
	.value	0x3
	.byte	0x77
	.sleb128 -96
	.quad	0
	.quad	0
.LVUS14:
	.uleb128 .LVU151
	.uleb128 .LVU161
	.uleb128 .LVU161
	.uleb128 .LVU164
	.uleb128 .LVU256
	.uleb128 .LVU258
.LLST14:
	.quad	.LVL28
	.quad	.LVL31
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL31
	.quad	.LVL32
	.value	0x3
	.byte	0x77
	.sleb128 88
	.quad	.LVL38
	.quad	.LVL39
	.value	0x3
	.byte	0x77
	.sleb128 88
	.quad	0
	.quad	0
.LVUS15:
	.uleb128 .LVU165
	.uleb128 .LVU166
	.uleb128 .LVU166
	.uleb128 .LVU167
	.uleb128 .LVU356
	.uleb128 0
.LLST15:
	.quad	.LVL33
	.quad	.LVL34
	.value	0x1
	.byte	0x54
	.quad	.LVL34
	.quad	.LVL35
	.value	0x3
	.byte	0x77
	.sleb128 88
	.quad	.LVL47
	.quad	.LFE12
	.value	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LVUS16:
	.uleb128 .LVU171
	.uleb128 .LVU253
	.uleb128 .LVU266
	.uleb128 .LVU346
	.uleb128 .LVU349
	.uleb128 .LVU356
.LLST16:
	.quad	.LVL36
	.quad	.LVL37
	.value	0x1
	.byte	0x66
	.quad	.LVL42
	.quad	.LVL45
	.value	0x1
	.byte	0x66
	.quad	.LVL46
	.quad	.LVL47
	.value	0x1
	.byte	0x66
	.quad	0
	.quad	0
.LVUS17:
	.uleb128 .LVU341
	.uleb128 .LVU344
.LLST17:
	.quad	.LVL43
	.quad	.LVL44
	.value	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LVUS0:
	.uleb128 0
	.uleb128 .LVU11
	.uleb128 .LVU11
	.uleb128 .LVU140
	.uleb128 .LVU140
	.uleb128 .LVU141
	.uleb128 .LVU141
	.uleb128 0
.LLST0:
	.quad	.LVL0
	.quad	.LVL4
	.value	0x1
	.byte	0x55
	.quad	.LVL4
	.quad	.LVL23
	.value	0x1
	.byte	0x5d
	.quad	.LVL23
	.quad	.LVL24
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	.LVL24
	.quad	.LFE11
	.value	0x1
	.byte	0x5d
	.quad	0
	.quad	0
.LVUS1:
	.uleb128 0
	.uleb128 .LVU5
	.uleb128 .LVU5
	.uleb128 .LVU139
	.uleb128 .LVU139
	.uleb128 .LVU141
	.uleb128 .LVU141
	.uleb128 0
.LLST1:
	.quad	.LVL0
	.quad	.LVL1
	.value	0x1
	.byte	0x54
	.quad	.LVL1
	.quad	.LVL22
	.value	0x1
	.byte	0x56
	.quad	.LVL22
	.quad	.LVL24
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.quad	.LVL24
	.quad	.LFE11
	.value	0x1
	.byte	0x56
	.quad	0
	.quad	0
.LVUS2:
	.uleb128 0
	.uleb128 .LVU7
	.uleb128 .LVU7
	.uleb128 .LVU138
	.uleb128 .LVU138
	.uleb128 .LVU141
	.uleb128 .LVU141
	.uleb128 0
.LLST2:
	.quad	.LVL0
	.quad	.LVL2
	.value	0x1
	.byte	0x51
	.quad	.LVL2
	.quad	.LVL21
	.value	0x1
	.byte	0x53
	.quad	.LVL21
	.quad	.LVL24
	.value	0x3
	.byte	0x75
	.sleb128 -1
	.byte	0x9f
	.quad	.LVL24
	.quad	.LFE11
	.value	0x1
	.byte	0x53
	.quad	0
	.quad	0
.LVUS3:
	.uleb128 .LVU10
	.uleb128 .LVU12
	.uleb128 .LVU12
	.uleb128 .LVU145
.LLST3:
	.quad	.LVL3
	.quad	.LVL6
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL6
	.quad	.LVL27-1
	.value	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LVUS4:
	.uleb128 .LVU13
	.uleb128 .LVU145
.LLST4:
	.quad	.LVL6
	.quad	.LVL27-1
	.value	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LVUS5:
	.uleb128 .LVU14
	.uleb128 .LVU140
	.uleb128 .LVU140
	.uleb128 .LVU141
	.uleb128 .LVU141
	.uleb128 0
.LLST5:
	.quad	.LVL6
	.quad	.LVL23
	.value	0x1
	.byte	0x5d
	.quad	.LVL23
	.quad	.LVL24
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	.LVL24
	.quad	.LFE11
	.value	0x1
	.byte	0x5d
	.quad	0
	.quad	0
.LVUS6:
	.uleb128 .LVU15
	.uleb128 .LVU139
	.uleb128 .LVU139
	.uleb128 .LVU141
	.uleb128 .LVU141
	.uleb128 0
.LLST6:
	.quad	.LVL6
	.quad	.LVL22
	.value	0x1
	.byte	0x56
	.quad	.LVL22
	.quad	.LVL24
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.quad	.LVL24
	.quad	.LFE11
	.value	0x1
	.byte	0x56
	.quad	0
	.quad	0
.LVUS7:
	.uleb128 .LVU25
	.uleb128 .LVU134
	.uleb128 .LVU134
	.uleb128 .LVU135
	.uleb128 .LVU135
	.uleb128 .LVU145
.LLST7:
	.quad	.LVL7
	.quad	.LVL18
	.value	0x1
	.byte	0x52
	.quad	.LVL18
	.quad	.LVL19
	.value	0x3
	.byte	0x72
	.sleb128 -1
	.byte	0x9f
	.quad	.LVL19
	.quad	.LVL27-1
	.value	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LVUS8:
	.uleb128 .LVU28
	.uleb128 .LVU39
	.uleb128 .LVU39
	.uleb128 .LVU43
	.uleb128 .LVU43
	.uleb128 .LVU46
	.uleb128 .LVU131
	.uleb128 .LVU132
	.uleb128 .LVU141
	.uleb128 .LVU142
	.uleb128 .LVU142
	.uleb128 .LVU143
.LLST8:
	.quad	.LVL8
	.quad	.LVL9
	.value	0x1
	.byte	0x52
	.quad	.LVL9
	.quad	.LVL10
	.value	0x1
	.byte	0x5b
	.quad	.LVL10
	.quad	.LVL11
	.value	0x3
	.byte	0x7b
	.sleb128 -1
	.byte	0x9f
	.quad	.LVL17
	.quad	.LVL18
	.value	0x1
	.byte	0x5b
	.quad	.LVL24
	.quad	.LVL25
	.value	0x1
	.byte	0x52
	.quad	.LVL25
	.quad	.LVL26
	.value	0x3
	.byte	0x72
	.sleb128 1
	.byte	0x9f
	.quad	0
	.quad	0
	.section	.debug_aranges,"",@progbits
	.long	0x3c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.quad	0
	.quad	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.LBB2
	.quad	.LBE2
	.quad	.LBB4
	.quad	.LBE4
	.quad	.LBB5
	.quad	.LBE5
	.quad	0
	.quad	0
	.quad	.LBB6
	.quad	.LBE6
	.quad	.LBB18
	.quad	.LBE18
	.quad	.LBB19
	.quad	.LBE19
	.quad	.LBB20
	.quad	.LBE20
	.quad	0
	.quad	0
	.quad	.LBB7
	.quad	.LBE7
	.quad	.LBB16
	.quad	.LBE16
	.quad	.LBB17
	.quad	.LBE17
	.quad	0
	.quad	0
	.quad	.LBB8
	.quad	.LBE8
	.quad	.LBB14
	.quad	.LBE14
	.quad	.LBB15
	.quad	.LBE15
	.quad	0
	.quad	0
	.quad	.LBB9
	.quad	.LBE9
	.quad	.LBB10
	.quad	.LBE10
	.quad	.LBB11
	.quad	.LBE11
	.quad	.LBB12
	.quad	.LBE12
	.quad	.LBB13
	.quad	.LBE13
	.quad	0
	.quad	0
	.quad	.LBB21
	.quad	.LBE21
	.quad	.LBB26
	.quad	.LBE26
	.quad	0
	.quad	0
	.quad	.LBB22
	.quad	.LBE22
	.quad	.LBB23
	.quad	.LBE23
	.quad	.LBB24
	.quad	.LBE24
	.quad	.LBB25
	.quad	.LBE25
	.quad	0
	.quad	0
	.quad	.Ltext0
	.quad	.Letext0
	.quad	.LFB13
	.quad	.LFE13
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF19:
	.string	"posix_memalign"
.LASF13:
	.string	"remontee"
.LASF17:
	.string	"size_t"
.LASF3:
	.string	"unsigned char"
.LASF0:
	.string	"long unsigned int"
.LASF4:
	.string	"short unsigned int"
.LASF20:
	.string	"__stack_chk_fail"
.LASF10:
	.string	"double"
.LASF16:
	.string	"/home/coco/Cours/Master1/PPN"
.LASF11:
	.string	"main"
.LASF5:
	.string	"unsigned int"
.LASF9:
	.string	"long long unsigned int"
.LASF18:
	.string	"free"
.LASF2:
	.string	"long long int"
.LASF12:
	.string	"gauss"
.LASF7:
	.string	"short int"
.LASF14:
	.ascii	"GNU C17 12.2.0 -march=haswell -mmmx -mpopcnt -msse -msse2 -m"
	.ascii	"sse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -mno-sse4a -mno-"
	.ascii	"fma4 -mno-xop -mfma -mno-avx512f -mbmi -mbmi2 -maes -mpclmul"
	.ascii	" -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512cd -mn"
	.ascii	"o-avx512er -mno-avx512pf -mno-avx512vbmi -mno-avx512ifma -mn"
	.ascii	"o-avx5124vnniw -mno-avx5124fmaps -mno-avx512vpopcntdq -mno-a"
	.ascii	"vx512vbmi2 -mno-gfni -mno-vpclmulqdq -mno-avx512vnni -mno-av"
	.ascii	"x512bitalg -mno-avx512bf16 -mno-avx512vp2intersect -mno-3dno"
	.ascii	"w -mno-adx -mabm -mno-cldemote -mno-clflushopt -mno-clwb -mn"
	.ascii	"o-clzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hl"
	.ascii	"e -msahf -mno-lwp -mlzcnt -mmovbe -mno-movdir64b -mno-movdir"
	.ascii	"i -mno-mwaitx -mno-pconfig -mno-pku -mno-prefetchwt1 -mno-pr"
	.ascii	"fchw -mno-ptwrite -mno-rdpid -mrdrnd -mno-rdseed -mno-rtm -m"
	.ascii	"no-serialize -mno-sgx -mno-sha -mno-shstk -mno-tbm -mno-tsxl"
	.ascii	"dtrk -mno-vaes -mno-waitpkg -mno-wbnoinvd -mxsave -mno-xsave"
	.ascii	"c -mxsaveopt -mno-xsaves -mno-amx-tile -mno-amx"
	.string	"-int8 -mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mno-avxvnni -mno-avx512fp16 --param=l1-cache-size=32 --param=l1-cache-line-size=64 --param=l2-cache-size=6144 -mtune=haswell -gdwarf-4 -O3 -ftree-vectorize -floop-unroll-and-jam -funroll-loops"
.LASF1:
	.string	"long int"
.LASF8:
	.string	"char"
.LASF6:
	.string	"signed char"
.LASF15:
	.string	"gauss_elimination.c"
	.ident	"GCC: (GNU) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
