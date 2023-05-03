
a.out:     format de fichier elf64-x86-64


Déassemblage de la section .init :

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64
    1004:	48 83 ec 08          	sub    $0x8,%rsp
    1008:	48 8b 05 c1 2f 00 00 	mov    0x2fc1(%rip),%rax        # 3fd0 <__gmon_start__@Base>
    100f:	48 85 c0             	test   %rax,%rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	call   *%rax
    1016:	48 83 c4 08          	add    $0x8,%rsp
    101a:	c3                   	ret

Déassemblage de la section .plt :

0000000000001020 <free@plt-0x10>:
    1020:	ff 35 ca 2f 00 00    	push   0x2fca(%rip)        # 3ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	ff 25 cc 2f 00 00    	jmp    *0x2fcc(%rip)        # 3ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    102c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000001030 <free@plt>:
    1030:	ff 25 ca 2f 00 00    	jmp    *0x2fca(%rip)        # 4000 <free@GLIBC_2.2.5>
    1036:	68 00 00 00 00       	push   $0x0
    103b:	e9 e0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001040 <__stack_chk_fail@plt>:
    1040:	ff 25 c2 2f 00 00    	jmp    *0x2fc2(%rip)        # 4008 <__stack_chk_fail@GLIBC_2.4>
    1046:	68 01 00 00 00       	push   $0x1
    104b:	e9 d0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001050 <posix_memalign@plt>:
    1050:	ff 25 ba 2f 00 00    	jmp    *0x2fba(%rip)        # 4010 <posix_memalign@GLIBC_2.2.5>
    1056:	68 02 00 00 00       	push   $0x2
    105b:	e9 c0 ff ff ff       	jmp    1020 <_init+0x20>

Déassemblage de la section .text :

0000000000001060 <main>:
    1060:	41 54                	push   %r12
    1062:	ba 00 00 00 20       	mov    $0x20000000,%edx
    1067:	be 20 00 00 00       	mov    $0x20,%esi
    106c:	55                   	push   %rbp
    106d:	53                   	push   %rbx
    106e:	31 db                	xor    %ebx,%ebx
    1070:	48 83 ec 20          	sub    $0x20,%rsp
    1074:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    107b:	00 00 
    107d:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    1082:	31 c0                	xor    %eax,%eax
    1084:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    1089:	e8 c2 ff ff ff       	call   1050 <posix_memalign@plt>
    108e:	85 c0                	test   %eax,%eax
    1090:	75 05                	jne    1097 <main+0x37>
    1092:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    1097:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    109c:	ba 00 00 01 00       	mov    $0x10000,%edx
    10a1:	be 20 00 00 00       	mov    $0x20,%esi
    10a6:	31 ed                	xor    %ebp,%ebp
    10a8:	e8 a3 ff ff ff       	call   1050 <posix_memalign@plt>
    10ad:	85 c0                	test   %eax,%eax
    10af:	75 05                	jne    10b6 <main+0x56>
    10b1:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    10b6:	c5 fb 10 3d 4a 0f 00 	vmovsd 0xf4a(%rip),%xmm7        # 2008 <_IO_stdin_used+0x8>
    10bd:	00 
    10be:	c5 e0 57 db          	vxorps %xmm3,%xmm3,%xmm3
    10c2:	48 89 da             	mov    %rbx,%rdx
    10c5:	c5 fb 10 0d 43 0f 00 	vmovsd 0xf43(%rip),%xmm1        # 2010 <_IO_stdin_used+0x10>
    10cc:	00 
    10cd:	c5 fb 10 35 43 0f 00 	vmovsd 0xf43(%rip),%xmm6        # 2018 <_IO_stdin_used+0x18>
    10d4:	00 
    10d5:	c5 fb 10 2d 43 0f 00 	vmovsd 0xf43(%rip),%xmm5        # 2020 <_IO_stdin_used+0x20>
    10dc:	00 
    10dd:	31 c9                	xor    %ecx,%ecx
    10df:	c5 d9 57 e4          	vxorpd %xmm4,%xmm4,%xmm4
    10e3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    10e8:	c4 e1 e3 2a d1       	vcvtsi2sd %rcx,%xmm3,%xmm2
    10ed:	31 c0                	xor    %eax,%eax
    10ef:	c5 6b 59 c6          	vmulsd %xmm6,%xmm2,%xmm8
    10f3:	c5 eb 10 c2          	vmovsd %xmm2,%xmm2,%xmm0
    10f7:	c4 e2 f1 99 c7       	vfmadd132sd %xmm7,%xmm1,%xmm0
    10fc:	c5 fb 11 44 cd 00    	vmovsd %xmm0,0x0(%rbp,%rcx,8)
    1102:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1108:	c4 61 e3 2a c8       	vcvtsi2sd %rax,%xmm3,%xmm9
    110d:	c4 62 b9 9d cd       	vfnmadd132sd %xmm5,%xmm8,%xmm9
    1112:	c5 33 58 d1          	vaddsd %xmm1,%xmm9,%xmm10
    1116:	c5 79 2e d4          	vucomisd %xmm4,%xmm10
    111a:	7a 74                	jp     1190 <main+0x130>
    111c:	75 72                	jne    1190 <main+0x130>
    111e:	c5 fb 11 0c c2       	vmovsd %xmm1,(%rdx,%rax,8)
    1123:	48 ff c0             	inc    %rax
    1126:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
    112c:	75 da                	jne    1108 <main+0xa8>
    112e:	48 ff c1             	inc    %rcx
    1131:	48 81 c2 00 00 01 00 	add    $0x10000,%rdx
    1138:	48 81 f9 00 20 00 00 	cmp    $0x2000,%rcx
    113f:	75 a7                	jne    10e8 <main+0x88>
    1141:	ba 00 20 00 00       	mov    $0x2000,%edx
    1146:	48 89 ee             	mov    %rbp,%rsi
    1149:	48 89 df             	mov    %rbx,%rdi
    114c:	e8 ff 03 00 00       	call   1550 <gauss>
    1151:	48 89 df             	mov    %rbx,%rdi
    1154:	49 89 c4             	mov    %rax,%r12
    1157:	e8 d4 fe ff ff       	call   1030 <free@plt>
    115c:	48 89 ef             	mov    %rbp,%rdi
    115f:	e8 cc fe ff ff       	call   1030 <free@plt>
    1164:	4c 89 e7             	mov    %r12,%rdi
    1167:	e8 c4 fe ff ff       	call   1030 <free@plt>
    116c:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    1171:	64 48 2b 04 25 28 00 	sub    %fs:0x28,%rax
    1178:	00 00 
    117a:	75 2a                	jne    11a6 <main+0x146>
    117c:	48 83 c4 20          	add    $0x20,%rsp
    1180:	31 c0                	xor    %eax,%eax
    1182:	5b                   	pop    %rbx
    1183:	5d                   	pop    %rbp
    1184:	41 5c                	pop    %r12
    1186:	c3                   	ret
    1187:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    118e:	00 00 
    1190:	c5 7b 11 14 c2       	vmovsd %xmm10,(%rdx,%rax,8)
    1195:	48 ff c0             	inc    %rax
    1198:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
    119e:	0f 85 64 ff ff ff    	jne    1108 <main+0xa8>
    11a4:	eb 88                	jmp    112e <main+0xce>
    11a6:	e8 95 fe ff ff       	call   1040 <__stack_chk_fail@plt>
    11ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000011b0 <_start>:
    11b0:	f3 0f 1e fa          	endbr64
    11b4:	31 ed                	xor    %ebp,%ebp
    11b6:	49 89 d1             	mov    %rdx,%r9
    11b9:	5e                   	pop    %rsi
    11ba:	48 89 e2             	mov    %rsp,%rdx
    11bd:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    11c1:	50                   	push   %rax
    11c2:	54                   	push   %rsp
    11c3:	45 31 c0             	xor    %r8d,%r8d
    11c6:	31 c9                	xor    %ecx,%ecx
    11c8:	48 8d 3d 91 fe ff ff 	lea    -0x16f(%rip),%rdi        # 1060 <main>
    11cf:	ff 15 eb 2d 00 00    	call   *0x2deb(%rip)        # 3fc0 <__libc_start_main@GLIBC_2.34>
    11d5:	f4                   	hlt
    11d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    11dd:	00 00 00 

00000000000011e0 <deregister_tm_clones>:
    11e0:	48 8d 3d 41 2e 00 00 	lea    0x2e41(%rip),%rdi        # 4028 <__TMC_END__>
    11e7:	48 8d 05 3a 2e 00 00 	lea    0x2e3a(%rip),%rax        # 4028 <__TMC_END__>
    11ee:	48 39 f8             	cmp    %rdi,%rax
    11f1:	74 15                	je     1208 <deregister_tm_clones+0x28>
    11f3:	48 8b 05 ce 2d 00 00 	mov    0x2dce(%rip),%rax        # 3fc8 <_ITM_deregisterTMCloneTable@Base>
    11fa:	48 85 c0             	test   %rax,%rax
    11fd:	74 09                	je     1208 <deregister_tm_clones+0x28>
    11ff:	ff e0                	jmp    *%rax
    1201:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1208:	c3                   	ret
    1209:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001210 <register_tm_clones>:
    1210:	48 8d 3d 11 2e 00 00 	lea    0x2e11(%rip),%rdi        # 4028 <__TMC_END__>
    1217:	48 8d 35 0a 2e 00 00 	lea    0x2e0a(%rip),%rsi        # 4028 <__TMC_END__>
    121e:	48 29 fe             	sub    %rdi,%rsi
    1221:	48 89 f0             	mov    %rsi,%rax
    1224:	48 c1 ee 3f          	shr    $0x3f,%rsi
    1228:	48 c1 f8 03          	sar    $0x3,%rax
    122c:	48 01 c6             	add    %rax,%rsi
    122f:	48 d1 fe             	sar    %rsi
    1232:	74 14                	je     1248 <register_tm_clones+0x38>
    1234:	48 8b 05 9d 2d 00 00 	mov    0x2d9d(%rip),%rax        # 3fd8 <_ITM_registerTMCloneTable@Base>
    123b:	48 85 c0             	test   %rax,%rax
    123e:	74 08                	je     1248 <register_tm_clones+0x38>
    1240:	ff e0                	jmp    *%rax
    1242:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1248:	c3                   	ret
    1249:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001250 <__do_global_dtors_aux>:
    1250:	f3 0f 1e fa          	endbr64
    1254:	80 3d cd 2d 00 00 00 	cmpb   $0x0,0x2dcd(%rip)        # 4028 <__TMC_END__>
    125b:	75 33                	jne    1290 <__do_global_dtors_aux+0x40>
    125d:	55                   	push   %rbp
    125e:	48 83 3d 7a 2d 00 00 	cmpq   $0x0,0x2d7a(%rip)        # 3fe0 <__cxa_finalize@GLIBC_2.2.5>
    1265:	00 
    1266:	48 89 e5             	mov    %rsp,%rbp
    1269:	74 0d                	je     1278 <__do_global_dtors_aux+0x28>
    126b:	48 8b 3d ae 2d 00 00 	mov    0x2dae(%rip),%rdi        # 4020 <__dso_handle>
    1272:	ff 15 68 2d 00 00    	call   *0x2d68(%rip)        # 3fe0 <__cxa_finalize@GLIBC_2.2.5>
    1278:	e8 63 ff ff ff       	call   11e0 <deregister_tm_clones>
    127d:	c6 05 a4 2d 00 00 01 	movb   $0x1,0x2da4(%rip)        # 4028 <__TMC_END__>
    1284:	5d                   	pop    %rbp
    1285:	c3                   	ret
    1286:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    128d:	00 00 00 
    1290:	c3                   	ret
    1291:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1298:	00 00 00 00 
    129c:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000012a0 <frame_dummy>:
    12a0:	f3 0f 1e fa          	endbr64
    12a4:	e9 67 ff ff ff       	jmp    1210 <register_tm_clones>
    12a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000012b0 <remontee>:
    12b0:	41 55                	push   %r13
    12b2:	49 89 fd             	mov    %rdi,%r13
    12b5:	41 54                	push   %r12
    12b7:	4c 8d 24 d5 00 00 00 	lea    0x0(,%rdx,8),%r12
    12be:	00 
    12bf:	55                   	push   %rbp
    12c0:	48 89 f5             	mov    %rsi,%rbp
    12c3:	be 20 00 00 00       	mov    $0x20,%esi
    12c8:	53                   	push   %rbx
    12c9:	48 89 d3             	mov    %rdx,%rbx
    12cc:	4c 89 e2             	mov    %r12,%rdx
    12cf:	48 83 ec 18          	sub    $0x18,%rsp
    12d3:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    12da:	00 00 
    12dc:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    12e1:	31 c0                	xor    %eax,%eax
    12e3:	48 89 e7             	mov    %rsp,%rdi
    12e6:	e8 65 fd ff ff       	call   1050 <posix_memalign@plt>
    12eb:	31 d2                	xor    %edx,%edx
    12ed:	85 c0                	test   %eax,%eax
    12ef:	75 04                	jne    12f5 <remontee+0x45>
    12f1:	48 8b 14 24          	mov    (%rsp),%rdx
    12f5:	48 8d 7b 01          	lea    0x1(%rbx),%rdi
    12f9:	48 8d 43 ff          	lea    -0x1(%rbx),%rax
    12fd:	c4 a1 7b 10 44 25 f8 	vmovsd -0x8(%rbp,%r12,1),%xmm0
    1304:	48 0f af c7          	imul   %rdi,%rax
    1308:	48 8d 4b fe          	lea    -0x2(%rbx),%rcx
    130c:	c4 c1 7b 5e 4c c5 00 	vdivsd 0x0(%r13,%rax,8),%xmm0,%xmm1
    1313:	c4 a1 7b 11 4c 22 f8 	vmovsd %xmm1,-0x8(%rdx,%r12,1)
    131a:	48 85 c9             	test   %rcx,%rcx
    131d:	0f 8e f3 01 00 00    	jle    1516 <remontee+0x266>
    1323:	4c 89 e6             	mov    %r12,%rsi
    1326:	49 c7 c1 f8 ff ff ff 	mov    $0xfffffffffffffff8,%r9
    132d:	48 29 f8             	sub    %rdi,%rax
    1330:	48 0f af f1          	imul   %rcx,%rsi
    1334:	4d 29 e1             	sub    %r12,%r9
    1337:	4d 8d 44 c5 00       	lea    0x0(%r13,%rax,8),%r8
    133c:	4c 01 ee             	add    %r13,%rsi
    133f:	90                   	nop
    1340:	48 39 d9             	cmp    %rbx,%rcx
    1343:	0f 83 ef 01 00 00    	jae    1538 <remontee+0x288>
    1349:	49 89 da             	mov    %rbx,%r10
    134c:	c5 fb 10 5c cd 00    	vmovsd 0x0(%rbp,%rcx,8),%xmm3
    1352:	c4 c1 7b 10 20       	vmovsd (%r8),%xmm4
    1357:	49 89 cb             	mov    %rcx,%r11
    135a:	49 29 ca             	sub    %rcx,%r10
    135d:	41 83 e2 07          	and    $0x7,%r10d
    1361:	0f 84 dd 00 00 00    	je     1444 <remontee+0x194>
    1367:	49 83 fa 01          	cmp    $0x1,%r10
    136b:	0f 84 b2 00 00 00    	je     1423 <remontee+0x173>
    1371:	49 83 fa 02          	cmp    $0x2,%r10
    1375:	0f 84 90 00 00 00    	je     140b <remontee+0x15b>
    137b:	49 83 fa 03          	cmp    $0x3,%r10
    137f:	74 72                	je     13f3 <remontee+0x143>
    1381:	49 83 fa 04          	cmp    $0x4,%r10
    1385:	74 54                	je     13db <remontee+0x12b>
    1387:	49 83 fa 05          	cmp    $0x5,%r10
    138b:	74 36                	je     13c3 <remontee+0x113>
    138d:	49 83 fa 06          	cmp    $0x6,%r10
    1391:	74 18                	je     13ab <remontee+0xfb>
    1393:	c5 fb 10 14 ce       	vmovsd (%rsi,%rcx,8),%xmm2
    1398:	c4 e2 e1 9d 14 ca    	vfnmadd132sd (%rdx,%rcx,8),%xmm3,%xmm2
    139e:	4c 8d 59 01          	lea    0x1(%rcx),%r11
    13a2:	c5 eb 5e ec          	vdivsd %xmm4,%xmm2,%xmm5
    13a6:	c5 fb 11 2c ca       	vmovsd %xmm5,(%rdx,%rcx,8)
    13ab:	c4 a1 7b 10 34 de    	vmovsd (%rsi,%r11,8),%xmm6
    13b1:	c4 a2 e1 9d 34 da    	vfnmadd132sd (%rdx,%r11,8),%xmm3,%xmm6
    13b7:	49 ff c3             	inc    %r11
    13ba:	c5 cb 5e fc          	vdivsd %xmm4,%xmm6,%xmm7
    13be:	c5 fb 11 3c ca       	vmovsd %xmm7,(%rdx,%rcx,8)
    13c3:	c4 21 7b 10 04 de    	vmovsd (%rsi,%r11,8),%xmm8
    13c9:	c4 22 e1 9d 04 da    	vfnmadd132sd (%rdx,%r11,8),%xmm3,%xmm8
    13cf:	49 ff c3             	inc    %r11
    13d2:	c5 3b 5e cc          	vdivsd %xmm4,%xmm8,%xmm9
    13d6:	c5 7b 11 0c ca       	vmovsd %xmm9,(%rdx,%rcx,8)
    13db:	c4 21 7b 10 14 de    	vmovsd (%rsi,%r11,8),%xmm10
    13e1:	c4 22 e1 9d 14 da    	vfnmadd132sd (%rdx,%r11,8),%xmm3,%xmm10
    13e7:	49 ff c3             	inc    %r11
    13ea:	c5 2b 5e dc          	vdivsd %xmm4,%xmm10,%xmm11
    13ee:	c5 7b 11 1c ca       	vmovsd %xmm11,(%rdx,%rcx,8)
    13f3:	c4 21 7b 10 24 de    	vmovsd (%rsi,%r11,8),%xmm12
    13f9:	c4 22 e1 9d 24 da    	vfnmadd132sd (%rdx,%r11,8),%xmm3,%xmm12
    13ff:	49 ff c3             	inc    %r11
    1402:	c5 1b 5e ec          	vdivsd %xmm4,%xmm12,%xmm13
    1406:	c5 7b 11 2c ca       	vmovsd %xmm13,(%rdx,%rcx,8)
    140b:	c4 21 7b 10 34 de    	vmovsd (%rsi,%r11,8),%xmm14
    1411:	c4 22 e1 9d 34 da    	vfnmadd132sd (%rdx,%r11,8),%xmm3,%xmm14
    1417:	49 ff c3             	inc    %r11
    141a:	c5 0b 5e fc          	vdivsd %xmm4,%xmm14,%xmm15
    141e:	c5 7b 11 3c ca       	vmovsd %xmm15,(%rdx,%rcx,8)
    1423:	c4 a1 7b 10 04 de    	vmovsd (%rsi,%r11,8),%xmm0
    1429:	c4 a2 e1 9d 04 da    	vfnmadd132sd (%rdx,%r11,8),%xmm3,%xmm0
    142f:	49 ff c3             	inc    %r11
    1432:	c5 fb 5e cc          	vdivsd %xmm4,%xmm0,%xmm1
    1436:	c5 fb 11 0c ca       	vmovsd %xmm1,(%rdx,%rcx,8)
    143b:	4c 39 db             	cmp    %r11,%rbx
    143e:	0f 84 c3 00 00 00    	je     1507 <remontee+0x257>
    1444:	c4 a1 7b 10 14 de    	vmovsd (%rsi,%r11,8),%xmm2
    144a:	c4 a2 e1 9d 14 da    	vfnmadd132sd (%rdx,%r11,8),%xmm3,%xmm2
    1450:	c4 a1 7b 10 74 de 08 	vmovsd 0x8(%rsi,%r11,8),%xmm6
    1457:	c4 21 7b 10 44 de 10 	vmovsd 0x10(%rsi,%r11,8),%xmm8
    145e:	c4 21 7b 10 54 de 18 	vmovsd 0x18(%rsi,%r11,8),%xmm10
    1465:	c4 21 7b 10 64 de 20 	vmovsd 0x20(%rsi,%r11,8),%xmm12
    146c:	c4 21 7b 10 74 de 28 	vmovsd 0x28(%rsi,%r11,8),%xmm14
    1473:	c4 a1 7b 10 44 de 30 	vmovsd 0x30(%rsi,%r11,8),%xmm0
    147a:	c5 eb 5e ec          	vdivsd %xmm4,%xmm2,%xmm5
    147e:	c4 a1 7b 10 54 de 38 	vmovsd 0x38(%rsi,%r11,8),%xmm2
    1485:	c5 fb 11 2c ca       	vmovsd %xmm5,(%rdx,%rcx,8)
    148a:	c4 a2 e1 9d 74 da 08 	vfnmadd132sd 0x8(%rdx,%r11,8),%xmm3,%xmm6
    1491:	c5 cb 5e fc          	vdivsd %xmm4,%xmm6,%xmm7
    1495:	c5 fb 11 3c ca       	vmovsd %xmm7,(%rdx,%rcx,8)
    149a:	c4 22 e1 9d 44 da 10 	vfnmadd132sd 0x10(%rdx,%r11,8),%xmm3,%xmm8
    14a1:	c5 3b 5e cc          	vdivsd %xmm4,%xmm8,%xmm9
    14a5:	c5 7b 11 0c ca       	vmovsd %xmm9,(%rdx,%rcx,8)
    14aa:	c4 22 e1 9d 54 da 18 	vfnmadd132sd 0x18(%rdx,%r11,8),%xmm3,%xmm10
    14b1:	c5 2b 5e dc          	vdivsd %xmm4,%xmm10,%xmm11
    14b5:	c5 7b 11 1c ca       	vmovsd %xmm11,(%rdx,%rcx,8)
    14ba:	c4 22 e1 9d 64 da 20 	vfnmadd132sd 0x20(%rdx,%r11,8),%xmm3,%xmm12
    14c1:	c5 1b 5e ec          	vdivsd %xmm4,%xmm12,%xmm13
    14c5:	c5 7b 11 2c ca       	vmovsd %xmm13,(%rdx,%rcx,8)
    14ca:	c4 22 e1 9d 74 da 28 	vfnmadd132sd 0x28(%rdx,%r11,8),%xmm3,%xmm14
    14d1:	c5 0b 5e fc          	vdivsd %xmm4,%xmm14,%xmm15
    14d5:	c5 7b 11 3c ca       	vmovsd %xmm15,(%rdx,%rcx,8)
    14da:	c4 a2 e1 9d 44 da 30 	vfnmadd132sd 0x30(%rdx,%r11,8),%xmm3,%xmm0
    14e1:	c5 fb 5e cc          	vdivsd %xmm4,%xmm0,%xmm1
    14e5:	c5 fb 11 0c ca       	vmovsd %xmm1,(%rdx,%rcx,8)
    14ea:	c4 a2 e1 9d 54 da 38 	vfnmadd132sd 0x38(%rdx,%r11,8),%xmm3,%xmm2
    14f1:	49 83 c3 08          	add    $0x8,%r11
    14f5:	c5 eb 5e ec          	vdivsd %xmm4,%xmm2,%xmm5
    14f9:	c5 fb 11 2c ca       	vmovsd %xmm5,(%rdx,%rcx,8)
    14fe:	4c 39 db             	cmp    %r11,%rbx
    1501:	0f 85 3d ff ff ff    	jne    1444 <remontee+0x194>
    1507:	4c 29 e6             	sub    %r12,%rsi
    150a:	4d 01 c8             	add    %r9,%r8
    150d:	48 ff c9             	dec    %rcx
    1510:	0f 85 2a fe ff ff    	jne    1340 <remontee+0x90>
    1516:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    151b:	64 48 2b 04 25 28 00 	sub    %fs:0x28,%rax
    1522:	00 00 
    1524:	75 20                	jne    1546 <remontee+0x296>
    1526:	48 83 c4 18          	add    $0x18,%rsp
    152a:	48 89 d0             	mov    %rdx,%rax
    152d:	5b                   	pop    %rbx
    152e:	5d                   	pop    %rbp
    152f:	41 5c                	pop    %r12
    1531:	41 5d                	pop    %r13
    1533:	c3                   	ret
    1534:	0f 1f 40 00          	nopl   0x0(%rax)
    1538:	48 ff c9             	dec    %rcx
    153b:	4c 29 e6             	sub    %r12,%rsi
    153e:	4d 01 c8             	add    %r9,%r8
    1541:	e9 fa fd ff ff       	jmp    1340 <remontee+0x90>
    1546:	e8 f5 fa ff ff       	call   1040 <__stack_chk_fail@plt>
    154b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001550 <gauss>:
    1550:	55                   	push   %rbp
    1551:	48 89 e5             	mov    %rsp,%rbp
    1554:	41 57                	push   %r15
    1556:	49 89 ff             	mov    %rdi,%r15
    1559:	41 56                	push   %r14
    155b:	49 89 d6             	mov    %rdx,%r14
    155e:	41 55                	push   %r13
    1560:	41 54                	push   %r12
    1562:	53                   	push   %rbx
    1563:	48 8d 5a ff          	lea    -0x1(%rdx),%rbx
    1567:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
    156b:	48 83 ec 68          	sub    $0x68,%rsp
    156f:	48 89 5c 24 c8       	mov    %rbx,-0x38(%rsp)
    1574:	48 83 fa 01          	cmp    $0x1,%rdx
    1578:	0f 84 51 03 00 00    	je     18cf <gauss+0x37f>
    157e:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1582:	48 c1 e2 04          	shl    $0x4,%rdx
    1586:	48 89 7c 24 50       	mov    %rdi,0x50(%rsp)
    158b:	45 31 ed             	xor    %r13d,%r13d
    158e:	48 89 44 24 d0       	mov    %rax,-0x30(%rsp)
    1593:	48 c1 e0 03          	shl    $0x3,%rax
    1597:	48 01 fa             	add    %rdi,%rdx
    159a:	4d 8d 47 08          	lea    0x8(%r15),%r8
    159e:	4c 8d 50 f8          	lea    -0x8(%rax),%r10
    15a2:	48 89 44 24 c0       	mov    %rax,-0x40(%rsp)
    15a7:	4c 8d 66 08          	lea    0x8(%rsi),%r12
    15ab:	4a 8d 0c 16          	lea    (%rsi,%r10,1),%rcx
    15af:	4a 8d 7c 17 08       	lea    0x8(%rdi,%r10,1),%rdi
    15b4:	48 89 54 24 b8       	mov    %rdx,-0x48(%rsp)
    15b9:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    15be:	4c 89 74 24 60       	mov    %r14,0x60(%rsp)
    15c3:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
    15ca:	00 00 
    15cc:	48 c7 44 24 58 00 00 	movq   $0x0,0x58(%rsp)
    15d3:	00 00 
    15d5:	48 89 7c 24 b0       	mov    %rdi,-0x50(%rsp)
    15da:	4c 89 44 24 a8       	mov    %r8,-0x58(%rsp)
    15df:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
    15e4:	48 89 74 24 a0       	mov    %rsi,-0x60(%rsp)
    15e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    15f0:	48 ff 44 24 58       	incq   0x58(%rsp)
    15f5:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
    15fa:	4c 39 f6             	cmp    %r14,%rsi
    15fd:	0f 83 7f 05 00 00    	jae    1b82 <gauss+0x632>
    1603:	4c 8b 5c 24 28       	mov    0x28(%rsp),%r11
    1608:	48 8b 74 24 60       	mov    0x60(%rsp),%rsi
    160d:	4c 89 f1             	mov    %r14,%rcx
    1610:	48 8b 44 24 b8       	mov    -0x48(%rsp),%rax
    1615:	48 8b 5c 24 b0       	mov    -0x50(%rsp),%rbx
    161a:	48 f7 d9             	neg    %rcx
    161d:	4e 8d 0c dd 00 00 00 	lea    0x0(,%r11,8),%r9
    1624:	00 
    1625:	4c 8d 5e fe          	lea    -0x2(%rsi),%r11
    1629:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
    162e:	4c 89 5c 24 18       	mov    %r11,0x18(%rsp)
    1633:	4e 8d 04 e8          	lea    (%rax,%r13,8),%r8
    1637:	4c 01 cb             	add    %r9,%rbx
    163a:	4c 89 ca             	mov    %r9,%rdx
    163d:	48 8b 44 24 a8       	mov    -0x58(%rsp),%rax
    1642:	4c 8b 5c 24 08       	mov    0x8(%rsp),%r11
    1647:	48 f7 da             	neg    %rdx
    164a:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
    164f:	4c 29 fa             	sub    %r15,%rdx
    1652:	4b 8d 1c 2e          	lea    (%r14,%r13,1),%rbx
    1656:	49 01 c1             	add    %rax,%r9
    1659:	4c 89 d8             	mov    %r11,%rax
    165c:	48 8d 52 f0          	lea    -0x10(%rdx),%rdx
    1660:	49 83 e3 fc          	and    $0xfffffffffffffffc,%r11
    1664:	48 c1 e8 02          	shr    $0x2,%rax
    1668:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
    166d:	4c 01 de             	add    %r11,%rsi
    1670:	48 89 df             	mov    %rbx,%rdi
    1673:	48 c1 e0 05          	shl    $0x5,%rax
    1677:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
    167c:	4c 89 5c 24 e8       	mov    %r11,-0x18(%rsp)
    1681:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    1686:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
    168b:	4c 29 da             	sub    %r11,%rdx
    168e:	48 89 5c 24 d8       	mov    %rbx,-0x28(%rsp)
    1693:	48 ff c8             	dec    %rax
    1696:	4c 8d 5a ff          	lea    -0x1(%rdx),%r11
    169a:	48 89 14 24          	mov    %rdx,(%rsp)
    169e:	48 89 44 24 e0       	mov    %rax,-0x20(%rsp)
    16a3:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    16a8:	4c 89 5c 24 f8       	mov    %r11,-0x8(%rsp)
    16ad:	83 e0 03             	and    $0x3,%eax
    16b0:	48 89 74 24 f0       	mov    %rsi,-0x10(%rsp)
    16b5:	4c 89 e6             	mov    %r12,%rsi
    16b8:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    16bd:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    16c2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    16c8:	48 8b 5c 24 50       	mov    0x50(%rsp),%rbx
    16cd:	c4 c1 7b 10 4c 24 f8 	vmovsd -0x8(%r12),%xmm1
    16d4:	c5 fb 10 40 f8       	vmovsd -0x8(%rax),%xmm0
    16d9:	48 83 7c 24 60 02    	cmpq   $0x2,0x60(%rsp)
    16df:	c5 fb 5e 2b          	vdivsd (%rbx),%xmm0,%xmm5
    16e3:	c4 e2 d1 ad 0e       	vfnmadd213sd (%rsi),%xmm5,%xmm1
    16e8:	c5 fb 11 0e          	vmovsd %xmm1,(%rsi)
    16ec:	0f 84 66 04 00 00    	je     1b58 <gauss+0x608>
    16f2:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    16f7:	4c 8d 1c 02          	lea    (%rdx,%rax,1),%r11
    16fb:	48 89 c2             	mov    %rax,%rdx
    16fe:	49 83 fb 10          	cmp    $0x10,%r11
    1702:	0f 87 e8 01 00 00    	ja     18f0 <gauss+0x3a0>
    1708:	4d 89 c3             	mov    %r8,%r11
    170b:	49 29 c3             	sub    %rax,%r11
    170e:	49 83 eb 08          	sub    $0x8,%r11
    1712:	49 c1 eb 03          	shr    $0x3,%r11
    1716:	49 ff c3             	inc    %r11
    1719:	41 83 e3 07          	and    $0x7,%r11d
    171d:	0f 84 b5 00 00 00    	je     17d8 <gauss+0x288>
    1723:	49 83 fb 01          	cmp    $0x1,%r11
    1727:	0f 84 8f 00 00 00    	je     17bc <gauss+0x26c>
    172d:	49 83 fb 02          	cmp    $0x2,%r11
    1731:	74 76                	je     17a9 <gauss+0x259>
    1733:	49 83 fb 03          	cmp    $0x3,%r11
    1737:	74 5d                	je     1796 <gauss+0x246>
    1739:	49 83 fb 04          	cmp    $0x4,%r11
    173d:	74 44                	je     1783 <gauss+0x233>
    173f:	49 83 fb 05          	cmp    $0x5,%r11
    1743:	74 2b                	je     1770 <gauss+0x220>
    1745:	49 83 fb 06          	cmp    $0x6,%r11
    1749:	74 12                	je     175d <gauss+0x20d>
    174b:	c5 fb 10 3c c8       	vmovsd (%rax,%rcx,8),%xmm7
    1750:	c4 e2 d1 ad 38       	vfnmadd213sd (%rax),%xmm5,%xmm7
    1755:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1759:	c5 fb 11 38          	vmovsd %xmm7,(%rax)
    175d:	c5 7b 10 04 ca       	vmovsd (%rdx,%rcx,8),%xmm8
    1762:	c4 62 d1 ad 02       	vfnmadd213sd (%rdx),%xmm5,%xmm8
    1767:	48 83 c2 08          	add    $0x8,%rdx
    176b:	c5 7b 11 42 f8       	vmovsd %xmm8,-0x8(%rdx)
    1770:	c5 7b 10 0c ca       	vmovsd (%rdx,%rcx,8),%xmm9
    1775:	c4 62 d1 ad 0a       	vfnmadd213sd (%rdx),%xmm5,%xmm9
    177a:	48 83 c2 08          	add    $0x8,%rdx
    177e:	c5 7b 11 4a f8       	vmovsd %xmm9,-0x8(%rdx)
    1783:	c5 7b 10 14 ca       	vmovsd (%rdx,%rcx,8),%xmm10
    1788:	c4 62 d1 ad 12       	vfnmadd213sd (%rdx),%xmm5,%xmm10
    178d:	48 83 c2 08          	add    $0x8,%rdx
    1791:	c5 7b 11 52 f8       	vmovsd %xmm10,-0x8(%rdx)
    1796:	c5 7b 10 1c ca       	vmovsd (%rdx,%rcx,8),%xmm11
    179b:	c4 62 d1 ad 1a       	vfnmadd213sd (%rdx),%xmm5,%xmm11
    17a0:	48 83 c2 08          	add    $0x8,%rdx
    17a4:	c5 7b 11 5a f8       	vmovsd %xmm11,-0x8(%rdx)
    17a9:	c5 7b 10 24 ca       	vmovsd (%rdx,%rcx,8),%xmm12
    17ae:	c4 62 d1 ad 22       	vfnmadd213sd (%rdx),%xmm5,%xmm12
    17b3:	48 83 c2 08          	add    $0x8,%rdx
    17b7:	c5 7b 11 62 f8       	vmovsd %xmm12,-0x8(%rdx)
    17bc:	c5 7b 10 2c ca       	vmovsd (%rdx,%rcx,8),%xmm13
    17c1:	c4 62 d1 ad 2a       	vfnmadd213sd (%rdx),%xmm5,%xmm13
    17c6:	48 83 c2 08          	add    $0x8,%rdx
    17ca:	c5 7b 11 6a f8       	vmovsd %xmm13,-0x8(%rdx)
    17cf:	4c 39 c2             	cmp    %r8,%rdx
    17d2:	0f 84 98 00 00 00    	je     1870 <gauss+0x320>
    17d8:	c5 7b 10 34 ca       	vmovsd (%rdx,%rcx,8),%xmm14
    17dd:	c4 62 d1 ad 32       	vfnmadd213sd (%rdx),%xmm5,%xmm14
    17e2:	c5 7b 11 32          	vmovsd %xmm14,(%rdx)
    17e6:	c5 7b 10 7c ca 08    	vmovsd 0x8(%rdx,%rcx,8),%xmm15
    17ec:	c4 62 d1 ad 7a 08    	vfnmadd213sd 0x8(%rdx),%xmm5,%xmm15
    17f2:	c5 7b 11 7a 08       	vmovsd %xmm15,0x8(%rdx)
    17f7:	c5 fb 10 44 ca 10    	vmovsd 0x10(%rdx,%rcx,8),%xmm0
    17fd:	c4 e2 d1 ad 42 10    	vfnmadd213sd 0x10(%rdx),%xmm5,%xmm0
    1803:	c5 fb 11 42 10       	vmovsd %xmm0,0x10(%rdx)
    1808:	c5 fb 10 4c ca 18    	vmovsd 0x18(%rdx,%rcx,8),%xmm1
    180e:	c4 e2 d1 ad 4a 18    	vfnmadd213sd 0x18(%rdx),%xmm5,%xmm1
    1814:	c5 fb 11 4a 18       	vmovsd %xmm1,0x18(%rdx)
    1819:	c5 fb 10 54 ca 20    	vmovsd 0x20(%rdx,%rcx,8),%xmm2
    181f:	c4 e2 d1 ad 52 20    	vfnmadd213sd 0x20(%rdx),%xmm5,%xmm2
    1825:	c5 fb 11 52 20       	vmovsd %xmm2,0x20(%rdx)
    182a:	c5 fb 10 5c ca 28    	vmovsd 0x28(%rdx,%rcx,8),%xmm3
    1830:	c4 e2 d1 ad 5a 28    	vfnmadd213sd 0x28(%rdx),%xmm5,%xmm3
    1836:	c5 fb 11 5a 28       	vmovsd %xmm3,0x28(%rdx)
    183b:	c5 fb 10 64 ca 30    	vmovsd 0x30(%rdx,%rcx,8),%xmm4
    1841:	c4 e2 d1 ad 62 30    	vfnmadd213sd 0x30(%rdx),%xmm5,%xmm4
    1847:	c5 fb 11 62 30       	vmovsd %xmm4,0x30(%rdx)
    184c:	c5 fb 10 74 ca 38    	vmovsd 0x38(%rdx,%rcx,8),%xmm6
    1852:	48 83 c2 40          	add    $0x40,%rdx
    1856:	c4 e2 d1 ad 72 f8    	vfnmadd213sd -0x8(%rdx),%xmm5,%xmm6
    185c:	c5 fb 11 72 f8       	vmovsd %xmm6,-0x8(%rdx)
    1861:	4c 39 c2             	cmp    %r8,%rdx
    1864:	0f 85 6e ff ff ff    	jne    17d8 <gauss+0x288>
    186a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1870:	48 83 c6 08          	add    $0x8,%rsi
    1874:	4c 01 d0             	add    %r10,%rax
    1877:	4c 01 f7             	add    %r14,%rdi
    187a:	4c 29 f1             	sub    %r14,%rcx
    187d:	4d 01 d0             	add    %r10,%r8
    1880:	48 39 74 24 38       	cmp    %rsi,0x38(%rsp)
    1885:	0f 85 3d fe ff ff    	jne    16c8 <gauss+0x178>
    188b:	4c 8b 6c 24 d8       	mov    -0x28(%rsp),%r13
    1890:	48 8b 7c 24 e0       	mov    -0x20(%rsp),%rdi
    1895:	4c 8b 4c 24 c0       	mov    -0x40(%rsp),%r9
    189a:	49 83 c4 08          	add    $0x8,%r12
    189e:	48 8b 4c 24 d0       	mov    -0x30(%rsp),%rcx
    18a3:	4c 01 4c 24 50       	add    %r9,0x50(%rsp)
    18a8:	48 ff 4c 24 08       	decq   0x8(%rsp)
    18ad:	4c 8b 44 24 c8       	mov    -0x38(%rsp),%r8
    18b2:	48 01 4c 24 28       	add    %rcx,0x28(%rsp)
    18b7:	48 89 7c 24 60       	mov    %rdi,0x60(%rsp)
    18bc:	4c 39 44 24 58       	cmp    %r8,0x58(%rsp)
    18c1:	0f 85 29 fd ff ff    	jne    15f0 <gauss+0xa0>
    18c7:	48 8b 74 24 a0       	mov    -0x60(%rsp),%rsi
    18cc:	c5 f8 77             	vzeroupper
    18cf:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    18d3:	4c 89 f2             	mov    %r14,%rdx
    18d6:	4c 89 ff             	mov    %r15,%rdi
    18d9:	5b                   	pop    %rbx
    18da:	41 5c                	pop    %r12
    18dc:	41 5d                	pop    %r13
    18de:	41 5e                	pop    %r14
    18e0:	41 5f                	pop    %r15
    18e2:	5d                   	pop    %rbp
    18e3:	e9 c8 f9 ff ff       	jmp    12b0 <remontee>
    18e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    18ef:	00 
    18f0:	48 83 7c 24 18 02    	cmpq   $0x2,0x18(%rsp)
    18f6:	0f 86 64 02 00 00    	jbe    1b60 <gauss+0x610>
    18fc:	4c 8b 5c 24 40       	mov    0x40(%rsp),%r11
    1901:	c4 e2 7d 19 dd       	vbroadcastsd %xmm5,%ymm3
    1906:	31 d2                	xor    %edx,%edx
    1908:	49 8d 5b e0          	lea    -0x20(%r11),%rbx
    190c:	48 c1 eb 05          	shr    $0x5,%rbx
    1910:	48 ff c3             	inc    %rbx
    1913:	83 e3 07             	and    $0x7,%ebx
    1916:	0f 84 c7 00 00 00    	je     19e3 <gauss+0x493>
    191c:	48 83 fb 01          	cmp    $0x1,%rbx
    1920:	0f 84 9a 00 00 00    	je     19c0 <gauss+0x470>
    1926:	48 83 fb 02          	cmp    $0x2,%rbx
    192a:	74 7f                	je     19ab <gauss+0x45b>
    192c:	48 83 fb 03          	cmp    $0x3,%rbx
    1930:	74 64                	je     1996 <gauss+0x446>
    1932:	48 83 fb 04          	cmp    $0x4,%rbx
    1936:	74 49                	je     1981 <gauss+0x431>
    1938:	48 83 fb 05          	cmp    $0x5,%rbx
    193c:	74 2e                	je     196c <gauss+0x41c>
    193e:	48 83 fb 06          	cmp    $0x6,%rbx
    1942:	74 13                	je     1957 <gauss+0x407>
    1944:	c4 c1 7d 10 11       	vmovupd (%r9),%ymm2
    1949:	c4 e2 e5 ac 10       	vfnmadd213pd (%rax),%ymm3,%ymm2
    194e:	ba 20 00 00 00       	mov    $0x20,%edx
    1953:	c5 fd 11 10          	vmovupd %ymm2,(%rax)
    1957:	c4 c1 7d 10 24 11    	vmovupd (%r9,%rdx,1),%ymm4
    195d:	c4 e2 e5 ac 24 10    	vfnmadd213pd (%rax,%rdx,1),%ymm3,%ymm4
    1963:	c5 fd 11 24 10       	vmovupd %ymm4,(%rax,%rdx,1)
    1968:	48 83 c2 20          	add    $0x20,%rdx
    196c:	c4 c1 7d 10 34 11    	vmovupd (%r9,%rdx,1),%ymm6
    1972:	c4 e2 e5 ac 34 10    	vfnmadd213pd (%rax,%rdx,1),%ymm3,%ymm6
    1978:	c5 fd 11 34 10       	vmovupd %ymm6,(%rax,%rdx,1)
    197d:	48 83 c2 20          	add    $0x20,%rdx
    1981:	c4 c1 7d 10 3c 11    	vmovupd (%r9,%rdx,1),%ymm7
    1987:	c4 e2 e5 ac 3c 10    	vfnmadd213pd (%rax,%rdx,1),%ymm3,%ymm7
    198d:	c5 fd 11 3c 10       	vmovupd %ymm7,(%rax,%rdx,1)
    1992:	48 83 c2 20          	add    $0x20,%rdx
    1996:	c4 41 7d 10 04 11    	vmovupd (%r9,%rdx,1),%ymm8
    199c:	c4 62 e5 ac 04 10    	vfnmadd213pd (%rax,%rdx,1),%ymm3,%ymm8
    19a2:	c5 7d 11 04 10       	vmovupd %ymm8,(%rax,%rdx,1)
    19a7:	48 83 c2 20          	add    $0x20,%rdx
    19ab:	c4 41 7d 10 0c 11    	vmovupd (%r9,%rdx,1),%ymm9
    19b1:	c4 62 e5 ac 0c 10    	vfnmadd213pd (%rax,%rdx,1),%ymm3,%ymm9
    19b7:	c5 7d 11 0c 10       	vmovupd %ymm9,(%rax,%rdx,1)
    19bc:	48 83 c2 20          	add    $0x20,%rdx
    19c0:	c4 41 7d 10 14 11    	vmovupd (%r9,%rdx,1),%ymm10
    19c6:	c4 62 e5 ac 14 10    	vfnmadd213pd (%rax,%rdx,1),%ymm3,%ymm10
    19cc:	4c 8b 5c 24 40       	mov    0x40(%rsp),%r11
    19d1:	c5 7d 11 14 10       	vmovupd %ymm10,(%rax,%rdx,1)
    19d6:	48 83 c2 20          	add    $0x20,%rdx
    19da:	4c 39 da             	cmp    %r11,%rdx
    19dd:	0f 84 d6 00 00 00    	je     1ab9 <gauss+0x569>
    19e3:	c4 41 7d 10 1c 11    	vmovupd (%r9,%rdx,1),%ymm11
    19e9:	c4 62 e5 ac 1c 10    	vfnmadd213pd (%rax,%rdx,1),%ymm3,%ymm11
    19ef:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
    19f4:	c5 7d 11 1c 10       	vmovupd %ymm11,(%rax,%rdx,1)
    19f9:	c4 41 7d 10 64 11 20 	vmovupd 0x20(%r9,%rdx,1),%ymm12
    1a00:	c4 62 e5 ac 64 10 20 	vfnmadd213pd 0x20(%rax,%rdx,1),%ymm3,%ymm12
    1a07:	c5 7d 11 64 10 20    	vmovupd %ymm12,0x20(%rax,%rdx,1)
    1a0d:	c4 41 7d 10 6c 11 40 	vmovupd 0x40(%r9,%rdx,1),%ymm13
    1a14:	c4 62 e5 ac 6c 10 40 	vfnmadd213pd 0x40(%rax,%rdx,1),%ymm3,%ymm13
    1a1b:	c5 7d 11 6c 10 40    	vmovupd %ymm13,0x40(%rax,%rdx,1)
    1a21:	c4 41 7d 10 74 11 60 	vmovupd 0x60(%r9,%rdx,1),%ymm14
    1a28:	c4 62 e5 ac 74 10 60 	vfnmadd213pd 0x60(%rax,%rdx,1),%ymm3,%ymm14
    1a2f:	c5 7d 11 74 10 60    	vmovupd %ymm14,0x60(%rax,%rdx,1)
    1a35:	c4 41 7d 10 bc 11 80 	vmovupd 0x80(%r9,%rdx,1),%ymm15
    1a3c:	00 00 00 
    1a3f:	c4 62 e5 ac bc 10 80 	vfnmadd213pd 0x80(%rax,%rdx,1),%ymm3,%ymm15
    1a46:	00 00 00 
    1a49:	c5 7d 11 bc 10 80 00 	vmovupd %ymm15,0x80(%rax,%rdx,1)
    1a50:	00 00 
    1a52:	c4 c1 7d 10 84 11 a0 	vmovupd 0xa0(%r9,%rdx,1),%ymm0
    1a59:	00 00 00 
    1a5c:	c4 e2 e5 ac 84 10 a0 	vfnmadd213pd 0xa0(%rax,%rdx,1),%ymm3,%ymm0
    1a63:	00 00 00 
    1a66:	c5 fd 11 84 10 a0 00 	vmovupd %ymm0,0xa0(%rax,%rdx,1)
    1a6d:	00 00 
    1a6f:	c4 c1 7d 10 8c 11 c0 	vmovupd 0xc0(%r9,%rdx,1),%ymm1
    1a76:	00 00 00 
    1a79:	c4 e2 e5 ac 8c 10 c0 	vfnmadd213pd 0xc0(%rax,%rdx,1),%ymm3,%ymm1
    1a80:	00 00 00 
    1a83:	c5 fd 11 8c 10 c0 00 	vmovupd %ymm1,0xc0(%rax,%rdx,1)
    1a8a:	00 00 
    1a8c:	c4 c1 7d 10 94 11 e0 	vmovupd 0xe0(%r9,%rdx,1),%ymm2
    1a93:	00 00 00 
    1a96:	c4 e2 e5 ac 94 10 e0 	vfnmadd213pd 0xe0(%rax,%rdx,1),%ymm3,%ymm2
    1a9d:	00 00 00 
    1aa0:	c5 fd 11 94 10 e0 00 	vmovupd %ymm2,0xe0(%rax,%rdx,1)
    1aa7:	00 00 
    1aa9:	48 81 c2 00 01 00 00 	add    $0x100,%rdx
    1ab0:	48 39 da             	cmp    %rbx,%rdx
    1ab3:	0f 85 2a ff ff ff    	jne    19e3 <gauss+0x493>
    1ab9:	48 83 7c 24 10 00    	cmpq   $0x0,0x10(%rsp)
    1abf:	0f 84 ab fd ff ff    	je     1870 <gauss+0x320>
    1ac5:	48 8b 54 24 f8       	mov    -0x8(%rsp),%rdx
    1aca:	48 83 3c 24 02       	cmpq   $0x2,(%rsp)
    1acf:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    1ad4:	0f 84 a1 00 00 00    	je     1b7b <gauss+0x62b>
    1ada:	4c 8b 5c 24 f0       	mov    -0x10(%rsp),%r11
    1adf:	48 8b 5c 24 e8       	mov    -0x18(%rsp),%rbx
    1ae4:	4c 89 5c 24 20       	mov    %r11,0x20(%rsp)
    1ae9:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
    1aee:	c5 fb 12 dd          	vmovddup %xmm5,%xmm3
    1af2:	48 01 fa             	add    %rdi,%rdx
    1af5:	48 01 da             	add    %rbx,%rdx
    1af8:	4d 8d 1c d7          	lea    (%r15,%rdx,8),%r11
    1afc:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
    1b01:	c4 c1 79 10 23       	vmovupd (%r11),%xmm4
    1b06:	48 8d 5c 13 01       	lea    0x1(%rbx,%rdx,1),%rbx
    1b0b:	c4 c2 d9 9c 1c df    	vfnmadd132pd (%r15,%rbx,8),%xmm4,%xmm3
    1b11:	c4 c1 79 11 1b       	vmovupd %xmm3,(%r11)
    1b16:	4c 8b 5c 24 30       	mov    0x30(%rsp),%r11
    1b1b:	41 f6 c3 01          	test   $0x1,%r11b
    1b1f:	0f 84 4b fd ff ff    	je     1870 <gauss+0x320>
    1b25:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
    1b2a:	4c 89 da             	mov    %r11,%rdx
    1b2d:	48 83 e2 fe          	and    $0xfffffffffffffffe,%rdx
    1b31:	48 01 da             	add    %rbx,%rdx
    1b34:	4c 8d 1c 17          	lea    (%rdi,%rdx,1),%r11
    1b38:	4c 01 ea             	add    %r13,%rdx
    1b3b:	4b 8d 1c df          	lea    (%r15,%r11,8),%rbx
    1b3f:	c5 fb 10 33          	vmovsd (%rbx),%xmm6
    1b43:	c4 c2 c9 9d 2c d7    	vfnmadd132sd (%r15,%rdx,8),%xmm6,%xmm5
    1b49:	c5 fb 11 2b          	vmovsd %xmm5,(%rbx)
    1b4d:	e9 1e fd ff ff       	jmp    1870 <gauss+0x320>
    1b52:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1b58:	48 89 c2             	mov    %rax,%rdx
    1b5b:	e9 a8 fb ff ff       	jmp    1708 <gauss+0x1b8>
    1b60:	48 8b 5c 24 e0       	mov    -0x20(%rsp),%rbx
    1b65:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
    1b6a:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
    1b6f:	31 db                	xor    %ebx,%ebx
    1b71:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    1b76:	e9 6e ff ff ff       	jmp    1ae9 <gauss+0x599>
    1b7b:	48 8b 54 24 f0       	mov    -0x10(%rsp),%rdx
    1b80:	eb b2                	jmp    1b34 <gauss+0x5e4>
    1b82:	4c 8b 4c 24 60       	mov    0x60(%rsp),%r9
    1b87:	4f 8d 2c 2e          	lea    (%r14,%r13,1),%r13
    1b8b:	49 ff c9             	dec    %r9
    1b8e:	4c 89 4c 24 e0       	mov    %r9,-0x20(%rsp)
    1b93:	e9 f8 fc ff ff       	jmp    1890 <gauss+0x340>

Déassemblage de la section .fini :

0000000000001b98 <_fini>:
    1b98:	f3 0f 1e fa          	endbr64
    1b9c:	48 83 ec 08          	sub    $0x8,%rsp
    1ba0:	48 83 c4 08          	add    $0x8,%rsp
    1ba4:	c3                   	ret
