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

