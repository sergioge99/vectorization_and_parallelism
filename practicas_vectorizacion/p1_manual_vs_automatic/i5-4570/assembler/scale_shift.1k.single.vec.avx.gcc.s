
scale_shift.1k.single.vec.avx.gcc:     formato del fichero elf64-x86-64


Desensamblado de la sección .init:

0000000000400470 <_init>:
  400470:	48 83 ec 08          	sub    $0x8,%rsp
  400474:	48 8b 05 7d 0b 20 00 	mov    0x200b7d(%rip),%rax        # 600ff8 <__gmon_start__>
  40047b:	48 85 c0             	test   %rax,%rax
  40047e:	74 05                	je     400485 <_init+0x15>
  400480:	e8 6b 00 00 00       	callq  4004f0 <.plt.got>
  400485:	48 83 c4 08          	add    $0x8,%rsp
  400489:	c3                   	retq   

Desensamblado de la sección .plt:

0000000000400490 <.plt>:
  400490:	ff 35 72 0b 20 00    	pushq  0x200b72(%rip)        # 601008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400496:	ff 25 74 0b 20 00    	jmpq   *0x200b74(%rip)        # 601010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40049c:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004004a0 <puts@plt>:
  4004a0:	ff 25 72 0b 20 00    	jmpq   *0x200b72(%rip)        # 601018 <puts@GLIBC_2.2.5>
  4004a6:	68 00 00 00 00       	pushq  $0x0
  4004ab:	e9 e0 ff ff ff       	jmpq   400490 <.plt>

00000000004004b0 <printf@plt>:
  4004b0:	ff 25 6a 0b 20 00    	jmpq   *0x200b6a(%rip)        # 601020 <printf@GLIBC_2.2.5>
  4004b6:	68 01 00 00 00       	pushq  $0x1
  4004bb:	e9 d0 ff ff ff       	jmpq   400490 <.plt>

00000000004004c0 <gettimeofday@plt>:
  4004c0:	ff 25 62 0b 20 00    	jmpq   *0x200b62(%rip)        # 601028 <gettimeofday@GLIBC_2.2.5>
  4004c6:	68 02 00 00 00       	pushq  $0x2
  4004cb:	e9 c0 ff ff ff       	jmpq   400490 <.plt>

00000000004004d0 <__libc_start_main@plt>:
  4004d0:	ff 25 5a 0b 20 00    	jmpq   *0x200b5a(%rip)        # 601030 <__libc_start_main@GLIBC_2.2.5>
  4004d6:	68 03 00 00 00       	pushq  $0x3
  4004db:	e9 b0 ff ff ff       	jmpq   400490 <.plt>

00000000004004e0 <exit@plt>:
  4004e0:	ff 25 52 0b 20 00    	jmpq   *0x200b52(%rip)        # 601038 <exit@GLIBC_2.2.5>
  4004e6:	68 04 00 00 00       	pushq  $0x4
  4004eb:	e9 a0 ff ff ff       	jmpq   400490 <.plt>

Desensamblado de la sección .plt.got:

00000000004004f0 <.plt.got>:
  4004f0:	ff 25 02 0b 20 00    	jmpq   *0x200b02(%rip)        # 600ff8 <__gmon_start__>
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
  400504:	bf 08 0a 40 00       	mov    $0x400a08,%edi
  400509:	e8 92 ff ff ff       	callq  4004a0 <puts@plt>
  printf("              Loop    ns     ps/el     Checksum \n");
  40050e:	bf 30 0a 40 00       	mov    $0x400a30,%edi
  400513:	e8 88 ff ff ff       	callq  4004a0 <puts@plt>
  scale_shift();
  400518:	31 c0                	xor    %eax,%eax
  40051a:	e8 d1 01 00 00       	callq  4006f0 <scale_shift>
  ss_intr_SSE();
  40051f:	31 c0                	xor    %eax,%eax
  400521:	e8 9a 02 00 00       	callq  4007c0 <ss_intr_SSE>
  ss_intr_AVX();
  400526:	31 c0                	xor    %eax,%eax
  400528:	e8 43 03 00 00       	callq  400870 <ss_intr_AVX>
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
  400543:	49 c7 c0 b0 09 40 00 	mov    $0x4009b0,%r8
  40054a:	48 c7 c1 40 09 40 00 	mov    $0x400940,%rcx
  400551:	48 c7 c7 00 05 40 00 	mov    $0x400500,%rdi
  400558:	e8 73 ff ff ff       	callq  4004d0 <__libc_start_main@plt>
  40055d:	f4                   	hlt    
  40055e:	66 90                	xchg   %ax,%ax

0000000000400560 <deregister_tm_clones>:
  400560:	b8 50 10 60 00       	mov    $0x601050,%eax
  400565:	48 3d 50 10 60 00    	cmp    $0x601050,%rax
  40056b:	74 13                	je     400580 <deregister_tm_clones+0x20>
  40056d:	b8 00 00 00 00       	mov    $0x0,%eax
  400572:	48 85 c0             	test   %rax,%rax
  400575:	74 09                	je     400580 <deregister_tm_clones+0x20>
  400577:	bf 50 10 60 00       	mov    $0x601050,%edi
  40057c:	ff e0                	jmpq   *%rax
  40057e:	66 90                	xchg   %ax,%ax
  400580:	c3                   	retq   
  400581:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400586:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40058d:	00 00 00 

0000000000400590 <register_tm_clones>:
  400590:	be 50 10 60 00       	mov    $0x601050,%esi
  400595:	48 81 ee 50 10 60 00 	sub    $0x601050,%rsi
  40059c:	48 89 f0             	mov    %rsi,%rax
  40059f:	48 c1 ee 3f          	shr    $0x3f,%rsi
  4005a3:	48 c1 f8 03          	sar    $0x3,%rax
  4005a7:	48 01 c6             	add    %rax,%rsi
  4005aa:	48 d1 fe             	sar    %rsi
  4005ad:	74 11                	je     4005c0 <register_tm_clones+0x30>
  4005af:	b8 00 00 00 00       	mov    $0x0,%eax
  4005b4:	48 85 c0             	test   %rax,%rax
  4005b7:	74 07                	je     4005c0 <register_tm_clones+0x30>
  4005b9:	bf 50 10 60 00       	mov    $0x601050,%edi
  4005be:	ff e0                	jmpq   *%rax
  4005c0:	c3                   	retq   
  4005c1:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4005c6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4005cd:	00 00 00 

00000000004005d0 <__do_global_dtors_aux>:
  4005d0:	80 3d a9 0a 20 00 00 	cmpb   $0x0,0x200aa9(%rip)        # 601080 <completed.7338>
  4005d7:	75 17                	jne    4005f0 <__do_global_dtors_aux+0x20>
  4005d9:	55                   	push   %rbp
  4005da:	48 89 e5             	mov    %rsp,%rbp
  4005dd:	e8 7e ff ff ff       	callq  400560 <deregister_tm_clones>
  4005e2:	5d                   	pop    %rbp
  4005e3:	c6 05 96 0a 20 00 01 	movb   $0x1,0x200a96(%rip)        # 601080 <completed.7338>
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
  40063d:	c5 fb 59 0d 23 04 00 	vmulsd 0x423(%rip),%xmm0,%xmm1        # 400a68 <_IO_stdin_used+0xa8>
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
  40067d:	bf c4 09 40 00       	mov    $0x4009c4,%edi
  400682:	b8 01 00 00 00       	mov    $0x1,%eax
  400687:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40068b:	e9 20 fe ff ff       	jmpq   4004b0 <printf@plt>

0000000000400690 <init>:
    for (int j = 0; j < LEN; j++)
  400690:	c5 fa 10 05 e8 03 00 	vmovss 0x3e8(%rip),%xmm0        # 400a80 <_IO_stdin_used+0xc0>
  400697:	00 
  400698:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  40069d:	0f 1f 00             	nopl   (%rax)
	    x[j] = 1.0;
  4006a0:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (int j = 0; j < LEN; j++)
  4006a4:	48 83 c0 04          	add    $0x4,%rax
  4006a8:	48 3d c0 20 60 00    	cmp    $0x6020c0,%rax
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
  4006c8:	bf c9 09 40 00       	mov    $0x4009c9,%edi
  4006cd:	c5 fb 5e 15 a3 03 00 	vdivsd 0x3a3(%rip),%xmm0,%xmm2        # 400a78 <_IO_stdin_used+0xb8>
  4006d4:	00 
  4006d5:	c5 fb 5e 0d 93 03 00 	vdivsd 0x393(%rip),%xmm0,%xmm1        # 400a70 <_IO_stdin_used+0xb0>
  4006dc:	00 
  4006dd:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  4006e1:	e9 ca fd ff ff       	jmpq   4004b0 <printf@plt>
  4006e6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4006ed:	00 00 00 

00000000004006f0 <scale_shift>:
{
  4006f0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4006f5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
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
  40070e:	bb c0 20 60 00       	mov    $0x6020c0,%ebx
  400713:	48 83 ec 38          	sub    $0x38,%rsp
    init();
  400717:	e8 74 ff ff ff       	callq  400690 <init>
    start_t = get_wall_time();
  40071c:	31 c0                	xor    %eax,%eax
  40071e:	e8 fd fe ff ff       	callq  400620 <get_wall_time>
  400723:	c5 fc 28 1d 75 03 00 	vmovaps 0x375(%rip),%ymm3        # 400aa0 <_IO_stdin_used+0xe0>
  40072a:	00 
  40072b:	c5 fc 28 15 8d 03 00 	vmovaps 0x38d(%rip),%ymm2        # 400ac0 <_IO_stdin_used+0x100>
  400732:	00 
  400733:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
        for (unsigned int i = 0; i < LEN; i++)
  400738:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  40073d:	0f 1f 00             	nopl   (%rax)
            x[i] = alpha*x[i] + beta;
  400740:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  400744:	48 83 c0 20          	add    $0x20,%rax
  400748:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  40074c:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
        for (unsigned int i = 0; i < LEN; i++)
  400751:	48 39 c3             	cmp    %rax,%rbx
  400754:	75 ea                	jne    400740 <scale_shift+0x50>
        dummy(x, alpha, beta);
  400756:	c5 fa 10 0d 26 03 00 	vmovss 0x326(%rip),%xmm1        # 400a84 <_IO_stdin_used+0xc4>
  40075d:	00 
  40075e:	c5 fa 10 05 22 03 00 	vmovss 0x322(%rip),%xmm0        # 400a88 <_IO_stdin_used+0xc8>
  400765:	00 
  400766:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  40076b:	c5 f8 77             	vzeroupper 
  40076e:	e8 8f fe ff ff       	callq  400602 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400773:	41 83 ec 01          	sub    $0x1,%r12d
  400777:	c5 fc 28 1d 21 03 00 	vmovaps 0x321(%rip),%ymm3        # 400aa0 <_IO_stdin_used+0xe0>
  40077e:	00 
  40077f:	c5 fc 28 15 39 03 00 	vmovaps 0x339(%rip),%ymm2        # 400ac0 <_IO_stdin_used+0x100>
  400786:	00 
  400787:	75 af                	jne    400738 <scale_shift+0x48>
    end_t = get_wall_time();
  400789:	31 c0                	xor    %eax,%eax
  40078b:	c5 f8 77             	vzeroupper 
  40078e:	e8 8d fe ff ff       	callq  400620 <get_wall_time>
    results(end_t - start_t, "scale_shift");
  400793:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400798:	bf e3 09 40 00       	mov    $0x4009e3,%edi
  40079d:	e8 1e ff ff ff       	callq  4006c0 <results>
    check(x);
  4007a2:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  4007a7:	e8 b4 fe ff ff       	callq  400660 <check>
}
  4007ac:	48 83 c4 38          	add    $0x38,%rsp
  4007b0:	31 c0                	xor    %eax,%eax
  4007b2:	5b                   	pop    %rbx
  4007b3:	41 5a                	pop    %r10
  4007b5:	41 5c                	pop    %r12
  4007b7:	5d                   	pop    %rbp
  4007b8:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4007bc:	c3                   	retq   
  4007bd:	0f 1f 00             	nopl   (%rax)

00000000004007c0 <ss_intr_SSE>:
{
  4007c0:	55                   	push   %rbp
    init();
  4007c1:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  4007c3:	bd 00 00 f0 00       	mov    $0xf00000,%ebp
{
  4007c8:	53                   	push   %rbx
  4007c9:	bb c0 20 60 00       	mov    $0x6020c0,%ebx
  4007ce:	48 83 ec 18          	sub    $0x18,%rsp
    init();
  4007d2:	e8 b9 fe ff ff       	callq  400690 <init>
    start_t = get_wall_time();
  4007d7:	31 c0                	xor    %eax,%eax
  4007d9:	e8 42 fe ff ff       	callq  400620 <get_wall_time>
  4007de:	c5 f8 28 1d fa 02 00 	vmovaps 0x2fa(%rip),%xmm3        # 400ae0 <_IO_stdin_used+0x120>
  4007e5:	00 
  4007e6:	c5 f8 28 15 02 03 00 	vmovaps 0x302(%rip),%xmm2        # 400af0 <_IO_stdin_used+0x130>
  4007ed:	00 
  4007ee:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
  4007f4:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  4007f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
}

extern __inline __m128 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_mul_ps (__m128 __A, __m128 __B)
{
  return (__m128) ((__v4sf)__A * (__v4sf)__B);
  400800:	c5 e0 59 00          	vmulps (%rax),%xmm3,%xmm0
  400804:	48 83 c0 10          	add    $0x10,%rax
  return (__m128) ((__v4sf)__A + (__v4sf)__B);
  400808:	c5 f8 58 c2          	vaddps %xmm2,%xmm0,%xmm0

/* Store four SPFP values.  The address must be 16-byte aligned.  */
extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_store_ps (float *__P, __m128 __A)
{
  *(__m128 *)__P = __A;
  40080c:	c5 f8 29 40 f0       	vmovaps %xmm0,-0x10(%rax)
  400811:	48 39 c3             	cmp    %rax,%rbx
  400814:	75 ea                	jne    400800 <ss_intr_SSE+0x40>
        dummy(x, alpha, beta);
  400816:	c5 fa 10 0d 66 02 00 	vmovss 0x266(%rip),%xmm1        # 400a84 <_IO_stdin_used+0xc4>
  40081d:	00 
  40081e:	c5 fa 10 05 62 02 00 	vmovss 0x262(%rip),%xmm0        # 400a88 <_IO_stdin_used+0xc8>
  400825:	00 
  400826:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  40082b:	e8 d2 fd ff ff       	callq  400602 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400830:	83 ed 01             	sub    $0x1,%ebp
  400833:	c5 f8 28 15 b5 02 00 	vmovaps 0x2b5(%rip),%xmm2        # 400af0 <_IO_stdin_used+0x130>
  40083a:	00 
  40083b:	c5 f8 28 1d 9d 02 00 	vmovaps 0x29d(%rip),%xmm3        # 400ae0 <_IO_stdin_used+0x120>
  400842:	00 
  400843:	75 af                	jne    4007f4 <ss_intr_SSE+0x34>
  end_t = get_wall_time();
  400845:	31 c0                	xor    %eax,%eax
  400847:	e8 d4 fd ff ff       	callq  400620 <get_wall_time>
  results(end_t - start_t, "ss_intr_SSE");
  40084c:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  400852:	bf ef 09 40 00       	mov    $0x4009ef,%edi
  400857:	e8 64 fe ff ff       	callq  4006c0 <results>
  check(x);
  40085c:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  400861:	e8 fa fd ff ff       	callq  400660 <check>
}
  400866:	48 83 c4 18          	add    $0x18,%rsp
  40086a:	31 c0                	xor    %eax,%eax
  40086c:	5b                   	pop    %rbx
  40086d:	5d                   	pop    %rbp
  40086e:	c3                   	retq   
  40086f:	90                   	nop

0000000000400870 <ss_intr_AVX>:
{
  400870:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400875:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400879:	31 c0                	xor    %eax,%eax
{
  40087b:	41 ff 72 f8          	pushq  -0x8(%r10)
  40087f:	55                   	push   %rbp
  400880:	48 89 e5             	mov    %rsp,%rbp
  400883:	41 54                	push   %r12
  start_t = get_wall_time();
  400885:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  40088b:	41 52                	push   %r10
  40088d:	53                   	push   %rbx
  40088e:	bb c0 20 60 00       	mov    $0x6020c0,%ebx
  400893:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  400897:	e8 f4 fd ff ff       	callq  400690 <init>
  start_t = get_wall_time();
  40089c:	31 c0                	xor    %eax,%eax
  40089e:	e8 7d fd ff ff       	callq  400620 <get_wall_time>
  4008a3:	c5 fc 28 1d f5 01 00 	vmovaps 0x1f5(%rip),%ymm3        # 400aa0 <_IO_stdin_used+0xe0>
  4008aa:	00 
  4008ab:	c5 fc 28 15 0d 02 00 	vmovaps 0x20d(%rip),%ymm2        # 400ac0 <_IO_stdin_used+0x100>
  4008b2:	00 
  4008b3:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
        for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4008b8:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  4008bd:	0f 1f 00             	nopl   (%rax)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_mul_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  4008c0:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4008c4:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4008c8:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  4008cc:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  4008d1:	48 39 c3             	cmp    %rax,%rbx
  4008d4:	75 ea                	jne    4008c0 <ss_intr_AVX+0x50>
        dummy(x, alpha, beta);
  4008d6:	c5 fa 10 0d a6 01 00 	vmovss 0x1a6(%rip),%xmm1        # 400a84 <_IO_stdin_used+0xc4>
  4008dd:	00 
  4008de:	c5 fa 10 05 a2 01 00 	vmovss 0x1a2(%rip),%xmm0        # 400a88 <_IO_stdin_used+0xc8>
  4008e5:	00 
  4008e6:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  4008eb:	c5 f8 77             	vzeroupper 
  4008ee:	e8 0f fd ff ff       	callq  400602 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4008f3:	41 83 ec 01          	sub    $0x1,%r12d
  4008f7:	c5 fc 28 1d a1 01 00 	vmovaps 0x1a1(%rip),%ymm3        # 400aa0 <_IO_stdin_used+0xe0>
  4008fe:	00 
  4008ff:	c5 fc 28 15 b9 01 00 	vmovaps 0x1b9(%rip),%ymm2        # 400ac0 <_IO_stdin_used+0x100>
  400906:	00 
  400907:	75 af                	jne    4008b8 <ss_intr_AVX+0x48>
  end_t = get_wall_time();
  400909:	31 c0                	xor    %eax,%eax
  40090b:	c5 f8 77             	vzeroupper 
  40090e:	e8 0d fd ff ff       	callq  400620 <get_wall_time>
  results(end_t - start_t, "ss_intr_AVX");
  400913:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400918:	bf fb 09 40 00       	mov    $0x4009fb,%edi
  40091d:	e8 9e fd ff ff       	callq  4006c0 <results>
  check(x);
  400922:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  400927:	e8 34 fd ff ff       	callq  400660 <check>
}
  40092c:	48 83 c4 38          	add    $0x38,%rsp
  400930:	31 c0                	xor    %eax,%eax
  400932:	5b                   	pop    %rbx
  400933:	41 5a                	pop    %r10
  400935:	41 5c                	pop    %r12
  400937:	5d                   	pop    %rbp
  400938:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40093c:	c3                   	retq   
  40093d:	0f 1f 00             	nopl   (%rax)

0000000000400940 <__libc_csu_init>:
  400940:	41 57                	push   %r15
  400942:	41 89 ff             	mov    %edi,%r15d
  400945:	41 56                	push   %r14
  400947:	49 89 f6             	mov    %rsi,%r14
  40094a:	41 55                	push   %r13
  40094c:	49 89 d5             	mov    %rdx,%r13
  40094f:	41 54                	push   %r12
  400951:	4c 8d 25 b0 04 20 00 	lea    0x2004b0(%rip),%r12        # 600e08 <__frame_dummy_init_array_entry>
  400958:	55                   	push   %rbp
  400959:	48 8d 2d b0 04 20 00 	lea    0x2004b0(%rip),%rbp        # 600e10 <__init_array_end>
  400960:	53                   	push   %rbx
  400961:	4c 29 e5             	sub    %r12,%rbp
  400964:	31 db                	xor    %ebx,%ebx
  400966:	48 c1 fd 03          	sar    $0x3,%rbp
  40096a:	48 83 ec 08          	sub    $0x8,%rsp
  40096e:	e8 fd fa ff ff       	callq  400470 <_init>
  400973:	48 85 ed             	test   %rbp,%rbp
  400976:	74 1e                	je     400996 <__libc_csu_init+0x56>
  400978:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40097f:	00 
  400980:	4c 89 ea             	mov    %r13,%rdx
  400983:	4c 89 f6             	mov    %r14,%rsi
  400986:	44 89 ff             	mov    %r15d,%edi
  400989:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  40098d:	48 83 c3 01          	add    $0x1,%rbx
  400991:	48 39 eb             	cmp    %rbp,%rbx
  400994:	75 ea                	jne    400980 <__libc_csu_init+0x40>
  400996:	48 83 c4 08          	add    $0x8,%rsp
  40099a:	5b                   	pop    %rbx
  40099b:	5d                   	pop    %rbp
  40099c:	41 5c                	pop    %r12
  40099e:	41 5d                	pop    %r13
  4009a0:	41 5e                	pop    %r14
  4009a2:	41 5f                	pop    %r15
  4009a4:	c3                   	retq   
  4009a5:	90                   	nop
  4009a6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4009ad:	00 00 00 

00000000004009b0 <__libc_csu_fini>:
  4009b0:	f3 c3                	repz retq 

Desensamblado de la sección .fini:

00000000004009b4 <_fini>:
  4009b4:	48 83 ec 08          	sub    $0x8,%rsp
  4009b8:	48 83 c4 08          	add    $0x8,%rsp
  4009bc:	c3                   	retq   
