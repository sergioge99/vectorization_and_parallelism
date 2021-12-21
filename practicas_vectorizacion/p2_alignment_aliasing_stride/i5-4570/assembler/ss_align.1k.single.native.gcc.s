
ss_align.1k.single.native.gcc:     file format elf64-x86-64


Disassembly of section .init:

00000000004004b0 <_init>:
  4004b0:	48 83 ec 08          	sub    $0x8,%rsp
  4004b4:	48 8b 05 3d 1b 20 00 	mov    0x201b3d(%rip),%rax        # 601ff8 <__gmon_start__>
  4004bb:	48 85 c0             	test   %rax,%rax
  4004be:	74 05                	je     4004c5 <_init+0x15>
  4004c0:	e8 7b 00 00 00       	callq  400540 <.plt.got>
  4004c5:	48 83 c4 08          	add    $0x8,%rsp
  4004c9:	c3                   	retq   

Disassembly of section .plt:

00000000004004d0 <.plt>:
  4004d0:	ff 35 32 1b 20 00    	pushq  0x201b32(%rip)        # 602008 <_GLOBAL_OFFSET_TABLE_+0x8>
  4004d6:	ff 25 34 1b 20 00    	jmpq   *0x201b34(%rip)        # 602010 <_GLOBAL_OFFSET_TABLE_+0x10>
  4004dc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004004e0 <putchar@plt>:
  4004e0:	ff 25 32 1b 20 00    	jmpq   *0x201b32(%rip)        # 602018 <putchar@GLIBC_2.2.5>
  4004e6:	68 00 00 00 00       	pushq  $0x0
  4004eb:	e9 e0 ff ff ff       	jmpq   4004d0 <.plt>

00000000004004f0 <puts@plt>:
  4004f0:	ff 25 2a 1b 20 00    	jmpq   *0x201b2a(%rip)        # 602020 <puts@GLIBC_2.2.5>
  4004f6:	68 01 00 00 00       	pushq  $0x1
  4004fb:	e9 d0 ff ff ff       	jmpq   4004d0 <.plt>

0000000000400500 <printf@plt>:
  400500:	ff 25 22 1b 20 00    	jmpq   *0x201b22(%rip)        # 602028 <printf@GLIBC_2.2.5>
  400506:	68 02 00 00 00       	pushq  $0x2
  40050b:	e9 c0 ff ff ff       	jmpq   4004d0 <.plt>

0000000000400510 <gettimeofday@plt>:
  400510:	ff 25 1a 1b 20 00    	jmpq   *0x201b1a(%rip)        # 602030 <gettimeofday@GLIBC_2.2.5>
  400516:	68 03 00 00 00       	pushq  $0x3
  40051b:	e9 b0 ff ff ff       	jmpq   4004d0 <.plt>

0000000000400520 <__libc_start_main@plt>:
  400520:	ff 25 12 1b 20 00    	jmpq   *0x201b12(%rip)        # 602038 <__libc_start_main@GLIBC_2.2.5>
  400526:	68 04 00 00 00       	pushq  $0x4
  40052b:	e9 a0 ff ff ff       	jmpq   4004d0 <.plt>

0000000000400530 <exit@plt>:
  400530:	ff 25 0a 1b 20 00    	jmpq   *0x201b0a(%rip)        # 602040 <exit@GLIBC_2.2.5>
  400536:	68 05 00 00 00       	pushq  $0x5
  40053b:	e9 90 ff ff ff       	jmpq   4004d0 <.plt>

Disassembly of section .plt.got:

0000000000400540 <.plt.got>:
  400540:	ff 25 b2 1a 20 00    	jmpq   *0x201ab2(%rip)        # 601ff8 <__gmon_start__>
  400546:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000400550 <main>:
  check(x);
  return 0;
}

int main()
{
  400550:	48 83 ec 08          	sub    $0x8,%rsp
  // printf("NTIMES: %u\n", NTIMES);

  printf("Direcciones de los vectores\n");
  400554:	bf 8f 0c 40 00       	mov    $0x400c8f,%edi
  400559:	e8 92 ff ff ff       	callq  4004f0 <puts@plt>
  printf("  @a[0]: %p\n", &x);
  40055e:	be c0 20 60 00       	mov    $0x6020c0,%esi
  400563:	bf ab 0c 40 00       	mov    $0x400cab,%edi
  400568:	31 c0                	xor    %eax,%eax
  40056a:	e8 91 ff ff ff       	callq  400500 <printf@plt>
  printf("  @a[8]: %p\n", &x[8]);
  40056f:	be e0 20 60 00       	mov    $0x6020e0,%esi
  400574:	bf b8 0c 40 00       	mov    $0x400cb8,%edi
  400579:	31 c0                	xor    %eax,%eax
  40057b:	e8 80 ff ff ff       	callq  400500 <printf@plt>
  printf("\n");
  400580:	bf 0a 00 00 00       	mov    $0xa,%edi
  400585:	e8 56 ff ff ff       	callq  4004e0 <putchar@plt>

  printf("                      Time      TPI\n");
  40058a:	bf c8 0c 40 00       	mov    $0x400cc8,%edi
  40058f:	e8 5c ff ff ff       	callq  4004f0 <puts@plt>
  printf("         Loop          ns      ps/el      Checksum\n");
  400594:	bf f0 0c 40 00       	mov    $0x400cf0,%edi
  400599:	e8 52 ff ff ff       	callq  4004f0 <puts@plt>

  ss_align_v1();         /* x[] alineado */
  40059e:	31 c0                	xor    %eax,%eax
  4005a0:	e8 eb 01 00 00       	callq  400790 <ss_align_v1>
  ss_align_v2();         /* x[] no alineado */
  4005a5:	31 c0                	xor    %eax,%eax
  4005a7:	e8 b4 02 00 00       	callq  400860 <ss_align_v2>
  ss_align_v1_intr();    /* v1 con intrinsecos */
  4005ac:	31 c0                	xor    %eax,%eax
  4005ae:	e8 7d 03 00 00       	callq  400930 <ss_align_v1_intr>
  ss_align_v2_intr();    /* v2 con intrínsecos */
  4005b3:	31 c0                	xor    %eax,%eax
  4005b5:	e8 46 04 00 00       	callq  400a00 <ss_align_v2_intr>
  ss_align_v1_intru();     /* v1 con intrinsecos pero vectores no alineados */
  4005ba:	31 c0                	xor    %eax,%eax
  4005bc:	e8 0f 05 00 00       	callq  400ad0 <ss_align_v1_intru>

  exit(0);
  4005c1:	31 ff                	xor    %edi,%edi
  4005c3:	e8 68 ff ff ff       	callq  400530 <exit@plt>

00000000004005c8 <_start>:
  4005c8:	31 ed                	xor    %ebp,%ebp
  4005ca:	49 89 d1             	mov    %rdx,%r9
  4005cd:	5e                   	pop    %rsi
  4005ce:	48 89 e2             	mov    %rsp,%rdx
  4005d1:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4005d5:	50                   	push   %rax
  4005d6:	54                   	push   %rsp
  4005d7:	49 c7 c0 10 0c 40 00 	mov    $0x400c10,%r8
  4005de:	48 c7 c1 a0 0b 40 00 	mov    $0x400ba0,%rcx
  4005e5:	48 c7 c7 50 05 40 00 	mov    $0x400550,%rdi
  4005ec:	e8 2f ff ff ff       	callq  400520 <__libc_start_main@plt>
  4005f1:	f4                   	hlt    
  4005f2:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4005f9:	00 00 00 
  4005fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400600 <deregister_tm_clones>:
  400600:	b8 58 20 60 00       	mov    $0x602058,%eax
  400605:	48 3d 58 20 60 00    	cmp    $0x602058,%rax
  40060b:	74 13                	je     400620 <deregister_tm_clones+0x20>
  40060d:	b8 00 00 00 00       	mov    $0x0,%eax
  400612:	48 85 c0             	test   %rax,%rax
  400615:	74 09                	je     400620 <deregister_tm_clones+0x20>
  400617:	bf 58 20 60 00       	mov    $0x602058,%edi
  40061c:	ff e0                	jmpq   *%rax
  40061e:	66 90                	xchg   %ax,%ax
  400620:	c3                   	retq   
  400621:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400626:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40062d:	00 00 00 

0000000000400630 <register_tm_clones>:
  400630:	be 58 20 60 00       	mov    $0x602058,%esi
  400635:	48 81 ee 58 20 60 00 	sub    $0x602058,%rsi
  40063c:	48 89 f0             	mov    %rsi,%rax
  40063f:	48 c1 ee 3f          	shr    $0x3f,%rsi
  400643:	48 c1 f8 03          	sar    $0x3,%rax
  400647:	48 01 c6             	add    %rax,%rsi
  40064a:	48 d1 fe             	sar    %rsi
  40064d:	74 11                	je     400660 <register_tm_clones+0x30>
  40064f:	b8 00 00 00 00       	mov    $0x0,%eax
  400654:	48 85 c0             	test   %rax,%rax
  400657:	74 07                	je     400660 <register_tm_clones+0x30>
  400659:	bf 58 20 60 00       	mov    $0x602058,%edi
  40065e:	ff e0                	jmpq   *%rax
  400660:	c3                   	retq   
  400661:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400666:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40066d:	00 00 00 

0000000000400670 <__do_global_dtors_aux>:
  400670:	80 3d 09 1a 20 00 00 	cmpb   $0x0,0x201a09(%rip)        # 602080 <completed.7338>
  400677:	75 17                	jne    400690 <__do_global_dtors_aux+0x20>
  400679:	55                   	push   %rbp
  40067a:	48 89 e5             	mov    %rsp,%rbp
  40067d:	e8 7e ff ff ff       	callq  400600 <deregister_tm_clones>
  400682:	5d                   	pop    %rbp
  400683:	c6 05 f6 19 20 00 01 	movb   $0x1,0x2019f6(%rip)        # 602080 <completed.7338>
  40068a:	c3                   	retq   
  40068b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400690:	c3                   	retq   
  400691:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400696:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40069d:	00 00 00 

00000000004006a0 <frame_dummy>:
  4006a0:	eb 8e                	jmp    400630 <register_tm_clones>

00000000004006a2 <dummy>:
  4006a2:	55                   	push   %rbp
  4006a3:	48 89 e5             	mov    %rsp,%rbp
  4006a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  4006aa:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  4006ae:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  4006b2:	f3 0f 11 45 e4       	movss  %xmm0,-0x1c(%rbp)
  4006b7:	b8 00 00 00 00       	mov    $0x0,%eax
  4006bc:	5d                   	pop    %rbp
  4006bd:	c3                   	retq   
  4006be:	66 90                	xchg   %ax,%ax

00000000004006c0 <get_wall_time>:
{
  4006c0:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  4006c4:	31 f6                	xor    %esi,%esi
  4006c6:	48 89 e7             	mov    %rsp,%rdi
  4006c9:	e8 42 fe ff ff       	callq  400510 <gettimeofday@plt>
  4006ce:	85 c0                	test   %eax,%eax
  4006d0:	75 22                	jne    4006f4 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4006d2:	c5 e8 57 d2          	vxorps %xmm2,%xmm2,%xmm2
  4006d6:	c4 e1 eb 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm2,%xmm0
  4006dd:	c5 fb 59 0d 43 06 00 	vmulsd 0x643(%rip),%xmm0,%xmm1        # 400d28 <_IO_stdin_used+0x108>
  4006e4:	00 
  4006e5:	c4 e1 eb 2a 04 24    	vcvtsi2sdq (%rsp),%xmm2,%xmm0
}
  4006eb:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4006ef:	c5 f3 58 c0          	vaddsd %xmm0,%xmm1,%xmm0
}
  4006f3:	c3                   	retq   
        exit(-1); // return 0;
  4006f4:	83 cf ff             	or     $0xffffffff,%edi
  4006f7:	e8 34 fe ff ff       	callq  400530 <exit@plt>
  4006fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400700 <check>:
  for (unsigned int i = 0; i < LEN; i++)
  400700:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
  real sum = 0;
  400707:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40070b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    sum += arr[i];
  400710:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
  for (unsigned int i = 0; i < LEN; i++)
  400714:	48 83 c7 04          	add    $0x4,%rdi
  400718:	48 39 f8             	cmp    %rdi,%rax
  40071b:	75 f3                	jne    400710 <check+0x10>
  printf("%f \n", sum);
  40071d:	bf 24 0c 40 00       	mov    $0x400c24,%edi
  400722:	b8 01 00 00 00       	mov    $0x1,%eax
  400727:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40072b:	e9 d0 fd ff ff       	jmpq   400500 <printf@plt>

0000000000400730 <init>:
    for (int j = 0; j < LEN; j++)
  400730:	c5 fa 10 05 08 06 00 	vmovss 0x608(%rip),%xmm0        # 400d40 <_IO_stdin_used+0x120>
  400737:	00 
  400738:	b8 c0 20 60 00       	mov    $0x6020c0,%eax
  40073d:	0f 1f 00             	nopl   (%rax)
	    x[j] = 1.0;
  400740:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (int j = 0; j < LEN; j++)
  400744:	48 83 c0 04          	add    $0x4,%rax
  400748:	48 3d c0 30 60 00    	cmp    $0x6030c0,%rax
  40074e:	75 f0                	jne    400740 <init+0x10>
}
  400750:	31 c0                	xor    %eax,%eax
  400752:	c3                   	retq   
  400753:	0f 1f 00             	nopl   (%rax)
  400756:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40075d:	00 00 00 

0000000000400760 <results>:
{
  400760:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %6.1f    %6.1f     ",
  400763:	b8 02 00 00 00       	mov    $0x2,%eax
  400768:	bf 29 0c 40 00       	mov    $0x400c29,%edi
  40076d:	c5 fb 5e 15 c3 05 00 	vdivsd 0x5c3(%rip),%xmm0,%xmm2        # 400d38 <_IO_stdin_used+0x118>
  400774:	00 
  400775:	c5 fb 5e 0d b3 05 00 	vdivsd 0x5b3(%rip),%xmm0,%xmm1        # 400d30 <_IO_stdin_used+0x110>
  40077c:	00 
  40077d:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  400781:	e9 7a fd ff ff       	jmpq   400500 <printf@plt>
  400786:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40078d:	00 00 00 

0000000000400790 <ss_align_v1>:
{
  400790:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400795:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400799:	31 c0                	xor    %eax,%eax
{
  40079b:	41 ff 72 f8          	pushq  -0x8(%r10)
  40079f:	55                   	push   %rbp
  4007a0:	48 89 e5             	mov    %rsp,%rbp
  4007a3:	41 54                	push   %r12
  start_t = get_wall_time();
  4007a5:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  4007ab:	41 52                	push   %r10
  4007ad:	53                   	push   %rbx
  4007ae:	bb c0 30 60 00       	mov    $0x6030c0,%ebx
  4007b3:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  4007b7:	e8 74 ff ff ff       	callq  400730 <init>
  start_t = get_wall_time();
  4007bc:	31 c0                	xor    %eax,%eax
  4007be:	e8 fd fe ff ff       	callq  4006c0 <get_wall_time>
  4007c3:	c5 fc 28 1d 95 05 00 	vmovaps 0x595(%rip),%ymm3        # 400d60 <_IO_stdin_used+0x140>
  4007ca:	00 
  4007cb:	c5 fc 28 15 ad 05 00 	vmovaps 0x5ad(%rip),%ymm2        # 400d80 <_IO_stdin_used+0x160>
  4007d2:	00 
  4007d3:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
    for (unsigned int i = 0; i < LEN; i++)
  4007d8:	b8 c0 20 60 00       	mov    $0x6020c0,%eax
  4007dd:	0f 1f 00             	nopl   (%rax)
        x[i] = alpha*x[i] + beta;
  4007e0:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4007e4:	48 83 c0 20          	add    $0x20,%rax
  4007e8:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  4007ec:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
    for (unsigned int i = 0; i < LEN; i++)
  4007f1:	48 39 c3             	cmp    %rax,%rbx
  4007f4:	75 ea                	jne    4007e0 <ss_align_v1+0x50>
    dummy(x, alpha, beta);
  4007f6:	c5 fa 10 0d 46 05 00 	vmovss 0x546(%rip),%xmm1        # 400d44 <_IO_stdin_used+0x124>
  4007fd:	00 
  4007fe:	c5 fa 10 05 42 05 00 	vmovss 0x542(%rip),%xmm0        # 400d48 <_IO_stdin_used+0x128>
  400805:	00 
  400806:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  40080b:	c5 f8 77             	vzeroupper 
  40080e:	e8 8f fe ff ff       	callq  4006a2 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  400813:	41 ff cc             	dec    %r12d
  400816:	c5 fc 28 1d 42 05 00 	vmovaps 0x542(%rip),%ymm3        # 400d60 <_IO_stdin_used+0x140>
  40081d:	00 
  40081e:	c5 fc 28 15 5a 05 00 	vmovaps 0x55a(%rip),%ymm2        # 400d80 <_IO_stdin_used+0x160>
  400825:	00 
  400826:	75 b0                	jne    4007d8 <ss_align_v1+0x48>
  end_t = get_wall_time();
  400828:	31 c0                	xor    %eax,%eax
  40082a:	c5 f8 77             	vzeroupper 
  40082d:	e8 8e fe ff ff       	callq  4006c0 <get_wall_time>
  results(end_t - start_t, "ss_align_v1");
  400832:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400837:	bf 43 0c 40 00       	mov    $0x400c43,%edi
  40083c:	e8 1f ff ff ff       	callq  400760 <results>
  check(x);
  400841:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400846:	e8 b5 fe ff ff       	callq  400700 <check>
}
  40084b:	48 83 c4 38          	add    $0x38,%rsp
  40084f:	31 c0                	xor    %eax,%eax
  400851:	5b                   	pop    %rbx
  400852:	41 5a                	pop    %r10
  400854:	41 5c                	pop    %r12
  400856:	5d                   	pop    %rbp
  400857:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40085b:	c3                   	retq   
  40085c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400860 <ss_align_v2>:
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
  40087e:	bb c4 30 60 00       	mov    $0x6030c4,%ebx
  400883:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  400887:	e8 a4 fe ff ff       	callq  400730 <init>
  start_t = get_wall_time();
  40088c:	31 c0                	xor    %eax,%eax
  40088e:	e8 2d fe ff ff       	callq  4006c0 <get_wall_time>
  400893:	c5 fc 28 1d c5 04 00 	vmovaps 0x4c5(%rip),%ymm3        # 400d60 <_IO_stdin_used+0x140>
  40089a:	00 
  40089b:	c5 fc 28 15 dd 04 00 	vmovaps 0x4dd(%rip),%ymm2        # 400d80 <_IO_stdin_used+0x160>
  4008a2:	00 
  4008a3:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
    for (unsigned int i = 0; i < LEN; i++)
  4008a8:	b8 c4 20 60 00       	mov    $0x6020c4,%eax
  4008ad:	0f 1f 00             	nopl   (%rax)
        x[i+1] = alpha*x[i+1] + beta;
  4008b0:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4008b4:	48 83 c0 20          	add    $0x20,%rax
  4008b8:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  4008bc:	c5 fc 11 40 e0       	vmovups %ymm0,-0x20(%rax)
    for (unsigned int i = 0; i < LEN; i++)
  4008c1:	48 39 c3             	cmp    %rax,%rbx
  4008c4:	75 ea                	jne    4008b0 <ss_align_v2+0x50>
    dummy(x, alpha, beta);
  4008c6:	c5 fa 10 0d 76 04 00 	vmovss 0x476(%rip),%xmm1        # 400d44 <_IO_stdin_used+0x124>
  4008cd:	00 
  4008ce:	c5 fa 10 05 72 04 00 	vmovss 0x472(%rip),%xmm0        # 400d48 <_IO_stdin_used+0x128>
  4008d5:	00 
  4008d6:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  4008db:	c5 f8 77             	vzeroupper 
  4008de:	e8 bf fd ff ff       	callq  4006a2 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4008e3:	41 ff cc             	dec    %r12d
  4008e6:	c5 fc 28 1d 72 04 00 	vmovaps 0x472(%rip),%ymm3        # 400d60 <_IO_stdin_used+0x140>
  4008ed:	00 
  4008ee:	c5 fc 28 15 8a 04 00 	vmovaps 0x48a(%rip),%ymm2        # 400d80 <_IO_stdin_used+0x160>
  4008f5:	00 
  4008f6:	75 b0                	jne    4008a8 <ss_align_v2+0x48>
  end_t = get_wall_time();
  4008f8:	31 c0                	xor    %eax,%eax
  4008fa:	c5 f8 77             	vzeroupper 
  4008fd:	e8 be fd ff ff       	callq  4006c0 <get_wall_time>
  results(end_t - start_t, "ss_align_v2");
  400902:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400907:	bf 4f 0c 40 00       	mov    $0x400c4f,%edi
  40090c:	e8 4f fe ff ff       	callq  400760 <results>
  check(x);
  400911:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400916:	e8 e5 fd ff ff       	callq  400700 <check>
}
  40091b:	48 83 c4 38          	add    $0x38,%rsp
  40091f:	31 c0                	xor    %eax,%eax
  400921:	5b                   	pop    %rbx
  400922:	41 5a                	pop    %r10
  400924:	41 5c                	pop    %r12
  400926:	5d                   	pop    %rbp
  400927:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  40092b:	c3                   	retq   
  40092c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400930 <ss_align_v1_intr>:
{
  400930:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400935:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400939:	31 c0                	xor    %eax,%eax
{
  40093b:	41 ff 72 f8          	pushq  -0x8(%r10)
  40093f:	55                   	push   %rbp
  400940:	48 89 e5             	mov    %rsp,%rbp
  400943:	41 54                	push   %r12
  start_t = get_wall_time();
  400945:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  40094b:	41 52                	push   %r10
  40094d:	53                   	push   %rbx
  40094e:	bb c0 30 60 00       	mov    $0x6030c0,%ebx
  400953:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  400957:	e8 d4 fd ff ff       	callq  400730 <init>
  start_t = get_wall_time();
  40095c:	31 c0                	xor    %eax,%eax
  40095e:	e8 5d fd ff ff       	callq  4006c0 <get_wall_time>
  400963:	c5 fc 28 1d f5 03 00 	vmovaps 0x3f5(%rip),%ymm3        # 400d60 <_IO_stdin_used+0x140>
  40096a:	00 
  40096b:	c5 fc 28 15 0d 04 00 	vmovaps 0x40d(%rip),%ymm2        # 400d80 <_IO_stdin_used+0x160>
  400972:	00 
  400973:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  400978:	b8 c0 20 60 00       	mov    $0x6020c0,%eax
  40097d:	0f 1f 00             	nopl   (%rax)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_mul_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  400980:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  400984:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  400988:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  40098c:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  400991:	48 39 c3             	cmp    %rax,%rbx
  400994:	75 ea                	jne    400980 <ss_align_v1_intr+0x50>
        dummy(x, alpha, beta);
  400996:	c5 fa 10 0d a6 03 00 	vmovss 0x3a6(%rip),%xmm1        # 400d44 <_IO_stdin_used+0x124>
  40099d:	00 
  40099e:	c5 fa 10 05 a2 03 00 	vmovss 0x3a2(%rip),%xmm0        # 400d48 <_IO_stdin_used+0x128>
  4009a5:	00 
  4009a6:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  4009ab:	c5 f8 77             	vzeroupper 
  4009ae:	e8 ef fc ff ff       	callq  4006a2 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  4009b3:	41 ff cc             	dec    %r12d
  4009b6:	c5 fc 28 1d a2 03 00 	vmovaps 0x3a2(%rip),%ymm3        # 400d60 <_IO_stdin_used+0x140>
  4009bd:	00 
  4009be:	c5 fc 28 15 ba 03 00 	vmovaps 0x3ba(%rip),%ymm2        # 400d80 <_IO_stdin_used+0x160>
  4009c5:	00 
  4009c6:	75 b0                	jne    400978 <ss_align_v1_intr+0x48>
  end_t = get_wall_time();
  4009c8:	31 c0                	xor    %eax,%eax
  4009ca:	c5 f8 77             	vzeroupper 
  4009cd:	e8 ee fc ff ff       	callq  4006c0 <get_wall_time>
  results(end_t - start_t, "ss_align_v1_intr");
  4009d2:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  4009d7:	bf 5b 0c 40 00       	mov    $0x400c5b,%edi
  4009dc:	e8 7f fd ff ff       	callq  400760 <results>
  check(x);
  4009e1:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  4009e6:	e8 15 fd ff ff       	callq  400700 <check>
}
  4009eb:	48 83 c4 38          	add    $0x38,%rsp
  4009ef:	31 c0                	xor    %eax,%eax
  4009f1:	5b                   	pop    %rbx
  4009f2:	41 5a                	pop    %r10
  4009f4:	41 5c                	pop    %r12
  4009f6:	5d                   	pop    %rbp
  4009f7:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4009fb:	c3                   	retq   
  4009fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400a00 <ss_align_v2_intr>:
{
  400a00:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400a05:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400a09:	31 c0                	xor    %eax,%eax
{
  400a0b:	41 ff 72 f8          	pushq  -0x8(%r10)
  400a0f:	55                   	push   %rbp
  400a10:	48 89 e5             	mov    %rsp,%rbp
  400a13:	41 54                	push   %r12
  start_t = get_wall_time();
  400a15:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  400a1b:	41 52                	push   %r10
  400a1d:	53                   	push   %rbx
  400a1e:	bb c4 30 60 00       	mov    $0x6030c4,%ebx
  400a23:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  400a27:	e8 04 fd ff ff       	callq  400730 <init>
  start_t = get_wall_time();
  400a2c:	31 c0                	xor    %eax,%eax
  400a2e:	e8 8d fc ff ff       	callq  4006c0 <get_wall_time>
  400a33:	c5 fc 28 1d 25 03 00 	vmovaps 0x325(%rip),%ymm3        # 400d60 <_IO_stdin_used+0x140>
  400a3a:	00 
  400a3b:	c5 fc 28 15 3d 03 00 	vmovaps 0x33d(%rip),%ymm2        # 400d80 <_IO_stdin_used+0x160>
  400a42:	00 
  400a43:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  400a48:	b8 c4 20 60 00       	mov    $0x6020c4,%eax
  400a4d:	0f 1f 00             	nopl   (%rax)
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  400a50:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  400a54:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  400a58:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_storeu_ps (float *__P, __m256 __A)
{
  *(__m256_u *)__P = __A;
  400a5c:	c5 fc 11 40 e0       	vmovups %ymm0,-0x20(%rax)
  400a61:	48 39 c3             	cmp    %rax,%rbx
  400a64:	75 ea                	jne    400a50 <ss_align_v2_intr+0x50>
    dummy(x, alpha, beta);
  400a66:	c5 fa 10 0d d6 02 00 	vmovss 0x2d6(%rip),%xmm1        # 400d44 <_IO_stdin_used+0x124>
  400a6d:	00 
  400a6e:	c5 fa 10 05 d2 02 00 	vmovss 0x2d2(%rip),%xmm0        # 400d48 <_IO_stdin_used+0x128>
  400a75:	00 
  400a76:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400a7b:	c5 f8 77             	vzeroupper 
  400a7e:	e8 1f fc ff ff       	callq  4006a2 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  400a83:	41 ff cc             	dec    %r12d
  400a86:	c5 fc 28 1d d2 02 00 	vmovaps 0x2d2(%rip),%ymm3        # 400d60 <_IO_stdin_used+0x140>
  400a8d:	00 
  400a8e:	c5 fc 28 15 ea 02 00 	vmovaps 0x2ea(%rip),%ymm2        # 400d80 <_IO_stdin_used+0x160>
  400a95:	00 
  400a96:	75 b0                	jne    400a48 <ss_align_v2_intr+0x48>
  end_t = get_wall_time();
  400a98:	31 c0                	xor    %eax,%eax
  400a9a:	c5 f8 77             	vzeroupper 
  400a9d:	e8 1e fc ff ff       	callq  4006c0 <get_wall_time>
  results(end_t - start_t, "ss_align_v2_intr");
  400aa2:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400aa7:	bf 6c 0c 40 00       	mov    $0x400c6c,%edi
  400aac:	e8 af fc ff ff       	callq  400760 <results>
  check(x);
  400ab1:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400ab6:	e8 45 fc ff ff       	callq  400700 <check>
}
  400abb:	48 83 c4 38          	add    $0x38,%rsp
  400abf:	31 c0                	xor    %eax,%eax
  400ac1:	5b                   	pop    %rbx
  400ac2:	41 5a                	pop    %r10
  400ac4:	41 5c                	pop    %r12
  400ac6:	5d                   	pop    %rbp
  400ac7:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400acb:	c3                   	retq   
  400acc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400ad0 <ss_align_v1_intru>:
{
  400ad0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400ad5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400ad9:	31 c0                	xor    %eax,%eax
{
  400adb:	41 ff 72 f8          	pushq  -0x8(%r10)
  400adf:	55                   	push   %rbp
  400ae0:	48 89 e5             	mov    %rsp,%rbp
  400ae3:	41 54                	push   %r12
  start_t = get_wall_time();
  400ae5:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  400aeb:	41 52                	push   %r10
  400aed:	53                   	push   %rbx
  400aee:	bb c4 30 60 00       	mov    $0x6030c4,%ebx
  400af3:	48 83 ec 38          	sub    $0x38,%rsp
  init();
  400af7:	e8 34 fc ff ff       	callq  400730 <init>
  start_t = get_wall_time();
  400afc:	31 c0                	xor    %eax,%eax
  400afe:	e8 bd fb ff ff       	callq  4006c0 <get_wall_time>
  400b03:	c5 fc 28 1d 55 02 00 	vmovaps 0x255(%rip),%ymm3        # 400d60 <_IO_stdin_used+0x140>
  400b0a:	00 
  400b0b:	c5 fc 28 15 6d 02 00 	vmovaps 0x26d(%rip),%ymm2        # 400d80 <_IO_stdin_used+0x160>
  400b12:	00 
  400b13:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  400b18:	b8 c4 20 60 00       	mov    $0x6020c4,%eax
  400b1d:	0f 1f 00             	nopl   (%rax)
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  400b20:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  400b24:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  400b28:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  *(__m256 *)__P = __A;
  400b2c:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  400b31:	48 39 c3             	cmp    %rax,%rbx
  400b34:	75 ea                	jne    400b20 <ss_align_v1_intru+0x50>
        dummy(x, alpha, beta);
  400b36:	c5 fa 10 0d 06 02 00 	vmovss 0x206(%rip),%xmm1        # 400d44 <_IO_stdin_used+0x124>
  400b3d:	00 
  400b3e:	c5 fa 10 05 02 02 00 	vmovss 0x202(%rip),%xmm0        # 400d48 <_IO_stdin_used+0x128>
  400b45:	00 
  400b46:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400b4b:	c5 f8 77             	vzeroupper 
  400b4e:	e8 4f fb ff ff       	callq  4006a2 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  400b53:	41 ff cc             	dec    %r12d
  400b56:	c5 fc 28 1d 02 02 00 	vmovaps 0x202(%rip),%ymm3        # 400d60 <_IO_stdin_used+0x140>
  400b5d:	00 
  400b5e:	c5 fc 28 15 1a 02 00 	vmovaps 0x21a(%rip),%ymm2        # 400d80 <_IO_stdin_used+0x160>
  400b65:	00 
  400b66:	75 b0                	jne    400b18 <ss_align_v1_intru+0x48>
  end_t = get_wall_time();
  400b68:	31 c0                	xor    %eax,%eax
  400b6a:	c5 f8 77             	vzeroupper 
  400b6d:	e8 4e fb ff ff       	callq  4006c0 <get_wall_time>
  results(end_t - start_t, "ss_align_v1_intru");
  400b72:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400b77:	bf 7d 0c 40 00       	mov    $0x400c7d,%edi
  400b7c:	e8 df fb ff ff       	callq  400760 <results>
  check(x);
  400b81:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400b86:	e8 75 fb ff ff       	callq  400700 <check>
}
  400b8b:	48 83 c4 38          	add    $0x38,%rsp
  400b8f:	31 c0                	xor    %eax,%eax
  400b91:	5b                   	pop    %rbx
  400b92:	41 5a                	pop    %r10
  400b94:	41 5c                	pop    %r12
  400b96:	5d                   	pop    %rbp
  400b97:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400b9b:	c3                   	retq   
  400b9c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400ba0 <__libc_csu_init>:
  400ba0:	41 57                	push   %r15
  400ba2:	41 89 ff             	mov    %edi,%r15d
  400ba5:	41 56                	push   %r14
  400ba7:	49 89 f6             	mov    %rsi,%r14
  400baa:	41 55                	push   %r13
  400bac:	49 89 d5             	mov    %rdx,%r13
  400baf:	41 54                	push   %r12
  400bb1:	4c 8d 25 50 12 20 00 	lea    0x201250(%rip),%r12        # 601e08 <__frame_dummy_init_array_entry>
  400bb8:	55                   	push   %rbp
  400bb9:	48 8d 2d 50 12 20 00 	lea    0x201250(%rip),%rbp        # 601e10 <__init_array_end>
  400bc0:	53                   	push   %rbx
  400bc1:	4c 29 e5             	sub    %r12,%rbp
  400bc4:	31 db                	xor    %ebx,%ebx
  400bc6:	48 c1 fd 03          	sar    $0x3,%rbp
  400bca:	48 83 ec 08          	sub    $0x8,%rsp
  400bce:	e8 dd f8 ff ff       	callq  4004b0 <_init>
  400bd3:	48 85 ed             	test   %rbp,%rbp
  400bd6:	74 1e                	je     400bf6 <__libc_csu_init+0x56>
  400bd8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  400bdf:	00 
  400be0:	4c 89 ea             	mov    %r13,%rdx
  400be3:	4c 89 f6             	mov    %r14,%rsi
  400be6:	44 89 ff             	mov    %r15d,%edi
  400be9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  400bed:	48 83 c3 01          	add    $0x1,%rbx
  400bf1:	48 39 eb             	cmp    %rbp,%rbx
  400bf4:	75 ea                	jne    400be0 <__libc_csu_init+0x40>
  400bf6:	48 83 c4 08          	add    $0x8,%rsp
  400bfa:	5b                   	pop    %rbx
  400bfb:	5d                   	pop    %rbp
  400bfc:	41 5c                	pop    %r12
  400bfe:	41 5d                	pop    %r13
  400c00:	41 5e                	pop    %r14
  400c02:	41 5f                	pop    %r15
  400c04:	c3                   	retq   
  400c05:	90                   	nop
  400c06:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400c0d:	00 00 00 

0000000000400c10 <__libc_csu_fini>:
  400c10:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000400c14 <_fini>:
  400c14:	48 83 ec 08          	sub    $0x8,%rsp
  400c18:	48 83 c4 08          	add    $0x8,%rsp
  400c1c:	c3                   	retq   
