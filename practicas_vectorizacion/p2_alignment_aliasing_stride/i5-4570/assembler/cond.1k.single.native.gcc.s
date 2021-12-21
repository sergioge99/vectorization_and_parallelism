
cond.1k.single.native.gcc:     formato del fichero elf64-x86-64


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
  check(z);
  return 0;
}

int main()
{
  400500:	48 83 ec 08          	sub    $0x8,%rsp
  printf("                      Time      TPI\n");
  400504:	bf 98 0a 40 00       	mov    $0x400a98,%edi
  400509:	e8 92 ff ff ff       	callq  4004a0 <puts@plt>
  printf("         Loop          ns      ps/el      Checksum\n");
  40050e:	bf c0 0a 40 00       	mov    $0x400ac0,%edi
  400513:	e8 88 ff ff ff       	callq  4004a0 <puts@plt>
  cond_esc();
  400518:	31 c0                	xor    %eax,%eax
  40051a:	e8 e1 02 00 00       	callq  400800 <cond_esc>
  cond_vec();
  40051f:	31 c0                	xor    %eax,%eax
  400521:	e8 da 03 00 00       	callq  400900 <cond_vec>
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
  40053c:	49 c7 c0 40 0a 40 00 	mov    $0x400a40,%r8
  400543:	48 c7 c1 d0 09 40 00 	mov    $0x4009d0,%rcx
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

0000000000400620 <set1d.constprop.0>:
    for (unsigned int i = 0; i < LEN; i += stride)
  400620:	c5 fa 10 05 d0 04 00 	vmovss 0x4d0(%rip),%xmm0        # 400af8 <_IO_stdin_used+0x98>
  400627:	00 
  400628:	b8 c0 30 60 00       	mov    $0x6030c0,%eax
  40062d:	ba c0 40 60 00       	mov    $0x6040c0,%edx
      arr[i] = value;
  400632:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (unsigned int i = 0; i < LEN; i += stride)
  400636:	48 83 c0 04          	add    $0x4,%rax
  40063a:	48 39 c2             	cmp    %rax,%rdx
  40063d:	75 f3                	jne    400632 <set1d.constprop.0+0x12>
}
  40063f:	31 c0                	xor    %eax,%eax
  400641:	c3                   	retq   
  400642:	0f 1f 40 00          	nopl   0x0(%rax)
  400646:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40064d:	00 00 00 

0000000000400650 <set1d.constprop.1>:
    for (unsigned int i = 0; i < LEN; i++)
  400650:	c5 fa 10 0d a0 04 00 	vmovss 0x4a0(%rip),%xmm1        # 400af8 <_IO_stdin_used+0x98>
  400657:	00 
  400658:	c5 e8 57 d2          	vxorps %xmm2,%xmm2,%xmm2
set1d(real arr[LEN], real value, int stride)
  40065c:	b8 01 00 00 00       	mov    $0x1,%eax
  400661:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
      arr[i] = 1. / (real) (i+1);
  400668:	c5 ea 2a c0          	vcvtsi2ss %eax,%xmm2,%xmm0
  40066c:	c5 f2 5e c0          	vdivss %xmm0,%xmm1,%xmm0
  400670:	c5 fa 11 44 87 fc    	vmovss %xmm0,-0x4(%rdi,%rax,4)
    for (unsigned int i = 0; i < LEN; i++)
  400676:	48 ff c0             	inc    %rax
  400679:	48 3d 01 04 00 00    	cmp    $0x401,%rax
  40067f:	75 e7                	jne    400668 <set1d.constprop.1+0x18>
}
  400681:	31 c0                	xor    %eax,%eax
  400683:	c3                   	retq   
  400684:	66 90                	xchg   %ax,%ax
  400686:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40068d:	00 00 00 

0000000000400690 <get_wall_time>:
{
  400690:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  400694:	31 f6                	xor    %esi,%esi
  400696:	48 89 e7             	mov    %rsp,%rdi
  400699:	e8 22 fe ff ff       	callq  4004c0 <gettimeofday@plt>
  40069e:	85 c0                	test   %eax,%eax
  4006a0:	75 22                	jne    4006c4 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4006a2:	c5 e8 57 d2          	vxorps %xmm2,%xmm2,%xmm2
  4006a6:	c4 e1 eb 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm2,%xmm0
  4006ad:	c5 fb 59 0d 53 04 00 	vmulsd 0x453(%rip),%xmm0,%xmm1        # 400b08 <_IO_stdin_used+0xa8>
  4006b4:	00 
  4006b5:	c4 e1 eb 2a 04 24    	vcvtsi2sdq (%rsp),%xmm2,%xmm0
}
  4006bb:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4006bf:	c5 f3 58 c0          	vaddsd %xmm0,%xmm1,%xmm0
}
  4006c3:	c3                   	retq   
        exit(-1); // return 0;
  4006c4:	83 cf ff             	or     $0xffffffff,%edi
  4006c7:	e8 14 fe ff ff       	callq  4004e0 <exit@plt>
  4006cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004006d0 <set1d>:
  if (stride == -1) {
  4006d0:	c5 f0 57 c9          	vxorps %xmm1,%xmm1,%xmm1
  4006d4:	83 fe ff             	cmp    $0xffffffff,%esi
  4006d7:	74 79                	je     400752 <set1d+0x82>
  else if (stride == -2) {
  4006d9:	83 fe fe             	cmp    $0xfffffffe,%esi
  4006dc:	74 44                	je     400722 <set1d+0x52>
    for (unsigned int i = 0; i < LEN; i += stride)
  4006de:	31 c0                	xor    %eax,%eax
  4006e0:	83 fe 01             	cmp    $0x1,%esi
  4006e3:	75 1b                	jne    400700 <set1d+0x30>
  4006e5:	0f 1f 00             	nopl   (%rax)
      arr[i] = value;
  4006e8:	89 c2                	mov    %eax,%edx
    for (unsigned int i = 0; i < LEN; i += stride)
  4006ea:	ff c0                	inc    %eax
      arr[i] = value;
  4006ec:	c5 fa 11 04 97       	vmovss %xmm0,(%rdi,%rdx,4)
    for (unsigned int i = 0; i < LEN; i += stride)
  4006f1:	3d 00 04 00 00       	cmp    $0x400,%eax
  4006f6:	75 f0                	jne    4006e8 <set1d+0x18>
}
  4006f8:	31 c0                	xor    %eax,%eax
  4006fa:	c3                   	retq   
  4006fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
      arr[i] = value;
  400700:	89 c2                	mov    %eax,%edx
    for (unsigned int i = 0; i < LEN; i += stride)
  400702:	01 f0                	add    %esi,%eax
      arr[i] = value;
  400704:	c5 fa 11 04 97       	vmovss %xmm0,(%rdi,%rdx,4)
    for (unsigned int i = 0; i < LEN; i += stride)
  400709:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  40070e:	77 e8                	ja     4006f8 <set1d+0x28>
      arr[i] = value;
  400710:	89 c2                	mov    %eax,%edx
    for (unsigned int i = 0; i < LEN; i += stride)
  400712:	01 f0                	add    %esi,%eax
      arr[i] = value;
  400714:	c5 fa 11 04 97       	vmovss %xmm0,(%rdi,%rdx,4)
    for (unsigned int i = 0; i < LEN; i += stride)
  400719:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  40071e:	76 e0                	jbe    400700 <set1d+0x30>
  400720:	eb d6                	jmp    4006f8 <set1d+0x28>
  400722:	c5 fa 10 15 ce 03 00 	vmovss 0x3ce(%rip),%xmm2        # 400af8 <_IO_stdin_used+0x98>
  400729:	00 
  40072a:	ba 01 00 00 00       	mov    $0x1,%edx
  40072f:	90                   	nop
      arr[i] = 1. / (real) ((i+1) * (i+1));
  400730:	89 d0                	mov    %edx,%eax
  400732:	0f af c2             	imul   %edx,%eax
  400735:	c5 f2 2a c0          	vcvtsi2ss %eax,%xmm1,%xmm0
  400739:	c5 ea 5e c0          	vdivss %xmm0,%xmm2,%xmm0
  40073d:	c5 fa 11 44 97 fc    	vmovss %xmm0,-0x4(%rdi,%rdx,4)
    for (unsigned int i = 0; i < LEN; i++)
  400743:	48 ff c2             	inc    %rdx
  400746:	48 81 fa 01 04 00 00 	cmp    $0x401,%rdx
  40074d:	75 e1                	jne    400730 <set1d+0x60>
}
  40074f:	31 c0                	xor    %eax,%eax
  400751:	c3                   	retq   
  400752:	c5 fa 10 15 9e 03 00 	vmovss 0x39e(%rip),%xmm2        # 400af8 <_IO_stdin_used+0x98>
  400759:	00 
  40075a:	b8 01 00 00 00       	mov    $0x1,%eax
  40075f:	90                   	nop
      arr[i] = 1. / (real) (i+1);
  400760:	c5 f2 2a c0          	vcvtsi2ss %eax,%xmm1,%xmm0
  400764:	c5 ea 5e c0          	vdivss %xmm0,%xmm2,%xmm0
  400768:	c5 fa 11 44 87 fc    	vmovss %xmm0,-0x4(%rdi,%rax,4)
    for (unsigned int i = 0; i < LEN; i++)
  40076e:	48 ff c0             	inc    %rax
  400771:	48 3d 01 04 00 00    	cmp    $0x401,%rax
  400777:	75 e7                	jne    400760 <set1d+0x90>
}
  400779:	31 c0                	xor    %eax,%eax
  40077b:	c3                   	retq   
  40077c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400780 <check>:
  for (unsigned int i = 0; i < LEN; i++)
  400780:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
  real sum = 0;
  400787:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40078b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    sum += arr[i];
  400790:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
  for (unsigned int i = 0; i < LEN; i++)
  400794:	48 83 c7 04          	add    $0x4,%rdi
  400798:	48 39 f8             	cmp    %rdi,%rax
  40079b:	75 f3                	jne    400790 <check+0x10>
  printf("%f \n", sum);
  40079d:	bf 64 0a 40 00       	mov    $0x400a64,%edi
  4007a2:	b8 01 00 00 00       	mov    $0x1,%eax
  4007a7:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  4007ab:	e9 00 fd ff ff       	jmpq   4004b0 <printf@plt>

00000000004007b0 <init>:
  set1d(x, one, unit);
  4007b0:	e8 6b fe ff ff       	callq  400620 <set1d.constprop.0>
  set1d(y, any, frac1);
  4007b5:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  4007ba:	e8 91 fe ff ff       	callq  400650 <set1d.constprop.1>
  set1d(z, any, frac1);
  4007bf:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  4007c4:	e8 87 fe ff ff       	callq  400650 <set1d.constprop.1>
}
  4007c9:	31 c0                	xor    %eax,%eax
  4007cb:	c3                   	retq   
  4007cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004007d0 <results>:
{
  4007d0:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %6.1f    %6.1f     ",
  4007d3:	b8 02 00 00 00       	mov    $0x2,%eax
  4007d8:	bf 69 0a 40 00       	mov    $0x400a69,%edi
  4007dd:	c5 fb 5e 15 33 03 00 	vdivsd 0x333(%rip),%xmm0,%xmm2        # 400b18 <_IO_stdin_used+0xb8>
  4007e4:	00 
  4007e5:	c5 fb 5e 0d 23 03 00 	vdivsd 0x323(%rip),%xmm0,%xmm1        # 400b10 <_IO_stdin_used+0xb0>
  4007ec:	00 
  4007ed:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  4007f1:	e9 ba fc ff ff       	jmpq   4004b0 <printf@plt>
  4007f6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4007fd:	00 00 00 

0000000000400800 <cond_esc>:
{
  400800:	53                   	push   %rbx
  init();
  400801:	31 c0                	xor    %eax,%eax
  start_t = get_wall_time();
  400803:	bb 00 00 a0 00       	mov    $0xa00000,%ebx
{
  400808:	48 83 ec 10          	sub    $0x10,%rsp
  init();
  40080c:	e8 9f ff ff ff       	callq  4007b0 <init>
  start_t = get_wall_time();
  400811:	31 c0                	xor    %eax,%eax
  400813:	e8 78 fe ff ff       	callq  400690 <get_wall_time>
  400818:	c5 fa 10 0d dc 02 00 	vmovss 0x2dc(%rip),%xmm1        # 400afc <_IO_stdin_used+0x9c>
  40081f:	00 
  400820:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
{
  400826:	31 c0                	xor    %eax,%eax
  400828:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40082f:	00 
      if (y[i] < umbral)
  400830:	c5 fa 10 80 c0 20 60 	vmovss 0x6020c0(%rax),%xmm0
  400837:	00 
  400838:	c5 f8 2f c8          	vcomiss %xmm0,%xmm1
  40083c:	0f 87 96 00 00 00    	ja     4008d8 <cond_esc+0xd8>
         z[i] = x[i];
  400842:	c5 fa 10 80 c0 30 60 	vmovss 0x6030c0(%rax),%xmm0
  400849:	00 
  40084a:	48 83 c0 04          	add    $0x4,%rax
  40084e:	c5 fa 11 80 bc 10 60 	vmovss %xmm0,0x6010bc(%rax)
  400855:	00 
    for (unsigned int i = 0; i < LEN; i++)
  400856:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  40085c:	75 d2                	jne    400830 <cond_esc+0x30>
    dummy(x, y, z, scalar);
  40085e:	ba c0 10 60 00       	mov    $0x6010c0,%edx
  400863:	be c0 20 60 00       	mov    $0x6020c0,%esi
  400868:	bf c0 30 60 00       	mov    $0x6030c0,%edi
  40086d:	c5 fa 10 05 8b 02 00 	vmovss 0x28b(%rip),%xmm0        # 400b00 <_IO_stdin_used+0xa0>
  400874:	00 
  400875:	e8 88 fd ff ff       	callq  400602 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40087a:	ff cb                	dec    %ebx
  40087c:	c5 fa 10 0d 78 02 00 	vmovss 0x278(%rip),%xmm1        # 400afc <_IO_stdin_used+0x9c>
  400883:	00 
  400884:	75 a0                	jne    400826 <cond_esc+0x26>
  end_t = get_wall_time();
  400886:	31 c0                	xor    %eax,%eax
  400888:	e8 03 fe ff ff       	callq  400690 <get_wall_time>
  results(end_t - start_t, "cond_esc");
  40088d:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  400893:	bf 83 0a 40 00       	mov    $0x400a83,%edi
  400898:	e8 33 ff ff ff       	callq  4007d0 <results>
  for (unsigned int i = 0; i < LEN; i++)
  40089d:	b8 c0 10 60 00       	mov    $0x6010c0,%eax
  real sum = 0;
  4008a2:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
    sum += arr[i];
  4008a6:	c5 fa 58 00          	vaddss (%rax),%xmm0,%xmm0
  for (unsigned int i = 0; i < LEN; i++)
  4008aa:	48 83 c0 04          	add    $0x4,%rax
  4008ae:	48 3d c0 20 60 00    	cmp    $0x6020c0,%rax
  4008b4:	75 f0                	jne    4008a6 <cond_esc+0xa6>
  printf("%f \n", sum);
  4008b6:	bf 64 0a 40 00       	mov    $0x400a64,%edi
  4008bb:	b8 01 00 00 00       	mov    $0x1,%eax
  4008c0:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  4008c4:	e8 e7 fb ff ff       	callq  4004b0 <printf@plt>
}
  4008c9:	48 83 c4 10          	add    $0x10,%rsp
  4008cd:	31 c0                	xor    %eax,%eax
  4008cf:	5b                   	pop    %rbx
  4008d0:	c3                   	retq   
  4008d1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  4008d8:	c5 fa 11 80 c0 10 60 	vmovss %xmm0,0x6010c0(%rax)
  4008df:	00 
    for (unsigned int i = 0; i < LEN; i++)
  4008e0:	48 83 c0 04          	add    $0x4,%rax
  4008e4:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  4008ea:	0f 85 40 ff ff ff    	jne    400830 <cond_esc+0x30>
  4008f0:	e9 69 ff ff ff       	jmpq   40085e <cond_esc+0x5e>
  4008f5:	90                   	nop
  4008f6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4008fd:	00 00 00 

0000000000400900 <cond_vec>:
{
  400900:	4c 8d 54 24 08       	lea    0x8(%rsp),%r10
  400905:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  init();
  400909:	31 c0                	xor    %eax,%eax
{
  40090b:	41 ff 72 f8          	pushq  -0x8(%r10)
  40090f:	55                   	push   %rbp
  400910:	48 89 e5             	mov    %rsp,%rbp
  400913:	41 52                	push   %r10
  400915:	53                   	push   %rbx
  start_t = get_wall_time();
  400916:	bb 00 00 a0 00       	mov    $0xa00000,%ebx
{
  40091b:	48 83 ec 20          	sub    $0x20,%rsp
  init();
  40091f:	e8 8c fe ff ff       	callq  4007b0 <init>
  start_t = get_wall_time();
  400924:	31 c0                	xor    %eax,%eax
  400926:	e8 65 fd ff ff       	callq  400690 <get_wall_time>
  40092b:	c5 fc 28 0d ed 01 00 	vmovaps 0x1ed(%rip),%ymm1        # 400b20 <_IO_stdin_used+0xc0>
  400932:	00 
  400933:	c5 fb 11 45 e8       	vmovsd %xmm0,-0x18(%rbp)
  400938:	31 c0                	xor    %eax,%eax
  40093a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
         z[i] = x[i];
  400940:	c5 fc 28 90 c0 20 60 	vmovaps 0x6020c0(%rax),%ymm2
  400947:	00 
  400948:	c5 fc 28 98 c0 30 60 	vmovaps 0x6030c0(%rax),%ymm3
  40094f:	00 
  400950:	48 83 c0 20          	add    $0x20,%rax
  400954:	c5 ec c2 c1 01       	vcmpltps %ymm1,%ymm2,%ymm0
  400959:	c4 e3 65 4a c2 00    	vblendvps %ymm0,%ymm2,%ymm3,%ymm0
  40095f:	c5 fc 29 80 a0 10 60 	vmovaps %ymm0,0x6010a0(%rax)
  400966:	00 
    for (unsigned int i = 0; i < LEN; i++)
  400967:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  40096d:	75 d1                	jne    400940 <cond_vec+0x40>
    dummy(x, y, z, scalar);
  40096f:	ba c0 10 60 00       	mov    $0x6010c0,%edx
  400974:	be c0 20 60 00       	mov    $0x6020c0,%esi
  400979:	bf c0 30 60 00       	mov    $0x6030c0,%edi
  40097e:	c5 fa 10 05 7a 01 00 	vmovss 0x17a(%rip),%xmm0        # 400b00 <_IO_stdin_used+0xa0>
  400985:	00 
  400986:	c5 f8 77             	vzeroupper 
  400989:	e8 74 fc ff ff       	callq  400602 <dummy>
  for (unsigned int nl = 0; nl < NTIMES; nl++)
  40098e:	ff cb                	dec    %ebx
  400990:	c5 fc 28 0d 88 01 00 	vmovaps 0x188(%rip),%ymm1        # 400b20 <_IO_stdin_used+0xc0>
  400997:	00 
  400998:	75 9e                	jne    400938 <cond_vec+0x38>
  end_t = get_wall_time();
  40099a:	31 c0                	xor    %eax,%eax
  40099c:	c5 f8 77             	vzeroupper 
  40099f:	e8 ec fc ff ff       	callq  400690 <get_wall_time>
  results(end_t - start_t, "cond_vec");
  4009a4:	c5 fb 5c 45 e8       	vsubsd -0x18(%rbp),%xmm0,%xmm0
  4009a9:	bf 8c 0a 40 00       	mov    $0x400a8c,%edi
  4009ae:	e8 1d fe ff ff       	callq  4007d0 <results>
  check(z);
  4009b3:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  4009b8:	e8 c3 fd ff ff       	callq  400780 <check>
}
  4009bd:	48 83 c4 20          	add    $0x20,%rsp
  4009c1:	31 c0                	xor    %eax,%eax
  4009c3:	5b                   	pop    %rbx
  4009c4:	41 5a                	pop    %r10
  4009c6:	5d                   	pop    %rbp
  4009c7:	49 8d 62 f8          	lea    -0x8(%r10),%rsp
  4009cb:	c3                   	retq   
  4009cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004009d0 <__libc_csu_init>:
  4009d0:	41 57                	push   %r15
  4009d2:	41 89 ff             	mov    %edi,%r15d
  4009d5:	41 56                	push   %r14
  4009d7:	49 89 f6             	mov    %rsi,%r14
  4009da:	41 55                	push   %r13
  4009dc:	49 89 d5             	mov    %rdx,%r13
  4009df:	41 54                	push   %r12
  4009e1:	4c 8d 25 20 04 20 00 	lea    0x200420(%rip),%r12        # 600e08 <__frame_dummy_init_array_entry>
  4009e8:	55                   	push   %rbp
  4009e9:	48 8d 2d 20 04 20 00 	lea    0x200420(%rip),%rbp        # 600e10 <__init_array_end>
  4009f0:	53                   	push   %rbx
  4009f1:	4c 29 e5             	sub    %r12,%rbp
  4009f4:	31 db                	xor    %ebx,%ebx
  4009f6:	48 c1 fd 03          	sar    $0x3,%rbp
  4009fa:	48 83 ec 08          	sub    $0x8,%rsp
  4009fe:	e8 6d fa ff ff       	callq  400470 <_init>
  400a03:	48 85 ed             	test   %rbp,%rbp
  400a06:	74 1e                	je     400a26 <__libc_csu_init+0x56>
  400a08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  400a0f:	00 
  400a10:	4c 89 ea             	mov    %r13,%rdx
  400a13:	4c 89 f6             	mov    %r14,%rsi
  400a16:	44 89 ff             	mov    %r15d,%edi
  400a19:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  400a1d:	48 83 c3 01          	add    $0x1,%rbx
  400a21:	48 39 eb             	cmp    %rbp,%rbx
  400a24:	75 ea                	jne    400a10 <__libc_csu_init+0x40>
  400a26:	48 83 c4 08          	add    $0x8,%rsp
  400a2a:	5b                   	pop    %rbx
  400a2b:	5d                   	pop    %rbp
  400a2c:	41 5c                	pop    %r12
  400a2e:	41 5d                	pop    %r13
  400a30:	41 5e                	pop    %r14
  400a32:	41 5f                	pop    %r15
  400a34:	c3                   	retq   
  400a35:	90                   	nop
  400a36:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400a3d:	00 00 00 

0000000000400a40 <__libc_csu_fini>:
  400a40:	f3 c3                	repz retq 

Desensamblado de la sección .fini:

0000000000400a44 <_fini>:
  400a44:	48 83 ec 08          	sub    $0x8,%rsp
  400a48:	48 83 c4 08          	add    $0x8,%rsp
  400a4c:	c3                   	retq   
