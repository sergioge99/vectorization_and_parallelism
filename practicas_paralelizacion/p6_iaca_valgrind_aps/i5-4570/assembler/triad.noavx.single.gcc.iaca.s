
triad.noavx.single.gcc.iaca:     formato del fichero elf64-x86-64


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
    check(a);
    return 0;
}

int main()
{
  400500:	48 83 ec 08          	sub    $0x8,%rsp
  // printf("LEN: %u\n\n", LEN);
  printf("triad kernel, LEN: %u, NTIMES: %lu\n\n", LEN, NTIMES);
  400504:	ba 00 00 f0 00       	mov    $0xf00000,%edx
  400509:	be 00 04 00 00       	mov    $0x400,%esi
  40050e:	31 c0                	xor    %eax,%eax
  400510:	bf f0 08 40 00       	mov    $0x4008f0,%edi
  400515:	e8 96 ff ff ff       	callq  4004b0 <printf@plt>
  printf("                     Time    TPI\n");
  40051a:	bf 18 09 40 00       	mov    $0x400918,%edi
  40051f:	e8 7c ff ff ff       	callq  4004a0 <puts@plt>
  printf("              Loop    ns     ps/it     Checksum \n");
  400524:	bf 40 09 40 00       	mov    $0x400940,%edi
  400529:	e8 72 ff ff ff       	callq  4004a0 <puts@plt>
  triad();
  40052e:	31 c0                	xor    %eax,%eax
  400530:	e8 2b 02 00 00       	callq  400760 <triad>
  exit(0);
  400535:	31 ff                	xor    %edi,%edi
  400537:	e8 a4 ff ff ff       	callq  4004e0 <exit@plt>

000000000040053c <_start>:
  40053c:	31 ed                	xor    %ebp,%ebp
  40053e:	49 89 d1             	mov    %rdx,%r9
  400541:	5e                   	pop    %rsi
  400542:	48 89 e2             	mov    %rsp,%rdx
  400545:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  400549:	50                   	push   %rax
  40054a:	54                   	push   %rsp
  40054b:	49 c7 c0 b0 08 40 00 	mov    $0x4008b0,%r8
  400552:	48 c7 c1 40 08 40 00 	mov    $0x400840,%rcx
  400559:	48 c7 c7 00 05 40 00 	mov    $0x400500,%rdi
  400560:	e8 6b ff ff ff       	callq  4004d0 <__libc_start_main@plt>
  400565:	f4                   	hlt    
  400566:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40056d:	00 00 00 

0000000000400570 <deregister_tm_clones>:
  400570:	b8 50 10 60 00       	mov    $0x601050,%eax
  400575:	48 3d 50 10 60 00    	cmp    $0x601050,%rax
  40057b:	74 13                	je     400590 <deregister_tm_clones+0x20>
  40057d:	b8 00 00 00 00       	mov    $0x0,%eax
  400582:	48 85 c0             	test   %rax,%rax
  400585:	74 09                	je     400590 <deregister_tm_clones+0x20>
  400587:	bf 50 10 60 00       	mov    $0x601050,%edi
  40058c:	ff e0                	jmpq   *%rax
  40058e:	66 90                	xchg   %ax,%ax
  400590:	c3                   	retq   
  400591:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400596:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40059d:	00 00 00 

00000000004005a0 <register_tm_clones>:
  4005a0:	be 50 10 60 00       	mov    $0x601050,%esi
  4005a5:	48 81 ee 50 10 60 00 	sub    $0x601050,%rsi
  4005ac:	48 89 f0             	mov    %rsi,%rax
  4005af:	48 c1 ee 3f          	shr    $0x3f,%rsi
  4005b3:	48 c1 f8 03          	sar    $0x3,%rax
  4005b7:	48 01 c6             	add    %rax,%rsi
  4005ba:	48 d1 fe             	sar    %rsi
  4005bd:	74 11                	je     4005d0 <register_tm_clones+0x30>
  4005bf:	b8 00 00 00 00       	mov    $0x0,%eax
  4005c4:	48 85 c0             	test   %rax,%rax
  4005c7:	74 07                	je     4005d0 <register_tm_clones+0x30>
  4005c9:	bf 50 10 60 00       	mov    $0x601050,%edi
  4005ce:	ff e0                	jmpq   *%rax
  4005d0:	c3                   	retq   
  4005d1:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4005d6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4005dd:	00 00 00 

00000000004005e0 <__do_global_dtors_aux>:
  4005e0:	80 3d 99 0a 20 00 00 	cmpb   $0x0,0x200a99(%rip)        # 601080 <completed.7338>
  4005e7:	75 17                	jne    400600 <__do_global_dtors_aux+0x20>
  4005e9:	55                   	push   %rbp
  4005ea:	48 89 e5             	mov    %rsp,%rbp
  4005ed:	e8 7e ff ff ff       	callq  400570 <deregister_tm_clones>
  4005f2:	5d                   	pop    %rbp
  4005f3:	c6 05 86 0a 20 00 01 	movb   $0x1,0x200a86(%rip)        # 601080 <completed.7338>
  4005fa:	c3                   	retq   
  4005fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400600:	c3                   	retq   
  400601:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400606:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40060d:	00 00 00 

0000000000400610 <frame_dummy>:
  400610:	eb 8e                	jmp    4005a0 <register_tm_clones>

0000000000400612 <dummy>:
  400612:	55                   	push   %rbp
  400613:	48 89 e5             	mov    %rsp,%rbp
  400616:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  40061a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  40061e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  400622:	f3 0f 11 45 e4       	movss  %xmm0,-0x1c(%rbp)
  400627:	b8 00 00 00 00       	mov    $0x0,%eax
  40062c:	5d                   	pop    %rbp
  40062d:	c3                   	retq   
  40062e:	66 90                	xchg   %ax,%ax

0000000000400630 <get_wall_time>:
{
  400630:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  400634:	31 f6                	xor    %esi,%esi
  400636:	48 89 e7             	mov    %rsp,%rdi
  400639:	e8 82 fe ff ff       	callq  4004c0 <gettimeofday@plt>
  40063e:	85 c0                	test   %eax,%eax
  400640:	75 22                	jne    400664 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  400642:	c5 e8 57 d2          	vxorps %xmm2,%xmm2,%xmm2
  400646:	c4 e1 eb 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm2,%xmm0
  40064d:	c5 fb 59 0d 23 03 00 	vmulsd 0x323(%rip),%xmm0,%xmm1        # 400978 <_IO_stdin_used+0xb8>
  400654:	00 
  400655:	c4 e1 eb 2a 04 24    	vcvtsi2sdq (%rsp),%xmm2,%xmm0
}
  40065b:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  40065f:	c5 f3 58 c0          	vaddsd %xmm0,%xmm1,%xmm0
}
  400663:	c3                   	retq   
        exit(-1); // return 0;
  400664:	83 cf ff             	or     $0xffffffff,%edi
  400667:	e8 74 fe ff ff       	callq  4004e0 <exit@plt>
  40066c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400670 <check>:
    for (unsigned int i = 0; i < LEN; i++)
  400670:	48 8d 87 00 10 00 00 	lea    0x1000(%rdi),%rax
    real sum = 0;
  400677:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  40067b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
        sum += arr[i];
  400680:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  400684:	48 83 c7 04          	add    $0x4,%rdi
  400688:	48 39 f8             	cmp    %rdi,%rax
  40068b:	75 f3                	jne    400680 <check+0x10>
    printf("%f \n", sum);
  40068d:	bf c4 08 40 00       	mov    $0x4008c4,%edi
  400692:	b8 01 00 00 00       	mov    $0x1,%eax
  400697:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  40069b:	e9 10 fe ff ff       	jmpq   4004b0 <printf@plt>

00000000004006a0 <init>:
    for (int j = 0; j < LEN; j++)
  4006a0:	ba c0 30 60 00       	mov    $0x6030c0,%edx
  4006a5:	c5 fa 10 05 e3 02 00 	vmovss 0x2e3(%rip),%xmm0        # 400990 <_IO_stdin_used+0xd0>
  4006ac:	00 
{
  4006ad:	48 89 d0             	mov    %rdx,%rax
	    a[j] = 1.0;
  4006b0:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (int j = 0; j < LEN; j++)
  4006b4:	48 83 c0 04          	add    $0x4,%rax
  4006b8:	48 3d c0 40 60 00    	cmp    $0x6040c0,%rax
  4006be:	75 f0                	jne    4006b0 <init+0x10>
  4006c0:	c5 fa 10 05 cc 02 00 	vmovss 0x2cc(%rip),%xmm0        # 400994 <_IO_stdin_used+0xd4>
  4006c7:	00 
  4006c8:	b8 c0 20 60 00       	mov    $0x6020c0,%eax
  4006cd:	0f 1f 00             	nopl   (%rax)
	    b[j] = 2.0;
  4006d0:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (int j = 0; j < LEN; j++)
  4006d4:	48 83 c0 04          	add    $0x4,%rax
  4006d8:	48 3d c0 30 60 00    	cmp    $0x6030c0,%rax
  4006de:	75 f0                	jne    4006d0 <init+0x30>
    b[69] = 69.0;
  4006e0:	c5 fa 10 05 b0 02 00 	vmovss 0x2b0(%rip),%xmm0        # 400998 <_IO_stdin_used+0xd8>
  4006e7:	00 
  4006e8:	be c0 10 60 00       	mov    $0x6010c0,%esi
  4006ed:	b9 00 02 00 00       	mov    $0x200,%ecx
  4006f2:	31 c0                	xor    %eax,%eax
  4006f4:	48 89 f7             	mov    %rsi,%rdi
  4006f7:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  4006fa:	c5 fa 11 05 d2 1a 20 	vmovss %xmm0,0x201ad2(%rip)        # 6021d4 <b+0x114>
  400701:	00 
    c[69] = 69.0;
  400702:	c5 fa 11 05 ca 0a 20 	vmovss %xmm0,0x200aca(%rip)        # 6011d4 <c+0x114>
  400709:	00 
    for (int j = 0; j < LEN; j++)
  40070a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
		a[j] = 2.0E0 * a[j];
  400710:	c5 fa 10 02          	vmovss (%rdx),%xmm0
  400714:	48 83 c2 04          	add    $0x4,%rdx
  400718:	c5 fa 58 c0          	vaddss %xmm0,%xmm0,%xmm0
  40071c:	c5 fa 11 42 fc       	vmovss %xmm0,-0x4(%rdx)
    for (int j = 0; j < LEN; j++)
  400721:	48 81 fa c0 40 60 00 	cmp    $0x6040c0,%rdx
  400728:	75 e6                	jne    400710 <init+0x70>
}
  40072a:	31 c0                	xor    %eax,%eax
  40072c:	c3                   	retq   
  40072d:	0f 1f 00             	nopl   (%rax)

0000000000400730 <results>:
{
  400730:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %5.1f    %5.1f     ",
  400733:	b8 02 00 00 00       	mov    $0x2,%eax
  400738:	bf c9 08 40 00       	mov    $0x4008c9,%edi
  40073d:	c5 fb 5e 15 43 02 00 	vdivsd 0x243(%rip),%xmm0,%xmm2        # 400988 <_IO_stdin_used+0xc8>
  400744:	00 
  400745:	c5 fb 5e 0d 33 02 00 	vdivsd 0x233(%rip),%xmm0,%xmm1        # 400980 <_IO_stdin_used+0xc0>
  40074c:	00 
  40074d:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  400751:	e9 5a fd ff ff       	jmpq   4004b0 <printf@plt>
  400756:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40075d:	00 00 00 

0000000000400760 <triad>:
{
  400760:	53                   	push   %rbx
    init();
  400761:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  400763:	bb 00 00 f0 00       	mov    $0xf00000,%ebx
{
  400768:	48 83 ec 10          	sub    $0x10,%rsp
    init();
  40076c:	e8 2f ff ff ff       	callq  4006a0 <init>
    start_t = get_wall_time();
  400771:	31 c0                	xor    %eax,%eax
  400773:	e8 b8 fe ff ff       	callq  400630 <get_wall_time>
  400778:	c5 fa 10 0d 1c 02 00 	vmovss 0x21c(%rip),%xmm1        # 40099c <_IO_stdin_used+0xdc>
  40077f:	00 
  400780:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
{
  400786:	31 c0                	xor    %eax,%eax
  400788:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40078f:	00 
            IACA_START
  400790:	bb 6f 00 00 00       	mov    $0x6f,%ebx
  400795:	64 67 90             	fs addr32 nop
            a[i] = b[i] + scalar*c[i];
  400798:	c5 f2 59 80 c0 10 60 	vmulss 0x6010c0(%rax),%xmm1,%xmm0
  40079f:	00 
  4007a0:	48 83 c0 04          	add    $0x4,%rax
  4007a4:	c5 fa 58 80 bc 20 60 	vaddss 0x6020bc(%rax),%xmm0,%xmm0
  4007ab:	00 
  4007ac:	c5 fa 11 80 bc 30 60 	vmovss %xmm0,0x6030bc(%rax)
  4007b3:	00 
        for (unsigned int i = 0; i < LEN; i++)
  4007b4:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
  4007ba:	75 d4                	jne    400790 <triad+0x30>
        IACA_END
  4007bc:	bb de 00 00 00       	mov    $0xde,%ebx
  4007c1:	64 67 90             	fs addr32 nop
        dummy(a, b, c, scalar);
  4007c4:	ba c0 10 60 00       	mov    $0x6010c0,%edx
  4007c9:	c5 f8 28 c1          	vmovaps %xmm1,%xmm0
  4007cd:	be c0 20 60 00       	mov    $0x6020c0,%esi
  4007d2:	bf c0 30 60 00       	mov    $0x6030c0,%edi
  4007d7:	e8 36 fe ff ff       	callq  400612 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4007dc:	83 eb 01             	sub    $0x1,%ebx
  4007df:	c5 fa 10 0d b5 01 00 	vmovss 0x1b5(%rip),%xmm1        # 40099c <_IO_stdin_used+0xdc>
  4007e6:	00 
  4007e7:	75 9d                	jne    400786 <triad+0x26>
    end_t = get_wall_time();
  4007e9:	31 c0                	xor    %eax,%eax
  4007eb:	e8 40 fe ff ff       	callq  400630 <get_wall_time>
    results(end_t - start_t, "triad");
  4007f0:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  4007f6:	bf e3 08 40 00       	mov    $0x4008e3,%edi
  4007fb:	e8 30 ff ff ff       	callq  400730 <results>
    for (unsigned int i = 0; i < LEN; i++)
  400800:	b8 c0 30 60 00       	mov    $0x6030c0,%eax
    real sum = 0;
  400805:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
        sum += arr[i];
  400809:	c5 fa 58 00          	vaddss (%rax),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  40080d:	48 83 c0 04          	add    $0x4,%rax
  400811:	48 3d c0 40 60 00    	cmp    $0x6040c0,%rax
  400817:	75 f0                	jne    400809 <triad+0xa9>
    printf("%f \n", sum);
  400819:	bf c4 08 40 00       	mov    $0x4008c4,%edi
  40081e:	b8 01 00 00 00       	mov    $0x1,%eax
  400823:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  400827:	e8 84 fc ff ff       	callq  4004b0 <printf@plt>
}
  40082c:	48 83 c4 10          	add    $0x10,%rsp
  400830:	31 c0                	xor    %eax,%eax
  400832:	5b                   	pop    %rbx
  400833:	c3                   	retq   
  400834:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40083b:	00 00 00 
  40083e:	66 90                	xchg   %ax,%ax

0000000000400840 <__libc_csu_init>:
  400840:	41 57                	push   %r15
  400842:	41 89 ff             	mov    %edi,%r15d
  400845:	41 56                	push   %r14
  400847:	49 89 f6             	mov    %rsi,%r14
  40084a:	41 55                	push   %r13
  40084c:	49 89 d5             	mov    %rdx,%r13
  40084f:	41 54                	push   %r12
  400851:	4c 8d 25 b0 05 20 00 	lea    0x2005b0(%rip),%r12        # 600e08 <__frame_dummy_init_array_entry>
  400858:	55                   	push   %rbp
  400859:	48 8d 2d b0 05 20 00 	lea    0x2005b0(%rip),%rbp        # 600e10 <__init_array_end>
  400860:	53                   	push   %rbx
  400861:	4c 29 e5             	sub    %r12,%rbp
  400864:	31 db                	xor    %ebx,%ebx
  400866:	48 c1 fd 03          	sar    $0x3,%rbp
  40086a:	48 83 ec 08          	sub    $0x8,%rsp
  40086e:	e8 fd fb ff ff       	callq  400470 <_init>
  400873:	48 85 ed             	test   %rbp,%rbp
  400876:	74 1e                	je     400896 <__libc_csu_init+0x56>
  400878:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40087f:	00 
  400880:	4c 89 ea             	mov    %r13,%rdx
  400883:	4c 89 f6             	mov    %r14,%rsi
  400886:	44 89 ff             	mov    %r15d,%edi
  400889:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  40088d:	48 83 c3 01          	add    $0x1,%rbx
  400891:	48 39 eb             	cmp    %rbp,%rbx
  400894:	75 ea                	jne    400880 <__libc_csu_init+0x40>
  400896:	48 83 c4 08          	add    $0x8,%rsp
  40089a:	5b                   	pop    %rbx
  40089b:	5d                   	pop    %rbp
  40089c:	41 5c                	pop    %r12
  40089e:	41 5d                	pop    %r13
  4008a0:	41 5e                	pop    %r14
  4008a2:	41 5f                	pop    %r15
  4008a4:	c3                   	retq   
  4008a5:	90                   	nop
  4008a6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4008ad:	00 00 00 

00000000004008b0 <__libc_csu_fini>:
  4008b0:	f3 c3                	repz retq 

Desensamblado de la sección .fini:

00000000004008b4 <_fini>:
  4008b4:	48 83 ec 08          	sub    $0x8,%rsp
  4008b8:	48 83 c4 08          	add    $0x8,%rsp
  4008bc:	c3                   	retq   
