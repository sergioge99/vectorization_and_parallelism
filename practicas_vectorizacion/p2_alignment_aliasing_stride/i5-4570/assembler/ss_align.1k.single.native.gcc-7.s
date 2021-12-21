
ss_align.1k.single.native.gcc-7:     file format elf64-x86-64


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
  400554:	bf 6f 0d 40 00       	mov    $0x400d6f,%edi
  400559:	e8 92 ff ff ff       	callq  4004f0 <puts@plt>
  printf("  @a[0]: %p\n", &x);
  40055e:	be c0 20 60 00       	mov    $0x6020c0,%esi
  400563:	bf 8b 0d 40 00       	mov    $0x400d8b,%edi
  400568:	31 c0                	xor    %eax,%eax
  40056a:	e8 91 ff ff ff       	callq  400500 <printf@plt>
  printf("  @a[8]: %p\n", &x[8]);
  40056f:	be e0 20 60 00       	mov    $0x6020e0,%esi
  400574:	bf 98 0d 40 00       	mov    $0x400d98,%edi
  400579:	31 c0                	xor    %eax,%eax
  40057b:	e8 80 ff ff ff       	callq  400500 <printf@plt>
  printf("\n");
  400580:	bf 0a 00 00 00       	mov    $0xa,%edi
  400585:	e8 56 ff ff ff       	callq  4004e0 <putchar@plt>

  printf("                      Time      TPI\n");
  40058a:	bf a8 0d 40 00       	mov    $0x400da8,%edi
  40058f:	e8 5c ff ff ff       	callq  4004f0 <puts@plt>
  printf("         Loop          ns      ps/el      Checksum\n");
  400594:	bf d0 0d 40 00       	mov    $0x400dd0,%edi
  400599:	e8 52 ff ff ff       	callq  4004f0 <puts@plt>

  ss_align_v1();         /* x[] alineado */
  40059e:	31 c0                	xor    %eax,%eax
  4005a0:	e8 eb 01 00 00       	callq  400790 <ss_align_v1>
  ss_align_v2();         /* x[] no alineado */
  4005a5:	31 c0                	xor    %eax,%eax
  4005a7:	e8 c4 02 00 00       	callq  400870 <ss_align_v2>
  ss_align_v1_intr();    /* v1 con intrinsecos */
  4005ac:	31 c0                	xor    %eax,%eax
  4005ae:	e8 3d 04 00 00       	callq  4009f0 <ss_align_v1_intr>
  ss_align_v2_intr();    /* v2 con intrínsecos */
  4005b3:	31 c0                	xor    %eax,%eax
  4005b5:	e8 16 05 00 00       	callq  400ad0 <ss_align_v2_intr>
  //ss_align_v1_intru();     /* v1 con intrinsecos pero vectores no alineados */

  exit(0);
  4005ba:	31 ff                	xor    %edi,%edi
  4005bc:	e8 6f ff ff ff       	callq  400530 <exit@plt>

00000000004005c1 <_start>:
  4005c1:	31 ed                	xor    %ebp,%ebp
  4005c3:	49 89 d1             	mov    %rdx,%r9
  4005c6:	5e                   	pop    %rsi
  4005c7:	48 89 e2             	mov    %rsp,%rdx
  4005ca:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4005ce:	50                   	push   %rax
  4005cf:	54                   	push   %rsp
  4005d0:	49 c7 c0 e0 0c 40 00 	mov    $0x400ce0,%r8
  4005d7:	48 c7 c1 70 0c 40 00 	mov    $0x400c70,%rcx
  4005de:	48 c7 c7 50 05 40 00 	mov    $0x400550,%rdi
  4005e5:	e8 36 ff ff ff       	callq  400520 <__libc_start_main@plt>
  4005ea:	f4                   	hlt    
  4005eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000004005f0 <deregister_tm_clones>:
  4005f0:	55                   	push   %rbp
  4005f1:	b8 58 20 60 00       	mov    $0x602058,%eax
  4005f6:	48 3d 58 20 60 00    	cmp    $0x602058,%rax
  4005fc:	48 89 e5             	mov    %rsp,%rbp
  4005ff:	74 17                	je     400618 <deregister_tm_clones+0x28>
  400601:	b8 00 00 00 00       	mov    $0x0,%eax
  400606:	48 85 c0             	test   %rax,%rax
  400609:	74 0d                	je     400618 <deregister_tm_clones+0x28>
  40060b:	bf 58 20 60 00       	mov    $0x602058,%edi
  400610:	5d                   	pop    %rbp
  400611:	ff e0                	jmpq   *%rax
  400613:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400618:	5d                   	pop    %rbp
  400619:	c3                   	retq   
  40061a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400620 <register_tm_clones>:
  400620:	be 58 20 60 00       	mov    $0x602058,%esi
  400625:	55                   	push   %rbp
  400626:	48 81 ee 58 20 60 00 	sub    $0x602058,%rsi
  40062d:	48 89 e5             	mov    %rsp,%rbp
  400630:	48 c1 fe 03          	sar    $0x3,%rsi
  400634:	48 89 f0             	mov    %rsi,%rax
  400637:	48 c1 e8 3f          	shr    $0x3f,%rax
  40063b:	48 01 c6             	add    %rax,%rsi
  40063e:	48 d1 fe             	sar    %rsi
  400641:	74 15                	je     400658 <register_tm_clones+0x38>
  400643:	b8 00 00 00 00       	mov    $0x0,%eax
  400648:	48 85 c0             	test   %rax,%rax
  40064b:	74 0b                	je     400658 <register_tm_clones+0x38>
  40064d:	bf 58 20 60 00       	mov    $0x602058,%edi
  400652:	5d                   	pop    %rbp
  400653:	ff e0                	jmpq   *%rax
  400655:	0f 1f 00             	nopl   (%rax)
  400658:	5d                   	pop    %rbp
  400659:	c3                   	retq   
  40065a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400660 <__do_global_dtors_aux>:
  400660:	80 3d 19 1a 20 00 00 	cmpb   $0x0,0x201a19(%rip)        # 602080 <completed.6908>
  400667:	75 17                	jne    400680 <__do_global_dtors_aux+0x20>
  400669:	55                   	push   %rbp
  40066a:	48 89 e5             	mov    %rsp,%rbp
  40066d:	e8 7e ff ff ff       	callq  4005f0 <deregister_tm_clones>
  400672:	c6 05 07 1a 20 00 01 	movb   $0x1,0x201a07(%rip)        # 602080 <completed.6908>
  400679:	5d                   	pop    %rbp
  40067a:	c3                   	retq   
  40067b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400680:	c3                   	retq   
  400681:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400686:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40068d:	00 00 00 

0000000000400690 <frame_dummy>:
  400690:	55                   	push   %rbp
  400691:	48 89 e5             	mov    %rsp,%rbp
  400694:	5d                   	pop    %rbp
  400695:	eb 89                	jmp    400620 <register_tm_clones>

0000000000400697 <dummy>:
  400697:	55                   	push   %rbp
  400698:	48 89 e5             	mov    %rsp,%rbp
  40069b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  40069f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  4006a3:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  4006a7:	f3 0f 11 45 e4       	movss  %xmm0,-0x1c(%rbp)
  4006ac:	b8 00 00 00 00       	mov    $0x0,%eax
  4006b1:	5d                   	pop    %rbp
  4006b2:	c3                   	retq   
  4006b3:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4006ba:	00 00 00 
  4006bd:	0f 1f 00             	nopl   (%rax)

00000000004006c0 <get_wall_time>:
{
  4006c0:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  4006c4:	31 f6                	xor    %esi,%esi
  4006c6:	48 89 e7             	mov    %rsp,%rdi
  4006c9:	e8 42 fe ff ff       	callq  400510 <gettimeofday@plt>
  4006ce:	85 c0                	test   %eax,%eax
  4006d0:	75 26                	jne    4006f8 <get_wall_time+0x38>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4006d2:	c5 f9 57 c0          	vxorpd %xmm0,%xmm0,%xmm0
  4006d6:	c5 f1 57 c9          	vxorpd %xmm1,%xmm1,%xmm1
  4006da:	c4 e1 fb 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm0,%xmm0
  4006e1:	c5 fb 59 05 1f 07 00 	vmulsd 0x71f(%rip),%xmm0,%xmm0        # 400e08 <_IO_stdin_used+0x108>
  4006e8:	00 
  4006e9:	c4 e1 f3 2a 0c 24    	vcvtsi2sdq (%rsp),%xmm1,%xmm1
}
  4006ef:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4006f3:	c5 fb 58 c1          	vaddsd %xmm1,%xmm0,%xmm0
}
  4006f7:	c3                   	retq   
        exit(-1); // return 0;
  4006f8:	83 cf ff             	or     $0xffffffff,%edi
  4006fb:	e8 30 fe ff ff       	callq  400530 <exit@plt>

0000000000400700 <check>:
{
  400700:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
  real sum = 0;
  400707:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40070b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    sum += arr[i];
  400710:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
  400714:	48 83 c7 04          	add    $0x4,%rdi
  for (unsigned int i = 0; i < LEN; i++)
  400718:	48 39 f8             	cmp    %rdi,%rax
  40071b:	75 f3                	jne    400710 <check+0x10>
  printf("%f \n", sum);
  40071d:	bf 04 0d 40 00       	mov    $0x400d04,%edi
  400722:	b8 01 00 00 00       	mov    $0x1,%eax
  400727:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40072b:	e9 d0 fd ff ff       	jmpq   400500 <printf@plt>

0000000000400730 <init>:
{
  400730:	c5 fa 10 05 e8 06 00 	vmovss 0x6e8(%rip),%xmm0        # 400e20 <_IO_stdin_used+0x120>
  400737:	00 
  400738:	b8 c0 20 60 00       	mov    $0x6020c0,%eax
  40073d:	0f 1f 00             	nopl   (%rax)
	    x[j] = 1.0;
  400740:	c5 fa 11 00          	vmovss %xmm0,(%rax)
  400744:	48 83 c0 04          	add    $0x4,%rax
    for (int j = 0; j < LEN; j++)
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
{
  400768:	c5 f9 28 c8          	vmovapd %xmm0,%xmm1
    printf("%18s  %6.1f    %6.1f     ",
  40076c:	bf 09 0d 40 00       	mov    $0x400d09,%edi
  400771:	c5 fb 5e 05 9f 06 00 	vdivsd 0x69f(%rip),%xmm0,%xmm0        # 400e18 <_IO_stdin_used+0x118>
  400778:	00 
  400779:	c5 f3 5e 0d 8f 06 00 	vdivsd 0x68f(%rip),%xmm1,%xmm1        # 400e10 <_IO_stdin_used+0x110>
  400780:	00 
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
  4007b3:	48 83 ec 78          	sub    $0x78,%rsp
  init();
  4007b7:	e8 74 ff ff ff       	callq  400730 <init>
  start_t = get_wall_time();
  4007bc:	31 c0                	xor    %eax,%eax
  4007be:	e8 fd fe ff ff       	callq  4006c0 <get_wall_time>
  4007c3:	c5 fc 28 1d 75 06 00 	vmovaps 0x675(%rip),%ymm3        # 400e40 <_IO_stdin_used+0x140>
  4007ca:	00 
  4007cb:	c5 fc 28 15 8d 06 00 	vmovaps 0x68d(%rip),%ymm2        # 400e60 <_IO_stdin_used+0x160>
  4007d2:	00 
  4007d3:	c5 fb 11 45 88       	vmovsd %xmm0,-0x78(%rbp)
  4007d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4007df:	00 
  4007e0:	b8 c0 20 60 00       	mov    $0x6020c0,%eax
  4007e5:	0f 1f 00             	nopl   (%rax)
        x[i] = alpha*x[i] + beta;
  4007e8:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4007ec:	48 83 c0 20          	add    $0x20,%rax
  4007f0:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  4007f4:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  4007f9:	48 39 c3             	cmp    %rax,%rbx
  4007fc:	75 ea                	jne    4007e8 <ss_align_v1+0x58>
    dummy(x, alpha, beta);
  4007fe:	c5 fa 10 0d 1e 06 00 	vmovss 0x61e(%rip),%xmm1        # 400e24 <_IO_stdin_used+0x124>
  400805:	00 
  400806:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  40080b:	c5 fc 29 55 90       	vmovaps %ymm2,-0x70(%rbp)
  400810:	c5 fa 10 05 10 06 00 	vmovss 0x610(%rip),%xmm0        # 400e28 <_IO_stdin_used+0x128>
  400817:	00 
  400818:	c5 fc 29 5d b0       	vmovaps %ymm3,-0x50(%rbp)
  40081d:	c5 f8 77             	vzeroupper 
  400820:	e8 72 fe ff ff       	callq  400697 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  400825:	41 83 ec 01          	sub    $0x1,%r12d
  400829:	c5 fc 28 5d b0       	vmovaps -0x50(%rbp),%ymm3
  40082e:	c5 fc 28 55 90       	vmovaps -0x70(%rbp),%ymm2
  400833:	75 ab                	jne    4007e0 <ss_align_v1+0x50>
  end_t = get_wall_time();
  400835:	31 c0                	xor    %eax,%eax
  400837:	c5 f8 77             	vzeroupper 
  40083a:	e8 81 fe ff ff       	callq  4006c0 <get_wall_time>
  results(end_t - start_t, "ss_align_v1");
  40083f:	c5 fb 5c 45 88       	vsubsd -0x78(%rbp),%xmm0,%xmm0
  400844:	bf 23 0d 40 00       	mov    $0x400d23,%edi
  400849:	e8 12 ff ff ff       	callq  400760 <results>
  check(x);
  40084e:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400853:	e8 a8 fe ff ff       	callq  400700 <check>
}
  400858:	48 83 c4 78          	add    $0x78,%rsp
  40085c:	31 c0                	xor    %eax,%eax
  40085e:	5b                   	pop    %rbx
  40085f:	41 5a                	pop    %r10
  400861:	41 5c                	pop    %r12
  400863:	5d                   	pop    %rbp
  400864:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400868:	c3                   	retq   
  400869:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000400870 <ss_align_v2>:
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
  40088e:	bb c0 30 60 00       	mov    $0x6030c0,%ebx
  400893:	48 83 ec 78          	sub    $0x78,%rsp
  init();
  400897:	e8 94 fe ff ff       	callq  400730 <init>
  start_t = get_wall_time();
  40089c:	31 c0                	xor    %eax,%eax
  40089e:	e8 1d fe ff ff       	callq  4006c0 <get_wall_time>
  4008a3:	c5 fa 10 2d 7d 05 00 	vmovss 0x57d(%rip),%xmm5        # 400e28 <_IO_stdin_used+0x128>
  4008aa:	00 
  4008ab:	c5 fa 10 25 71 05 00 	vmovss 0x571(%rip),%xmm4        # 400e24 <_IO_stdin_used+0x124>
  4008b2:	00 
  4008b3:	c5 fc 28 1d 85 05 00 	vmovaps 0x585(%rip),%ymm3        # 400e40 <_IO_stdin_used+0x140>
  4008ba:	00 
  4008bb:	c5 fc 28 15 9d 05 00 	vmovaps 0x59d(%rip),%ymm2        # 400e60 <_IO_stdin_used+0x160>
  4008c2:	00 
  4008c3:	c5 fb 11 45 c0       	vmovsd %xmm0,-0x40(%rbp)
  4008c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4008cf:	00 
        x[i+1] = alpha*x[i+1] + beta;
  4008d0:	c5 f8 10 35 ec 17 20 	vmovups 0x2017ec(%rip),%xmm6        # 6020c4 <x+0x4>
  4008d7:	00 
  4008d8:	c5 c8 59 05 a0 05 00 	vmulps 0x5a0(%rip),%xmm6,%xmm0        # 400e80 <_IO_stdin_used+0x180>
  4008df:	00 
  4008e0:	b8 e0 20 60 00       	mov    $0x6020e0,%eax
  4008e5:	c5 f8 58 05 a3 05 00 	vaddps 0x5a3(%rip),%xmm0,%xmm0        # 400e90 <_IO_stdin_used+0x190>
  4008ec:	00 
  4008ed:	c5 f8 11 05 cf 17 20 	vmovups %xmm0,0x2017cf(%rip)        # 6020c4 <x+0x4>
  4008f4:	00 
  4008f5:	c5 d2 59 05 d7 17 20 	vmulss 0x2017d7(%rip),%xmm5,%xmm0        # 6020d4 <x+0x14>
  4008fc:	00 
  4008fd:	c5 fa 58 c4          	vaddss %xmm4,%xmm0,%xmm0
  400901:	c5 fa 11 05 cb 17 20 	vmovss %xmm0,0x2017cb(%rip)        # 6020d4 <x+0x14>
  400908:	00 
  400909:	c5 d2 59 05 c7 17 20 	vmulss 0x2017c7(%rip),%xmm5,%xmm0        # 6020d8 <x+0x18>
  400910:	00 
  400911:	c5 fa 58 c4          	vaddss %xmm4,%xmm0,%xmm0
  400915:	c5 fa 11 05 bb 17 20 	vmovss %xmm0,0x2017bb(%rip)        # 6020d8 <x+0x18>
  40091c:	00 
  40091d:	c5 d2 59 05 b7 17 20 	vmulss 0x2017b7(%rip),%xmm5,%xmm0        # 6020dc <x+0x1c>
  400924:	00 
  400925:	c5 fa 58 c4          	vaddss %xmm4,%xmm0,%xmm0
  400929:	c5 fa 11 05 ab 17 20 	vmovss %xmm0,0x2017ab(%rip)        # 6020dc <x+0x1c>
  400930:	00 
  400931:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  400938:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  40093c:	48 83 c0 20          	add    $0x20,%rax
  400940:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  400944:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  400949:	48 39 c3             	cmp    %rax,%rbx
  40094c:	75 ea                	jne    400938 <ss_align_v2+0xc8>
    dummy(x, alpha, beta);
  40094e:	c5 f8 28 cc          	vmovaps %xmm4,%xmm1
  400952:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400957:	c5 fc 29 95 70 ff ff 	vmovaps %ymm2,-0x90(%rbp)
  40095e:	ff 
        x[i+1] = alpha*x[i+1] + beta;
  40095f:	c5 d2 59 05 59 27 20 	vmulss 0x202759(%rip),%xmm5,%xmm0        # 6030c0 <x+0x1000>
  400966:	00 
  400967:	c5 fc 29 5d 90       	vmovaps %ymm3,-0x70(%rbp)
    dummy(x, alpha, beta);
  40096c:	c5 fa 11 65 c8       	vmovss %xmm4,-0x38(%rbp)
  400971:	c5 fa 11 6d cc       	vmovss %xmm5,-0x34(%rbp)
        x[i+1] = alpha*x[i+1] + beta;
  400976:	c5 fa 58 c4          	vaddss %xmm4,%xmm0,%xmm0
  40097a:	c5 fa 11 05 3e 27 20 	vmovss %xmm0,0x20273e(%rip)        # 6030c0 <x+0x1000>
  400981:	00 
    dummy(x, alpha, beta);
  400982:	c5 f8 28 c5          	vmovaps %xmm5,%xmm0
  400986:	c5 f8 77             	vzeroupper 
  400989:	e8 09 fd ff ff       	callq  400697 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40098e:	41 83 ec 01          	sub    $0x1,%r12d
  400992:	c5 fa 10 6d cc       	vmovss -0x34(%rbp),%xmm5
  400997:	c5 fa 10 65 c8       	vmovss -0x38(%rbp),%xmm4
  40099c:	c5 fc 28 5d 90       	vmovaps -0x70(%rbp),%ymm3
  4009a1:	c5 fc 28 95 70 ff ff 	vmovaps -0x90(%rbp),%ymm2
  4009a8:	ff 
  4009a9:	0f 85 21 ff ff ff    	jne    4008d0 <ss_align_v2+0x60>
  end_t = get_wall_time();
  4009af:	31 c0                	xor    %eax,%eax
  4009b1:	c5 f8 77             	vzeroupper 
  4009b4:	e8 07 fd ff ff       	callq  4006c0 <get_wall_time>
  results(end_t - start_t, "ss_align_v2");
  4009b9:	c5 fb 5c 45 c0       	vsubsd -0x40(%rbp),%xmm0,%xmm0
  4009be:	bf 2f 0d 40 00       	mov    $0x400d2f,%edi
  4009c3:	e8 98 fd ff ff       	callq  400760 <results>
  check(x);
  4009c8:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  4009cd:	e8 2e fd ff ff       	callq  400700 <check>
}
  4009d2:	48 83 c4 78          	add    $0x78,%rsp
  4009d6:	31 c0                	xor    %eax,%eax
  4009d8:	5b                   	pop    %rbx
  4009d9:	41 5a                	pop    %r10
  4009db:	41 5c                	pop    %r12
  4009dd:	5d                   	pop    %rbp
  4009de:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4009e2:	c3                   	retq   
  4009e3:	0f 1f 00             	nopl   (%rax)
  4009e6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4009ed:	00 00 00 

00000000004009f0 <ss_align_v1_intr>:
{
  4009f0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4009f5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  4009f9:	31 c0                	xor    %eax,%eax
{
  4009fb:	41 ff 72 f8          	pushq  -0x8(%r10)
  4009ff:	55                   	push   %rbp
  400a00:	48 89 e5             	mov    %rsp,%rbp
  400a03:	41 54                	push   %r12
  start_t = get_wall_time();
  400a05:	41 bc 00 00 f0 00    	mov    $0xf00000,%r12d
{
  400a0b:	41 52                	push   %r10
  400a0d:	53                   	push   %rbx
  400a0e:	bb c0 30 60 00       	mov    $0x6030c0,%ebx
  400a13:	48 83 ec 78          	sub    $0x78,%rsp
  init();
  400a17:	e8 14 fd ff ff       	callq  400730 <init>
  start_t = get_wall_time();
  400a1c:	31 c0                	xor    %eax,%eax
  400a1e:	e8 9d fc ff ff       	callq  4006c0 <get_wall_time>
  400a23:	c5 fc 28 1d 15 04 00 	vmovaps 0x415(%rip),%ymm3        # 400e40 <_IO_stdin_used+0x140>
  400a2a:	00 
  400a2b:	c5 fc 28 15 2d 04 00 	vmovaps 0x42d(%rip),%ymm2        # 400e60 <_IO_stdin_used+0x160>
  400a32:	00 
  400a33:	c5 fb 11 45 88       	vmovsd %xmm0,-0x78(%rbp)
  400a38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  400a3f:	00 
  400a40:	b8 c0 20 60 00       	mov    $0x6020c0,%eax
  400a45:	0f 1f 00             	nopl   (%rax)
}

extern __inline __m256 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_mul_ps (__m256 __A, __m256 __B)
{
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  400a48:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  400a4c:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  400a50:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_store_ps (float *__P, __m256 __A)
{
  *(__m256 *)__P = __A;
  400a54:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  400a59:	48 39 c3             	cmp    %rax,%rbx
  400a5c:	75 ea                	jne    400a48 <ss_align_v1_intr+0x58>
        dummy(x, alpha, beta);
  400a5e:	c5 fa 10 0d be 03 00 	vmovss 0x3be(%rip),%xmm1        # 400e24 <_IO_stdin_used+0x124>
  400a65:	00 
  400a66:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400a6b:	c5 fc 29 55 90       	vmovaps %ymm2,-0x70(%rbp)
  400a70:	c5 fa 10 05 b0 03 00 	vmovss 0x3b0(%rip),%xmm0        # 400e28 <_IO_stdin_used+0x128>
  400a77:	00 
  400a78:	c5 fc 29 5d b0       	vmovaps %ymm3,-0x50(%rbp)
  400a7d:	c5 f8 77             	vzeroupper 
  400a80:	e8 12 fc ff ff       	callq  400697 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  400a85:	41 83 ec 01          	sub    $0x1,%r12d
  400a89:	c5 fc 28 5d b0       	vmovaps -0x50(%rbp),%ymm3
  400a8e:	c5 fc 28 55 90       	vmovaps -0x70(%rbp),%ymm2
  400a93:	75 ab                	jne    400a40 <ss_align_v1_intr+0x50>
  end_t = get_wall_time();
  400a95:	31 c0                	xor    %eax,%eax
  400a97:	c5 f8 77             	vzeroupper 
  400a9a:	e8 21 fc ff ff       	callq  4006c0 <get_wall_time>
  results(end_t - start_t, "ss_align_v1_intr");
  400a9f:	c5 fb 5c 45 88       	vsubsd -0x78(%rbp),%xmm0,%xmm0
  400aa4:	bf 3b 0d 40 00       	mov    $0x400d3b,%edi
  400aa9:	e8 b2 fc ff ff       	callq  400760 <results>
  check(x);
  400aae:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400ab3:	e8 48 fc ff ff       	callq  400700 <check>
}
  400ab8:	48 83 c4 78          	add    $0x78,%rsp
  400abc:	31 c0                	xor    %eax,%eax
  400abe:	5b                   	pop    %rbx
  400abf:	41 5a                	pop    %r10
  400ac1:	41 5c                	pop    %r12
  400ac3:	5d                   	pop    %rbp
  400ac4:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400ac8:	c3                   	retq   
  400ac9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000400ad0 <ss_align_v2_intr>:
{
  400ad0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400ad5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400ad9:	31 c0                	xor    %eax,%eax
{
  400adb:	41 ff 72 f8          	pushq  -0x8(%r10)
  400adf:	55                   	push   %rbp
  400ae0:	48 89 e5             	mov    %rsp,%rbp
  400ae3:	41 52                	push   %r10
  400ae5:	53                   	push   %rbx
  start_t = get_wall_time();
  400ae6:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  400aeb:	48 83 ec 60          	sub    $0x60,%rsp
  init();
  400aef:	e8 3c fc ff ff       	callq  400730 <init>
  start_t = get_wall_time();
  400af4:	31 c0                	xor    %eax,%eax
  400af6:	e8 c5 fb ff ff       	callq  4006c0 <get_wall_time>
  400afb:	c5 fc 28 1d 3d 03 00 	vmovaps 0x33d(%rip),%ymm3        # 400e40 <_IO_stdin_used+0x140>
  400b02:	00 
  400b03:	c5 fc 28 15 55 03 00 	vmovaps 0x355(%rip),%ymm2        # 400e60 <_IO_stdin_used+0x160>
  400b0a:	00 
  400b0b:	c5 fb 11 45 a8       	vmovsd %xmm0,-0x58(%rbp)
  400b10:	b8 c4 20 60 00       	mov    $0x6020c4,%eax
  400b15:	0f 1f 00             	nopl   (%rax)
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  400b18:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  400b1c:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  400b20:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
}

extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_storeu_ps (float *__P, __m256 __A)
{
  *(__m256_u *)__P = __A;
  400b24:	c5 fc 11 40 e0       	vmovups %ymm0,-0x20(%rax)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  400b29:	48 3d c4 30 60 00    	cmp    $0x6030c4,%rax
  400b2f:	75 e7                	jne    400b18 <ss_align_v2_intr+0x48>
    dummy(x, alpha, beta);
  400b31:	c5 fa 10 0d eb 02 00 	vmovss 0x2eb(%rip),%xmm1        # 400e24 <_IO_stdin_used+0x124>
  400b38:	00 
  400b39:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400b3e:	c5 fc 29 55 b0       	vmovaps %ymm2,-0x50(%rbp)
  400b43:	c5 fa 10 05 dd 02 00 	vmovss 0x2dd(%rip),%xmm0        # 400e28 <_IO_stdin_used+0x128>
  400b4a:	00 
  400b4b:	c5 fc 29 5d d0       	vmovaps %ymm3,-0x30(%rbp)
  400b50:	c5 f8 77             	vzeroupper 
  400b53:	e8 3f fb ff ff       	callq  400697 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  400b58:	83 eb 01             	sub    $0x1,%ebx
  400b5b:	c5 fc 28 5d d0       	vmovaps -0x30(%rbp),%ymm3
  400b60:	c5 fc 28 55 b0       	vmovaps -0x50(%rbp),%ymm2
  400b65:	75 a9                	jne    400b10 <ss_align_v2_intr+0x40>
  end_t = get_wall_time();
  400b67:	31 c0                	xor    %eax,%eax
  400b69:	c5 f8 77             	vzeroupper 
  400b6c:	e8 4f fb ff ff       	callq  4006c0 <get_wall_time>
  results(end_t - start_t, "ss_align_v2_intr");
  400b71:	c5 fb 5c 45 a8       	vsubsd -0x58(%rbp),%xmm0,%xmm0
  400b76:	bf 4c 0d 40 00       	mov    $0x400d4c,%edi
  400b7b:	e8 e0 fb ff ff       	callq  400760 <results>
  check(x);
  400b80:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400b85:	e8 76 fb ff ff       	callq  400700 <check>
}
  400b8a:	48 83 c4 60          	add    $0x60,%rsp
  400b8e:	31 c0                	xor    %eax,%eax
  400b90:	5b                   	pop    %rbx
  400b91:	41 5a                	pop    %r10
  400b93:	5d                   	pop    %rbp
  400b94:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400b98:	c3                   	retq   
  400b99:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000400ba0 <ss_align_v1_intru>:
{
  400ba0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400ba5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400ba9:	31 c0                	xor    %eax,%eax
{
  400bab:	41 ff 72 f8          	pushq  -0x8(%r10)
  400baf:	55                   	push   %rbp
  400bb0:	48 89 e5             	mov    %rsp,%rbp
  400bb3:	41 52                	push   %r10
  400bb5:	53                   	push   %rbx
  start_t = get_wall_time();
  400bb6:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  400bbb:	48 83 ec 60          	sub    $0x60,%rsp
  init();
  400bbf:	e8 6c fb ff ff       	callq  400730 <init>
  start_t = get_wall_time();
  400bc4:	31 c0                	xor    %eax,%eax
  400bc6:	e8 f5 fa ff ff       	callq  4006c0 <get_wall_time>
  400bcb:	c5 fc 28 1d 6d 02 00 	vmovaps 0x26d(%rip),%ymm3        # 400e40 <_IO_stdin_used+0x140>
  400bd2:	00 
  400bd3:	c5 fc 28 15 85 02 00 	vmovaps 0x285(%rip),%ymm2        # 400e60 <_IO_stdin_used+0x160>
  400bda:	00 
  400bdb:	c5 fb 11 45 a8       	vmovsd %xmm0,-0x58(%rbp)
  400be0:	b8 c4 20 60 00       	mov    $0x6020c4,%eax
  400be5:	0f 1f 00             	nopl   (%rax)
  return (__m256) ((__v8sf)__A * (__v8sf)__B);
  400be8:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  400bec:	48 83 c0 20          	add    $0x20,%rax
  return (__m256) ((__v8sf)__A + (__v8sf)__B);
  400bf0:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  *(__m256 *)__P = __A;
  400bf4:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
    for (unsigned int i = 0; i < LEN; i+= AVX_LEN)
  400bf9:	48 3d c4 30 60 00    	cmp    $0x6030c4,%rax
  400bff:	75 e7                	jne    400be8 <ss_align_v1_intru+0x48>
        dummy(x, alpha, beta);
  400c01:	c5 fa 10 0d 1b 02 00 	vmovss 0x21b(%rip),%xmm1        # 400e24 <_IO_stdin_used+0x124>
  400c08:	00 
  400c09:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400c0e:	c5 fc 29 55 b0       	vmovaps %ymm2,-0x50(%rbp)
  400c13:	c5 fa 10 05 0d 02 00 	vmovss 0x20d(%rip),%xmm0        # 400e28 <_IO_stdin_used+0x128>
  400c1a:	00 
  400c1b:	c5 fc 29 5d d0       	vmovaps %ymm3,-0x30(%rbp)
  400c20:	c5 f8 77             	vzeroupper 
  400c23:	e8 6f fa ff ff       	callq  400697 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  400c28:	83 eb 01             	sub    $0x1,%ebx
  400c2b:	c5 fc 28 5d d0       	vmovaps -0x30(%rbp),%ymm3
  400c30:	c5 fc 28 55 b0       	vmovaps -0x50(%rbp),%ymm2
  400c35:	75 a9                	jne    400be0 <ss_align_v1_intru+0x40>
  end_t = get_wall_time();
  400c37:	31 c0                	xor    %eax,%eax
  400c39:	c5 f8 77             	vzeroupper 
  400c3c:	e8 7f fa ff ff       	callq  4006c0 <get_wall_time>
  results(end_t - start_t, "ss_align_v1_intru");
  400c41:	c5 fb 5c 45 a8       	vsubsd -0x58(%rbp),%xmm0,%xmm0
  400c46:	bf 5d 0d 40 00       	mov    $0x400d5d,%edi
  400c4b:	e8 10 fb ff ff       	callq  400760 <results>
  check(x);
  400c50:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400c55:	e8 a6 fa ff ff       	callq  400700 <check>
}
  400c5a:	48 83 c4 60          	add    $0x60,%rsp
  400c5e:	31 c0                	xor    %eax,%eax
  400c60:	5b                   	pop    %rbx
  400c61:	41 5a                	pop    %r10
  400c63:	5d                   	pop    %rbp
  400c64:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400c68:	c3                   	retq   
  400c69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000400c70 <__libc_csu_init>:
  400c70:	41 57                	push   %r15
  400c72:	41 89 ff             	mov    %edi,%r15d
  400c75:	41 56                	push   %r14
  400c77:	49 89 f6             	mov    %rsi,%r14
  400c7a:	41 55                	push   %r13
  400c7c:	49 89 d5             	mov    %rdx,%r13
  400c7f:	41 54                	push   %r12
  400c81:	4c 8d 25 80 11 20 00 	lea    0x201180(%rip),%r12        # 601e08 <__frame_dummy_init_array_entry>
  400c88:	55                   	push   %rbp
  400c89:	48 8d 2d 80 11 20 00 	lea    0x201180(%rip),%rbp        # 601e10 <__init_array_end>
  400c90:	53                   	push   %rbx
  400c91:	4c 29 e5             	sub    %r12,%rbp
  400c94:	31 db                	xor    %ebx,%ebx
  400c96:	48 c1 fd 03          	sar    $0x3,%rbp
  400c9a:	48 83 ec 08          	sub    $0x8,%rsp
  400c9e:	e8 0d f8 ff ff       	callq  4004b0 <_init>
  400ca3:	48 85 ed             	test   %rbp,%rbp
  400ca6:	74 1e                	je     400cc6 <__libc_csu_init+0x56>
  400ca8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  400caf:	00 
  400cb0:	4c 89 ea             	mov    %r13,%rdx
  400cb3:	4c 89 f6             	mov    %r14,%rsi
  400cb6:	44 89 ff             	mov    %r15d,%edi
  400cb9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  400cbd:	48 83 c3 01          	add    $0x1,%rbx
  400cc1:	48 39 eb             	cmp    %rbp,%rbx
  400cc4:	75 ea                	jne    400cb0 <__libc_csu_init+0x40>
  400cc6:	48 83 c4 08          	add    $0x8,%rsp
  400cca:	5b                   	pop    %rbx
  400ccb:	5d                   	pop    %rbp
  400ccc:	41 5c                	pop    %r12
  400cce:	41 5d                	pop    %r13
  400cd0:	41 5e                	pop    %r14
  400cd2:	41 5f                	pop    %r15
  400cd4:	c3                   	retq   
  400cd5:	90                   	nop
  400cd6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400cdd:	00 00 00 

0000000000400ce0 <__libc_csu_fini>:
  400ce0:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000400ce4 <_fini>:
  400ce4:	48 83 ec 08          	sub    $0x8,%rsp
  400ce8:	48 83 c4 08          	add    $0x8,%rsp
  400cec:	c3                   	retq   
