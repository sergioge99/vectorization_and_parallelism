
scale_shift.1k.single.esc.avxfma.gcc:     formato del fichero elf64-x86-64


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
  40051a:	e8 f1 01 00 00       	callq  400710 <scale_shift>
  ss_intr_SSE();
  40051f:	31 c0                	xor    %eax,%eax
  400521:	e8 8a 02 00 00       	callq  4007b0 <ss_intr_SSE>
  ss_intr_AVX();
  400526:	31 c0                	xor    %eax,%eax
  400528:	e8 33 03 00 00       	callq  400860 <ss_intr_AVX>
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
  400562:	49 c7 c0 a0 09 40 00 	mov    $0x4009a0,%r8
  400569:	48 c7 c1 30 09 40 00 	mov    $0x400930,%rcx
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
  400663:	c4 e2 f1 99 05 fc 03 	vfmadd132sd 0x3fc(%rip),%xmm1,%xmm0        # 400a68 <_IO_stdin_used+0xa8>
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
  40069d:	bf c4 09 40 00       	mov    $0x4009c4,%edi
  4006a2:	b8 01 00 00 00       	mov    $0x1,%eax
  4006a7:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  4006ab:	e9 00 fe ff ff       	jmpq   4004b0 <printf@plt>

00000000004006b0 <init>:
    for (int j = 0; j < LEN; j++)
  4006b0:	c5 fa 10 05 c8 03 00 	vmovss 0x3c8(%rip),%xmm0        # 400a80 <_IO_stdin_used+0xc0>
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
  4006e0:	c5 fb 59 15 90 03 00 	vmulsd 0x390(%rip),%xmm0,%xmm2        # 400a78 <_IO_stdin_used+0xb8>
  4006e7:	00 
{
  4006e8:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %5.1f    %5.1f     ",
  4006eb:	b8 02 00 00 00       	mov    $0x2,%eax
  4006f0:	bf c9 09 40 00       	mov    $0x4009c9,%edi
  4006f5:	c5 fb 59 0d 73 03 00 	vmulsd 0x373(%rip),%xmm0,%xmm1        # 400a70 <_IO_stdin_used+0xb0>
  4006fc:	00 
  4006fd:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  400701:	e9 aa fd ff ff       	jmpq   4004b0 <printf@plt>
  400706:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40070d:	00 00 00 

0000000000400710 <scale_shift>:
{
  400710:	53                   	push   %rbx
    init();
  400711:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  400713:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  400718:	48 83 ec 10          	sub    $0x10,%rsp
    init();
  40071c:	e8 8f ff ff ff       	callq  4006b0 <init>
    start_t = get_wall_time();
  400721:	31 c0                	xor    %eax,%eax
  400723:	e8 18 ff ff ff       	callq  400640 <get_wall_time>
  400728:	c5 fa 10 15 54 03 00 	vmovss 0x354(%rip),%xmm2        # 400a84 <_IO_stdin_used+0xc4>
  40072f:	00 
  400730:	c5 fa 10 0d 50 03 00 	vmovss 0x350(%rip),%xmm1        # 400a88 <_IO_stdin_used+0xc8>
  400737:	00 
  400738:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
        for (unsigned int i = 0; i < LEN; i++)
  40073e:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  400743:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
            x[i] = alpha*x[i] + beta;
  400748:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  40074c:	c4 e2 71 99 00       	vfmadd132ss (%rax),%xmm1,%xmm0
  400751:	48 83 c0 04          	add    $0x4,%rax
  400755:	c5 fa 11 40 fc       	vmovss %xmm0,-0x4(%rax)
        for (unsigned int i = 0; i < LEN; i++)
  40075a:	48 3d c0 20 60 00    	cmp    $0x6020c0,%rax
  400760:	75 e6                	jne    400748 <scale_shift+0x38>
        dummy(x, alpha, beta);
  400762:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  400766:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  40076b:	e8 b2 fe ff ff       	callq  400622 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400770:	83 eb 01             	sub    $0x1,%ebx
  400773:	c5 fa 10 15 09 03 00 	vmovss 0x309(%rip),%xmm2        # 400a84 <_IO_stdin_used+0xc4>
  40077a:	00 
  40077b:	c5 fa 10 0d 05 03 00 	vmovss 0x305(%rip),%xmm1        # 400a88 <_IO_stdin_used+0xc8>
  400782:	00 
  400783:	75 b9                	jne    40073e <scale_shift+0x2e>
    end_t = get_wall_time();
  400785:	31 c0                	xor    %eax,%eax
  400787:	e8 b4 fe ff ff       	callq  400640 <get_wall_time>
    results(end_t - start_t, "scale_shift");
  40078c:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  400792:	bf e3 09 40 00       	mov    $0x4009e3,%edi
  400797:	e8 44 ff ff ff       	callq  4006e0 <results>
    check(x);
  40079c:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  4007a1:	e8 da fe ff ff       	callq  400680 <check>
}
  4007a6:	48 83 c4 10          	add    $0x10,%rsp
  4007aa:	31 c0                	xor    %eax,%eax
  4007ac:	5b                   	pop    %rbx
  4007ad:	c3                   	retq   
  4007ae:	66 90                	xchg   %ax,%ax

00000000004007b0 <ss_intr_SSE>:
{
  4007b0:	55                   	push   %rbp
    init();
  4007b1:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  4007b3:	bd 00 00 f0 00       	mov    $0xf00000,%ebp
{
  4007b8:	53                   	push   %rbx
  4007b9:	bb c0 20 60 00       	mov    $0x6020c0,%ebx
  4007be:	48 83 ec 18          	sub    $0x18,%rsp
    init();
  4007c2:	e8 e9 fe ff ff       	callq  4006b0 <init>
    start_t = get_wall_time();
  4007c7:	31 c0                	xor    %eax,%eax
  4007c9:	e8 72 fe ff ff       	callq  400640 <get_wall_time>
  4007ce:	c5 f8 28 1d ba 02 00 	vmovaps 0x2ba(%rip),%xmm3        # 400a90 <_IO_stdin_used+0xd0>
  4007d5:	00 
  4007d6:	c5 f8 28 15 c2 02 00 	vmovaps 0x2c2(%rip),%xmm2        # 400aa0 <_IO_stdin_used+0xe0>
  4007dd:	00 
  4007de:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
        for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
  4007e4:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  4007e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
/* Perform the respective operation on the four SPFP values in A and B.  */

extern __inline __m128 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_add_ps (__m128 __A, __m128 __B)
{
  return (__m128) ((__v4sf)__A + (__v4sf)__B);
  4007f0:	c5 f8 28 c3          	vmovaps %xmm3,%xmm0
  4007f4:	c4 e2 69 98 00       	vfmadd132ps (%rax),%xmm2,%xmm0

/* Store four SPFP values.  The address must be 16-byte aligned.  */
extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_store_ps (float *__P, __m128 __A)
{
  *(__m128 *)__P = __A;
  4007f9:	48 83 c0 10          	add    $0x10,%rax
  4007fd:	c5 f8 29 40 f0       	vmovaps %xmm0,-0x10(%rax)
  400802:	48 39 c3             	cmp    %rax,%rbx
  400805:	75 e9                	jne    4007f0 <ss_intr_SSE+0x40>
        dummy(x, alpha, beta);
  400807:	c5 fa 10 0d 79 02 00 	vmovss 0x279(%rip),%xmm1        # 400a88 <_IO_stdin_used+0xc8>
  40080e:	00 
  40080f:	c5 fa 10 05 6d 02 00 	vmovss 0x26d(%rip),%xmm0        # 400a84 <_IO_stdin_used+0xc4>
  400816:	00 
  400817:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  40081c:	e8 01 fe ff ff       	callq  400622 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400821:	83 ed 01             	sub    $0x1,%ebp
  400824:	c5 f8 28 1d 64 02 00 	vmovaps 0x264(%rip),%xmm3        # 400a90 <_IO_stdin_used+0xd0>
  40082b:	00 
  40082c:	c5 f8 28 15 6c 02 00 	vmovaps 0x26c(%rip),%xmm2        # 400aa0 <_IO_stdin_used+0xe0>
  400833:	00 
  400834:	75 ae                	jne    4007e4 <ss_intr_SSE+0x34>
  end_t = get_wall_time();
  400836:	31 c0                	xor    %eax,%eax
  400838:	e8 03 fe ff ff       	callq  400640 <get_wall_time>
  results(end_t - start_t, "ss_intr_SSE");
  40083d:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  400843:	bf ef 09 40 00       	mov    $0x4009ef,%edi
  400848:	e8 93 fe ff ff       	callq  4006e0 <results>
  check(x);
  40084d:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  400852:	e8 29 fe ff ff       	callq  400680 <check>
}
  400857:	48 83 c4 18          	add    $0x18,%rsp
  40085b:	31 c0                	xor    %eax,%eax
  40085d:	5b                   	pop    %rbx
  40085e:	5d                   	pop    %rbp
  40085f:	c3                   	retq   

0000000000400860 <ss_intr_AVX>:
{
  400860:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400865:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400869:	31 c0                	xor    %eax,%eax
{
  40086b:	41 ff 72 f8          	pushq  -0x8(%r10)
  40086f:	55                   	push   %rbp
  400870:	48 89 e5             	mov    %rsp,%rbp
  400873:	41 54                	push   %r12
  start_t = get_wall_time();
  400875:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  40087b:	41 52                	push   %r10
  40087d:	53                   	push   %rbx
  40087e:	bb c0 20 60 00       	mov    $0x6020c0,%ebx
  400883:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  400887:	e8 24 fe ff ff       	callq  4006b0 <init>
  start_t = get_wall_time();
  40088c:	31 c0                	xor    %eax,%eax
  40088e:	e8 ad fd ff ff       	callq  400640 <get_wall_time>
  400893:	c5 fc 28 1d 25 02 00 	vmovaps 0x225(%rip),%ymm3        # 400ac0 <_IO_stdin_used+0x100>
  40089a:	00 
  40089b:	c5 fc 28 15 3d 02 00 	vmovaps 0x23d(%rip),%ymm2        # 400ae0 <_IO_stdin_used+0x120>
  4008a2:	00 
  4008a3:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
        for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  4008a8:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  4008ad:	0f 1f 00             	nopl   (%rax)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_add_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  4008b0:	c5 fc 28 c3          	vmovaps %ymm3,%ymm0
  4008b4:	c4 e2 6d 98 00       	vfmadd132ps (%rax),%ymm2,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  4008b9:	48 83 c0 20          	add    $0x20,%rax
  4008bd:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  4008c2:	48 39 c3             	cmp    %rax,%rbx
  4008c5:	75 e9                	jne    4008b0 <ss_intr_AVX+0x50>
        dummy(x, alpha, beta);
  4008c7:	c5 fa 10 0d b9 01 00 	vmovss 0x1b9(%rip),%xmm1        # 400a88 <_IO_stdin_used+0xc8>
  4008ce:	00 
  4008cf:	c5 fa 10 05 ad 01 00 	vmovss 0x1ad(%rip),%xmm0        # 400a84 <_IO_stdin_used+0xc4>
  4008d6:	00 
  4008d7:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  4008dc:	c5 f8 77             	vzeroupper 
  4008df:	e8 3e fd ff ff       	callq  400622 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4008e4:	41 83 ec 01          	sub    $0x1,%r12d
  4008e8:	c5 fc 28 1d d0 01 00 	vmovaps 0x1d0(%rip),%ymm3        # 400ac0 <_IO_stdin_used+0x100>
  4008ef:	00 
  4008f0:	c5 fc 28 15 e8 01 00 	vmovaps 0x1e8(%rip),%ymm2        # 400ae0 <_IO_stdin_used+0x120>
  4008f7:	00 
  4008f8:	75 ae                	jne    4008a8 <ss_intr_AVX+0x48>
  end_t = get_wall_time();
  4008fa:	31 c0                	xor    %eax,%eax
  4008fc:	c5 f8 77             	vzeroupper 
  4008ff:	e8 3c fd ff ff       	callq  400640 <get_wall_time>
  results(end_t - start_t, "ss_intr_AVX");
  400904:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400909:	bf fb 09 40 00       	mov    $0x4009fb,%edi
  40090e:	e8 cd fd ff ff       	callq  4006e0 <results>
  check(x);
  400913:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  400918:	e8 63 fd ff ff       	callq  400680 <check>
}
  40091d:	48 83 c4 38          	add    $0x38,%rsp
  400921:	31 c0                	xor    %eax,%eax
  400923:	5b                   	pop    %rbx
  400924:	41 5a                	pop    %r10
  400926:	41 5c                	pop    %r12
  400928:	5d                   	pop    %rbp
  400929:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40092d:	c3                   	retq   
  40092e:	66 90                	xchg   %ax,%ax

0000000000400930 <__libc_csu_init>:
  400930:	41 57                	push   %r15
  400932:	41 89 ff             	mov    %edi,%r15d
  400935:	41 56                	push   %r14
  400937:	49 89 f6             	mov    %rsi,%r14
  40093a:	41 55                	push   %r13
  40093c:	49 89 d5             	mov    %rdx,%r13
  40093f:	41 54                	push   %r12
  400941:	4c 8d 25 b8 04 20 00 	lea    0x2004b8(%rip),%r12        # 600e00 <__frame_dummy_init_array_entry>
  400948:	55                   	push   %rbp
  400949:	48 8d 2d c0 04 20 00 	lea    0x2004c0(%rip),%rbp        # 600e10 <__init_array_end>
  400950:	53                   	push   %rbx
  400951:	4c 29 e5             	sub    %r12,%rbp
  400954:	31 db                	xor    %ebx,%ebx
  400956:	48 c1 fd 03          	sar    $0x3,%rbp
  40095a:	48 83 ec 08          	sub    $0x8,%rsp
  40095e:	e8 0d fb ff ff       	callq  400470 <_init>
  400963:	48 85 ed             	test   %rbp,%rbp
  400966:	74 1e                	je     400986 <__libc_csu_init+0x56>
  400968:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40096f:	00 
  400970:	4c 89 ea             	mov    %r13,%rdx
  400973:	4c 89 f6             	mov    %r14,%rsi
  400976:	44 89 ff             	mov    %r15d,%edi
  400979:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  40097d:	48 83 c3 01          	add    $0x1,%rbx
  400981:	48 39 eb             	cmp    %rbp,%rbx
  400984:	75 ea                	jne    400970 <__libc_csu_init+0x40>
  400986:	48 83 c4 08          	add    $0x8,%rsp
  40098a:	5b                   	pop    %rbx
  40098b:	5d                   	pop    %rbp
  40098c:	41 5c                	pop    %r12
  40098e:	41 5d                	pop    %r13
  400990:	41 5e                	pop    %r14
  400992:	41 5f                	pop    %r15
  400994:	c3                   	retq   
  400995:	90                   	nop
  400996:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40099d:	00 00 00 

00000000004009a0 <__libc_csu_fini>:
  4009a0:	f3 c3                	repz retq 

Desensamblado de la sección .fini:

00000000004009a4 <_fini>:
  4009a4:	48 83 ec 08          	sub    $0x8,%rsp
  4009a8:	48 83 c4 08          	add    $0x8,%rsp
  4009ac:	c3                   	retq   
