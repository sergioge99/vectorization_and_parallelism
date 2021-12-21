
ss_stride.1k.single.native.gcc:     file format elf64-x86-64


Disassembly of section .init:

0000000000400470 <_init>:
  400470:	48 83 ec 08          	sub    $0x8,%rsp
  400474:	48 8b 05 7d 0b 20 00 	mov    0x200b7d(%rip),%rax        # 600ff8 <__gmon_start__>
  40047b:	48 85 c0             	test   %rax,%rax
  40047e:	74 05                	je     400485 <_init+0x15>
  400480:	e8 6b 00 00 00       	callq  4004f0 <.plt.got>
  400485:	48 83 c4 08          	add    $0x8,%rsp
  400489:	c3                   	retq   

Disassembly of section .plt:

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

Disassembly of section .plt.got:

00000000004004f0 <.plt.got>:
  4004f0:	ff 25 02 0b 20 00    	jmpq   *0x200b02(%rip)        # 600ff8 <__gmon_start__>
  4004f6:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000400500 <main>:
  return 0;
}
#endif

int main()
{
  400500:	48 83 ec 08          	sub    $0x8,%rsp
  printf("                     Time       TPI\n");
  400504:	bf 80 09 40 00       	mov    $0x400980,%edi
  400509:	e8 92 ff ff ff       	callq  4004a0 <puts@plt>
  printf("             Loop     ns       ps/el     Checksum\n");
  40050e:	bf a8 09 40 00       	mov    $0x4009a8,%edi
  400513:	e8 88 ff ff ff       	callq  4004a0 <puts@plt>
  ss_stride_esc();
  400518:	31 c0                	xor    %eax,%eax
  40051a:	e8 d1 01 00 00       	callq  4006f0 <ss_stride_esc>
  ss_stride_vec();
  40051f:	31 c0                	xor    %eax,%eax
  400521:	e8 6a 02 00 00       	callq  400790 <ss_stride_vec>
  //ss_stride_v2(x);
  return 0;
}
  400526:	31 c0                	xor    %eax,%eax
  400528:	48 83 c4 08          	add    $0x8,%rsp
  40052c:	c3                   	retq   

000000000040052d <_start>:
  40052d:	31 ed                	xor    %ebp,%ebp
  40052f:	49 89 d1             	mov    %rdx,%r9
  400532:	5e                   	pop    %rsi
  400533:	48 89 e2             	mov    %rsp,%rdx
  400536:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  40053a:	50                   	push   %rax
  40053b:	54                   	push   %rsp
  40053c:	49 c7 c0 20 09 40 00 	mov    $0x400920,%r8
  400543:	48 c7 c1 b0 08 40 00 	mov    $0x4008b0,%rcx
  40054a:	48 c7 c7 00 05 40 00 	mov    $0x400500,%rdi
  400551:	e8 7a ff ff ff       	callq  4004d0 <__libc_start_main@plt>
  400556:	f4                   	hlt    
  400557:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40055e:	00 00 

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
  40060a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  40060e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  400612:	f3 0f 11 45 e4       	movss  %xmm0,-0x1c(%rbp)
  400617:	b8 00 00 00 00       	mov    $0x0,%eax
  40061c:	5d                   	pop    %rbp
  40061d:	c3                   	retq   
  40061e:	66 90                	xchg   %ax,%ax

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
  40063d:	c5 fb 59 0d 9b 03 00 	vmulsd 0x39b(%rip),%xmm0,%xmm1        # 4009e0 <_IO_stdin_used+0xa0>
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
  40067d:	bf 44 09 40 00       	mov    $0x400944,%edi
  400682:	b8 01 00 00 00       	mov    $0x1,%eax
  400687:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40068b:	e9 20 fe ff ff       	jmpq   4004b0 <printf@plt>

0000000000400690 <init>:
  for (int j = 0; j < LEN; j++)
  400690:	c5 fa 10 05 60 03 00 	vmovss 0x360(%rip),%xmm0        # 4009f8 <_IO_stdin_used+0xb8>
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
    printf("%18s  %6.1f    %6.1f     ",
  4006c3:	b8 02 00 00 00       	mov    $0x2,%eax
  4006c8:	bf 49 09 40 00       	mov    $0x400949,%edi
  4006cd:	c5 fb 5e 15 1b 03 00 	vdivsd 0x31b(%rip),%xmm0,%xmm2        # 4009f0 <_IO_stdin_used+0xb0>
  4006d4:	00 
  4006d5:	c5 fb 5e 0d 0b 03 00 	vdivsd 0x30b(%rip),%xmm0,%xmm1        # 4009e8 <_IO_stdin_used+0xa8>
  4006dc:	00 
  4006dd:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  4006e1:	e9 ca fd ff ff       	jmpq   4004b0 <printf@plt>
  4006e6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4006ed:	00 00 00 

00000000004006f0 <ss_stride_esc>:
{
  4006f0:	53                   	push   %rbx
  init();
  4006f1:	31 c0                	xor    %eax,%eax
  start_t = get_wall_time();
  4006f3:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  4006f8:	48 83 ec 10          	sub    $0x10,%rsp
  init();
  4006fc:	e8 8f ff ff ff       	callq  400690 <init>
  start_t = get_wall_time();
  400701:	31 c0                	xor    %eax,%eax
  400703:	e8 18 ff ff ff       	callq  400620 <get_wall_time>
  400708:	c5 fa 10 15 ec 02 00 	vmovss 0x2ec(%rip),%xmm2        # 4009fc <_IO_stdin_used+0xbc>
  40070f:	00 
  400710:	c5 fa 10 0d e8 02 00 	vmovss 0x2e8(%rip),%xmm1        # 400a00 <_IO_stdin_used+0xc0>
  400717:	00 
  400718:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  40071e:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  400723:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
      x[i] = alpha*x[i] + beta;
  400728:	c5 ea 59 00          	vmulss (%rax),%xmm2,%xmm0
  40072c:	48 83 c0 08          	add    $0x8,%rax
  400730:	c5 fa 58 c1          	vaddss %xmm1,%xmm0,%xmm0
  400734:	c5 fa 11 40 f8       	vmovss %xmm0,-0x8(%rax)
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  400739:	48 3d c0 30 60 00    	cmp    $0x6030c0,%rax
  40073f:	75 e7                	jne    400728 <ss_stride_esc+0x38>
    dummy(x, alpha, beta);
  400741:	c5 f8 28 c2          	vmovaps %xmm2,%xmm0
  400745:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  40074a:	e8 b3 fe ff ff       	callq  400602 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40074f:	ff cb                	dec    %ebx
  400751:	c5 fa 10 15 a3 02 00 	vmovss 0x2a3(%rip),%xmm2        # 4009fc <_IO_stdin_used+0xbc>
  400758:	00 
  400759:	c5 fa 10 0d 9f 02 00 	vmovss 0x29f(%rip),%xmm1        # 400a00 <_IO_stdin_used+0xc0>
  400760:	00 
  400761:	75 bb                	jne    40071e <ss_stride_esc+0x2e>
  end_t = get_wall_time();
  400763:	31 c0                	xor    %eax,%eax
  400765:	e8 b6 fe ff ff       	callq  400620 <get_wall_time>
  results(end_t - start_t, "ss_stride_esc");
  40076a:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  400770:	bf 63 09 40 00       	mov    $0x400963,%edi
  400775:	e8 46 ff ff ff       	callq  4006c0 <results>
  check(x);
  40077a:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  40077f:	e8 dc fe ff ff       	callq  400660 <check>
}
  400784:	48 83 c4 10          	add    $0x10,%rsp
  400788:	31 c0                	xor    %eax,%eax
  40078a:	5b                   	pop    %rbx
  40078b:	c3                   	retq   
  40078c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400790 <ss_stride_vec>:
{
  400790:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400795:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400799:	31 c0                	xor    %eax,%eax
{
  40079b:	41 ff 72 f8          	pushq  -0x8(%r10)
  40079f:	55                   	push   %rbp
  4007a0:	48 89 e5             	mov    %rsp,%rbp
  4007a3:	41 52                	push   %r10
  4007a5:	53                   	push   %rbx
  start_t = get_wall_time();
  4007a6:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  4007ab:	48 83 ec 20          	sub    $0x20,%rsp
  init();
  4007af:	e8 dc fe ff ff       	callq  400690 <init>
  start_t = get_wall_time();
  4007b4:	31 c0                	xor    %eax,%eax
  4007b6:	e8 65 fe ff ff       	callq  400620 <get_wall_time>
  4007bb:	c5 fc 28 25 5d 02 00 	vmovaps 0x25d(%rip),%ymm4        # 400a20 <_IO_stdin_used+0xe0>
  4007c2:	00 
  4007c3:	c5 fc 28 1d 75 02 00 	vmovaps 0x275(%rip),%ymm3        # 400a40 <_IO_stdin_used+0x100>
  4007ca:	00 
  4007cb:	c5 fb 11 45 e8       	vmovsd %xmm0,-0x18(%rbp)
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  4007d0:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  4007d5:	0f 1f 00             	nopl   (%rax)
        x[i] = alpha*x[i] + beta;
  4007d8:	c5 fc 28 28          	vmovaps (%rax),%ymm5
  4007dc:	c5 d4 c6 48 20 88    	vshufps $0x88,0x20(%rax),%ymm5,%ymm1
  4007e2:	c4 e3 75 06 d1 03    	vperm2f128 $0x3,%ymm1,%ymm1,%ymm2
  4007e8:	48 83 c0 40          	add    $0x40,%rax
  4007ec:	c5 f4 c6 c2 44       	vshufps $0x44,%ymm2,%ymm1,%ymm0
  4007f1:	c5 f4 c6 d2 ee       	vshufps $0xee,%ymm2,%ymm1,%ymm2
  4007f6:	c4 e3 7d 18 c2 01    	vinsertf128 $0x1,%xmm2,%ymm0,%ymm0
  4007fc:	c5 fc 59 c4          	vmulps %ymm4,%ymm0,%ymm0
  400800:	c5 fc 58 c3          	vaddps %ymm3,%ymm0,%ymm0
  400804:	c5 fa 11 40 c0       	vmovss %xmm0,-0x40(%rax)
  400809:	c4 e3 79 17 40 c8 01 	vextractps $0x1,%xmm0,-0x38(%rax)
  400810:	c4 e3 79 17 40 d0 02 	vextractps $0x2,%xmm0,-0x30(%rax)
  400817:	c4 e3 79 17 40 d8 03 	vextractps $0x3,%xmm0,-0x28(%rax)
  40081e:	c4 e3 7d 19 c0 01    	vextractf128 $0x1,%ymm0,%xmm0
  400824:	c5 fa 11 40 e0       	vmovss %xmm0,-0x20(%rax)
  400829:	c4 e3 79 17 40 e8 01 	vextractps $0x1,%xmm0,-0x18(%rax)
  400830:	c4 e3 79 17 40 f0 02 	vextractps $0x2,%xmm0,-0x10(%rax)
  400837:	c4 e3 79 17 40 f8 03 	vextractps $0x3,%xmm0,-0x8(%rax)
    for (unsigned int i = 0; i < 2*LEN; i+=2)
  40083e:	48 3d c0 30 60 00    	cmp    $0x6030c0,%rax
  400844:	75 92                	jne    4007d8 <ss_stride_vec+0x48>
    dummy(x, alpha, beta);
  400846:	c5 fa 10 0d b2 01 00 	vmovss 0x1b2(%rip),%xmm1        # 400a00 <_IO_stdin_used+0xc0>
  40084d:	00 
  40084e:	c5 fa 10 05 a6 01 00 	vmovss 0x1a6(%rip),%xmm0        # 4009fc <_IO_stdin_used+0xbc>
  400855:	00 
  400856:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  40085b:	c5 f8 77             	vzeroupper 
  40085e:	e8 9f fd ff ff       	callq  400602 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  400863:	ff cb                	dec    %ebx
  400865:	c5 fc 28 25 b3 01 00 	vmovaps 0x1b3(%rip),%ymm4        # 400a20 <_IO_stdin_used+0xe0>
  40086c:	00 
  40086d:	c5 fc 28 1d cb 01 00 	vmovaps 0x1cb(%rip),%ymm3        # 400a40 <_IO_stdin_used+0x100>
  400874:	00 
  400875:	0f 85 55 ff ff ff    	jne    4007d0 <ss_stride_vec+0x40>
  end_t = get_wall_time();
  40087b:	31 c0                	xor    %eax,%eax
  40087d:	c5 f8 77             	vzeroupper 
  400880:	e8 9b fd ff ff       	callq  400620 <get_wall_time>
  results(end_t - start_t, "ss_stride_vec");
  400885:	c5 fb 5c 45 e8       	vsubsd -0x18(%rbp),%xmm0,%xmm0
  40088a:	bf 71 09 40 00       	mov    $0x400971,%edi
  40088f:	e8 2c fe ff ff       	callq  4006c0 <results>
  check(x);
  400894:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  400899:	e8 c2 fd ff ff       	callq  400660 <check>
}
  40089e:	48 83 c4 20          	add    $0x20,%rsp
  4008a2:	31 c0                	xor    %eax,%eax
  4008a4:	5b                   	pop    %rbx
  4008a5:	41 5a                	pop    %r10
  4008a7:	5d                   	pop    %rbp
  4008a8:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4008ac:	c3                   	retq   
  4008ad:	0f 1f 00             	nopl   (%rax)

00000000004008b0 <__libc_csu_init>:
  4008b0:	41 57                	push   %r15
  4008b2:	41 89 ff             	mov    %edi,%r15d
  4008b5:	41 56                	push   %r14
  4008b7:	49 89 f6             	mov    %rsi,%r14
  4008ba:	41 55                	push   %r13
  4008bc:	49 89 d5             	mov    %rdx,%r13
  4008bf:	41 54                	push   %r12
  4008c1:	4c 8d 25 40 05 20 00 	lea    0x200540(%rip),%r12        # 600e08 <__frame_dummy_init_array_entry>
  4008c8:	55                   	push   %rbp
  4008c9:	48 8d 2d 40 05 20 00 	lea    0x200540(%rip),%rbp        # 600e10 <__init_array_end>
  4008d0:	53                   	push   %rbx
  4008d1:	4c 29 e5             	sub    %r12,%rbp
  4008d4:	31 db                	xor    %ebx,%ebx
  4008d6:	48 c1 fd 03          	sar    $0x3,%rbp
  4008da:	48 83 ec 08          	sub    $0x8,%rsp
  4008de:	e8 8d fb ff ff       	callq  400470 <_init>
  4008e3:	48 85 ed             	test   %rbp,%rbp
  4008e6:	74 1e                	je     400906 <__libc_csu_init+0x56>
  4008e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4008ef:	00 
  4008f0:	4c 89 ea             	mov    %r13,%rdx
  4008f3:	4c 89 f6             	mov    %r14,%rsi
  4008f6:	44 89 ff             	mov    %r15d,%edi
  4008f9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  4008fd:	48 83 c3 01          	add    $0x1,%rbx
  400901:	48 39 eb             	cmp    %rbp,%rbx
  400904:	75 ea                	jne    4008f0 <__libc_csu_init+0x40>
  400906:	48 83 c4 08          	add    $0x8,%rsp
  40090a:	5b                   	pop    %rbx
  40090b:	5d                   	pop    %rbp
  40090c:	41 5c                	pop    %r12
  40090e:	41 5d                	pop    %r13
  400910:	41 5e                	pop    %r14
  400912:	41 5f                	pop    %r15
  400914:	c3                   	retq   
  400915:	90                   	nop
  400916:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40091d:	00 00 00 

0000000000400920 <__libc_csu_fini>:
  400920:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000400924 <_fini>:
  400924:	48 83 ec 08          	sub    $0x8,%rsp
  400928:	48 83 c4 08          	add    $0x8,%rsp
  40092c:	c3                   	retq   
