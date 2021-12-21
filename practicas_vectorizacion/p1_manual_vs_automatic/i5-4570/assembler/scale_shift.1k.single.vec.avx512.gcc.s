
scale_shift.1k.single.vec.avx512.gcc:     formato del fichero elf64-x86-64


Desensamblado de la sección .init:

0000000000400470 <_init>:
  400470:	48 83 ec 08          	sub    $0x8,%rsp
  400474:	48 8b 05 7d 1b 20 00 	mov    0x201b7d(%rip),%rax        # 601ff8 <__gmon_start__>
  40047b:	48 85 c0             	test   %rax,%rax
  40047e:	74 05                	je     400485 <_init+0x15>
  400480:	e8 6b 00 00 00       	callq  4004f0 <.plt.got>
  400485:	48 83 c4 08          	add    $0x8,%rsp
  400489:	c3                   	retq   

Desensamblado de la sección .plt:

0000000000400490 <.plt>:
  400490:	ff 35 72 1b 20 00    	pushq  0x201b72(%rip)        # 602008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400496:	ff 25 74 1b 20 00    	jmpq   *0x201b74(%rip)        # 602010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40049c:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004004a0 <puts@plt>:
  4004a0:	ff 25 72 1b 20 00    	jmpq   *0x201b72(%rip)        # 602018 <puts@GLIBC_2.2.5>
  4004a6:	68 00 00 00 00       	pushq  $0x0
  4004ab:	e9 e0 ff ff ff       	jmpq   400490 <.plt>

00000000004004b0 <printf@plt>:
  4004b0:	ff 25 6a 1b 20 00    	jmpq   *0x201b6a(%rip)        # 602020 <printf@GLIBC_2.2.5>
  4004b6:	68 01 00 00 00       	pushq  $0x1
  4004bb:	e9 d0 ff ff ff       	jmpq   400490 <.plt>

00000000004004c0 <gettimeofday@plt>:
  4004c0:	ff 25 62 1b 20 00    	jmpq   *0x201b62(%rip)        # 602028 <gettimeofday@GLIBC_2.2.5>
  4004c6:	68 02 00 00 00       	pushq  $0x2
  4004cb:	e9 c0 ff ff ff       	jmpq   400490 <.plt>

00000000004004d0 <__libc_start_main@plt>:
  4004d0:	ff 25 5a 1b 20 00    	jmpq   *0x201b5a(%rip)        # 602030 <__libc_start_main@GLIBC_2.2.5>
  4004d6:	68 03 00 00 00       	pushq  $0x3
  4004db:	e9 b0 ff ff ff       	jmpq   400490 <.plt>

00000000004004e0 <exit@plt>:
  4004e0:	ff 25 52 1b 20 00    	jmpq   *0x201b52(%rip)        # 602038 <exit@GLIBC_2.2.5>
  4004e6:	68 04 00 00 00       	pushq  $0x4
  4004eb:	e9 a0 ff ff ff       	jmpq   400490 <.plt>

Desensamblado de la sección .plt.got:

00000000004004f0 <.plt.got>:
  4004f0:	ff 25 02 1b 20 00    	jmpq   *0x201b02(%rip)        # 601ff8 <__gmon_start__>
  4004f6:	66 90                	xchg   %ax,%ax

Desensamblado de la sección .text:

0000000000400500 <main>:
  check(x);
  return 0;
}

int main()
{
  400500:	48 83 ec 08          	sub    $0x8,%rsp
  // printf("LEN: %u, NTIMES: %lu\n\n", LEN, NTIMES);
  printf("                     Time    TPI\n");
  400504:	bf 48 0a 40 00       	mov    $0x400a48,%edi
  400509:	e8 92 ff ff ff       	callq  4004a0 <puts@plt>
  printf("              Loop    ns     ps/el     Checksum \n");
  40050e:	bf 70 0a 40 00       	mov    $0x400a70,%edi
  400513:	e8 88 ff ff ff       	callq  4004a0 <puts@plt>
  scale_shift();
  400518:	31 c0                	xor    %eax,%eax
  40051a:	e8 d1 01 00 00       	callq  4006f0 <scale_shift>
  ss_intr_SSE();
  40051f:	31 c0                	xor    %eax,%eax
  400521:	e8 aa 02 00 00       	callq  4007d0 <ss_intr_SSE>
  ss_intr_AVX();
  400526:	31 c0                	xor    %eax,%eax
  400528:	e8 53 03 00 00       	callq  400880 <ss_intr_AVX>
  exit(0);
  40052d:	31 ff                	xor    %edi,%edi
  40052f:	e8 ac ff ff ff       	callq  4004e0 <exit@plt>

0000000000400534 <_start>:
  400534:	31 ed                	xor    %ebp,%ebp
  400536:	49 89 d1             	mov    %rdx,%r9
  400539:	5e                   	pop    %rsi
  40053a:	48 89 e2             	mov    %rsp,%rdx
  40053d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  400541:	50                   	push   %rax
  400542:	54                   	push   %rsp
  400543:	49 c7 c0 c0 09 40 00 	mov    $0x4009c0,%r8
  40054a:	48 c7 c1 50 09 40 00 	mov    $0x400950,%rcx
  400551:	48 c7 c7 00 05 40 00 	mov    $0x400500,%rdi
  400558:	e8 73 ff ff ff       	callq  4004d0 <__libc_start_main@plt>
  40055d:	f4                   	hlt    
  40055e:	66 90                	xchg   %ax,%ax

0000000000400560 <deregister_tm_clones>:
  400560:	b8 50 20 60 00       	mov    $0x602050,%eax
  400565:	48 3d 50 20 60 00    	cmp    $0x602050,%rax
  40056b:	74 13                	je     400580 <deregister_tm_clones+0x20>
  40056d:	b8 00 00 00 00       	mov    $0x0,%eax
  400572:	48 85 c0             	test   %rax,%rax
  400575:	74 09                	je     400580 <deregister_tm_clones+0x20>
  400577:	bf 50 20 60 00       	mov    $0x602050,%edi
  40057c:	ff e0                	jmpq   *%rax
  40057e:	66 90                	xchg   %ax,%ax
  400580:	c3                   	retq   
  400581:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400586:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40058d:	00 00 00 

0000000000400590 <register_tm_clones>:
  400590:	be 50 20 60 00       	mov    $0x602050,%esi
  400595:	48 81 ee 50 20 60 00 	sub    $0x602050,%rsi
  40059c:	48 89 f0             	mov    %rsi,%rax
  40059f:	48 c1 ee 3f          	shr    $0x3f,%rsi
  4005a3:	48 c1 f8 03          	sar    $0x3,%rax
  4005a7:	48 01 c6             	add    %rax,%rsi
  4005aa:	48 d1 fe             	sar    %rsi
  4005ad:	74 11                	je     4005c0 <register_tm_clones+0x30>
  4005af:	b8 00 00 00 00       	mov    $0x0,%eax
  4005b4:	48 85 c0             	test   %rax,%rax
  4005b7:	74 07                	je     4005c0 <register_tm_clones+0x30>
  4005b9:	bf 50 20 60 00       	mov    $0x602050,%edi
  4005be:	ff e0                	jmpq   *%rax
  4005c0:	c3                   	retq   
  4005c1:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4005c6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4005cd:	00 00 00 

00000000004005d0 <__do_global_dtors_aux>:
  4005d0:	80 3d a9 1a 20 00 00 	cmpb   $0x0,0x201aa9(%rip)        # 602080 <completed.7338>
  4005d7:	75 17                	jne    4005f0 <__do_global_dtors_aux+0x20>
  4005d9:	55                   	push   %rbp
  4005da:	48 89 e5             	mov    %rsp,%rbp
  4005dd:	e8 7e ff ff ff       	callq  400560 <deregister_tm_clones>
  4005e2:	5d                   	pop    %rbp
  4005e3:	c6 05 96 1a 20 00 01 	movb   $0x1,0x201a96(%rip)        # 602080 <completed.7338>
  4005ea:	c3                   	retq   
  4005eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4005f0:	c3                   	retq   
  4005f1:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4005f6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4005fd:	00 00 00 

0000000000400600 <frame_dummy>:
  400600:	eb 8e                	jmp    400590 <register_tm_clones>

0000000000400602 <dummy>:
  400602:	55                   	push   %rbp
  400603:	48 89 e5             	mov    %rsp,%rbp
  400606:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  40060a:	f3 0f 11 45 f4       	movss  %xmm0,-0xc(%rbp)
  40060f:	f3 0f 11 4d f0       	movss  %xmm1,-0x10(%rbp)
  400614:	b8 00 00 00 00       	mov    $0x0,%eax
  400619:	5d                   	pop    %rbp
  40061a:	c3                   	retq   
  40061b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000400620 <get_wall_time>:
{
  400620:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  400624:	31 f6                	xor    %esi,%esi
  400626:	48 89 e7             	mov    %rsp,%rdi
  400629:	e8 92 fe ff ff       	callq  4004c0 <gettimeofday@plt>
  40062e:	85 c0                	test   %eax,%eax
  400630:	75 22                	jne    400654 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  400632:	c5 e8 57 d2          	vxorps %xmm2,%xmm2,%xmm2
  400636:	c4 e1 eb 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm2,%xmm0
  40063d:	c5 fb 59 0d 63 04 00 	vmulsd 0x463(%rip),%xmm0,%xmm1        # 400aa8 <_IO_stdin_used+0xa8>
  400644:	00 
  400645:	c4 e1 eb 2a 04 24    	vcvtsi2sdq (%rsp),%xmm2,%xmm0
}
  40064b:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  40064f:	c5 f3 58 c0          	vaddsd %xmm0,%xmm1,%xmm0
}
  400653:	c3                   	retq   
        exit(-1); // return 0;
  400654:	83 cf ff             	or     $0xffffffff,%edi
  400657:	e8 84 fe ff ff       	callq  4004e0 <exit@plt>
  40065c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400660 <check>:
    for (unsigned int i = 0; i < LEN; i++)
  400660:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
    real sum = 0;
  400667:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40066b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
        sum += arr[i];
  400670:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  400674:	48 83 c7 04          	add    $0x4,%rdi
  400678:	48 39 f8             	cmp    %rdi,%rax
  40067b:	75 f3                	jne    400670 <check+0x10>
    printf("%f \n", sum);
  40067d:	bf 04 0a 40 00       	mov    $0x400a04,%edi
  400682:	b8 01 00 00 00       	mov    $0x1,%eax
  400687:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40068b:	e9 20 fe ff ff       	jmpq   4004b0 <printf@plt>

0000000000400690 <init>:
    for (int j = 0; j < LEN; j++)
  400690:	c5 fa 10 05 28 04 00 	vmovss 0x428(%rip),%xmm0        # 400ac0 <_IO_stdin_used+0xc0>
  400697:	00 
  400698:	b8 c0 20 60 00       	mov    $0x6020c0,%eax
  40069d:	0f 1f 00             	nopl   (%rax)
	    x[j] = 1.0;
  4006a0:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (int j = 0; j < LEN; j++)
  4006a4:	48 83 c0 04          	add    $0x4,%rax
  4006a8:	48 3d c0 30 60 00    	cmp    $0x6030c0,%rax
  4006ae:	75 f0                	jne    4006a0 <init+0x10>
}
  4006b0:	31 c0                	xor    %eax,%eax
  4006b2:	c3                   	retq   
  4006b3:	0f 1f 00             	nopl   (%rax)
  4006b6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4006bd:	00 00 00 

00000000004006c0 <results>:
{
  4006c0:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %5.1f    %5.1f     ",
  4006c3:	b8 02 00 00 00       	mov    $0x2,%eax
  4006c8:	bf 09 0a 40 00       	mov    $0x400a09,%edi
  4006cd:	c5 fb 5e 15 e3 03 00 	vdivsd 0x3e3(%rip),%xmm0,%xmm2        # 400ab8 <_IO_stdin_used+0xb8>
  4006d4:	00 
  4006d5:	c5 fb 5e 0d d3 03 00 	vdivsd 0x3d3(%rip),%xmm0,%xmm1        # 400ab0 <_IO_stdin_used+0xb0>
  4006dc:	00 
  4006dd:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  4006e1:	e9 ca fd ff ff       	jmpq   4004b0 <printf@plt>
  4006e6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4006ed:	00 00 00 

00000000004006f0 <scale_shift>:
{
  4006f0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4006f5:	48 83 e4 c0          	and    $0xffffffffffffffc0,%rsp
    init();
  4006f9:	31 c0                	xor    %eax,%eax
{
  4006fb:	41 ff 72 f8          	pushq  -0x8(%r10)
  4006ff:	55                   	push   %rbp
  400700:	48 89 e5             	mov    %rsp,%rbp
  400703:	41 54                	push   %r12
    start_t = get_wall_time();
  400705:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  40070b:	41 52                	push   %r10
  40070d:	53                   	push   %rbx
  40070e:	bb c0 30 60 00       	mov    $0x6030c0,%ebx
  400713:	48 83 ec 58          	sub    $0x58,%rsp
    init();
  400717:	e8 74 ff ff ff       	callq  400690 <init>
    start_t = get_wall_time();
  40071c:	31 c0                	xor    %eax,%eax
  40071e:	e8 fd fe ff ff       	callq  400620 <get_wall_time>
  400723:	62 f1 7c 48 28 1d d3 	vmovaps 0x3d3(%rip),%zmm3        # 400b00 <_IO_stdin_used+0x100>
  40072a:	03 00 00 
  40072d:	62 f1 7c 48 28 15 09 	vmovaps 0x409(%rip),%zmm2        # 400b40 <_IO_stdin_used+0x140>
  400734:	04 00 00 
  400737:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
        for (unsigned int i = 0; i < LEN; i++)
  40073c:	b8 c0 20 60 00       	mov    $0x6020c0,%eax
  400741:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
            x[i] = alpha*x[i] + beta;
  400748:	62 f1 64 48 59 00    	vmulps (%rax),%zmm3,%zmm0
  40074e:	48 83 c0 40          	add    $0x40,%rax
  400752:	62 f1 7c 48 58 c2    	vaddps %zmm2,%zmm0,%zmm0
  400758:	62 f1 7c 48 29 40 ff 	vmovaps %zmm0,-0x40(%rax)
        for (unsigned int i = 0; i < LEN; i++)
  40075f:	48 39 c3             	cmp    %rax,%rbx
  400762:	75 e4                	jne    400748 <scale_shift+0x58>
        dummy(x, alpha, beta);
  400764:	c5 fa 10 0d 58 03 00 	vmovss 0x358(%rip),%xmm1        # 400ac4 <_IO_stdin_used+0xc4>
  40076b:	00 
  40076c:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400771:	c5 fa 10 05 4f 03 00 	vmovss 0x34f(%rip),%xmm0        # 400ac8 <_IO_stdin_used+0xc8>
  400778:	00 
  400779:	c5 f8 77             	vzeroupper 
  40077c:	e8 81 fe ff ff       	callq  400602 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400781:	41 83 ec 01          	sub    $0x1,%r12d
  400785:	62 f1 7c 48 28 1d 71 	vmovaps 0x371(%rip),%zmm3        # 400b00 <_IO_stdin_used+0x100>
  40078c:	03 00 00 
  40078f:	62 f1 7c 48 28 15 a7 	vmovaps 0x3a7(%rip),%zmm2        # 400b40 <_IO_stdin_used+0x140>
  400796:	03 00 00 
  400799:	75 a1                	jne    40073c <scale_shift+0x4c>
    end_t = get_wall_time();
  40079b:	31 c0                	xor    %eax,%eax
  40079d:	c5 f8 77             	vzeroupper 
  4007a0:	e8 7b fe ff ff       	callq  400620 <get_wall_time>
    results(end_t - start_t, "scale_shift");
  4007a5:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  4007aa:	bf 23 0a 40 00       	mov    $0x400a23,%edi
  4007af:	e8 0c ff ff ff       	callq  4006c0 <results>
    check(x);
  4007b4:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  4007b9:	e8 a2 fe ff ff       	callq  400660 <check>
}
  4007be:	48 83 c4 58          	add    $0x58,%rsp
  4007c2:	31 c0                	xor    %eax,%eax
  4007c4:	5b                   	pop    %rbx
  4007c5:	41 5a                	pop    %r10
  4007c7:	41 5c                	pop    %r12
  4007c9:	5d                   	pop    %rbp
  4007ca:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4007ce:	c3                   	retq   
  4007cf:	90                   	nop

00000000004007d0 <ss_intr_SSE>:
{
  4007d0:	55                   	push   %rbp
    init();
  4007d1:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  4007d3:	bd 00 00 f0 00       	mov    $0xf00000,%ebp
{
  4007d8:	53                   	push   %rbx
  4007d9:	bb c0 30 60 00       	mov    $0x6030c0,%ebx
  4007de:	48 83 ec 18          	sub    $0x18,%rsp
    init();
  4007e2:	e8 a9 fe ff ff       	callq  400690 <init>
    start_t = get_wall_time();
  4007e7:	31 c0                	xor    %eax,%eax
  4007e9:	e8 32 fe ff ff       	callq  400620 <get_wall_time>
  4007ee:	c5 f8 28 1d 8a 03 00 	vmovaps 0x38a(%rip),%xmm3        # 400b80 <_IO_stdin_used+0x180>
  4007f5:	00 
  4007f6:	c5 f8 28 15 92 03 00 	vmovaps 0x392(%rip),%xmm2        # 400b90 <_IO_stdin_used+0x190>
  4007fd:	00 
  4007fe:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
  400804:	b8 c0 20 60 00       	mov    $0x6020c0,%eax
  400809:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
}

extern __inline __m128 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_mul_ps (__m128 __A, __m128 __B)
{
  return (__m128) ((__v4sf)__A * (__v4sf)__B);
  400810:	c5 e0 59 00          	vmulps (%rax),%xmm3,%xmm0
  400814:	48 83 c0 10          	add    $0x10,%rax
  return (__m128) ((__v4sf)__A + (__v4sf)__B);
  400818:	c5 f8 58 c2          	vaddps %xmm2,%xmm0,%xmm0

/* Store four SPFP values.  The address must be 16-byte aligned.  */
extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_store_ps (float *__P, __m128 __A)
{
  *(__m128 *)__P = __A;
  40081c:	c5 f8 29 40 f0       	vmovaps %xmm0,-0x10(%rax)
  400821:	48 39 c3             	cmp    %rax,%rbx
  400824:	75 ea                	jne    400810 <ss_intr_SSE+0x40>
        dummy(x, alpha, beta);
  400826:	c5 fa 10 0d 96 02 00 	vmovss 0x296(%rip),%xmm1        # 400ac4 <_IO_stdin_used+0xc4>
  40082d:	00 
  40082e:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400833:	c5 fa 10 05 8d 02 00 	vmovss 0x28d(%rip),%xmm0        # 400ac8 <_IO_stdin_used+0xc8>
  40083a:	00 
  40083b:	e8 c2 fd ff ff       	callq  400602 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400840:	83 ed 01             	sub    $0x1,%ebp
  400843:	c5 f8 28 15 45 03 00 	vmovaps 0x345(%rip),%xmm2        # 400b90 <_IO_stdin_used+0x190>
  40084a:	00 
  40084b:	c5 f8 28 1d 2d 03 00 	vmovaps 0x32d(%rip),%xmm3        # 400b80 <_IO_stdin_used+0x180>
  400852:	00 
  400853:	75 af                	jne    400804 <ss_intr_SSE+0x34>
  end_t = get_wall_time();
  400855:	31 c0                	xor    %eax,%eax
  400857:	e8 c4 fd ff ff       	callq  400620 <get_wall_time>
  results(end_t - start_t, "ss_intr_SSE");
  40085c:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  400862:	bf 2f 0a 40 00       	mov    $0x400a2f,%edi
  400867:	e8 54 fe ff ff       	callq  4006c0 <results>
  check(x);
  40086c:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400871:	e8 ea fd ff ff       	callq  400660 <check>
}
  400876:	48 83 c4 18          	add    $0x18,%rsp
  40087a:	31 c0                	xor    %eax,%eax
  40087c:	5b                   	pop    %rbx
  40087d:	5d                   	pop    %rbp
  40087e:	c3                   	retq   
  40087f:	90                   	nop

0000000000400880 <ss_intr_AVX>:
{
  400880:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400885:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400889:	31 c0                	xor    %eax,%eax
{
  40088b:	41 ff 72 f8          	pushq  -0x8(%r10)
  40088f:	55                   	push   %rbp
  400890:	48 89 e5             	mov    %rsp,%rbp
  400893:	41 54                	push   %r12
  start_t = get_wall_time();
  400895:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  40089b:	41 52                	push   %r10
  40089d:	53                   	push   %rbx
  40089e:	bb c0 30 60 00       	mov    $0x6030c0,%ebx
  4008a3:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  4008a7:	e8 e4 fd ff ff       	callq  400690 <init>
  start_t = get_wall_time();
  4008ac:	31 c0                	xor    %eax,%eax
  4008ae:	e8 6d fd ff ff       	callq  400620 <get_wall_time>
  4008b3:	c5 fc 28 1d e5 02 00 	vmovaps 0x2e5(%rip),%ymm3        # 400ba0 <_IO_stdin_used+0x1a0>
  4008ba:	00 
  4008bb:	c5 fc 28 15 fd 02 00 	vmovaps 0x2fd(%rip),%ymm2        # 400bc0 <_IO_stdin_used+0x1c0>
  4008c2:	00 
  4008c3:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
        for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4008c8:	b8 c0 20 60 00       	mov    $0x6020c0,%eax
  4008cd:	0f 1f 00             	nopl   (%rax)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_mul_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  4008d0:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4008d4:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4008d8:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  4008dc:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  4008e1:	48 39 c3             	cmp    %rax,%rbx
  4008e4:	75 ea                	jne    4008d0 <ss_intr_AVX+0x50>
        dummy(x, alpha, beta);
  4008e6:	c5 fa 10 0d d6 01 00 	vmovss 0x1d6(%rip),%xmm1        # 400ac4 <_IO_stdin_used+0xc4>
  4008ed:	00 
  4008ee:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  4008f3:	c5 fa 10 05 cd 01 00 	vmovss 0x1cd(%rip),%xmm0        # 400ac8 <_IO_stdin_used+0xc8>
  4008fa:	00 
  4008fb:	c5 f8 77             	vzeroupper 
  4008fe:	e8 ff fc ff ff       	callq  400602 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400903:	41 83 ec 01          	sub    $0x1,%r12d
  400907:	c5 fc 28 15 b1 02 00 	vmovaps 0x2b1(%rip),%ymm2        # 400bc0 <_IO_stdin_used+0x1c0>
  40090e:	00 
  40090f:	c5 fc 28 1d 89 02 00 	vmovaps 0x289(%rip),%ymm3        # 400ba0 <_IO_stdin_used+0x1a0>
  400916:	00 
  400917:	75 af                	jne    4008c8 <ss_intr_AVX+0x48>
  end_t = get_wall_time();
  400919:	31 c0                	xor    %eax,%eax
  40091b:	c5 f8 77             	vzeroupper 
  40091e:	e8 fd fc ff ff       	callq  400620 <get_wall_time>
  results(end_t - start_t, "ss_intr_AVX");
  400923:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400928:	bf 3b 0a 40 00       	mov    $0x400a3b,%edi
  40092d:	e8 8e fd ff ff       	callq  4006c0 <results>
  check(x);
  400932:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400937:	e8 24 fd ff ff       	callq  400660 <check>
}
  40093c:	48 83 c4 38          	add    $0x38,%rsp
  400940:	31 c0                	xor    %eax,%eax
  400942:	5b                   	pop    %rbx
  400943:	41 5a                	pop    %r10
  400945:	41 5c                	pop    %r12
  400947:	5d                   	pop    %rbp
  400948:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40094c:	c3                   	retq   
  40094d:	0f 1f 00             	nopl   (%rax)

0000000000400950 <__libc_csu_init>:
  400950:	41 57                	push   %r15
  400952:	41 89 ff             	mov    %edi,%r15d
  400955:	41 56                	push   %r14
  400957:	49 89 f6             	mov    %rsi,%r14
  40095a:	41 55                	push   %r13
  40095c:	49 89 d5             	mov    %rdx,%r13
  40095f:	41 54                	push   %r12
  400961:	4c 8d 25 a0 14 20 00 	lea    0x2014a0(%rip),%r12        # 601e08 <__frame_dummy_init_array_entry>
  400968:	55                   	push   %rbp
  400969:	48 8d 2d a0 14 20 00 	lea    0x2014a0(%rip),%rbp        # 601e10 <__init_array_end>
  400970:	53                   	push   %rbx
  400971:	4c 29 e5             	sub    %r12,%rbp
  400974:	31 db                	xor    %ebx,%ebx
  400976:	48 c1 fd 03          	sar    $0x3,%rbp
  40097a:	48 83 ec 08          	sub    $0x8,%rsp
  40097e:	e8 ed fa ff ff       	callq  400470 <_init>
  400983:	48 85 ed             	test   %rbp,%rbp
  400986:	74 1e                	je     4009a6 <__libc_csu_init+0x56>
  400988:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40098f:	00 
  400990:	4c 89 ea             	mov    %r13,%rdx
  400993:	4c 89 f6             	mov    %r14,%rsi
  400996:	44 89 ff             	mov    %r15d,%edi
  400999:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  40099d:	48 83 c3 01          	add    $0x1,%rbx
  4009a1:	48 39 eb             	cmp    %rbp,%rbx
  4009a4:	75 ea                	jne    400990 <__libc_csu_init+0x40>
  4009a6:	48 83 c4 08          	add    $0x8,%rsp
  4009aa:	5b                   	pop    %rbx
  4009ab:	5d                   	pop    %rbp
  4009ac:	41 5c                	pop    %r12
  4009ae:	41 5d                	pop    %r13
  4009b0:	41 5e                	pop    %r14
  4009b2:	41 5f                	pop    %r15
  4009b4:	c3                   	retq   
  4009b5:	90                   	nop
  4009b6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4009bd:	00 00 00 

00000000004009c0 <__libc_csu_fini>:
  4009c0:	f3 c3                	repz retq 

Desensamblado de la sección .fini:

00000000004009c4 <_fini>:
  4009c4:	48 83 ec 08          	sub    $0x8,%rsp
  4009c8:	48 83 c4 08          	add    $0x8,%rsp
  4009cc:	c3                   	retq   
