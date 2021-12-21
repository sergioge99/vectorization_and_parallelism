
triad.noavx.omp.32k.single.gcc:     formato del fichero elf64-x86-64


Desensamblado de la sección .init:

00000000004005e0 <_init>:
  4005e0:	48 83 ec 08          	sub    $0x8,%rsp
  4005e4:	48 8b 05 0d 0a 20 00 	mov    0x200a0d(%rip),%rax        # 600ff8 <__gmon_start__>
  4005eb:	48 85 c0             	test   %rax,%rax
  4005ee:	74 05                	je     4005f5 <_init+0x15>
  4005f0:	e8 ab 00 00 00       	callq  4006a0 <.plt.got>
  4005f5:	48 83 c4 08          	add    $0x8,%rsp
  4005f9:	c3                   	retq   

Desensamblado de la sección .plt:

0000000000400600 <.plt>:
  400600:	ff 35 02 0a 20 00    	pushq  0x200a02(%rip)        # 601008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400606:	ff 25 04 0a 20 00    	jmpq   *0x200a04(%rip)        # 601010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40060c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400610 <puts@plt>:
  400610:	ff 25 02 0a 20 00    	jmpq   *0x200a02(%rip)        # 601018 <puts@GLIBC_2.2.5>
  400616:	68 00 00 00 00       	pushq  $0x0
  40061b:	e9 e0 ff ff ff       	jmpq   400600 <.plt>

0000000000400620 <omp_get_thread_num@plt>:
  400620:	ff 25 fa 09 20 00    	jmpq   *0x2009fa(%rip)        # 601020 <omp_get_thread_num@OMP_1.0>
  400626:	68 01 00 00 00       	pushq  $0x1
  40062b:	e9 d0 ff ff ff       	jmpq   400600 <.plt>

0000000000400630 <printf@plt>:
  400630:	ff 25 f2 09 20 00    	jmpq   *0x2009f2(%rip)        # 601028 <printf@GLIBC_2.2.5>
  400636:	68 02 00 00 00       	pushq  $0x2
  40063b:	e9 c0 ff ff ff       	jmpq   400600 <.plt>

0000000000400640 <gettimeofday@plt>:
  400640:	ff 25 ea 09 20 00    	jmpq   *0x2009ea(%rip)        # 601030 <gettimeofday@GLIBC_2.2.5>
  400646:	68 03 00 00 00       	pushq  $0x3
  40064b:	e9 b0 ff ff ff       	jmpq   400600 <.plt>

0000000000400650 <memset@plt>:
  400650:	ff 25 e2 09 20 00    	jmpq   *0x2009e2(%rip)        # 601038 <memset@GLIBC_2.2.5>
  400656:	68 04 00 00 00       	pushq  $0x4
  40065b:	e9 a0 ff ff ff       	jmpq   400600 <.plt>

0000000000400660 <__libc_start_main@plt>:
  400660:	ff 25 da 09 20 00    	jmpq   *0x2009da(%rip)        # 601040 <__libc_start_main@GLIBC_2.2.5>
  400666:	68 05 00 00 00       	pushq  $0x5
  40066b:	e9 90 ff ff ff       	jmpq   400600 <.plt>

0000000000400670 <omp_get_num_threads@plt>:
  400670:	ff 25 d2 09 20 00    	jmpq   *0x2009d2(%rip)        # 601048 <omp_get_num_threads@OMP_1.0>
  400676:	68 06 00 00 00       	pushq  $0x6
  40067b:	e9 80 ff ff ff       	jmpq   400600 <.plt>

0000000000400680 <exit@plt>:
  400680:	ff 25 ca 09 20 00    	jmpq   *0x2009ca(%rip)        # 601050 <exit@GLIBC_2.2.5>
  400686:	68 07 00 00 00       	pushq  $0x7
  40068b:	e9 70 ff ff ff       	jmpq   400600 <.plt>

0000000000400690 <GOMP_parallel@plt>:
  400690:	ff 25 c2 09 20 00    	jmpq   *0x2009c2(%rip)        # 601058 <GOMP_parallel@GOMP_4.0>
  400696:	68 08 00 00 00       	pushq  $0x8
  40069b:	e9 60 ff ff ff       	jmpq   400600 <.plt>

Desensamblado de la sección .plt.got:

00000000004006a0 <.plt.got>:
  4006a0:	ff 25 52 09 20 00    	jmpq   *0x200952(%rip)        # 600ff8 <__gmon_start__>
  4006a6:	66 90                	xchg   %ax,%ax

Desensamblado de la sección .text:

00000000004006b0 <main>:
    check(a);
    return 0;
}

int main()
{
  4006b0:	48 83 ec 08          	sub    $0x8,%rsp
  // printf("LEN: %u\n\n", LEN);
  printf("triad kernel, LEN: %u, NTIMES: %lu\n\n", LEN, NTIMES);
  4006b4:	ba 00 80 07 00       	mov    $0x78000,%edx
  4006b9:	be 00 80 00 00       	mov    $0x8000,%esi
  4006be:	31 c0                	xor    %eax,%eax
  4006c0:	bf 00 0b 40 00       	mov    $0x400b00,%edi
  4006c5:	e8 66 ff ff ff       	callq  400630 <printf@plt>
  printf("                     Time    TPI\n");
  4006ca:	bf 28 0b 40 00       	mov    $0x400b28,%edi
  4006cf:	e8 3c ff ff ff       	callq  400610 <puts@plt>
  printf("              Loop    ns     ps/it     Checksum \n");
  4006d4:	bf 50 0b 40 00       	mov    $0x400b50,%edi
  4006d9:	e8 32 ff ff ff       	callq  400610 <puts@plt>
  triad();
  4006de:	31 c0                	xor    %eax,%eax
  4006e0:	e8 bb 02 00 00       	callq  4009a0 <triad>
  exit(0);
  4006e5:	31 ff                	xor    %edi,%edi
  4006e7:	e8 94 ff ff ff       	callq  400680 <exit@plt>

00000000004006ec <_start>:
  4006ec:	31 ed                	xor    %ebp,%ebp
  4006ee:	49 89 d1             	mov    %rdx,%r9
  4006f1:	5e                   	pop    %rsi
  4006f2:	48 89 e2             	mov    %rsp,%rdx
  4006f5:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4006f9:	50                   	push   %rax
  4006fa:	54                   	push   %rsp
  4006fb:	49 c7 c0 c0 0a 40 00 	mov    $0x400ac0,%r8
  400702:	48 c7 c1 50 0a 40 00 	mov    $0x400a50,%rcx
  400709:	48 c7 c7 b0 06 40 00 	mov    $0x4006b0,%rdi
  400710:	e8 4b ff ff ff       	callq  400660 <__libc_start_main@plt>
  400715:	f4                   	hlt    
  400716:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40071d:	00 00 00 

0000000000400720 <deregister_tm_clones>:
  400720:	b8 70 10 60 00       	mov    $0x601070,%eax
  400725:	48 3d 70 10 60 00    	cmp    $0x601070,%rax
  40072b:	74 13                	je     400740 <deregister_tm_clones+0x20>
  40072d:	b8 00 00 00 00       	mov    $0x0,%eax
  400732:	48 85 c0             	test   %rax,%rax
  400735:	74 09                	je     400740 <deregister_tm_clones+0x20>
  400737:	bf 70 10 60 00       	mov    $0x601070,%edi
  40073c:	ff e0                	jmpq   *%rax
  40073e:	66 90                	xchg   %ax,%ax
  400740:	c3                   	retq   
  400741:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400746:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40074d:	00 00 00 

0000000000400750 <register_tm_clones>:
  400750:	be 70 10 60 00       	mov    $0x601070,%esi
  400755:	48 81 ee 70 10 60 00 	sub    $0x601070,%rsi
  40075c:	48 89 f0             	mov    %rsi,%rax
  40075f:	48 c1 ee 3f          	shr    $0x3f,%rsi
  400763:	48 c1 f8 03          	sar    $0x3,%rax
  400767:	48 01 c6             	add    %rax,%rsi
  40076a:	48 d1 fe             	sar    %rsi
  40076d:	74 11                	je     400780 <register_tm_clones+0x30>
  40076f:	b8 00 00 00 00       	mov    $0x0,%eax
  400774:	48 85 c0             	test   %rax,%rax
  400777:	74 07                	je     400780 <register_tm_clones+0x30>
  400779:	bf 70 10 60 00       	mov    $0x601070,%edi
  40077e:	ff e0                	jmpq   *%rax
  400780:	c3                   	retq   
  400781:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400786:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40078d:	00 00 00 

0000000000400790 <__do_global_dtors_aux>:
  400790:	80 3d e9 08 20 00 00 	cmpb   $0x0,0x2008e9(%rip)        # 601080 <completed.7338>
  400797:	75 17                	jne    4007b0 <__do_global_dtors_aux+0x20>
  400799:	55                   	push   %rbp
  40079a:	48 89 e5             	mov    %rsp,%rbp
  40079d:	e8 7e ff ff ff       	callq  400720 <deregister_tm_clones>
  4007a2:	5d                   	pop    %rbp
  4007a3:	c6 05 d6 08 20 00 01 	movb   $0x1,0x2008d6(%rip)        # 601080 <completed.7338>
  4007aa:	c3                   	retq   
  4007ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4007b0:	c3                   	retq   
  4007b1:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4007b6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4007bd:	00 00 00 

00000000004007c0 <frame_dummy>:
  4007c0:	eb 8e                	jmp    400750 <register_tm_clones>

00000000004007c2 <dummy>:
  4007c2:	55                   	push   %rbp
  4007c3:	48 89 e5             	mov    %rsp,%rbp
  4007c6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  4007ca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  4007ce:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  4007d2:	f3 0f 11 45 e4       	movss  %xmm0,-0x1c(%rbp)
  4007d7:	b8 00 00 00 00       	mov    $0x0,%eax
  4007dc:	5d                   	pop    %rbp
  4007dd:	c3                   	retq   
  4007de:	66 90                	xchg   %ax,%ax

00000000004007e0 <triad._omp_fn.0>:
		#pragma omp parallel for
  4007e0:	53                   	push   %rbx
  4007e1:	e8 8a fe ff ff       	callq  400670 <omp_get_num_threads@plt>
  4007e6:	89 c3                	mov    %eax,%ebx
  4007e8:	e8 33 fe ff ff       	callq  400620 <omp_get_thread_num@plt>
  4007ed:	31 d2                	xor    %edx,%edx
  4007ef:	89 c1                	mov    %eax,%ecx
  4007f1:	b8 00 80 00 00       	mov    $0x8000,%eax
  4007f6:	f7 f3                	div    %ebx
  4007f8:	39 d1                	cmp    %edx,%ecx
  4007fa:	72 54                	jb     400850 <triad._omp_fn.0+0x70>
  4007fc:	0f af c8             	imul   %eax,%ecx
  4007ff:	01 ca                	add    %ecx,%edx
  400801:	8d 0c 10             	lea    (%rax,%rdx,1),%ecx
  400804:	39 ca                	cmp    %ecx,%edx
  400806:	73 41                	jae    400849 <triad._omp_fn.0+0x69>
  400808:	83 e8 01             	sub    $0x1,%eax
  40080b:	c5 fa 10 0d 75 03 00 	vmovss 0x375(%rip),%xmm1        # 400b88 <_IO_stdin_used+0xb8>
  400812:	00 
  400813:	48 8d 0c 95 00 00 00 	lea    0x0(,%rdx,4),%rcx
  40081a:	00 
  40081b:	48 8d 44 02 01       	lea    0x1(%rdx,%rax,1),%rax
  400820:	48 c1 e0 02          	shl    $0x2,%rax
  400824:	0f 1f 40 00          	nopl   0x0(%rax)
            a[i] = b[i] + scalar*c[i];
  400828:	c5 f2 59 81 c0 10 60 	vmulss 0x6010c0(%rcx),%xmm1,%xmm0
  40082f:	00 
  400830:	48 83 c1 04          	add    $0x4,%rcx
  400834:	c5 fa 58 81 bc 10 62 	vaddss 0x6210bc(%rcx),%xmm0,%xmm0
  40083b:	00 
  40083c:	c5 fa 11 81 bc 10 64 	vmovss %xmm0,0x6410bc(%rcx)
  400843:	00 
  400844:	48 39 c8             	cmp    %rcx,%rax
  400847:	75 df                	jne    400828 <triad._omp_fn.0+0x48>
		#pragma omp parallel for
  400849:	5b                   	pop    %rbx
  40084a:	c3                   	retq   
  40084b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400850:	83 c0 01             	add    $0x1,%eax
  400853:	31 d2                	xor    %edx,%edx
  400855:	eb a5                	jmp    4007fc <triad._omp_fn.0+0x1c>
  400857:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40085e:	00 00 

0000000000400860 <get_wall_time>:
{
  400860:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  400864:	31 f6                	xor    %esi,%esi
  400866:	48 89 e7             	mov    %rsp,%rdi
  400869:	e8 d2 fd ff ff       	callq  400640 <gettimeofday@plt>
  40086e:	85 c0                	test   %eax,%eax
  400870:	75 22                	jne    400894 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  400872:	c5 e8 57 d2          	vxorps %xmm2,%xmm2,%xmm2
  400876:	c4 e1 eb 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm2,%xmm0
  40087d:	c5 fb 59 0d 13 03 00 	vmulsd 0x313(%rip),%xmm0,%xmm1        # 400b98 <_IO_stdin_used+0xc8>
  400884:	00 
  400885:	c4 e1 eb 2a 04 24    	vcvtsi2sdq (%rsp),%xmm2,%xmm0
}
  40088b:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  40088f:	c5 f3 58 c0          	vaddsd %xmm0,%xmm1,%xmm0
}
  400893:	c3                   	retq   
        exit(-1); // return 0;
  400894:	83 cf ff             	or     $0xffffffff,%edi
  400897:	e8 e4 fd ff ff       	callq  400680 <exit@plt>
  40089c:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004008a0 <check>:
    for (unsigned int i = 0; i < LEN; i++)
  4008a0:	48 8d 87 00 00 02 00 	lea    0x20000(%rdi),%rax
    real sum = 0;
  4008a7:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  4008ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
        sum += arr[i];
  4008b0:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  4008b4:	48 83 c7 04          	add    $0x4,%rdi
  4008b8:	48 39 f8             	cmp    %rdi,%rax
  4008bb:	75 f3                	jne    4008b0 <check+0x10>
    printf("%f \n", sum);
  4008bd:	bf d4 0a 40 00       	mov    $0x400ad4,%edi
  4008c2:	b8 01 00 00 00       	mov    $0x1,%eax
  4008c7:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  4008cb:	e9 60 fd ff ff       	jmpq   400630 <printf@plt>

00000000004008d0 <init>:
{
  4008d0:	53                   	push   %rbx
  4008d1:	c5 fa 10 05 b3 02 00 	vmovss 0x2b3(%rip),%xmm0        # 400b8c <_IO_stdin_used+0xbc>
  4008d8:	00 
  4008d9:	bb c0 10 64 00       	mov    $0x6410c0,%ebx
  4008de:	48 89 d8             	mov    %rbx,%rax
  4008e1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
	    a[j] = 1.0;
  4008e8:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (int j = 0; j < LEN; j++)
  4008ec:	48 83 c0 04          	add    $0x4,%rax
  4008f0:	48 3d c0 10 66 00    	cmp    $0x6610c0,%rax
  4008f6:	75 f0                	jne    4008e8 <init+0x18>
  4008f8:	c5 fa 10 05 90 02 00 	vmovss 0x290(%rip),%xmm0        # 400b90 <_IO_stdin_used+0xc0>
  4008ff:	00 
  400900:	b8 c0 10 62 00       	mov    $0x6210c0,%eax
  400905:	0f 1f 00             	nopl   (%rax)
	    b[j] = 2.0;
  400908:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (int j = 0; j < LEN; j++)
  40090c:	48 83 c0 04          	add    $0x4,%rax
  400910:	48 3d c0 10 64 00    	cmp    $0x6410c0,%rax
  400916:	75 f0                	jne    400908 <init+0x38>
  400918:	ba 00 00 02 00       	mov    $0x20000,%edx
  40091d:	31 f6                	xor    %esi,%esi
  40091f:	bf c0 10 60 00       	mov    $0x6010c0,%edi
  400924:	e8 27 fd ff ff       	callq  400650 <memset@plt>
    b[69] = 69.0;
  400929:	c5 fa 10 05 63 02 00 	vmovss 0x263(%rip),%xmm0        # 400b94 <_IO_stdin_used+0xc4>
  400930:	00 
  400931:	c5 fa 11 05 9b 08 22 	vmovss %xmm0,0x22089b(%rip)        # 6211d4 <b+0x114>
  400938:	00 
    c[69] = 69.0;
  400939:	c5 fa 11 05 93 08 20 	vmovss %xmm0,0x200893(%rip)        # 6011d4 <c+0x114>
  400940:	00 
    for (int j = 0; j < LEN; j++)
  400941:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
		a[j] = 2.0E0 * a[j];
  400948:	c5 fa 10 03          	vmovss (%rbx),%xmm0
  40094c:	48 83 c3 04          	add    $0x4,%rbx
  400950:	c5 fa 58 c0          	vaddss %xmm0,%xmm0,%xmm0
  400954:	c5 fa 11 43 fc       	vmovss %xmm0,-0x4(%rbx)
    for (int j = 0; j < LEN; j++)
  400959:	48 81 fb c0 10 66 00 	cmp    $0x6610c0,%rbx
  400960:	75 e6                	jne    400948 <init+0x78>
}
  400962:	31 c0                	xor    %eax,%eax
  400964:	5b                   	pop    %rbx
  400965:	c3                   	retq   
  400966:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40096d:	00 00 00 

0000000000400970 <results>:
{
  400970:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %5.1f    %5.1f     ",
  400973:	b8 02 00 00 00       	mov    $0x2,%eax
  400978:	bf d9 0a 40 00       	mov    $0x400ad9,%edi
  40097d:	c5 fb 5e 15 23 02 00 	vdivsd 0x223(%rip),%xmm0,%xmm2        # 400ba8 <_IO_stdin_used+0xd8>
  400984:	00 
  400985:	c5 fb 5e 0d 13 02 00 	vdivsd 0x213(%rip),%xmm0,%xmm1        # 400ba0 <_IO_stdin_used+0xd0>
  40098c:	00 
  40098d:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  400991:	e9 9a fc ff ff       	jmpq   400630 <printf@plt>
  400996:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40099d:	00 00 00 

00000000004009a0 <triad>:
{
  4009a0:	53                   	push   %rbx
    init();
  4009a1:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  4009a3:	bb 00 80 07 00       	mov    $0x78000,%ebx
{
  4009a8:	48 83 ec 10          	sub    $0x10,%rsp
    init();
  4009ac:	e8 1f ff ff ff       	callq  4008d0 <init>
    start_t = get_wall_time();
  4009b1:	31 c0                	xor    %eax,%eax
  4009b3:	e8 a8 fe ff ff       	callq  400860 <get_wall_time>
  4009b8:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4009be:	66 90                	xchg   %ax,%ax
  4009c0:	31 d2                	xor    %edx,%edx
  4009c2:	31 f6                	xor    %esi,%esi
  4009c4:	31 c9                	xor    %ecx,%ecx
  4009c6:	bf e0 07 40 00       	mov    $0x4007e0,%edi
  4009cb:	e8 c0 fc ff ff       	callq  400690 <GOMP_parallel@plt>
        dummy(a, b, c, scalar);
  4009d0:	ba c0 10 60 00       	mov    $0x6010c0,%edx
  4009d5:	be c0 10 62 00       	mov    $0x6210c0,%esi
  4009da:	c5 fa 10 05 a6 01 00 	vmovss 0x1a6(%rip),%xmm0        # 400b88 <_IO_stdin_used+0xb8>
  4009e1:	00 
  4009e2:	bf c0 10 64 00       	mov    $0x6410c0,%edi
  4009e7:	e8 d6 fd ff ff       	callq  4007c2 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  4009ec:	83 eb 01             	sub    $0x1,%ebx
  4009ef:	75 cf                	jne    4009c0 <triad+0x20>
    end_t = get_wall_time();
  4009f1:	31 c0                	xor    %eax,%eax
  4009f3:	e8 68 fe ff ff       	callq  400860 <get_wall_time>
    results(end_t - start_t, "triad");
  4009f8:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  4009fe:	bf f3 0a 40 00       	mov    $0x400af3,%edi
  400a03:	e8 68 ff ff ff       	callq  400970 <results>
    for (unsigned int i = 0; i < LEN; i++)
  400a08:	b8 c0 10 64 00       	mov    $0x6410c0,%eax
    real sum = 0;
  400a0d:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  400a11:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
        sum += arr[i];
  400a18:	c5 fa 58 00          	vaddss (%rax),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  400a1c:	48 83 c0 04          	add    $0x4,%rax
  400a20:	48 3d c0 10 66 00    	cmp    $0x6610c0,%rax
  400a26:	75 f0                	jne    400a18 <triad+0x78>
    printf("%f \n", sum);
  400a28:	bf d4 0a 40 00       	mov    $0x400ad4,%edi
  400a2d:	b8 01 00 00 00       	mov    $0x1,%eax
  400a32:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  400a36:	e8 f5 fb ff ff       	callq  400630 <printf@plt>
}
  400a3b:	48 83 c4 10          	add    $0x10,%rsp
  400a3f:	31 c0                	xor    %eax,%eax
  400a41:	5b                   	pop    %rbx
  400a42:	c3                   	retq   
  400a43:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400a4a:	00 00 00 
  400a4d:	0f 1f 00             	nopl   (%rax)

0000000000400a50 <__libc_csu_init>:
  400a50:	41 57                	push   %r15
  400a52:	41 89 ff             	mov    %edi,%r15d
  400a55:	41 56                	push   %r14
  400a57:	49 89 f6             	mov    %rsi,%r14
  400a5a:	41 55                	push   %r13
  400a5c:	49 89 d5             	mov    %rdx,%r13
  400a5f:	41 54                	push   %r12
  400a61:	4c 8d 25 80 03 20 00 	lea    0x200380(%rip),%r12        # 600de8 <__frame_dummy_init_array_entry>
  400a68:	55                   	push   %rbp
  400a69:	48 8d 2d 80 03 20 00 	lea    0x200380(%rip),%rbp        # 600df0 <__init_array_end>
  400a70:	53                   	push   %rbx
  400a71:	4c 29 e5             	sub    %r12,%rbp
  400a74:	31 db                	xor    %ebx,%ebx
  400a76:	48 c1 fd 03          	sar    $0x3,%rbp
  400a7a:	48 83 ec 08          	sub    $0x8,%rsp
  400a7e:	e8 5d fb ff ff       	callq  4005e0 <_init>
  400a83:	48 85 ed             	test   %rbp,%rbp
  400a86:	74 1e                	je     400aa6 <__libc_csu_init+0x56>
  400a88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  400a8f:	00 
  400a90:	4c 89 ea             	mov    %r13,%rdx
  400a93:	4c 89 f6             	mov    %r14,%rsi
  400a96:	44 89 ff             	mov    %r15d,%edi
  400a99:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  400a9d:	48 83 c3 01          	add    $0x1,%rbx
  400aa1:	48 39 eb             	cmp    %rbp,%rbx
  400aa4:	75 ea                	jne    400a90 <__libc_csu_init+0x40>
  400aa6:	48 83 c4 08          	add    $0x8,%rsp
  400aaa:	5b                   	pop    %rbx
  400aab:	5d                   	pop    %rbp
  400aac:	41 5c                	pop    %r12
  400aae:	41 5d                	pop    %r13
  400ab0:	41 5e                	pop    %r14
  400ab2:	41 5f                	pop    %r15
  400ab4:	c3                   	retq   
  400ab5:	90                   	nop
  400ab6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400abd:	00 00 00 

0000000000400ac0 <__libc_csu_fini>:
  400ac0:	f3 c3                	repz retq 

Desensamblado de la sección .fini:

0000000000400ac4 <_fini>:
  400ac4:	48 83 ec 08          	sub    $0x8,%rsp
  400ac8:	48 83 c4 08          	add    $0x8,%rsp
  400acc:	c3                   	retq   
