
ss_alias.1k.single.native.gcc:     file format elf64-x86-64


Disassembly of section .init:

0000000000400470 <_init>:
  400470:	48 83 ec 08          	sub    $0x8,%rsp
  400474:	48 8b 05 7d 1b 20 00 	mov    0x201b7d(%rip),%rax        # 601ff8 <__gmon_start__>
  40047b:	48 85 c0             	test   %rax,%rax
  40047e:	74 05                	je     400485 <_init+0x15>
  400480:	e8 6b 00 00 00       	callq  4004f0 <.plt.got>
  400485:	48 83 c4 08          	add    $0x8,%rsp
  400489:	c3                   	retq   

Disassembly of section .plt:

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

Disassembly of section .plt.got:

00000000004004f0 <.plt.got>:
  4004f0:	ff 25 02 1b 20 00    	jmpq   *0x201b02(%rip)        # 601ff8 <__gmon_start__>
  4004f6:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000400500 <main>:
  check(y);
  return 0;
}

int main()
{
  400500:	48 83 ec 08          	sub    $0x8,%rsp
  //x = aligned_alloc(SIMD_ALIGN, (LEN+1)*sizeof(real));
  //y = aligned_alloc(SIMD_ALIGN, (LEN+1)*sizeof(real));
    
  /* y[] = alpha*x[] + beta */

  printf("                     Time       TPI\n");
  400504:	bf 28 0d 40 00       	mov    $0x400d28,%edi
  400509:	e8 92 ff ff ff       	callq  4004a0 <puts@plt>
  printf("             Loop     ns       ps/el     Checksum\n");
  40050e:	bf 50 0d 40 00       	mov    $0x400d50,%edi
  400513:	e8 88 ff ff ff       	callq  4004a0 <puts@plt>

  ss_alias_v1(&y[1], y);      /* solapamiento y dependencia */
  400518:	be c0 20 60 00       	mov    $0x6020c0,%esi
  40051d:	bf c4 20 60 00       	mov    $0x6020c4,%edi
  400522:	e8 59 02 00 00       	callq  400780 <ss_alias_v1>
  ss_alias_v1(y, &y[1]);      /* solapamiento, no dependencia */
  400527:	be c4 20 60 00       	mov    $0x6020c4,%esi
  40052c:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400531:	e8 4a 02 00 00       	callq  400780 <ss_alias_v1>
  ss_alias_v1(y, y);          /* solapamiento, no dependencia */
  400536:	be c0 20 60 00       	mov    $0x6020c0,%esi
  40053b:	48 89 f7             	mov    %rsi,%rdi
  40053e:	e8 3d 02 00 00       	callq  400780 <ss_alias_v1>
  ss_alias_v1(y, x);          /* no solapamiento, no dependencia */
  400543:	be 00 31 60 00       	mov    $0x603100,%esi
  400548:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  40054d:	e8 2e 02 00 00       	callq  400780 <ss_alias_v1>

  /* restrict en parametros */
  ss_alias_v2(&y[1], &x[1]);    /* no solapamiento, no dependencia */
  400552:	be 04 31 60 00       	mov    $0x603104,%esi
  400557:	bf c4 20 60 00       	mov    $0x6020c4,%edi
  40055c:	e8 5f 03 00 00       	callq  4008c0 <ss_alias_v2>
  ss_alias_v2(y, x);            /* no solapamiento, no dependencia */
  400561:	be 00 31 60 00       	mov    $0x603100,%esi
  400566:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  40056b:	e8 50 03 00 00       	callq  4008c0 <ss_alias_v2>

  /* #pragma GCC ivdep */
  ss_alias_v3(&y[1], &x[1]);    /* no solapamiento, no dependencia */
  400570:	be 04 31 60 00       	mov    $0x603104,%esi
  400575:	bf c4 20 60 00       	mov    $0x6020c4,%edi
  40057a:	e8 21 04 00 00       	callq  4009a0 <ss_alias_v3>
  ss_alias_v3(y, x);            /* no solapamiento, no dependencia */
  40057f:	be 00 31 60 00       	mov    $0x603100,%esi
  400584:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400589:	e8 12 04 00 00       	callq  4009a0 <ss_alias_v3>

  /* restrict en parametros + __builtin_assume_aligned() */
  ss_alias_v4(y, x);             /* no solapamiento, no dependencia */
  40058e:	be 00 31 60 00       	mov    $0x603100,%esi
  400593:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400598:	e8 e3 04 00 00       	callq  400a80 <ss_alias_v4>

  /* scale_and_shift variables globales */
  scale_and_shift();                             /* solapamiento, no dependencia */
  40059d:	31 c0                	xor    %eax,%eax
  40059f:	e8 bc 05 00 00       	callq  400b60 <scale_and_shift>

  return 0;
}
  4005a4:	31 c0                	xor    %eax,%eax
  4005a6:	48 83 c4 08          	add    $0x8,%rsp
  4005aa:	c3                   	retq   

00000000004005ab <_start>:
  4005ab:	31 ed                	xor    %ebp,%ebp
  4005ad:	49 89 d1             	mov    %rdx,%r9
  4005b0:	5e                   	pop    %rsi
  4005b1:	48 89 e2             	mov    %rsp,%rdx
  4005b4:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4005b8:	50                   	push   %rax
  4005b9:	54                   	push   %rsp
  4005ba:	49 c7 c0 b0 0c 40 00 	mov    $0x400cb0,%r8
  4005c1:	48 c7 c1 40 0c 40 00 	mov    $0x400c40,%rcx
  4005c8:	48 c7 c7 00 05 40 00 	mov    $0x400500,%rdi
  4005cf:	e8 fc fe ff ff       	callq  4004d0 <__libc_start_main@plt>
  4005d4:	f4                   	hlt    
  4005d5:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4005dc:	00 00 00 
  4005df:	90                   	nop

00000000004005e0 <deregister_tm_clones>:
  4005e0:	b8 50 20 60 00       	mov    $0x602050,%eax
  4005e5:	48 3d 50 20 60 00    	cmp    $0x602050,%rax
  4005eb:	74 13                	je     400600 <deregister_tm_clones+0x20>
  4005ed:	b8 00 00 00 00       	mov    $0x0,%eax
  4005f2:	48 85 c0             	test   %rax,%rax
  4005f5:	74 09                	je     400600 <deregister_tm_clones+0x20>
  4005f7:	bf 50 20 60 00       	mov    $0x602050,%edi
  4005fc:	ff e0                	jmpq   *%rax
  4005fe:	66 90                	xchg   %ax,%ax
  400600:	c3                   	retq   
  400601:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400606:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40060d:	00 00 00 

0000000000400610 <register_tm_clones>:
  400610:	be 50 20 60 00       	mov    $0x602050,%esi
  400615:	48 81 ee 50 20 60 00 	sub    $0x602050,%rsi
  40061c:	48 89 f0             	mov    %rsi,%rax
  40061f:	48 c1 ee 3f          	shr    $0x3f,%rsi
  400623:	48 c1 f8 03          	sar    $0x3,%rax
  400627:	48 01 c6             	add    %rax,%rsi
  40062a:	48 d1 fe             	sar    %rsi
  40062d:	74 11                	je     400640 <register_tm_clones+0x30>
  40062f:	b8 00 00 00 00       	mov    $0x0,%eax
  400634:	48 85 c0             	test   %rax,%rax
  400637:	74 07                	je     400640 <register_tm_clones+0x30>
  400639:	bf 50 20 60 00       	mov    $0x602050,%edi
  40063e:	ff e0                	jmpq   *%rax
  400640:	c3                   	retq   
  400641:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400646:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40064d:	00 00 00 

0000000000400650 <__do_global_dtors_aux>:
  400650:	80 3d 29 1a 20 00 00 	cmpb   $0x0,0x201a29(%rip)        # 602080 <completed.7338>
  400657:	75 17                	jne    400670 <__do_global_dtors_aux+0x20>
  400659:	55                   	push   %rbp
  40065a:	48 89 e5             	mov    %rsp,%rbp
  40065d:	e8 7e ff ff ff       	callq  4005e0 <deregister_tm_clones>
  400662:	5d                   	pop    %rbp
  400663:	c6 05 16 1a 20 00 01 	movb   $0x1,0x201a16(%rip)        # 602080 <completed.7338>
  40066a:	c3                   	retq   
  40066b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400670:	c3                   	retq   
  400671:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400676:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40067d:	00 00 00 

0000000000400680 <frame_dummy>:
  400680:	eb 8e                	jmp    400610 <register_tm_clones>

0000000000400682 <dummy>:
  400682:	55                   	push   %rbp
  400683:	48 89 e5             	mov    %rsp,%rbp
  400686:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  40068a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  40068e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  400692:	f3 0f 11 45 e4       	movss  %xmm0,-0x1c(%rbp)
  400697:	b8 00 00 00 00       	mov    $0x0,%eax
  40069c:	5d                   	pop    %rbp
  40069d:	c3                   	retq   
  40069e:	66 90                	xchg   %ax,%ax

00000000004006a0 <get_wall_time>:
{
  4006a0:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  4006a4:	31 f6                	xor    %esi,%esi
  4006a6:	48 89 e7             	mov    %rsp,%rdi
  4006a9:	e8 12 fe ff ff       	callq  4004c0 <gettimeofday@plt>
  4006ae:	85 c0                	test   %eax,%eax
  4006b0:	75 22                	jne    4006d4 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4006b2:	c5 e8 57 d2          	vxorps %xmm2,%xmm2,%xmm2
  4006b6:	c4 e1 eb 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm2,%xmm0
  4006bd:	c5 fb 59 0d c3 06 00 	vmulsd 0x6c3(%rip),%xmm0,%xmm1        # 400d88 <_IO_stdin_used+0xc8>
  4006c4:	00 
  4006c5:	c4 e1 eb 2a 04 24    	vcvtsi2sdq (%rsp),%xmm2,%xmm0
}
  4006cb:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4006cf:	c5 f3 58 c0          	vaddsd %xmm0,%xmm1,%xmm0
}
  4006d3:	c3                   	retq   
        exit(-1); // return 0;
  4006d4:	83 cf ff             	or     $0xffffffff,%edi
  4006d7:	e8 04 fe ff ff       	callq  4004e0 <exit@plt>
  4006dc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004006e0 <check>:
  for (unsigned int i = 0; i < LEN; i++)
  4006e0:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
  real sum = 0;
  4006e7:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  4006eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    sum += arr[i];
  4006f0:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
  for (unsigned int i = 0; i < LEN; i++)
  4006f4:	48 83 c7 04          	add    $0x4,%rdi
  4006f8:	48 39 f8             	cmp    %rdi,%rax
  4006fb:	75 f3                	jne    4006f0 <check+0x10>
  printf("%f \n", sum);
  4006fd:	bf c4 0c 40 00       	mov    $0x400cc4,%edi
  400702:	b8 01 00 00 00       	mov    $0x1,%eax
  400707:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40070b:	e9 a0 fd ff ff       	jmpq   4004b0 <printf@plt>

0000000000400710 <init>:
    for (int j = 0; j < LEN; j++)
  400710:	c5 fa 10 0d 88 06 00 	vmovss 0x688(%rip),%xmm1        # 400da0 <_IO_stdin_used+0xe0>
  400717:	00 
  400718:	c5 fa 10 05 84 06 00 	vmovss 0x684(%rip),%xmm0        # 400da4 <_IO_stdin_used+0xe4>
  40071f:	00 
{
  400720:	31 c0                	xor    %eax,%eax
  400722:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
        vx[j] = 2.0;
  400728:	c5 fa 11 0c 07       	vmovss %xmm1,(%rdi,%rax,1)
        vy[j] = 1.0;
  40072d:	c5 fa 11 04 06       	vmovss %xmm0,(%rsi,%rax,1)
    for (int j = 0; j < LEN; j++)
  400732:	48 83 c0 04          	add    $0x4,%rax
  400736:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  40073c:	75 ea                	jne    400728 <init+0x18>
}
  40073e:	31 c0                	xor    %eax,%eax
  400740:	c3                   	retq   
  400741:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400746:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40074d:	00 00 00 

0000000000400750 <results>:
{
  400750:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %6.1f    %6.1f     ",
  400753:	b8 02 00 00 00       	mov    $0x2,%eax
  400758:	bf c9 0c 40 00       	mov    $0x400cc9,%edi
  40075d:	c5 fb 5e 15 33 06 00 	vdivsd 0x633(%rip),%xmm0,%xmm2        # 400d98 <_IO_stdin_used+0xd8>
  400764:	00 
  400765:	c5 fb 5e 0d 23 06 00 	vdivsd 0x623(%rip),%xmm0,%xmm1        # 400d90 <_IO_stdin_used+0xd0>
  40076c:	00 
  40076d:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  400771:	e9 3a fd ff ff       	jmpq   4004b0 <printf@plt>
  400776:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40077d:	00 00 00 

0000000000400780 <ss_alias_v1>:
{
  400780:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400785:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  400789:	41 ff 72 f8          	pushq  -0x8(%r10)
  40078d:	55                   	push   %rbp
  40078e:	48 89 e5             	mov    %rsp,%rbp
  400791:	41 56                	push   %r14
  400793:	49 89 f6             	mov    %rsi,%r14
  init(vx, vy);
  400796:	48 89 fe             	mov    %rdi,%rsi
{
  400799:	41 55                	push   %r13
  40079b:	4d 8d 6e 1f          	lea    0x1f(%r14),%r13
  40079f:	41 54                	push   %r12
  4007a1:	49 89 fc             	mov    %rdi,%r12
  init(vx, vy);
  4007a4:	4c 89 f7             	mov    %r14,%rdi
{
  4007a7:	41 52                	push   %r10
  4007a9:	4d 29 e5             	sub    %r12,%r13
  4007ac:	53                   	push   %rbx
  start_t = get_wall_time();
  4007ad:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  4007b2:	48 83 ec 28          	sub    $0x28,%rsp
  init(vx, vy);
  4007b6:	e8 55 ff ff ff       	callq  400710 <init>
  start_t = get_wall_time();
  4007bb:	31 c0                	xor    %eax,%eax
  4007bd:	e8 de fe ff ff       	callq  4006a0 <get_wall_time>
  4007c2:	c5 fa 10 1d de 05 00 	vmovss 0x5de(%rip),%xmm3        # 400da8 <_IO_stdin_used+0xe8>
  4007c9:	00 
  4007ca:	c5 fa 10 15 da 05 00 	vmovss 0x5da(%rip),%xmm2        # 400dac <_IO_stdin_used+0xec>
  4007d1:	00 
  4007d2:	c5 fc 28 2d e6 05 00 	vmovaps 0x5e6(%rip),%ymm5        # 400dc0 <_IO_stdin_used+0x100>
  4007d9:	00 
  4007da:	c5 fc 28 25 fe 05 00 	vmovaps 0x5fe(%rip),%ymm4        # 400de0 <_IO_stdin_used+0x120>
  4007e1:	00 
  4007e2:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
{
  4007e7:	31 c0                	xor    %eax,%eax
  4007e9:	49 83 fd 3e          	cmp    $0x3e,%r13
  4007ed:	0f 86 9d 00 00 00    	jbe    400890 <ss_alias_v1+0x110>
  4007f3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
        vy[i] = alpha*vx[i] + beta;
  4007f8:	c4 c1 54 59 04 06    	vmulps (%r14,%rax,1),%ymm5,%ymm0
  4007fe:	c5 fc 58 c4          	vaddps %ymm4,%ymm0,%ymm0
  400802:	c4 c1 7c 11 04 04    	vmovups %ymm0,(%r12,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  400808:	48 83 c0 20          	add    $0x20,%rax
  40080c:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  400812:	75 e4                	jne    4007f8 <ss_alias_v1+0x78>
    dummy(vy, alpha, beta);
  400814:	c5 fa 10 0d 90 05 00 	vmovss 0x590(%rip),%xmm1        # 400dac <_IO_stdin_used+0xec>
  40081b:	00 
  40081c:	c5 fa 10 05 84 05 00 	vmovss 0x584(%rip),%xmm0        # 400da8 <_IO_stdin_used+0xe8>
  400823:	00 
  400824:	4c 89 e7             	mov    %r12,%rdi
  400827:	c5 f8 77             	vzeroupper 
  40082a:	e8 53 fe ff ff       	callq  400682 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40082f:	ff cb                	dec    %ebx
  400831:	c5 fa 10 1d 6f 05 00 	vmovss 0x56f(%rip),%xmm3        # 400da8 <_IO_stdin_used+0xe8>
  400838:	00 
  400839:	c5 fa 10 15 6b 05 00 	vmovss 0x56b(%rip),%xmm2        # 400dac <_IO_stdin_used+0xec>
  400840:	00 
  400841:	c5 fc 28 2d 77 05 00 	vmovaps 0x577(%rip),%ymm5        # 400dc0 <_IO_stdin_used+0x100>
  400848:	00 
  400849:	c5 fc 28 25 8f 05 00 	vmovaps 0x58f(%rip),%ymm4        # 400de0 <_IO_stdin_used+0x120>
  400850:	00 
  400851:	75 94                	jne    4007e7 <ss_alias_v1+0x67>
  end_t = get_wall_time();
  400853:	31 c0                	xor    %eax,%eax
  400855:	c5 f8 77             	vzeroupper 
  400858:	e8 43 fe ff ff       	callq  4006a0 <get_wall_time>
  results(end_t - start_t, "ss_alias_v1");
  40085d:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400862:	bf e3 0c 40 00       	mov    $0x400ce3,%edi
  400867:	e8 e4 fe ff ff       	callq  400750 <results>
  check(vy);
  40086c:	4c 89 e7             	mov    %r12,%rdi
  40086f:	e8 6c fe ff ff       	callq  4006e0 <check>
}
  400874:	48 83 c4 28          	add    $0x28,%rsp
  400878:	31 c0                	xor    %eax,%eax
  40087a:	5b                   	pop    %rbx
  40087b:	41 5a                	pop    %r10
  40087d:	41 5c                	pop    %r12
  40087f:	41 5d                	pop    %r13
  400881:	41 5e                	pop    %r14
  400883:	5d                   	pop    %rbp
  400884:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400888:	c3                   	retq   
  400889:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
        vy[i] = alpha*vx[i] + beta;
  400890:	c4 c1 62 59 04 06    	vmulss (%r14,%rax,1),%xmm3,%xmm0
  400896:	c5 fa 58 c2          	vaddss %xmm2,%xmm0,%xmm0
  40089a:	c4 c1 7a 11 04 04    	vmovss %xmm0,(%r12,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  4008a0:	48 83 c0 04          	add    $0x4,%rax
  4008a4:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  4008aa:	75 e4                	jne    400890 <ss_alias_v1+0x110>
  4008ac:	e9 63 ff ff ff       	jmpq   400814 <ss_alias_v1+0x94>
  4008b1:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4008b6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4008bd:	00 00 00 

00000000004008c0 <ss_alias_v2>:
{
  4008c0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4008c5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  4008c9:	41 ff 72 f8          	pushq  -0x8(%r10)
  4008cd:	55                   	push   %rbp
  4008ce:	48 89 e5             	mov    %rsp,%rbp
  4008d1:	41 55                	push   %r13
  start_t = get_wall_time();
  4008d3:	41 bd 00 00 f0 00    	mov    $0xf00000,%r13d
{
  4008d9:	41 54                	push   %r12
  4008db:	49 89 fc             	mov    %rdi,%r12
  4008de:	41 52                	push   %r10
  4008e0:	53                   	push   %rbx
  4008e1:	48 89 f3             	mov    %rsi,%rbx
  init(vx, vy);
  4008e4:	48 89 fe             	mov    %rdi,%rsi
  4008e7:	48 89 df             	mov    %rbx,%rdi
{
  4008ea:	48 83 ec 30          	sub    $0x30,%rsp
  init(vx, vy);
  4008ee:	e8 1d fe ff ff       	callq  400710 <init>
  start_t = get_wall_time();
  4008f3:	31 c0                	xor    %eax,%eax
  4008f5:	e8 a6 fd ff ff       	callq  4006a0 <get_wall_time>
  4008fa:	c5 fc 28 1d be 04 00 	vmovaps 0x4be(%rip),%ymm3        # 400dc0 <_IO_stdin_used+0x100>
  400901:	00 
  400902:	c5 fc 28 15 d6 04 00 	vmovaps 0x4d6(%rip),%ymm2        # 400de0 <_IO_stdin_used+0x120>
  400909:	00 
  40090a:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
{
  40090f:	31 c0                	xor    %eax,%eax
  400911:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
        vy[i] = alpha*vx[i] + beta;
  400918:	c5 e4 59 04 03       	vmulps (%rbx,%rax,1),%ymm3,%ymm0
  40091d:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  400921:	c4 c1 7c 11 04 04    	vmovups %ymm0,(%r12,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  400927:	48 83 c0 20          	add    $0x20,%rax
  40092b:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  400931:	75 e5                	jne    400918 <ss_alias_v2+0x58>
    dummy(vy, alpha, beta);
  400933:	c5 fa 10 0d 71 04 00 	vmovss 0x471(%rip),%xmm1        # 400dac <_IO_stdin_used+0xec>
  40093a:	00 
  40093b:	c5 fa 10 05 65 04 00 	vmovss 0x465(%rip),%xmm0        # 400da8 <_IO_stdin_used+0xe8>
  400942:	00 
  400943:	4c 89 e7             	mov    %r12,%rdi
  400946:	c5 f8 77             	vzeroupper 
  400949:	e8 34 fd ff ff       	callq  400682 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40094e:	41 ff cd             	dec    %r13d
  400951:	c5 fc 28 1d 67 04 00 	vmovaps 0x467(%rip),%ymm3        # 400dc0 <_IO_stdin_used+0x100>
  400958:	00 
  400959:	c5 fc 28 15 7f 04 00 	vmovaps 0x47f(%rip),%ymm2        # 400de0 <_IO_stdin_used+0x120>
  400960:	00 
  400961:	75 ac                	jne    40090f <ss_alias_v2+0x4f>
  end_t = get_wall_time();
  400963:	31 c0                	xor    %eax,%eax
  400965:	c5 f8 77             	vzeroupper 
  400968:	e8 33 fd ff ff       	callq  4006a0 <get_wall_time>
  results(end_t - start_t, "ss_alias_v2");
  40096d:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400972:	bf ef 0c 40 00       	mov    $0x400cef,%edi
  400977:	e8 d4 fd ff ff       	callq  400750 <results>
  check(vy);
  40097c:	4c 89 e7             	mov    %r12,%rdi
  40097f:	e8 5c fd ff ff       	callq  4006e0 <check>
}
  400984:	48 83 c4 30          	add    $0x30,%rsp
  400988:	31 c0                	xor    %eax,%eax
  40098a:	5b                   	pop    %rbx
  40098b:	41 5a                	pop    %r10
  40098d:	41 5c                	pop    %r12
  40098f:	41 5d                	pop    %r13
  400991:	5d                   	pop    %rbp
  400992:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400996:	c3                   	retq   
  400997:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40099e:	00 00 

00000000004009a0 <ss_alias_v3>:
{
  4009a0:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  4009a5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  4009a9:	41 ff 72 f8          	pushq  -0x8(%r10)
  4009ad:	55                   	push   %rbp
  4009ae:	48 89 e5             	mov    %rsp,%rbp
  4009b1:	41 55                	push   %r13
  start_t = get_wall_time();
  4009b3:	41 bd 00 00 f0 00    	mov    $0xf00000,%r13d
{
  4009b9:	41 54                	push   %r12
  4009bb:	49 89 fc             	mov    %rdi,%r12
  4009be:	41 52                	push   %r10
  4009c0:	53                   	push   %rbx
  4009c1:	48 89 f3             	mov    %rsi,%rbx
  init(vx, vy);
  4009c4:	48 89 fe             	mov    %rdi,%rsi
  4009c7:	48 89 df             	mov    %rbx,%rdi
{
  4009ca:	48 83 ec 30          	sub    $0x30,%rsp
  init(vx, vy);
  4009ce:	e8 3d fd ff ff       	callq  400710 <init>
  start_t = get_wall_time();
  4009d3:	31 c0                	xor    %eax,%eax
  4009d5:	e8 c6 fc ff ff       	callq  4006a0 <get_wall_time>
  4009da:	c5 fc 28 1d de 03 00 	vmovaps 0x3de(%rip),%ymm3        # 400dc0 <_IO_stdin_used+0x100>
  4009e1:	00 
  4009e2:	c5 fc 28 15 f6 03 00 	vmovaps 0x3f6(%rip),%ymm2        # 400de0 <_IO_stdin_used+0x120>
  4009e9:	00 
  4009ea:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
{
  4009ef:	31 c0                	xor    %eax,%eax
  4009f1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
      vy[i] = alpha*vx[i] + beta;
  4009f8:	c5 e4 59 04 03       	vmulps (%rbx,%rax,1),%ymm3,%ymm0
  4009fd:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  400a01:	c4 c1 7c 11 04 04    	vmovups %ymm0,(%r12,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  400a07:	48 83 c0 20          	add    $0x20,%rax
  400a0b:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  400a11:	75 e5                	jne    4009f8 <ss_alias_v3+0x58>
    dummy(vy, alpha, beta);
  400a13:	c5 fa 10 0d 91 03 00 	vmovss 0x391(%rip),%xmm1        # 400dac <_IO_stdin_used+0xec>
  400a1a:	00 
  400a1b:	c5 fa 10 05 85 03 00 	vmovss 0x385(%rip),%xmm0        # 400da8 <_IO_stdin_used+0xe8>
  400a22:	00 
  400a23:	4c 89 e7             	mov    %r12,%rdi
  400a26:	c5 f8 77             	vzeroupper 
  400a29:	e8 54 fc ff ff       	callq  400682 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  400a2e:	41 ff cd             	dec    %r13d
  400a31:	c5 fc 28 1d 87 03 00 	vmovaps 0x387(%rip),%ymm3        # 400dc0 <_IO_stdin_used+0x100>
  400a38:	00 
  400a39:	c5 fc 28 15 9f 03 00 	vmovaps 0x39f(%rip),%ymm2        # 400de0 <_IO_stdin_used+0x120>
  400a40:	00 
  400a41:	75 ac                	jne    4009ef <ss_alias_v3+0x4f>
  end_t = get_wall_time();
  400a43:	31 c0                	xor    %eax,%eax
  400a45:	c5 f8 77             	vzeroupper 
  400a48:	e8 53 fc ff ff       	callq  4006a0 <get_wall_time>
  results(end_t - start_t, "ss_alias_v3");
  400a4d:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400a52:	bf fb 0c 40 00       	mov    $0x400cfb,%edi
  400a57:	e8 f4 fc ff ff       	callq  400750 <results>
  check(vy);
  400a5c:	4c 89 e7             	mov    %r12,%rdi
  400a5f:	e8 7c fc ff ff       	callq  4006e0 <check>
}
  400a64:	48 83 c4 30          	add    $0x30,%rsp
  400a68:	31 c0                	xor    %eax,%eax
  400a6a:	5b                   	pop    %rbx
  400a6b:	41 5a                	pop    %r10
  400a6d:	41 5c                	pop    %r12
  400a6f:	41 5d                	pop    %r13
  400a71:	5d                   	pop    %rbp
  400a72:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400a76:	c3                   	retq   
  400a77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  400a7e:	00 00 

0000000000400a80 <ss_alias_v4>:
{
  400a80:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400a85:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  400a89:	41 ff 72 f8          	pushq  -0x8(%r10)
  400a8d:	55                   	push   %rbp
  400a8e:	48 89 e5             	mov    %rsp,%rbp
  400a91:	41 55                	push   %r13
  start_t = get_wall_time();
  400a93:	41 bd 00 00 f0 00    	mov    $0xf00000,%r13d
{
  400a99:	41 54                	push   %r12
  400a9b:	49 89 fc             	mov    %rdi,%r12
  400a9e:	41 52                	push   %r10
  400aa0:	53                   	push   %rbx
  400aa1:	48 89 f3             	mov    %rsi,%rbx
  init(xx, yy);
  400aa4:	48 89 fe             	mov    %rdi,%rsi
  400aa7:	48 89 df             	mov    %rbx,%rdi
{
  400aaa:	48 83 ec 30          	sub    $0x30,%rsp
  init(xx, yy);
  400aae:	e8 5d fc ff ff       	callq  400710 <init>
  start_t = get_wall_time();
  400ab3:	31 c0                	xor    %eax,%eax
  400ab5:	e8 e6 fb ff ff       	callq  4006a0 <get_wall_time>
  400aba:	c5 fc 28 1d fe 02 00 	vmovaps 0x2fe(%rip),%ymm3        # 400dc0 <_IO_stdin_used+0x100>
  400ac1:	00 
  400ac2:	c5 fc 28 15 16 03 00 	vmovaps 0x316(%rip),%ymm2        # 400de0 <_IO_stdin_used+0x120>
  400ac9:	00 
  400aca:	c5 fb 11 45 c8       	vmovsd %xmm0,-0x38(%rbp)
{
  400acf:	31 c0                	xor    %eax,%eax
  400ad1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
      yy[i] = alpha*xx[i] + beta;
  400ad8:	c5 e4 59 04 03       	vmulps (%rbx,%rax,1),%ymm3,%ymm0
  400add:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  400ae1:	c4 c1 7c 29 04 04    	vmovaps %ymm0,(%r12,%rax,1)
    for (unsigned int i = 0; i < LEN; i++)
  400ae7:	48 83 c0 20          	add    $0x20,%rax
  400aeb:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  400af1:	75 e5                	jne    400ad8 <ss_alias_v4+0x58>
    dummy(yy, alpha, beta);
  400af3:	c5 fa 10 0d b1 02 00 	vmovss 0x2b1(%rip),%xmm1        # 400dac <_IO_stdin_used+0xec>
  400afa:	00 
  400afb:	c5 fa 10 05 a5 02 00 	vmovss 0x2a5(%rip),%xmm0        # 400da8 <_IO_stdin_used+0xe8>
  400b02:	00 
  400b03:	4c 89 e7             	mov    %r12,%rdi
  400b06:	c5 f8 77             	vzeroupper 
  400b09:	e8 74 fb ff ff       	callq  400682 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  400b0e:	41 ff cd             	dec    %r13d
  400b11:	c5 fc 28 1d a7 02 00 	vmovaps 0x2a7(%rip),%ymm3        # 400dc0 <_IO_stdin_used+0x100>
  400b18:	00 
  400b19:	c5 fc 28 15 bf 02 00 	vmovaps 0x2bf(%rip),%ymm2        # 400de0 <_IO_stdin_used+0x120>
  400b20:	00 
  400b21:	75 ac                	jne    400acf <ss_alias_v4+0x4f>
  end_t = get_wall_time();
  400b23:	31 c0                	xor    %eax,%eax
  400b25:	c5 f8 77             	vzeroupper 
  400b28:	e8 73 fb ff ff       	callq  4006a0 <get_wall_time>
  results(end_t - start_t, "ss_alias_v4");
  400b2d:	c5 fb 5c 45 c8       	vsubsd -0x38(%rbp),%xmm0,%xmm0
  400b32:	bf 07 0d 40 00       	mov    $0x400d07,%edi
  400b37:	e8 14 fc ff ff       	callq  400750 <results>
  check(yy);
  400b3c:	4c 89 e7             	mov    %r12,%rdi
  400b3f:	e8 9c fb ff ff       	callq  4006e0 <check>
}
  400b44:	48 83 c4 30          	add    $0x30,%rsp
  400b48:	31 c0                	xor    %eax,%eax
  400b4a:	5b                   	pop    %rbx
  400b4b:	41 5a                	pop    %r10
  400b4d:	41 5c                	pop    %r12
  400b4f:	41 5d                	pop    %r13
  400b51:	5d                   	pop    %rbp
  400b52:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400b56:	c3                   	retq   
  400b57:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  400b5e:	00 00 

0000000000400b60 <scale_and_shift>:
{
  400b60:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400b65:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init(x, y);
  400b69:	be c0 20 60 00       	mov    $0x6020c0,%esi
  400b6e:	bf 00 31 60 00       	mov    $0x603100,%edi
{
  400b73:	41 ff 72 f8          	pushq  -0x8(%r10)
  400b77:	55                   	push   %rbp
  400b78:	48 89 e5             	mov    %rsp,%rbp
  400b7b:	41 52                	push   %r10
  400b7d:	53                   	push   %rbx
  start_t = get_wall_time();
  400b7e:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  400b83:	48 83 ec 20          	sub    $0x20,%rsp
  init(x, y);
  400b87:	e8 84 fb ff ff       	callq  400710 <init>
  start_t = get_wall_time();
  400b8c:	31 c0                	xor    %eax,%eax
  400b8e:	e8 0d fb ff ff       	callq  4006a0 <get_wall_time>
  400b93:	c5 fc 28 1d 25 02 00 	vmovaps 0x225(%rip),%ymm3        # 400dc0 <_IO_stdin_used+0x100>
  400b9a:	00 
  400b9b:	c5 fc 28 15 3d 02 00 	vmovaps 0x23d(%rip),%ymm2        # 400de0 <_IO_stdin_used+0x120>
  400ba2:	00 
  400ba3:	c5 fb 11 45 e8       	vmovsd %xmm0,-0x18(%rbp)
{
  400ba8:	31 c0                	xor    %eax,%eax
  400baa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
      y[i] = alpha*x[i] + beta;
  400bb0:	c5 e4 59 80 00 31 60 	vmulps 0x603100(%rax),%ymm3,%ymm0
  400bb7:	00 
  400bb8:	48 83 c0 20          	add    $0x20,%rax
  400bbc:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  400bc0:	c5 fc 29 80 a0 20 60 	vmovaps %ymm0,0x6020a0(%rax)
  400bc7:	00 
    for (unsigned int i = 0; i < LEN; i++)
  400bc8:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  400bce:	75 e0                	jne    400bb0 <scale_and_shift+0x50>
        dummy(y, alpha, beta);
  400bd0:	c5 fa 10 0d d4 01 00 	vmovss 0x1d4(%rip),%xmm1        # 400dac <_IO_stdin_used+0xec>
  400bd7:	00 
  400bd8:	c5 fa 10 05 c8 01 00 	vmovss 0x1c8(%rip),%xmm0        # 400da8 <_IO_stdin_used+0xe8>
  400bdf:	00 
  400be0:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400be5:	c5 f8 77             	vzeroupper 
  400be8:	e8 95 fa ff ff       	callq  400682 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  400bed:	ff cb                	dec    %ebx
  400bef:	c5 fc 28 1d c9 01 00 	vmovaps 0x1c9(%rip),%ymm3        # 400dc0 <_IO_stdin_used+0x100>
  400bf6:	00 
  400bf7:	c5 fc 28 15 e1 01 00 	vmovaps 0x1e1(%rip),%ymm2        # 400de0 <_IO_stdin_used+0x120>
  400bfe:	00 
  400bff:	75 a7                	jne    400ba8 <scale_and_shift+0x48>
  end_t = get_wall_time();
  400c01:	31 c0                	xor    %eax,%eax
  400c03:	c5 f8 77             	vzeroupper 
  400c06:	e8 95 fa ff ff       	callq  4006a0 <get_wall_time>
  results(end_t - start_t, "scale_and_shift");
  400c0b:	c5 fb 5c 45 e8       	vsubsd -0x18(%rbp),%xmm0,%xmm0
  400c10:	bf 13 0d 40 00       	mov    $0x400d13,%edi
  400c15:	e8 36 fb ff ff       	callq  400750 <results>
  check(y);
  400c1a:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400c1f:	e8 bc fa ff ff       	callq  4006e0 <check>
}
  400c24:	48 83 c4 20          	add    $0x20,%rsp
  400c28:	31 c0                	xor    %eax,%eax
  400c2a:	5b                   	pop    %rbx
  400c2b:	41 5a                	pop    %r10
  400c2d:	5d                   	pop    %rbp
  400c2e:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  400c32:	c3                   	retq   
  400c33:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400c3a:	00 00 00 
  400c3d:	0f 1f 00             	nopl   (%rax)

0000000000400c40 <__libc_csu_init>:
  400c40:	41 57                	push   %r15
  400c42:	41 89 ff             	mov    %edi,%r15d
  400c45:	41 56                	push   %r14
  400c47:	49 89 f6             	mov    %rsi,%r14
  400c4a:	41 55                	push   %r13
  400c4c:	49 89 d5             	mov    %rdx,%r13
  400c4f:	41 54                	push   %r12
  400c51:	4c 8d 25 b0 11 20 00 	lea    0x2011b0(%rip),%r12        # 601e08 <__frame_dummy_init_array_entry>
  400c58:	55                   	push   %rbp
  400c59:	48 8d 2d b0 11 20 00 	lea    0x2011b0(%rip),%rbp        # 601e10 <__init_array_end>
  400c60:	53                   	push   %rbx
  400c61:	4c 29 e5             	sub    %r12,%rbp
  400c64:	31 db                	xor    %ebx,%ebx
  400c66:	48 c1 fd 03          	sar    $0x3,%rbp
  400c6a:	48 83 ec 08          	sub    $0x8,%rsp
  400c6e:	e8 fd f7 ff ff       	callq  400470 <_init>
  400c73:	48 85 ed             	test   %rbp,%rbp
  400c76:	74 1e                	je     400c96 <__libc_csu_init+0x56>
  400c78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  400c7f:	00 
  400c80:	4c 89 ea             	mov    %r13,%rdx
  400c83:	4c 89 f6             	mov    %r14,%rsi
  400c86:	44 89 ff             	mov    %r15d,%edi
  400c89:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  400c8d:	48 83 c3 01          	add    $0x1,%rbx
  400c91:	48 39 eb             	cmp    %rbp,%rbx
  400c94:	75 ea                	jne    400c80 <__libc_csu_init+0x40>
  400c96:	48 83 c4 08          	add    $0x8,%rsp
  400c9a:	5b                   	pop    %rbx
  400c9b:	5d                   	pop    %rbp
  400c9c:	41 5c                	pop    %r12
  400c9e:	41 5d                	pop    %r13
  400ca0:	41 5e                	pop    %r14
  400ca2:	41 5f                	pop    %r15
  400ca4:	c3                   	retq   
  400ca5:	90                   	nop
  400ca6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400cad:	00 00 00 

0000000000400cb0 <__libc_csu_fini>:
  400cb0:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000400cb4 <_fini>:
  400cb4:	48 83 ec 08          	sub    $0x8,%rsp
  400cb8:	48 83 c4 08          	add    $0x8,%rsp
  400cbc:	c3                   	retq   
