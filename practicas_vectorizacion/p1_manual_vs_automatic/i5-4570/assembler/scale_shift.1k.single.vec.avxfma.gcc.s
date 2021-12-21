
scale_shift.1k.single.vec.avxfma.gcc:     formato del fichero elf64-x86-64


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
  400504:	bf 28 0a 40 00       	mov    $0x400a28,%edi
  400509:	e8 92 ff ff ff       	callq  4004a0 <puts@plt>
  printf("              Loop    ns     ps/el     Checksum \n");
  40050e:	bf 50 0a 40 00       	mov    $0x400a50,%edi
  400513:	e8 88 ff ff ff       	callq  4004a0 <puts@plt>
  scale_shift();
  400518:	31 c0                	xor    %eax,%eax
  40051a:	e8 f1 01 00 00       	callq  400710 <scale_shift>
  ss_intr_SSE();
  40051f:	31 c0                	xor    %eax,%eax
  400521:	e8 ba 02 00 00       	callq  4007e0 <ss_intr_SSE>
  ss_intr_AVX();
  400526:	31 c0                	xor    %eax,%eax
  400528:	e8 63 03 00 00       	callq  400890 <ss_intr_AVX>
  exit(0);
  40052d:	31 ff                	xor    %edi,%edi
  40052f:	e8 ac ff ff ff       	callq  4004e0 <exit@plt>
  400534:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40053b:	00 00 00 
  40053e:	66 90                	xchg   %ax,%ax

0000000000400540 <set_fast_math>:
  400540:	0f ae 5c 24 fc       	stmxcsr -0x4(%rsp)
  400545:	81 4c 24 fc 40 80 00 	orl    $0x8040,-0x4(%rsp)
  40054c:	00 
  40054d:	0f ae 54 24 fc       	ldmxcsr -0x4(%rsp)
  400552:	c3                   	retq   

0000000000400553 <_start>:
  400553:	31 ed                	xor    %ebp,%ebp
  400555:	49 89 d1             	mov    %rdx,%r9
  400558:	5e                   	pop    %rsi
  400559:	48 89 e2             	mov    %rsp,%rdx
  40055c:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  400560:	50                   	push   %rax
  400561:	54                   	push   %rsp
  400562:	49 c7 c0 d0 09 40 00 	mov    $0x4009d0,%r8
  400569:	48 c7 c1 60 09 40 00 	mov    $0x400960,%rcx
  400570:	48 c7 c7 00 05 40 00 	mov    $0x400500,%rdi
  400577:	e8 54 ff ff ff       	callq  4004d0 <__libc_start_main@plt>
  40057c:	f4                   	hlt    
  40057d:	0f 1f 00             	nopl   (%rax)

0000000000400580 <deregister_tm_clones>:
  400580:	b8 50 10 60 00       	mov    $0x601050,%eax
  400585:	48 3d 50 10 60 00    	cmp    $0x601050,%rax
  40058b:	74 13                	je     4005a0 <deregister_tm_clones+0x20>
  40058d:	b8 00 00 00 00       	mov    $0x0,%eax
  400592:	48 85 c0             	test   %rax,%rax
  400595:	74 09                	je     4005a0 <deregister_tm_clones+0x20>
  400597:	bf 50 10 60 00       	mov    $0x601050,%edi
  40059c:	ff e0                	jmpq   *%rax
  40059e:	66 90                	xchg   %ax,%ax
  4005a0:	c3                   	retq   
  4005a1:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4005a6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4005ad:	00 00 00 

00000000004005b0 <register_tm_clones>:
  4005b0:	be 50 10 60 00       	mov    $0x601050,%esi
  4005b5:	48 81 ee 50 10 60 00 	sub    $0x601050,%rsi
  4005bc:	48 89 f0             	mov    %rsi,%rax
  4005bf:	48 c1 ee 3f          	shr    $0x3f,%rsi
  4005c3:	48 c1 f8 03          	sar    $0x3,%rax
  4005c7:	48 01 c6             	add    %rax,%rsi
  4005ca:	48 d1 fe             	sar    %rsi
  4005cd:	74 11                	je     4005e0 <register_tm_clones+0x30>
  4005cf:	b8 00 00 00 00       	mov    $0x0,%eax
  4005d4:	48 85 c0             	test   %rax,%rax
  4005d7:	74 07                	je     4005e0 <register_tm_clones+0x30>
  4005d9:	bf 50 10 60 00       	mov    $0x601050,%edi
  4005de:	ff e0                	jmpq   *%rax
  4005e0:	c3                   	retq   
  4005e1:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4005e6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4005ed:	00 00 00 

00000000004005f0 <__do_global_dtors_aux>:
  4005f0:	80 3d 89 0a 20 00 00 	cmpb   $0x0,0x200a89(%rip)        # 601080 <completed.7338>
  4005f7:	75 17                	jne    400610 <__do_global_dtors_aux+0x20>
  4005f9:	55                   	push   %rbp
  4005fa:	48 89 e5             	mov    %rsp,%rbp
  4005fd:	e8 7e ff ff ff       	callq  400580 <deregister_tm_clones>
  400602:	5d                   	pop    %rbp
  400603:	c6 05 76 0a 20 00 01 	movb   $0x1,0x200a76(%rip)        # 601080 <completed.7338>
  40060a:	c3                   	retq   
  40060b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400610:	c3                   	retq   
  400611:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400616:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40061d:	00 00 00 

0000000000400620 <frame_dummy>:
  400620:	eb 8e                	jmp    4005b0 <register_tm_clones>

0000000000400622 <dummy>:
  400622:	55                   	push   %rbp
  400623:	48 89 e5             	mov    %rsp,%rbp
  400626:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  40062a:	f3 0f 11 45 f4       	movss  %xmm0,-0xc(%rbp)
  40062f:	f3 0f 11 4d f0       	movss  %xmm1,-0x10(%rbp)
  400634:	b8 00 00 00 00       	mov    $0x0,%eax
  400639:	5d                   	pop    %rbp
  40063a:	c3                   	retq   
  40063b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000400640 <get_wall_time>:
{
  400640:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  400644:	31 f6                	xor    %esi,%esi
  400646:	48 89 e7             	mov    %rsp,%rdi
  400649:	e8 72 fe ff ff       	callq  4004c0 <gettimeofday@plt>
  40064e:	85 c0                	test   %eax,%eax
  400650:	75 1f                	jne    400671 <get_wall_time+0x31>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  400652:	c5 f0 57 c9          	vxorps %xmm1,%xmm1,%xmm1
  400656:	c4 e1 f3 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm1,%xmm0
  40065d:	c4 e1 f3 2a 0c 24    	vcvtsi2sdq (%rsp),%xmm1,%xmm1
  400663:	c4 e2 f1 99 05 1c 04 	vfmadd132sd 0x41c(%rip),%xmm1,%xmm0        # 400a88 <_IO_stdin_used+0xa8>
  40066a:	00 00 
}
  40066c:	48 83 c4 18          	add    $0x18,%rsp
  400670:	c3                   	retq   
        exit(-1); // return 0;
  400671:	83 cf ff             	or     $0xffffffff,%edi
  400674:	e8 67 fe ff ff       	callq  4004e0 <exit@plt>
  400679:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000400680 <check>:
    for (unsigned int i = 0; i < LEN; i++)
  400680:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
    real sum = 0;
  400687:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40068b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
        sum += arr[i];
  400690:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  400694:	48 83 c7 04          	add    $0x4,%rdi
  400698:	48 39 f8             	cmp    %rdi,%rax
  40069b:	75 f3                	jne    400690 <check+0x10>
    printf("%f \n", sum);
  40069d:	bf e4 09 40 00       	mov    $0x4009e4,%edi
  4006a2:	b8 01 00 00 00       	mov    $0x1,%eax
  4006a7:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  4006ab:	e9 00 fe ff ff       	jmpq   4004b0 <printf@plt>

00000000004006b0 <init>:
    for (int j = 0; j < LEN; j++)
  4006b0:	c5 fa 10 05 e8 03 00 	vmovss 0x3e8(%rip),%xmm0        # 400aa0 <_IO_stdin_used+0xc0>
  4006b7:	00 
  4006b8:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  4006bd:	0f 1f 00             	nopl   (%rax)
	    x[j] = 1.0;
  4006c0:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (int j = 0; j < LEN; j++)
  4006c4:	48 83 c0 04          	add    $0x4,%rax
  4006c8:	48 3d c0 20 60 00    	cmp    $0x6020c0,%rax
  4006ce:	75 f0                	jne    4006c0 <init+0x10>
}
  4006d0:	31 c0                	xor    %eax,%eax
  4006d2:	c3                   	retq   
  4006d3:	0f 1f 00             	nopl   (%rax)
  4006d6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4006dd:	00 00 00 

00000000004006e0 <results>:
    printf("%18s  %5.1f    %5.1f     ",
  4006e0:	c5 fb 59 15 b0 03 00 	vmulsd 0x3b0(%rip),%xmm0,%xmm2        # 400a98 <_IO_stdin_used+0xb8>
  4006e7:	00 
{
  4006e8:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %5.1f    %5.1f     ",
  4006eb:	b8 02 00 00 00       	mov    $0x2,%eax
  4006f0:	bf e9 09 40 00       	mov    $0x4009e9,%edi
  4006f5:	c5 fb 59 0d 93 03 00 	vmulsd 0x393(%rip),%xmm0,%xmm1        # 400a90 <_IO_stdin_used+0xb0>
  4006fc:	00 
  4006fd:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  400701:	e9 aa fd ff ff       	jmpq   4004b0 <printf@plt>
  400706:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40070d:	00 00 00 

0000000000400710 <scale_shift>:
{
  400710:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400715:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
    init();
  400719:	31 c0                	xor    %eax,%eax
{
  40071b:	41 ff 72 f8          	pushq  -0x8(%r10)
  40071f:	55                   	push   %rbp
  400720:	48 89 e5             	mov    %rsp,%rbp
  400723:	41 54                	push   %r12
    start_t = get_wall_time();
  400725:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  40072b:	41 52                	push   %r10
  40072d:	53                   	push   %rbx
  40072e:	bb c0 20 60 00       	mov    $0x6020c0,%ebx
  400733:	48 83 ec 38          	sub    $0x38,%rsp
    init();
  400737:	e8 74 ff ff ff       	callq  4006b0 <init>
    start_t = get_wall_time();
  40073c:	31 c0                	xor    %eax,%eax
  40073e:	e8 fd fe ff ff       	callq  400640 <get_wall_time>
  400743:	c5 fc 28 1d 75 03 00 	vmovaps 0x375(%rip),%ymm3        # 400ac0 <_IO_stdin_used+0xe0>
  40074a:	00 
  40074b:	c5 fc 28 15 8d 03 00 	vmovaps 0x38d(%rip),%ymm2        # 400ae0 <_IO_stdin_used+0x100>
  400752:	00 
  400753:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
        for (unsigned int i = 0; i < LEN; i++)
  400758:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  40075d:	0f 1f 00             	nopl   (%rax)
            x[i] = alpha*x[i] + beta;
  400760:	c5 fc 28 c3          	vmovaps %ymm3,%ymm0
  400764:	c4 e2 6d 98 00       	vfmadd132ps (%rax),%ymm2,%ymm0
  400769:	48 83 c0 20          	add    $0x20,%rax
  40076d:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
        for (unsigned int i = 0; i < LEN; i++)
  400772:	48 39 c3             	cmp    %rax,%rbx
  400775:	75 e9                	jne    400760 <scale_shift+0x50>
        dummy(x, alpha, beta);
  400777:	c5 fa 10 0d 25 03 00 	vmovss 0x325(%rip),%xmm1        # 400aa4 <_IO_stdin_used+0xc4>
  40077e:	00 
  40077f:	c5 fa 10 05 21 03 00 	vmovss 0x321(%rip),%xmm0        # 400aa8 <_IO_stdin_used+0xc8>
  400786:	00 
  400787:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  40078c:	c5 f8 77             	vzeroupper 
  40078f:	e8 8e fe ff ff       	callq  400622 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400794:	41 83 ec 01          	sub    $0x1,%r12d
  400798:	c5 fc 28 1d 20 03 00 	vmovaps 0x320(%rip),%ymm3        # 400ac0 <_IO_stdin_used+0xe0>
  40079f:	00 
  4007a0:	c5 fc 28 15 38 03 00 	vmovaps 0x338(%rip),%ymm2        # 400ae0 <_IO_stdin_used+0x100>
  4007a7:	00 
  4007a8:	75 ae                	jne    400758 <scale_shift+0x48>
    end_t = get_wall_time();
  4007aa:	31 c0                	xor    %eax,%eax
  4007ac:	c5 f8 77             	vzeroupper 
  4007af:	e8 8c fe ff ff       	callq  400640 <get_wall_time>
    results(end_t - start_t, "scale_shift");
  4007b4:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  4007b9:	bf 03 0a 40 00       	mov    $0x400a03,%edi
  4007be:	e8 1d ff ff ff       	callq  4006e0 <results>
    check(x);
  4007c3:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  4007c8:	e8 b3 fe ff ff       	callq  400680 <check>
}
  4007cd:	48 83 c4 38          	add    $0x38,%rsp
  4007d1:	31 c0                	xor    %eax,%eax
  4007d3:	5b                   	pop    %rbx
  4007d4:	41 5a                	pop    %r10
  4007d6:	41 5c                	pop    %r12
  4007d8:	5d                   	pop    %rbp
  4007d9:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4007dd:	c3                   	retq   
  4007de:	66 90                	xchg   %ax,%ax

00000000004007e0 <ss_intr_SSE>:
{
  4007e0:	55                   	push   %rbp
    init();
  4007e1:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  4007e3:	bd 00 00 f0 00       	mov    $0xf00000,%ebp
{
  4007e8:	53                   	push   %rbx
  4007e9:	bb c0 20 60 00       	mov    $0x6020c0,%ebx
  4007ee:	48 83 ec 18          	sub    $0x18,%rsp
    init();
  4007f2:	e8 b9 fe ff ff       	callq  4006b0 <init>
    start_t = get_wall_time();
  4007f7:	31 c0                	xor    %eax,%eax
  4007f9:	e8 42 fe ff ff       	callq  400640 <get_wall_time>
  4007fe:	c5 f8 28 1d fa 02 00 	vmovaps 0x2fa(%rip),%xmm3        # 400b00 <_IO_stdin_used+0x120>
  400805:	00 
  400806:	c5 f8 28 15 02 03 00 	vmovaps 0x302(%rip),%xmm2        # 400b10 <_IO_stdin_used+0x130>
  40080d:	00 
  40080e:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
  400814:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  400819:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
/* Perform the respective operation on the four SPFP values in A and B.  */

extern __inline __m128 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_add_ps (__m128 __A, __m128 __B)
{
  return (__m128) ((__v4sf)__A + (__v4sf)__B);
  400820:	c5 f8 28 c3          	vmovaps %xmm3,%xmm0
  400824:	c4 e2 69 98 00       	vfmadd132ps (%rax),%xmm2,%xmm0

/* Store four SPFP values.  The address must be 16-byte aligned.  */
extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_store_ps (float *__P, __m128 __A)
{
  *(__m128 *)__P = __A;
  400829:	48 83 c0 10          	add    $0x10,%rax
  40082d:	c5 f8 29 40 f0       	vmovaps %xmm0,-0x10(%rax)
  400832:	48 39 c3             	cmp    %rax,%rbx
  400835:	75 e9                	jne    400820 <ss_intr_SSE+0x40>
        dummy(x, alpha, beta);
  400837:	c5 fa 10 0d 65 02 00 	vmovss 0x265(%rip),%xmm1        # 400aa4 <_IO_stdin_used+0xc4>
  40083e:	00 
  40083f:	c5 fa 10 05 61 02 00 	vmovss 0x261(%rip),%xmm0        # 400aa8 <_IO_stdin_used+0xc8>
  400846:	00 
  400847:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  40084c:	e8 d1 fd ff ff       	callq  400622 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400851:	83 ed 01             	sub    $0x1,%ebp
  400854:	c5 f8 28 15 b4 02 00 	vmovaps 0x2b4(%rip),%xmm2        # 400b10 <_IO_stdin_used+0x130>
  40085b:	00 
  40085c:	c5 f8 28 1d 9c 02 00 	vmovaps 0x29c(%rip),%xmm3        # 400b00 <_IO_stdin_used+0x120>
  400863:	00 
  400864:	75 ae                	jne    400814 <ss_intr_SSE+0x34>
  end_t = get_wall_time();
  400866:	31 c0                	xor    %eax,%eax
  400868:	e8 d3 fd ff ff       	callq  400640 <get_wall_time>
  results(end_t - start_t, "ss_intr_SSE");
  40086d:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  400873:	bf 0f 0a 40 00       	mov    $0x400a0f,%edi
  400878:	e8 63 fe ff ff       	callq  4006e0 <results>
  check(x);
  40087d:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  400882:	e8 f9 fd ff ff       	callq  400680 <check>
}
  400887:	48 83 c4 18          	add    $0x18,%rsp
  40088b:	31 c0                	xor    %eax,%eax
  40088d:	5b                   	pop    %rbx
  40088e:	5d                   	pop    %rbp
  40088f:	c3                   	retq   

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
  4008a3:	41 54                	push   %r12
  start_t = get_wall_time();
  4008a5:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  4008ab:	41 52                	push   %r10
  4008ad:	53                   	push   %rbx
  4008ae:	bb c0 20 60 00       	mov    $0x6020c0,%ebx
  4008b3:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  4008b7:	e8 f4 fd ff ff       	callq  4006b0 <init>
  start_t = get_wall_time();
  4008bc:	31 c0                	xor    %eax,%eax
  4008be:	e8 7d fd ff ff       	callq  400640 <get_wall_time>
  4008c3:	c5 fc 28 1d f5 01 00 	vmovaps 0x1f5(%rip),%ymm3        # 400ac0 <_IO_stdin_used+0xe0>
  4008ca:	00 
  4008cb:	c5 fc 28 15 0d 02 00 	vmovaps 0x20d(%rip),%ymm2        # 400ae0 <_IO_stdin_used+0x100>
  4008d2:	00 
  4008d3:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
        for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4008d8:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  4008dd:	0f 1f 00             	nopl   (%rax)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_add_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4008e0:	c5 fc 28 c3          	vmovaps %ymm3,%ymm0
  4008e4:	c4 e2 6d 98 00       	vfmadd132ps (%rax),%ymm2,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  4008e9:	48 83 c0 20          	add    $0x20,%rax
  4008ed:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  4008f2:	48 39 c3             	cmp    %rax,%rbx
  4008f5:	75 e9                	jne    4008e0 <ss_intr_AVX+0x50>
        dummy(x, alpha, beta);
  4008f7:	c5 fa 10 0d a5 01 00 	vmovss 0x1a5(%rip),%xmm1        # 400aa4 <_IO_stdin_used+0xc4>
  4008fe:	00 
  4008ff:	c5 fa 10 05 a1 01 00 	vmovss 0x1a1(%rip),%xmm0        # 400aa8 <_IO_stdin_used+0xc8>
  400906:	00 
  400907:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  40090c:	c5 f8 77             	vzeroupper 
  40090f:	e8 0e fd ff ff       	callq  400622 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400914:	41 83 ec 01          	sub    $0x1,%r12d
  400918:	c5 fc 28 1d a0 01 00 	vmovaps 0x1a0(%rip),%ymm3        # 400ac0 <_IO_stdin_used+0xe0>
  40091f:	00 
  400920:	c5 fc 28 15 b8 01 00 	vmovaps 0x1b8(%rip),%ymm2        # 400ae0 <_IO_stdin_used+0x100>
  400927:	00 
  400928:	75 ae                	jne    4008d8 <ss_intr_AVX+0x48>
  end_t = get_wall_time();
  40092a:	31 c0                	xor    %eax,%eax
  40092c:	c5 f8 77             	vzeroupper 
  40092f:	e8 0c fd ff ff       	callq  400640 <get_wall_time>
  results(end_t - start_t, "ss_intr_AVX");
  400934:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400939:	bf 1b 0a 40 00       	mov    $0x400a1b,%edi
  40093e:	e8 9d fd ff ff       	callq  4006e0 <results>
  check(x);
  400943:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  400948:	e8 33 fd ff ff       	callq  400680 <check>
}
  40094d:	48 83 c4 38          	add    $0x38,%rsp
  400951:	31 c0                	xor    %eax,%eax
  400953:	5b                   	pop    %rbx
  400954:	41 5a                	pop    %r10
  400956:	41 5c                	pop    %r12
  400958:	5d                   	pop    %rbp
  400959:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40095d:	c3                   	retq   
  40095e:	66 90                	xchg   %ax,%ax

0000000000400960 <__libc_csu_init>:
  400960:	41 57                	push   %r15
  400962:	41 89 ff             	mov    %edi,%r15d
  400965:	41 56                	push   %r14
  400967:	49 89 f6             	mov    %rsi,%r14
  40096a:	41 55                	push   %r13
  40096c:	49 89 d5             	mov    %rdx,%r13
  40096f:	41 54                	push   %r12
  400971:	4c 8d 25 88 04 20 00 	lea    0x200488(%rip),%r12        # 600e00 <__frame_dummy_init_array_entry>
  400978:	55                   	push   %rbp
  400979:	48 8d 2d 90 04 20 00 	lea    0x200490(%rip),%rbp        # 600e10 <__init_array_end>
  400980:	53                   	push   %rbx
  400981:	4c 29 e5             	sub    %r12,%rbp
  400984:	31 db                	xor    %ebx,%ebx
  400986:	48 c1 fd 03          	sar    $0x3,%rbp
  40098a:	48 83 ec 08          	sub    $0x8,%rsp
  40098e:	e8 dd fa ff ff       	callq  400470 <_init>
  400993:	48 85 ed             	test   %rbp,%rbp
  400996:	74 1e                	je     4009b6 <__libc_csu_init+0x56>
  400998:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40099f:	00 
  4009a0:	4c 89 ea             	mov    %r13,%rdx
  4009a3:	4c 89 f6             	mov    %r14,%rsi
  4009a6:	44 89 ff             	mov    %r15d,%edi
  4009a9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  4009ad:	48 83 c3 01          	add    $0x1,%rbx
  4009b1:	48 39 eb             	cmp    %rbp,%rbx
  4009b4:	75 ea                	jne    4009a0 <__libc_csu_init+0x40>
  4009b6:	48 83 c4 08          	add    $0x8,%rsp
  4009ba:	5b                   	pop    %rbx
  4009bb:	5d                   	pop    %rbp
  4009bc:	41 5c                	pop    %r12
  4009be:	41 5d                	pop    %r13
  4009c0:	41 5e                	pop    %r14
  4009c2:	41 5f                	pop    %r15
  4009c4:	c3                   	retq   
  4009c5:	90                   	nop
  4009c6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4009cd:	00 00 00 

00000000004009d0 <__libc_csu_fini>:
  4009d0:	f3 c3                	repz retq 

Desensamblado de la sección .fini:

00000000004009d4 <_fini>:
  4009d4:	48 83 ec 08          	sub    $0x8,%rsp
  4009d8:	48 83 c4 08          	add    $0x8,%rsp
  4009dc:	c3                   	retq   
