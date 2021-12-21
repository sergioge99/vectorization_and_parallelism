
scale_shift.1k.single.esc.avx.gcc:     formato del fichero elf64-x86-64


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
  400504:	bf 68 0a 40 00       	mov    $0x400a68,%edi
  400509:	e8 92 ff ff ff       	callq  4004a0 <puts@plt>
  printf("              Loop    ns     ps/el     Checksum \n");
  40050e:	bf 90 0a 40 00       	mov    $0x400a90,%edi
  400513:	e8 88 ff ff ff       	callq  4004a0 <puts@plt>
  scale_shift();
  400518:	31 c0                	xor    %eax,%eax
  40051a:	e8 d1 01 00 00       	callq  4006f0 <scale_shift>
  ss_intr_SSE();
  40051f:	31 c0                	xor    %eax,%eax
  400521:	e8 9a 02 00 00       	callq  4007c0 <ss_intr_SSE>
  ss_intr_AVX();
  400526:	31 c0                	xor    %eax,%eax
  400528:	e8 63 03 00 00       	callq  400890 <ss_intr_AVX>
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
  400543:	49 c7 c0 00 0a 40 00 	mov    $0x400a00,%r8
  40054a:	48 c7 c1 90 09 40 00 	mov    $0x400990,%rcx
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
  40063d:	c5 fb 59 0d 83 04 00 	vmulsd 0x483(%rip),%xmm0,%xmm1        # 400ac8 <_IO_stdin_used+0xa8>
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
  40067d:	bf 24 0a 40 00       	mov    $0x400a24,%edi
  400682:	b8 01 00 00 00       	mov    $0x1,%eax
  400687:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40068b:	e9 20 fe ff ff       	jmpq   4004b0 <printf@plt>

0000000000400690 <init>:
    for (int j = 0; j < LEN; j++)
  400690:	c5 fa 10 05 48 04 00 	vmovss 0x448(%rip),%xmm0        # 400ae0 <_IO_stdin_used+0xc0>
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
  4006c8:	bf 29 0a 40 00       	mov    $0x400a29,%edi
  4006cd:	c5 fb 5e 15 03 04 00 	vdivsd 0x403(%rip),%xmm0,%xmm2        # 400ad8 <_IO_stdin_used+0xb8>
  4006d4:	00 
  4006d5:	c5 fb 5e 0d f3 03 00 	vdivsd 0x3f3(%rip),%xmm0,%xmm1        # 400ad0 <_IO_stdin_used+0xb0>
  4006dc:	00 
  4006dd:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  4006e1:	e9 ca fd ff ff       	jmpq   4004b0 <printf@plt>
  4006e6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4006ed:	00 00 00 

00000000004006f0 <scale_shift>:
{
  4006f0:	55                   	push   %rbp
    init();
  4006f1:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  4006f3:	bd 00 00 f0 00       	mov    $0xf00000,%ebp
{
  4006f8:	53                   	push   %rbx
  4006f9:	48 83 ec 18          	sub    $0x18,%rsp
    init();
  4006fd:	e8 8e ff ff ff       	callq  400690 <init>
    start_t = get_wall_time();
  400702:	31 c0                	xor    %eax,%eax
  400704:	e8 17 ff ff ff       	callq  400620 <get_wall_time>
  400709:	c5 fa 10 15 d3 03 00 	vmovss 0x3d3(%rip),%xmm2        # 400ae4 <_IO_stdin_used+0xc4>
  400710:	00 
  400711:	c5 fa 10 0d cf 03 00 	vmovss 0x3cf(%rip),%xmm1        # 400ae8 <_IO_stdin_used+0xc8>
  400718:	00 
  400719:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
        for (unsigned int i = 0; i < LEN; i++)
  40071f:	bb c0 10 60 00       	mov    $0x6010c0,%ebx
{
  400724:	48 89 d8             	mov    %rbx,%rax
  400727:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40072e:	00 00 
            x[i] = alpha*x[i] + beta;
  400730:	c5 ea 59 00          	vmulss (%rax),%xmm2,%xmm0
  400734:	48 83 c0 04          	add    $0x4,%rax
  400738:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  40073c:	c5 fa 11 40 fc       	vmovss %xmm0,-0x4(%rax)
        for (unsigned int i = 0; i < LEN; i++)
  400741:	48 3d c0 20 60 00    	cmp    $0x6020c0,%rax
  400747:	75 e7                	jne    400730 <scale_shift+0x40>
        dummy(x, alpha, beta);
  400749:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  40074d:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  400752:	e8 ab fe ff ff       	callq  400602 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400757:	83 ed 01             	sub    $0x1,%ebp
  40075a:	c5 fa 10 15 82 03 00 	vmovss 0x382(%rip),%xmm2        # 400ae4 <_IO_stdin_used+0xc4>
  400761:	00 
  400762:	c5 fa 10 0d 7e 03 00 	vmovss 0x37e(%rip),%xmm1        # 400ae8 <_IO_stdin_used+0xc8>
  400769:	00 
  40076a:	75 b3                	jne    40071f <scale_shift+0x2f>
    end_t = get_wall_time();
  40076c:	31 c0                	xor    %eax,%eax
  40076e:	e8 ad fe ff ff       	callq  400620 <get_wall_time>
    results(end_t - start_t, "scale_shift");
  400773:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  400779:	bf 43 0a 40 00       	mov    $0x400a43,%edi
  40077e:	e8 3d ff ff ff       	callq  4006c0 <results>
    real sum = 0;
  400783:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
        sum += arr[i];
  400787:	c5 fa 58 03          	vaddss (%rbx),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  40078b:	48 83 c3 04          	add    $0x4,%rbx
  40078f:	48 81 fb c0 20 60 00 	cmp    $0x6020c0,%rbx
  400796:	75 ef                	jne    400787 <scale_shift+0x97>
    printf("%f \n", sum);
  400798:	bf 24 0a 40 00       	mov    $0x400a24,%edi
  40079d:	b8 01 00 00 00       	mov    $0x1,%eax
  4007a2:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  4007a6:	e8 05 fd ff ff       	callq  4004b0 <printf@plt>
}
  4007ab:	48 83 c4 18          	add    $0x18,%rsp
  4007af:	31 c0                	xor    %eax,%eax
  4007b1:	5b                   	pop    %rbx
  4007b2:	5d                   	pop    %rbp
  4007b3:	c3                   	retq   
  4007b4:	66 90                	xchg   %ax,%ax
  4007b6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4007bd:	00 00 00 

00000000004007c0 <ss_intr_SSE>:
{
  4007c0:	41 54                	push   %r12
    init();
  4007c2:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  4007c4:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  4007ca:	55                   	push   %rbp
  4007cb:	53                   	push   %rbx
  4007cc:	bb c0 20 60 00       	mov    $0x6020c0,%ebx
  4007d1:	48 83 ec 10          	sub    $0x10,%rsp
    init();
  4007d5:	e8 b6 fe ff ff       	callq  400690 <init>
    start_t = get_wall_time();
  4007da:	31 c0                	xor    %eax,%eax
  4007dc:	e8 3f fe ff ff       	callq  400620 <get_wall_time>
  4007e1:	c5 f8 28 1d 07 03 00 	vmovaps 0x307(%rip),%xmm3        # 400af0 <_IO_stdin_used+0xd0>
  4007e8:	00 
  4007e9:	c5 f8 28 15 0f 03 00 	vmovaps 0x30f(%rip),%xmm2        # 400b00 <_IO_stdin_used+0xe0>
  4007f0:	00 
  4007f1:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
  4007f7:	bd c0 10 60 00       	mov    $0x6010c0,%ebp
{
  4007fc:	48 89 e8             	mov    %rbp,%rax
  4007ff:	90                   	nop
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
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
  400811:	48 39 c3             	cmp    %rax,%rbx
  400814:	75 ea                	jne    400800 <ss_intr_SSE+0x40>
        dummy(x, alpha, beta);
  400816:	c5 fa 10 0d ca 02 00 	vmovss 0x2ca(%rip),%xmm1        # 400ae8 <_IO_stdin_used+0xc8>
  40081d:	00 
  40081e:	c5 fa 10 05 be 02 00 	vmovss 0x2be(%rip),%xmm0        # 400ae4 <_IO_stdin_used+0xc4>
  400825:	00 
  400826:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  40082b:	e8 d2 fd ff ff       	callq  400602 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400830:	41 83 ec 01          	sub    $0x1,%r12d
  400834:	c5 f8 28 1d b4 02 00 	vmovaps 0x2b4(%rip),%xmm3        # 400af0 <_IO_stdin_used+0xd0>
  40083b:	00 
  40083c:	c5 f8 28 15 bc 02 00 	vmovaps 0x2bc(%rip),%xmm2        # 400b00 <_IO_stdin_used+0xe0>
  400843:	00 
  400844:	75 b1                	jne    4007f7 <ss_intr_SSE+0x37>
  end_t = get_wall_time();
  400846:	31 c0                	xor    %eax,%eax
  400848:	e8 d3 fd ff ff       	callq  400620 <get_wall_time>
  results(end_t - start_t, "ss_intr_SSE");
  40084d:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  400853:	bf 4f 0a 40 00       	mov    $0x400a4f,%edi
  400858:	e8 63 fe ff ff       	callq  4006c0 <results>
    real sum = 0;
  40085d:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
        sum += arr[i];
  400861:	c5 fa 58 45 00       	vaddss 0x0(%rbp),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  400866:	48 83 c5 04          	add    $0x4,%rbp
  40086a:	48 39 eb             	cmp    %rbp,%rbx
  40086d:	75 f2                	jne    400861 <ss_intr_SSE+0xa1>
    printf("%f \n", sum);
  40086f:	bf 24 0a 40 00       	mov    $0x400a24,%edi
  400874:	b8 01 00 00 00       	mov    $0x1,%eax
  400879:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40087d:	e8 2e fc ff ff       	callq  4004b0 <printf@plt>
}
  400882:	48 83 c4 10          	add    $0x10,%rsp
  400886:	31 c0                	xor    %eax,%eax
  400888:	5b                   	pop    %rbx
  400889:	5d                   	pop    %rbp
  40088a:	41 5c                	pop    %r12
  40088c:	c3                   	retq   
  40088d:	0f 1f 00             	nopl   (%rax)

0000000000400890 <ss_intr_AVX>:
{
  400890:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400895:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400899:	31 c0                	xor    %eax,%eax
{
  40089b:	41 ff 72 f8          	pushq  -0x8(%r10)
  40089f:	55                   	push   %rbp
  4008a0:	48 89 e5             	mov    %rsp,%rbp
  4008a3:	41 55                	push   %r13
  start_t = get_wall_time();
  4008a5:	41 bd 00 00 f0 00    	mov    $0xf00000,%r13d
{
  4008ab:	41 54                	push   %r12
  4008ad:	41 52                	push   %r10
  4008af:	53                   	push   %rbx
  4008b0:	bb c0 20 60 00       	mov    $0x6020c0,%ebx
  4008b5:	48 83 ec 30          	sub    $0x30,%rsp
  init();
  4008b9:	e8 d2 fd ff ff       	callq  400690 <init>
  start_t = get_wall_time();
  4008be:	31 c0                	xor    %eax,%eax
  4008c0:	e8 5b fd ff ff       	callq  400620 <get_wall_time>
  4008c5:	c5 fc 28 1d 53 02 00 	vmovaps 0x253(%rip),%ymm3        # 400b20 <_IO_stdin_used+0x100>
  4008cc:	00 
  4008cd:	c5 fc 28 15 6b 02 00 	vmovaps 0x26b(%rip),%ymm2        # 400b40 <_IO_stdin_used+0x120>
  4008d4:	00 
  4008d5:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
        for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4008da:	41 bc c0 10 60 00    	mov    $0x6010c0,%r12d
{
  4008e0:	4c 89 e0             	mov    %r12,%rax
  4008e3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_mul_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  4008e8:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4008ec:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4008f0:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  4008f4:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
        for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4008f9:	48 39 c3             	cmp    %rax,%rbx
  4008fc:	75 ea                	jne    4008e8 <ss_intr_AVX+0x58>
        dummy(x, alpha, beta);
  4008fe:	c5 fa 10 0d e2 01 00 	vmovss 0x1e2(%rip),%xmm1        # 400ae8 <_IO_stdin_used+0xc8>
  400905:	00 
  400906:	c5 fa 10 05 d6 01 00 	vmovss 0x1d6(%rip),%xmm0        # 400ae4 <_IO_stdin_used+0xc4>
  40090d:	00 
  40090e:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  400913:	c5 f8 77             	vzeroupper 
  400916:	e8 e7 fc ff ff       	callq  400602 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  40091b:	41 83 ed 01          	sub    $0x1,%r13d
  40091f:	c5 fc 28 1d f9 01 00 	vmovaps 0x1f9(%rip),%ymm3        # 400b20 <_IO_stdin_used+0x100>
  400926:	00 
  400927:	c5 fc 28 15 11 02 00 	vmovaps 0x211(%rip),%ymm2        # 400b40 <_IO_stdin_used+0x120>
  40092e:	00 
  40092f:	75 a9                	jne    4008da <ss_intr_AVX+0x4a>
  end_t = get_wall_time();
  400931:	31 c0                	xor    %eax,%eax
  400933:	c5 f8 77             	vzeroupper 
  400936:	e8 e5 fc ff ff       	callq  400620 <get_wall_time>
  results(end_t - start_t, "ss_intr_AVX");
  40093b:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400940:	bf 5b 0a 40 00       	mov    $0x400a5b,%edi
  400945:	e8 76 fd ff ff       	callq  4006c0 <results>
    real sum = 0;
  40094a:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
        sum += arr[i];
  40094e:	c4 c1 7a 58 04 24    	vaddss (%r12),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  400954:	49 83 c4 04          	add    $0x4,%r12
  400958:	4c 39 e3             	cmp    %r12,%rbx
  40095b:	75 f1                	jne    40094e <ss_intr_AVX+0xbe>
    printf("%f \n", sum);
  40095d:	bf 24 0a 40 00       	mov    $0x400a24,%edi
  400962:	b8 01 00 00 00       	mov    $0x1,%eax
  400967:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40096b:	e8 40 fb ff ff       	callq  4004b0 <printf@plt>
}
  400970:	48 83 c4 30          	add    $0x30,%rsp
  400974:	31 c0                	xor    %eax,%eax
  400976:	5b                   	pop    %rbx
  400977:	41 5a                	pop    %r10
  400979:	41 5c                	pop    %r12
  40097b:	41 5d                	pop    %r13
  40097d:	5d                   	pop    %rbp
  40097e:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400982:	c3                   	retq   
  400983:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40098a:	00 00 00 
  40098d:	0f 1f 00             	nopl   (%rax)

0000000000400990 <__libc_csu_init>:
  400990:	41 57                	push   %r15
  400992:	41 89 ff             	mov    %edi,%r15d
  400995:	41 56                	push   %r14
  400997:	49 89 f6             	mov    %rsi,%r14
  40099a:	41 55                	push   %r13
  40099c:	49 89 d5             	mov    %rdx,%r13
  40099f:	41 54                	push   %r12
  4009a1:	4c 8d 25 60 04 20 00 	lea    0x200460(%rip),%r12        # 600e08 <__frame_dummy_init_array_entry>
  4009a8:	55                   	push   %rbp
  4009a9:	48 8d 2d 60 04 20 00 	lea    0x200460(%rip),%rbp        # 600e10 <__init_array_end>
  4009b0:	53                   	push   %rbx
  4009b1:	4c 29 e5             	sub    %r12,%rbp
  4009b4:	31 db                	xor    %ebx,%ebx
  4009b6:	48 c1 fd 03          	sar    $0x3,%rbp
  4009ba:	48 83 ec 08          	sub    $0x8,%rsp
  4009be:	e8 ad fa ff ff       	callq  400470 <_init>
  4009c3:	48 85 ed             	test   %rbp,%rbp
  4009c6:	74 1e                	je     4009e6 <__libc_csu_init+0x56>
  4009c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4009cf:	00 
  4009d0:	4c 89 ea             	mov    %r13,%rdx
  4009d3:	4c 89 f6             	mov    %r14,%rsi
  4009d6:	44 89 ff             	mov    %r15d,%edi
  4009d9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  4009dd:	48 83 c3 01          	add    $0x1,%rbx
  4009e1:	48 39 eb             	cmp    %rbp,%rbx
  4009e4:	75 ea                	jne    4009d0 <__libc_csu_init+0x40>
  4009e6:	48 83 c4 08          	add    $0x8,%rsp
  4009ea:	5b                   	pop    %rbx
  4009eb:	5d                   	pop    %rbp
  4009ec:	41 5c                	pop    %r12
  4009ee:	41 5d                	pop    %r13
  4009f0:	41 5e                	pop    %r14
  4009f2:	41 5f                	pop    %r15
  4009f4:	c3                   	retq   
  4009f5:	90                   	nop
  4009f6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4009fd:	00 00 00 

0000000000400a00 <__libc_csu_fini>:
  400a00:	f3 c3                	repz retq 

Desensamblado de la sección .fini:

0000000000400a04 <_fini>:
  400a04:	48 83 ec 08          	sub    $0x8,%rsp
  400a08:	48 83 c4 08          	add    $0x8,%rsp
  400a0c:	c3                   	retq   
