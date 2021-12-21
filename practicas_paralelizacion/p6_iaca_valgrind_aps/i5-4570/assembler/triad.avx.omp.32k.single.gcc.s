
triad.avx.omp.32k.single.gcc:     formato del fichero elf64-x86-64


Desensamblado de la sección .init:

00000000004005e0 <_init>:
  4005e0:	48 83 ec 08          	sub    $0x8,%rsp
  4005e4:	48 8b 05 0d 1a 20 00 	mov    0x201a0d(%rip),%rax        # 601ff8 <__gmon_start__>
  4005eb:	48 85 c0             	test   %rax,%rax
  4005ee:	74 05                	je     4005f5 <_init+0x15>
  4005f0:	e8 ab 00 00 00       	callq  4006a0 <.plt.got>
  4005f5:	48 83 c4 08          	add    $0x8,%rsp
  4005f9:	c3                   	retq   

Desensamblado de la sección .plt:

0000000000400600 <.plt>:
  400600:	ff 35 02 1a 20 00    	pushq  0x201a02(%rip)        # 602008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400606:	ff 25 04 1a 20 00    	jmpq   *0x201a04(%rip)        # 602010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40060c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400610 <puts@plt>:
  400610:	ff 25 02 1a 20 00    	jmpq   *0x201a02(%rip)        # 602018 <puts@GLIBC_2.2.5>
  400616:	68 00 00 00 00       	pushq  $0x0
  40061b:	e9 e0 ff ff ff       	jmpq   400600 <.plt>

0000000000400620 <omp_get_thread_num@plt>:
  400620:	ff 25 fa 19 20 00    	jmpq   *0x2019fa(%rip)        # 602020 <omp_get_thread_num@OMP_1.0>
  400626:	68 01 00 00 00       	pushq  $0x1
  40062b:	e9 d0 ff ff ff       	jmpq   400600 <.plt>

0000000000400630 <printf@plt>:
  400630:	ff 25 f2 19 20 00    	jmpq   *0x2019f2(%rip)        # 602028 <printf@GLIBC_2.2.5>
  400636:	68 02 00 00 00       	pushq  $0x2
  40063b:	e9 c0 ff ff ff       	jmpq   400600 <.plt>

0000000000400640 <gettimeofday@plt>:
  400640:	ff 25 ea 19 20 00    	jmpq   *0x2019ea(%rip)        # 602030 <gettimeofday@GLIBC_2.2.5>
  400646:	68 03 00 00 00       	pushq  $0x3
  40064b:	e9 b0 ff ff ff       	jmpq   400600 <.plt>

0000000000400650 <memset@plt>:
  400650:	ff 25 e2 19 20 00    	jmpq   *0x2019e2(%rip)        # 602038 <memset@GLIBC_2.2.5>
  400656:	68 04 00 00 00       	pushq  $0x4
  40065b:	e9 a0 ff ff ff       	jmpq   400600 <.plt>

0000000000400660 <__libc_start_main@plt>:
  400660:	ff 25 da 19 20 00    	jmpq   *0x2019da(%rip)        # 602040 <__libc_start_main@GLIBC_2.2.5>
  400666:	68 05 00 00 00       	pushq  $0x5
  40066b:	e9 90 ff ff ff       	jmpq   400600 <.plt>

0000000000400670 <omp_get_num_threads@plt>:
  400670:	ff 25 d2 19 20 00    	jmpq   *0x2019d2(%rip)        # 602048 <omp_get_num_threads@OMP_1.0>
  400676:	68 06 00 00 00       	pushq  $0x6
  40067b:	e9 80 ff ff ff       	jmpq   400600 <.plt>

0000000000400680 <exit@plt>:
  400680:	ff 25 ca 19 20 00    	jmpq   *0x2019ca(%rip)        # 602050 <exit@GLIBC_2.2.5>
  400686:	68 07 00 00 00       	pushq  $0x7
  40068b:	e9 70 ff ff ff       	jmpq   400600 <.plt>

0000000000400690 <GOMP_parallel@plt>:
  400690:	ff 25 c2 19 20 00    	jmpq   *0x2019c2(%rip)        # 602058 <GOMP_parallel@GOMP_4.0>
  400696:	68 08 00 00 00       	pushq  $0x8
  40069b:	e9 60 ff ff ff       	jmpq   400600 <.plt>

Desensamblado de la sección .plt.got:

00000000004006a0 <.plt.got>:
  4006a0:	ff 25 52 19 20 00    	jmpq   *0x201952(%rip)        # 601ff8 <__gmon_start__>
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
  4006c0:	bf 50 0c 40 00       	mov    $0x400c50,%edi
  4006c5:	e8 66 ff ff ff       	callq  400630 <printf@plt>
  printf("                     Time    TPI\n");
  4006ca:	bf 78 0c 40 00       	mov    $0x400c78,%edi
  4006cf:	e8 3c ff ff ff       	callq  400610 <puts@plt>
  printf("              Loop    ns     ps/it     Checksum \n");
  4006d4:	bf a0 0c 40 00       	mov    $0x400ca0,%edi
  4006d9:	e8 32 ff ff ff       	callq  400610 <puts@plt>
  triad();
  4006de:	31 c0                	xor    %eax,%eax
  4006e0:	e8 2b 04 00 00       	callq  400b10 <triad>
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
  4006fb:	49 c7 c0 00 0c 40 00 	mov    $0x400c00,%r8
  400702:	48 c7 c1 90 0b 40 00 	mov    $0x400b90,%rcx
  400709:	48 c7 c7 b0 06 40 00 	mov    $0x4006b0,%rdi
  400710:	e8 4b ff ff ff       	callq  400660 <__libc_start_main@plt>
  400715:	f4                   	hlt    
  400716:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40071d:	00 00 00 

0000000000400720 <deregister_tm_clones>:
  400720:	b8 70 20 60 00       	mov    $0x602070,%eax
  400725:	48 3d 70 20 60 00    	cmp    $0x602070,%rax
  40072b:	74 13                	je     400740 <deregister_tm_clones+0x20>
  40072d:	b8 00 00 00 00       	mov    $0x0,%eax
  400732:	48 85 c0             	test   %rax,%rax
  400735:	74 09                	je     400740 <deregister_tm_clones+0x20>
  400737:	bf 70 20 60 00       	mov    $0x602070,%edi
  40073c:	ff e0                	jmpq   *%rax
  40073e:	66 90                	xchg   %ax,%ax
  400740:	c3                   	retq   
  400741:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400746:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40074d:	00 00 00 

0000000000400750 <register_tm_clones>:
  400750:	be 70 20 60 00       	mov    $0x602070,%esi
  400755:	48 81 ee 70 20 60 00 	sub    $0x602070,%rsi
  40075c:	48 89 f0             	mov    %rsi,%rax
  40075f:	48 c1 ee 3f          	shr    $0x3f,%rsi
  400763:	48 c1 f8 03          	sar    $0x3,%rax
  400767:	48 01 c6             	add    %rax,%rsi
  40076a:	48 d1 fe             	sar    %rsi
  40076d:	74 11                	je     400780 <register_tm_clones+0x30>
  40076f:	b8 00 00 00 00       	mov    $0x0,%eax
  400774:	48 85 c0             	test   %rax,%rax
  400777:	74 07                	je     400780 <register_tm_clones+0x30>
  400779:	bf 70 20 60 00       	mov    $0x602070,%edi
  40077e:	ff e0                	jmpq   *%rax
  400780:	c3                   	retq   
  400781:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400786:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40078d:	00 00 00 

0000000000400790 <__do_global_dtors_aux>:
  400790:	80 3d e9 18 20 00 00 	cmpb   $0x0,0x2018e9(%rip)        # 602080 <completed.7338>
  400797:	75 17                	jne    4007b0 <__do_global_dtors_aux+0x20>
  400799:	55                   	push   %rbp
  40079a:	48 89 e5             	mov    %rsp,%rbp
  40079d:	e8 7e ff ff ff       	callq  400720 <deregister_tm_clones>
  4007a2:	5d                   	pop    %rbp
  4007a3:	c6 05 d6 18 20 00 01 	movb   $0x1,0x2018d6(%rip)        # 602080 <completed.7338>
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
  4007e0:	55                   	push   %rbp
  4007e1:	48 89 e5             	mov    %rsp,%rbp
  4007e4:	53                   	push   %rbx
  4007e5:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  4007e9:	e8 82 fe ff ff       	callq  400670 <omp_get_num_threads@plt>
  4007ee:	89 c3                	mov    %eax,%ebx
  4007f0:	e8 2b fe ff ff       	callq  400620 <omp_get_thread_num@plt>
  4007f5:	31 d2                	xor    %edx,%edx
  4007f7:	89 c1                	mov    %eax,%ecx
  4007f9:	b8 00 80 00 00       	mov    $0x8000,%eax
  4007fe:	f7 f3                	div    %ebx
  400800:	39 d1                	cmp    %edx,%ecx
  400802:	0f 82 b0 01 00 00    	jb     4009b8 <triad._omp_fn.0+0x1d8>
  400808:	0f af c8             	imul   %eax,%ecx
  40080b:	01 ca                	add    %ecx,%edx
  40080d:	44 8d 14 10          	lea    (%rax,%rdx,1),%r10d
  400811:	44 39 d2             	cmp    %r10d,%edx
  400814:	0f 83 94 01 00 00    	jae    4009ae <triad._omp_fn.0+0x1ce>
  40081a:	8d 48 ff             	lea    -0x1(%rax),%ecx
  40081d:	83 f9 06             	cmp    $0x6,%ecx
  400820:	0f 86 85 00 00 00    	jbe    4008ab <triad._omp_fn.0+0xcb>
  400826:	89 d6                	mov    %edx,%esi
  400828:	41 89 c1             	mov    %eax,%r9d
  40082b:	c5 fc 28 15 ad 04 00 	vmovaps 0x4ad(%rip),%ymm2        # 400ce0 <_IO_stdin_used+0xc0>
  400832:	00 
  400833:	31 c9                	xor    %ecx,%ecx
  400835:	48 c1 e6 02          	shl    $0x2,%rsi
  400839:	41 c1 e9 03          	shr    $0x3,%r9d
  40083d:	4c 8d 86 c0 20 62 00 	lea    0x6220c0(%rsi),%r8
  400844:	48 8d be c0 20 60 00 	lea    0x6020c0(%rsi),%rdi
  40084b:	49 c1 e1 05          	shl    $0x5,%r9
  40084f:	48 81 c6 c0 20 64 00 	add    $0x6420c0,%rsi
  400856:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40085d:	00 00 00 
            a[i] = b[i] + scalar*c[i];
  400860:	c5 f8 10 1c 0f       	vmovups (%rdi,%rcx,1),%xmm3
  400865:	c4 e3 65 18 44 0f 10 	vinsertf128 $0x1,0x10(%rdi,%rcx,1),%ymm3,%ymm0
  40086c:	01 
  40086d:	c4 c1 78 10 24 08    	vmovups (%r8,%rcx,1),%xmm4
  400873:	c4 c3 5d 18 4c 08 10 	vinsertf128 $0x1,0x10(%r8,%rcx,1),%ymm4,%ymm1
  40087a:	01 
  40087b:	c5 fc 59 c2          	vmulps %ymm2,%ymm0,%ymm0
  40087f:	c5 fc 58 c1          	vaddps %ymm1,%ymm0,%ymm0
  400883:	c5 f8 11 04 0e       	vmovups %xmm0,(%rsi,%rcx,1)
  400888:	c4 e3 7d 19 44 0e 10 	vextractf128 $0x1,%ymm0,0x10(%rsi,%rcx,1)
  40088f:	01 
  400890:	48 83 c1 20          	add    $0x20,%rcx
  400894:	4c 39 c9             	cmp    %r9,%rcx
  400897:	75 c7                	jne    400860 <triad._omp_fn.0+0x80>
  400899:	89 c1                	mov    %eax,%ecx
  40089b:	83 e1 f8             	and    $0xfffffff8,%ecx
  40089e:	01 ca                	add    %ecx,%edx
  4008a0:	39 c8                	cmp    %ecx,%eax
  4008a2:	0f 84 20 01 00 00    	je     4009c8 <triad._omp_fn.0+0x1e8>
  4008a8:	c5 f8 77             	vzeroupper 
  4008ab:	89 d0                	mov    %edx,%eax
  4008ad:	c5 fa 10 05 4b 04 00 	vmovss 0x44b(%rip),%xmm0        # 400d00 <_IO_stdin_used+0xe0>
  4008b4:	00 
  4008b5:	c5 fa 59 0c 85 c0 20 	vmulss 0x6020c0(,%rax,4),%xmm0,%xmm1
  4008bc:	60 00 
  4008be:	c5 f2 58 0c 85 c0 20 	vaddss 0x6220c0(,%rax,4),%xmm1,%xmm1
  4008c5:	62 00 
  4008c7:	c5 fa 11 0c 85 c0 20 	vmovss %xmm1,0x6420c0(,%rax,4)
  4008ce:	64 00 
  4008d0:	8d 42 01             	lea    0x1(%rdx),%eax
  4008d3:	44 39 d0             	cmp    %r10d,%eax
  4008d6:	0f 83 d2 00 00 00    	jae    4009ae <triad._omp_fn.0+0x1ce>
  4008dc:	c5 fa 59 0c 85 c0 20 	vmulss 0x6020c0(,%rax,4),%xmm0,%xmm1
  4008e3:	60 00 
  4008e5:	c5 f2 58 0c 85 c0 20 	vaddss 0x6220c0(,%rax,4),%xmm1,%xmm1
  4008ec:	62 00 
  4008ee:	c5 fa 11 0c 85 c0 20 	vmovss %xmm1,0x6420c0(,%rax,4)
  4008f5:	64 00 
  4008f7:	8d 42 02             	lea    0x2(%rdx),%eax
  4008fa:	41 39 c2             	cmp    %eax,%r10d
  4008fd:	0f 86 ab 00 00 00    	jbe    4009ae <triad._omp_fn.0+0x1ce>
  400903:	c5 fa 59 0c 85 c0 20 	vmulss 0x6020c0(,%rax,4),%xmm0,%xmm1
  40090a:	60 00 
  40090c:	c5 f2 58 0c 85 c0 20 	vaddss 0x6220c0(,%rax,4),%xmm1,%xmm1
  400913:	62 00 
  400915:	c5 fa 11 0c 85 c0 20 	vmovss %xmm1,0x6420c0(,%rax,4)
  40091c:	64 00 
  40091e:	8d 42 03             	lea    0x3(%rdx),%eax
  400921:	41 39 c2             	cmp    %eax,%r10d
  400924:	0f 86 84 00 00 00    	jbe    4009ae <triad._omp_fn.0+0x1ce>
  40092a:	c5 fa 59 0c 85 c0 20 	vmulss 0x6020c0(,%rax,4),%xmm0,%xmm1
  400931:	60 00 
  400933:	c5 f2 58 0c 85 c0 20 	vaddss 0x6220c0(,%rax,4),%xmm1,%xmm1
  40093a:	62 00 
  40093c:	c5 fa 11 0c 85 c0 20 	vmovss %xmm1,0x6420c0(,%rax,4)
  400943:	64 00 
  400945:	8d 42 04             	lea    0x4(%rdx),%eax
  400948:	41 39 c2             	cmp    %eax,%r10d
  40094b:	76 61                	jbe    4009ae <triad._omp_fn.0+0x1ce>
  40094d:	c5 fa 59 0c 85 c0 20 	vmulss 0x6020c0(,%rax,4),%xmm0,%xmm1
  400954:	60 00 
  400956:	c5 f2 58 0c 85 c0 20 	vaddss 0x6220c0(,%rax,4),%xmm1,%xmm1
  40095d:	62 00 
  40095f:	c5 fa 11 0c 85 c0 20 	vmovss %xmm1,0x6420c0(,%rax,4)
  400966:	64 00 
  400968:	8d 42 05             	lea    0x5(%rdx),%eax
  40096b:	41 39 c2             	cmp    %eax,%r10d
  40096e:	76 3e                	jbe    4009ae <triad._omp_fn.0+0x1ce>
  400970:	c5 fa 59 0c 85 c0 20 	vmulss 0x6020c0(,%rax,4),%xmm0,%xmm1
  400977:	60 00 
  400979:	83 c2 06             	add    $0x6,%edx
  40097c:	c5 f2 58 0c 85 c0 20 	vaddss 0x6220c0(,%rax,4),%xmm1,%xmm1
  400983:	62 00 
  400985:	c5 fa 11 0c 85 c0 20 	vmovss %xmm1,0x6420c0(,%rax,4)
  40098c:	64 00 
  40098e:	41 39 d2             	cmp    %edx,%r10d
  400991:	76 1b                	jbe    4009ae <triad._omp_fn.0+0x1ce>
  400993:	c5 fa 59 04 95 c0 20 	vmulss 0x6020c0(,%rdx,4),%xmm0,%xmm0
  40099a:	60 00 
  40099c:	c5 fa 58 04 95 c0 20 	vaddss 0x6220c0(,%rdx,4),%xmm0,%xmm0
  4009a3:	62 00 
  4009a5:	c5 fa 11 04 95 c0 20 	vmovss %xmm0,0x6420c0(,%rdx,4)
  4009ac:	64 00 
		#pragma omp parallel for
  4009ae:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  4009b2:	c9                   	leaveq 
  4009b3:	c3                   	retq   
  4009b4:	0f 1f 40 00          	nopl   0x0(%rax)
  4009b8:	83 c0 01             	add    $0x1,%eax
  4009bb:	31 d2                	xor    %edx,%edx
  4009bd:	e9 46 fe ff ff       	jmpq   400808 <triad._omp_fn.0+0x28>
  4009c2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  4009c8:	c5 f8 77             	vzeroupper 
  4009cb:	eb e1                	jmp    4009ae <triad._omp_fn.0+0x1ce>
  4009cd:	0f 1f 00             	nopl   (%rax)

00000000004009d0 <get_wall_time>:
{
  4009d0:	48 83 ec 18          	sub    $0x18,%rsp
    if (gettimeofday(&time,NULL)) {
  4009d4:	31 f6                	xor    %esi,%esi
  4009d6:	48 89 e7             	mov    %rsp,%rdi
  4009d9:	e8 62 fc ff ff       	callq  400640 <gettimeofday@plt>
  4009de:	85 c0                	test   %eax,%eax
  4009e0:	75 22                	jne    400a04 <get_wall_time+0x34>
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4009e2:	c5 e8 57 d2          	vxorps %xmm2,%xmm2,%xmm2
  4009e6:	c4 e1 eb 2a 44 24 08 	vcvtsi2sdq 0x8(%rsp),%xmm2,%xmm0
  4009ed:	c5 fb 59 0d 1b 03 00 	vmulsd 0x31b(%rip),%xmm0,%xmm1        # 400d10 <_IO_stdin_used+0xf0>
  4009f4:	00 
  4009f5:	c4 e1 eb 2a 04 24    	vcvtsi2sdq (%rsp),%xmm2,%xmm0
}
  4009fb:	48 83 c4 18          	add    $0x18,%rsp
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
  4009ff:	c5 f3 58 c0          	vaddsd %xmm0,%xmm1,%xmm0
}
  400a03:	c3                   	retq   
        exit(-1); // return 0;
  400a04:	83 cf ff             	or     $0xffffffff,%edi
  400a07:	e8 74 fc ff ff       	callq  400680 <exit@plt>
  400a0c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400a10 <check>:
    for (unsigned int i = 0; i < LEN; i++)
  400a10:	48 8d 87 00 00 02 00 	lea    0x20000(%rdi),%rax
    real sum = 0;
  400a17:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  400a1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
        sum += arr[i];
  400a20:	c5 fa 58 07          	vaddss (%rdi),%xmm0,%xmm0
    for (unsigned int i = 0; i < LEN; i++)
  400a24:	48 83 c7 04          	add    $0x4,%rdi
  400a28:	48 39 f8             	cmp    %rdi,%rax
  400a2b:	75 f3                	jne    400a20 <check+0x10>
    printf("%f \n", sum);
  400a2d:	bf 24 0c 40 00       	mov    $0x400c24,%edi
  400a32:	b8 01 00 00 00       	mov    $0x1,%eax
  400a37:	c5 fa 5a c0          	vcvtss2sd %xmm0,%xmm0,%xmm0
  400a3b:	e9 f0 fb ff ff       	jmpq   400630 <printf@plt>

0000000000400a40 <init>:
{
  400a40:	53                   	push   %rbx
  400a41:	c5 fa 10 05 bb 02 00 	vmovss 0x2bb(%rip),%xmm0        # 400d04 <_IO_stdin_used+0xe4>
  400a48:	00 
  400a49:	bb c0 20 64 00       	mov    $0x6420c0,%ebx
  400a4e:	48 89 d8             	mov    %rbx,%rax
  400a51:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
	    a[j] = 1.0;
  400a58:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (int j = 0; j < LEN; j++)
  400a5c:	48 83 c0 04          	add    $0x4,%rax
  400a60:	48 3d c0 20 66 00    	cmp    $0x6620c0,%rax
  400a66:	75 f0                	jne    400a58 <init+0x18>
  400a68:	c5 fa 10 05 98 02 00 	vmovss 0x298(%rip),%xmm0        # 400d08 <_IO_stdin_used+0xe8>
  400a6f:	00 
  400a70:	b8 c0 20 62 00       	mov    $0x6220c0,%eax
  400a75:	0f 1f 00             	nopl   (%rax)
	    b[j] = 2.0;
  400a78:	c5 fa 11 00          	vmovss %xmm0,(%rax)
    for (int j = 0; j < LEN; j++)
  400a7c:	48 83 c0 04          	add    $0x4,%rax
  400a80:	48 3d c0 20 64 00    	cmp    $0x6420c0,%rax
  400a86:	75 f0                	jne    400a78 <init+0x38>
  400a88:	ba 00 00 02 00       	mov    $0x20000,%edx
  400a8d:	31 f6                	xor    %esi,%esi
  400a8f:	bf c0 20 60 00       	mov    $0x6020c0,%edi
  400a94:	e8 b7 fb ff ff       	callq  400650 <memset@plt>
    b[69] = 69.0;
  400a99:	c5 fa 10 05 6b 02 00 	vmovss 0x26b(%rip),%xmm0        # 400d0c <_IO_stdin_used+0xec>
  400aa0:	00 
  400aa1:	c5 fa 11 05 2b 17 22 	vmovss %xmm0,0x22172b(%rip)        # 6221d4 <b+0x114>
  400aa8:	00 
    c[69] = 69.0;
  400aa9:	c5 fa 11 05 23 17 20 	vmovss %xmm0,0x201723(%rip)        # 6021d4 <c+0x114>
  400ab0:	00 
    for (int j = 0; j < LEN; j++)
  400ab1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
		a[j] = 2.0E0 * a[j];
  400ab8:	c5 fa 10 03          	vmovss (%rbx),%xmm0
  400abc:	48 83 c3 04          	add    $0x4,%rbx
  400ac0:	c5 fa 58 c0          	vaddss %xmm0,%xmm0,%xmm0
  400ac4:	c5 fa 11 43 fc       	vmovss %xmm0,-0x4(%rbx)
    for (int j = 0; j < LEN; j++)
  400ac9:	48 81 fb c0 20 66 00 	cmp    $0x6620c0,%rbx
  400ad0:	75 e6                	jne    400ab8 <init+0x78>
}
  400ad2:	31 c0                	xor    %eax,%eax
  400ad4:	5b                   	pop    %rbx
  400ad5:	c3                   	retq   
  400ad6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400add:	00 00 00 

0000000000400ae0 <results>:
{
  400ae0:	48 89 fe             	mov    %rdi,%rsi
    printf("%18s  %5.1f    %5.1f     ",
  400ae3:	b8 02 00 00 00       	mov    $0x2,%eax
  400ae8:	bf 29 0c 40 00       	mov    $0x400c29,%edi
  400aed:	c5 fb 5e 15 2b 02 00 	vdivsd 0x22b(%rip),%xmm0,%xmm2        # 400d20 <_IO_stdin_used+0x100>
  400af4:	00 
  400af5:	c5 fb 5e 0d 1b 02 00 	vdivsd 0x21b(%rip),%xmm0,%xmm1        # 400d18 <_IO_stdin_used+0xf8>
  400afc:	00 
  400afd:	c5 f9 28 c2          	vmovapd %xmm2,%xmm0
  400b01:	e9 2a fb ff ff       	jmpq   400630 <printf@plt>
  400b06:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400b0d:	00 00 00 

0000000000400b10 <triad>:
{
  400b10:	53                   	push   %rbx
    init();
  400b11:	31 c0                	xor    %eax,%eax
    start_t = get_wall_time();
  400b13:	bb 00 80 07 00       	mov    $0x78000,%ebx
{
  400b18:	48 83 ec 10          	sub    $0x10,%rsp
    init();
  400b1c:	e8 1f ff ff ff       	callq  400a40 <init>
    start_t = get_wall_time();
  400b21:	31 c0                	xor    %eax,%eax
  400b23:	e8 a8 fe ff ff       	callq  4009d0 <get_wall_time>
  400b28:	c5 fb 11 44 24 08    	vmovsd %xmm0,0x8(%rsp)
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400b2e:	66 90                	xchg   %ax,%ax
  400b30:	31 d2                	xor    %edx,%edx
  400b32:	31 f6                	xor    %esi,%esi
  400b34:	31 c9                	xor    %ecx,%ecx
  400b36:	bf e0 07 40 00       	mov    $0x4007e0,%edi
  400b3b:	e8 50 fb ff ff       	callq  400690 <GOMP_parallel@plt>
        dummy(a, b, c, scalar);
  400b40:	ba c0 20 60 00       	mov    $0x6020c0,%edx
  400b45:	be c0 20 62 00       	mov    $0x6220c0,%esi
  400b4a:	c5 fa 10 05 ae 01 00 	vmovss 0x1ae(%rip),%xmm0        # 400d00 <_IO_stdin_used+0xe0>
  400b51:	00 
  400b52:	bf c0 20 64 00       	mov    $0x6420c0,%edi
  400b57:	e8 66 fc ff ff       	callq  4007c2 <dummy>
    for (unsigned int nl = 0; nl < NTIMES; nl++)
  400b5c:	83 eb 01             	sub    $0x1,%ebx
  400b5f:	75 cf                	jne    400b30 <triad+0x20>
    end_t = get_wall_time();
  400b61:	31 c0                	xor    %eax,%eax
  400b63:	e8 68 fe ff ff       	callq  4009d0 <get_wall_time>
    results(end_t - start_t, "triad");
  400b68:	c5 fb 5c 44 24 08    	vsubsd 0x8(%rsp),%xmm0,%xmm0
  400b6e:	bf 43 0c 40 00       	mov    $0x400c43,%edi
  400b73:	e8 68 ff ff ff       	callq  400ae0 <results>
    check(a);
  400b78:	bf c0 20 64 00       	mov    $0x6420c0,%edi
  400b7d:	e8 8e fe ff ff       	callq  400a10 <check>
}
  400b82:	48 83 c4 10          	add    $0x10,%rsp
  400b86:	31 c0                	xor    %eax,%eax
  400b88:	5b                   	pop    %rbx
  400b89:	c3                   	retq   
  400b8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400b90 <__libc_csu_init>:
  400b90:	41 57                	push   %r15
  400b92:	41 89 ff             	mov    %edi,%r15d
  400b95:	41 56                	push   %r14
  400b97:	49 89 f6             	mov    %rsi,%r14
  400b9a:	41 55                	push   %r13
  400b9c:	49 89 d5             	mov    %rdx,%r13
  400b9f:	41 54                	push   %r12
  400ba1:	4c 8d 25 40 12 20 00 	lea    0x201240(%rip),%r12        # 601de8 <__frame_dummy_init_array_entry>
  400ba8:	55                   	push   %rbp
  400ba9:	48 8d 2d 40 12 20 00 	lea    0x201240(%rip),%rbp        # 601df0 <__init_array_end>
  400bb0:	53                   	push   %rbx
  400bb1:	4c 29 e5             	sub    %r12,%rbp
  400bb4:	31 db                	xor    %ebx,%ebx
  400bb6:	48 c1 fd 03          	sar    $0x3,%rbp
  400bba:	48 83 ec 08          	sub    $0x8,%rsp
  400bbe:	e8 1d fa ff ff       	callq  4005e0 <_init>
  400bc3:	48 85 ed             	test   %rbp,%rbp
  400bc6:	74 1e                	je     400be6 <__libc_csu_init+0x56>
  400bc8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  400bcf:	00 
  400bd0:	4c 89 ea             	mov    %r13,%rdx
  400bd3:	4c 89 f6             	mov    %r14,%rsi
  400bd6:	44 89 ff             	mov    %r15d,%edi
  400bd9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  400bdd:	48 83 c3 01          	add    $0x1,%rbx
  400be1:	48 39 eb             	cmp    %rbp,%rbx
  400be4:	75 ea                	jne    400bd0 <__libc_csu_init+0x40>
  400be6:	48 83 c4 08          	add    $0x8,%rsp
  400bea:	5b                   	pop    %rbx
  400beb:	5d                   	pop    %rbp
  400bec:	41 5c                	pop    %r12
  400bee:	41 5d                	pop    %r13
  400bf0:	41 5e                	pop    %r14
  400bf2:	41 5f                	pop    %r15
  400bf4:	c3                   	retq   
  400bf5:	90                   	nop
  400bf6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400bfd:	00 00 00 

0000000000400c00 <__libc_csu_fini>:
  400c00:	f3 c3                	repz retq 

Desensamblado de la sección .fini:

0000000000400c04 <_fini>:
  400c04:	48 83 ec 08          	sub    $0x8,%rsp
  400c08:	48 83 c4 08          	add    $0x8,%rsp
  400c0c:	c3                   	retq   
