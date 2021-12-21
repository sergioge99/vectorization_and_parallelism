Ensamblador de GNU versi髇 2.27 (x86_64-redhat-linux)
	 utilizando BFD versi髇 version 2.27-34.base.el7.
 opciones pasadas	: --64 -adghln=assembler/misc.gcc.s 
 fich entrada  	: /tmp/ccSPyIWu.s
 fich salida   	: misc.o
 objetivo      	: x86_64-redhat-linux-gnu
 marca tiempo  	: 2020-03-30T19:37:18.000+0200

   1              		.file	"misc.c"
   2              		.text
   3              	.Ltext0:
   4              		.p2align 4
   5              		.globl	get_wall_time
   7              	get_wall_time:
   8              	.LFB7:
   9              		.file 1 "misc.c"
   1:misc.c        **** /* Adaptado: Jes煤s Alastruey Bened茅
   2:misc.c        ****  * v1.0, 28-abril-2016
   3:misc.c        ****  * v1.1, 24-marzo-2017
   4:misc.c        ****  * v1.2, 15-marzo-2018 */
   5:misc.c        **** 
   6:misc.c        **** #include <stdio.h>
   7:misc.c        **** #include <stdlib.h>
   8:misc.c        **** #include <time.h>
   9:misc.c        **** #include <sys/time.h>
  10:misc.c        **** #include <sys/times.h>
  11:misc.c        **** #include <malloc.h>
  12:misc.c        **** 
  13:misc.c        **** #include "jpeg_handler.h"
  14:misc.c        **** #include "include/jpeglib.h"
  15:misc.c        **** #include "misc.h"
  16:misc.c        **** 
  17:misc.c        **** //----------------------------------------------------------------------------
  18:misc.c        **** 
  19:misc.c        **** int dummy(image_t *im1, image_t *im2);
  20:misc.c        **** 
  21:misc.c        **** //----------------------------------------------------------------------------
  22:misc.c        **** 
  23:misc.c        **** /* inhibimos el inlining
  24:misc.c        ****  * para que el ensamblador sea m谩s c贸modo de leer */
  25:misc.c        **** 
  26:misc.c        **** /* return wall time in seconds */
  27:misc.c        **** __attribute__ ((noinline))
  28:misc.c        **** double
  29:misc.c        **** get_wall_time()
  30:misc.c        **** {
  10              		.loc 1 30 1
  11              		.cfi_startproc
  31:misc.c        ****     struct timeval time;
  12              		.loc 1 31 5
  32:misc.c        ****     if (gettimeofday(&time,NULL)) {
  13              		.loc 1 32 5
  30:misc.c        ****     struct timeval time;
  14              		.loc 1 30 1 is_stmt 0
  15 0000 4883EC18 		subq	$24, %rsp
  16              		.cfi_def_cfa_offset 32
  17              		.loc 1 32 9
  18 0004 31F6     		xorl	%esi, %esi
  19 0006 4889E7   		movq	%rsp, %rdi
  20 0009 E8000000 		call	gettimeofday
  20      00
  21              	.LVL0:
  22              		.loc 1 32 8
  23 000e 85C0     		testl	%eax, %eax
  24 0010 7522     		jne	.L5
  33:misc.c        ****         exit(-1); // return 0;
  34:misc.c        ****     }
  35:misc.c        ****     return (double)time.tv_sec + (double)time.tv_usec * .000001;
  25              		.loc 1 35 5 is_stmt 1
  26 0012 C5E857D2 		vxorps	%xmm2, %xmm2, %xmm2
  27              		.loc 1 35 34 is_stmt 0
  28 0016 C4E1EB2A 		vcvtsi2sdq	8(%rsp), %xmm2, %xmm0
  28      442408
  29              		.loc 1 35 55
  30 001d C5FB590D 		vmulsd	.LC0(%rip), %xmm0, %xmm1
  30      00000000 
  31              		.loc 1 35 12
  32 0025 C4E1EB2A 		vcvtsi2sdq	(%rsp), %xmm2, %xmm0
  32      0424
  36:misc.c        **** }
  33              		.loc 1 36 1
  34 002b 4883C418 		addq	$24, %rsp
  35              		.cfi_remember_state
  36              		.cfi_def_cfa_offset 8
  35:misc.c        **** }
  37              		.loc 1 35 32
  38 002f C5F358C0 		vaddsd	%xmm0, %xmm1, %xmm0
  39              		.loc 1 36 1
  40 0033 C3       		ret
  41              	.L5:
  42              		.cfi_restore_state
  33:misc.c        ****         exit(-1); // return 0;
  43              		.loc 1 33 9 is_stmt 1
  44 0034 83CFFF   		orl	$-1, %edi
  45 0037 E8000000 		call	exit
  45      00
  46              	.LVL1:
  47              		.cfi_endproc
  48              	.LFE7:
  50 003c 0F1F4000 		.p2align 4
  51              		.globl	get_cpu_time
  53              	get_cpu_time:
  54              	.LFB8:
  37:misc.c        **** //----------------------------------------------------------------------------
  38:misc.c        **** 
  39:misc.c        **** /* return cpu time in seconds */
  40:misc.c        **** __attribute__ ((noinline))
  41:misc.c        **** double
  42:misc.c        **** get_cpu_time()
  43:misc.c        **** {
  55              		.loc 1 43 1
  56              		.cfi_startproc
  44:misc.c        ****     return (double) clock() / CLOCKS_PER_SEC;
  57              		.loc 1 44 5
  43:misc.c        ****     return (double) clock() / CLOCKS_PER_SEC;
  58              		.loc 1 43 1 is_stmt 0
  59 0040 4883EC08 		subq	$8, %rsp
  60              		.cfi_def_cfa_offset 16
  61              		.loc 1 44 21
  62 0044 E8000000 		call	clock
  62      00
  63              	.LVL2:
  64              		.loc 1 44 12
  65 0049 C5F857C0 		vxorps	%xmm0, %xmm0, %xmm0
  66 004d C4E1FB2A 		vcvtsi2sdq	%rax, %xmm0, %xmm0
  66      C0
  67              		.loc 1 44 29
  68 0052 C5FB5E05 		vdivsd	.LC1(%rip), %xmm0, %xmm0
  68      00000000 
  45:misc.c        **** }
  69              		.loc 1 45 1
  70 005a 4883C408 		addq	$8, %rsp
  71              		.cfi_def_cfa_offset 8
  72 005e C3       		ret
  73              		.cfi_endproc
  74              	.LFE8:
  76              		.section	.rodata.str1.8,"aMS",@progbits,1
  77              		.align 8
  78              	.LC5:
  79 0000 25313873 		.string	"%18s  %5.1f    %4.1f       %4.2f \n"
  79      20202535 
  79      2E316620 
  79      20202025 
  79      342E3166 
  80              		.text
  81 005f 90       		.p2align 4
  82              		.globl	results
  84              	results:
  85              	.LFB9:
  46:misc.c        **** //----------------------------------------------------------------------------
  47:misc.c        **** 
  48:misc.c        **** /* inhibimos el inlining de algunas funciones
  49:misc.c        ****  * para que el ensamblador sea m谩s c贸modo de leer */
  50:misc.c        **** __attribute__ ((noinline))
  51:misc.c        **** void results(double wall_time, int npixels, char *loop)
  52:misc.c        **** {
  86              		.loc 1 52 1 is_stmt 1
  87              		.cfi_startproc
  88              	.LVL3:
  53:misc.c        ****   // printf("                  Time\n");
  54:misc.c        ****   // printf("funci贸n            (s)    ns/pix  Gpixels/s\n");
  55:misc.c        **** 
  56:misc.c        ****   printf("%18s  %5.1f    %4.1f       %4.2f \n",
  89              		.loc 1 56 3
  57:misc.c        ****           loop /* nombre del bucle */,
  58:misc.c        ****           (1e3)*wall_time/NITER,
  59:misc.c        ****           (1e9)*wall_time/(NITER*npixels)  /* ns/pixel */,
  60:misc.c        ****           (NITER*npixels)/(wall_time*(1e9)) /* Gpixels por segundo */);
  90              		.loc 1 60 17 is_stmt 0
  91 0060 8D04BF   		leal	(%rdi,%rdi,4), %eax
  92              		.loc 1 60 37
  93 0063 C5FB591D 		vmulsd	.LC2(%rip), %xmm0, %xmm3
  93      00000000 
  56:misc.c        ****           loop /* nombre del bucle */,
  94              		.loc 1 56 3
  95 006b C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
  96 006f BF000000 		movl	$.LC5, %edi
  96      00
  97              	.LVL4:
  58:misc.c        ****           (1e9)*wall_time/(NITER*npixels)  /* ns/pixel */,
  98              		.loc 1 58 16
  99 0074 C5FB5905 		vmulsd	.LC3(%rip), %xmm0, %xmm0
  99      00000000 
 100              	.LVL5:
 101              		.loc 1 60 17
 102 007c 01C0     		addl	%eax, %eax
  56:misc.c        ****           loop /* nombre del bucle */,
 103              		.loc 1 56 3
 104 007e C5F32AC8 		vcvtsi2sdl	%eax, %xmm1, %xmm1
 105 0082 B8030000 		movl	$3, %eax
 105      00
 106 0087 C5FB5E05 		vdivsd	.LC4(%rip), %xmm0, %xmm0
 106      00000000 
 107 008f C5F35ED3 		vdivsd	%xmm3, %xmm1, %xmm2
 108 0093 C5E35EC9 		vdivsd	%xmm1, %xmm3, %xmm1
 109 0097 E9000000 		jmp	printf
 109      00
 110              	.LVL6:
 111              		.cfi_endproc
 112              	.LFE9:
 114              		.section	.rodata.str1.1,"aMS",@progbits,1
 115              	.LC7:
 116 0000 4F4B00   		.string	"OK"
 117              	.LC8:
 118 0003 4552524F 		.string	"ERROR"
 118      5200
 119              		.section	.rodata.str1.8
 120 0023 00000000 		.align 8
 120      00
 121              	.LC9:
 122 0028 4552524F 		.string	"ERROR: input image has to be RGB or YCbCr"
 122      523A2069 
 122      6E707574 
 122      20696D61 
 122      67652068 
 123              		.section	.rodata.str1.1
 124              	.LC11:
 125 0009 636D7043 		.string	"cmpColor"
 125      6F6C6F72 
 125      00
 126              		.section	.rodata.str1.8
 127 0052 00000000 		.align 8
 127      0000
 128              	.LC12:
 129 0058 25313873 		.string	"%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n"
 129      20202535 
 129      2E316620 
 129      20202025 
 129      342E3166 
 130 009b 00000000 		.align 8
 130      00
 131              	.LC13:
 132 00a0 20202020 		.string	"        funci\303\263n      Time    ns/px    Gpixels/s  %%diff  max_dif  (max_idx)\n"
 132      20202020 
 132      66756E63 
 132      69C3B36E 
 132      20202020 
 133              		.text
 134 009c 0F1F4000 		.p2align 4
 135              		.globl	cmpColor
 137              	cmpColor:
 138              	.LFB10:
  61:misc.c        **** }
  62:misc.c        **** //----------------------------------------------------------------------------
  63:misc.c        **** 
  64:misc.c        **** int
  65:misc.c        **** cmpColor(image_t * image_in1, image_t * image_in2, image_t * image_out)
  66:misc.c        **** {
 139              		.loc 1 66 1 is_stmt 1
 140              		.cfi_startproc
 141              	.LVL7:
  67:misc.c        ****     double start_t, end_t, wall_dif;
 142              		.loc 1 67 5
  68:misc.c        ****     const int height = image_in1->height;
 143              		.loc 1 68 5
  66:misc.c        ****     double start_t, end_t, wall_dif;
 144              		.loc 1 66 1 is_stmt 0
 145 00a0 4157     		pushq	%r15
 146              		.cfi_def_cfa_offset 16
 147              		.cfi_offset 15, -16
 148 00a2 4156     		pushq	%r14
 149              		.cfi_def_cfa_offset 24
 150              		.cfi_offset 14, -24
 151 00a4 4155     		pushq	%r13
 152              		.cfi_def_cfa_offset 32
 153              		.cfi_offset 13, -32
 154 00a6 4154     		pushq	%r12
 155              		.cfi_def_cfa_offset 40
 156              		.cfi_offset 12, -40
 157 00a8 55       		pushq	%rbp
 158              		.cfi_def_cfa_offset 48
 159              		.cfi_offset 6, -48
 160 00a9 53       		pushq	%rbx
 161              		.cfi_def_cfa_offset 56
 162              		.cfi_offset 3, -56
 163 00aa 4883EC38 		subq	$56, %rsp
 164              		.cfi_def_cfa_offset 112
  69:misc.c        ****     const int width =  image_in1->width;
  70:misc.c        ****     const int color_space =  image_in1->color_space;
  71:misc.c        ****     unsigned char * pixels_in1 = image_in1->pixels;
  72:misc.c        ****     unsigned char * pixels_in2 = image_in2->pixels;
  73:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
  74:misc.c        ****     int max_idx, diff;
  75:misc.c        ****     char max_diff; /* can be negative */
  76:misc.c        **** 
  77:misc.c        ****     if (image_in1->bytes_per_pixel != 3)
 165              		.loc 1 77 8
 166 00ae 837F1003 		cmpl	$3, 16(%rdi)
  68:misc.c        ****     const int width =  image_in1->width;
 167              		.loc 1 68 15
 168 00b2 8B6F0C   		movl	12(%rdi), %ebp
 169              	.LVL8:
  69:misc.c        ****     const int width =  image_in1->width;
 170              		.loc 1 69 5 is_stmt 1
  69:misc.c        ****     const int width =  image_in1->width;
 171              		.loc 1 69 15 is_stmt 0
 172 00b5 8B5F08   		movl	8(%rdi), %ebx
 173              	.LVL9:
  70:misc.c        ****     unsigned char * pixels_in1 = image_in1->pixels;
 174              		.loc 1 70 5 is_stmt 1
  70:misc.c        ****     unsigned char * pixels_in1 = image_in1->pixels;
 175              		.loc 1 70 15 is_stmt 0
 176 00b8 8B4714   		movl	20(%rdi), %eax
 177              	.LVL10:
  71:misc.c        ****     unsigned char * pixels_in2 = image_in2->pixels;
 178              		.loc 1 71 5 is_stmt 1
  71:misc.c        ****     unsigned char * pixels_in2 = image_in2->pixels;
 179              		.loc 1 71 21 is_stmt 0
 180 00bb 4C8B37   		movq	(%rdi), %r14
 181              	.LVL11:
  72:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
 182              		.loc 1 72 5 is_stmt 1
  72:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
 183              		.loc 1 72 21 is_stmt 0
 184 00be 4C8B3E   		movq	(%rsi), %r15
 185              	.LVL12:
  73:misc.c        ****     int max_idx, diff;
 186              		.loc 1 73 5 is_stmt 1
  73:misc.c        ****     int max_idx, diff;
 187              		.loc 1 73 21 is_stmt 0
 188 00c1 4C8B1A   		movq	(%rdx), %r11
 189              	.LVL13:
  74:misc.c        ****     char max_diff; /* can be negative */
 190              		.loc 1 74 5 is_stmt 1
  75:misc.c        **** 
 191              		.loc 1 75 5
 192              		.loc 1 77 5
 193              		.loc 1 77 8 is_stmt 0
 194 00c4 0F857001 		jne	.L20
 194      0000
  78:misc.c        ****     {
  79:misc.c        ****         printf("ERROR: input image has to be RGB or YCbCr\n");
  80:misc.c        ****         exit(-1);
  81:misc.c        ****     }
  82:misc.c        **** 
  83:misc.c        ****     /* fill struct fields */
  84:misc.c        ****     image_out->width  = width;
  85:misc.c        ****     image_out->height = height;
 195              		.loc 1 85 23
 196 00ca 896A0C   		movl	%ebp, 12(%rdx)
 197              	.LBB2:
 198              	.LBB3:
  86:misc.c        ****     image_out->bytes_per_pixel = 3;
  87:misc.c        ****     image_out->color_space = color_space;
  88:misc.c        ****     // image_out->color_space = JCS_RGB;
  89:misc.c        **** 
  90:misc.c        ****     start_t = get_wall_time();
  91:misc.c        ****     for (int it = 0; it < NITER/10; it++)
  92:misc.c        ****     {
  93:misc.c        ****         max_diff = 0; max_idx = -1; diff = 0;
  94:misc.c        ****         for (int i = 0; i < 3*height*width; i++)
 199              		.loc 1 94 37
 200 00cd 0FAFEB   		imull	%ebx, %ebp
 201              	.LVL14:
 202              	.LBE3:
 203              	.LBE2:
  87:misc.c        ****     // image_out->color_space = JCS_RGB;
 204              		.loc 1 87 28
 205 00d0 894214   		movl	%eax, 20(%rdx)
  90:misc.c        ****     for (int it = 0; it < NITER/10; it++)
 206              		.loc 1 90 15
 207 00d3 31C0     		xorl	%eax, %eax
 208              	.LVL15:
  84:misc.c        ****     image_out->height = height;
 209              		.loc 1 84 23
 210 00d5 895A08   		movl	%ebx, 8(%rdx)
  86:misc.c        ****     image_out->color_space = color_space;
 211              		.loc 1 86 32
 212 00d8 C7421003 		movl	$3, 16(%rdx)
 212      000000
 213 00df 48897C24 		movq	%rdi, 24(%rsp)
 213      18
 214 00e4 4C895C24 		movq	%r11, 40(%rsp)
 214      28
  84:misc.c        ****     image_out->height = height;
 215              		.loc 1 84 5 is_stmt 1
  85:misc.c        ****     image_out->bytes_per_pixel = 3;
 216              		.loc 1 85 5
  86:misc.c        ****     image_out->color_space = color_space;
 217              		.loc 1 86 5
  87:misc.c        ****     // image_out->color_space = JCS_RGB;
 218              		.loc 1 87 5
  87:misc.c        ****     // image_out->color_space = JCS_RGB;
 219              		.loc 1 87 28 is_stmt 0
 220 00e9 48895424 		movq	%rdx, 16(%rsp)
 220      10
  90:misc.c        ****     for (int it = 0; it < NITER/10; it++)
 221              		.loc 1 90 5 is_stmt 1
  90:misc.c        ****     for (int it = 0; it < NITER/10; it++)
 222              		.loc 1 90 15 is_stmt 0
 223 00ee E8000000 		call	get_wall_time
 223      00
 224              	.LVL16:
 225              	.LBB7:
 226              	.LBB4:
 227              		.loc 1 94 37
 228 00f3 8D446D00 		leal	0(%rbp,%rbp,2), %eax
 229              		.loc 1 94 9
 230 00f7 488B7424 		movq	16(%rsp), %rsi
 230      10
 231 00fc 488B7C24 		movq	24(%rsp), %rdi
 231      18
 232 0101 85C0     		testl	%eax, %eax
 233              		.loc 1 94 37
 234 0103 8944240C 		movl	%eax, 12(%rsp)
 235              	.LBE4:
 236              	.LBE7:
  90:misc.c        ****     for (int it = 0; it < NITER/10; it++)
 237              		.loc 1 90 15
 238 0107 C5FB1144 		vmovsd	%xmm0, 32(%rsp)
 238      2420
 239              	.LVL17:
  91:misc.c        ****     {
 240              		.loc 1 91 5 is_stmt 1
 241              	.LBB8:
  91:misc.c        ****     {
 242              		.loc 1 91 10
  91:misc.c        ****     {
 243              		.loc 1 91 22
 244              	.LBB5:
 245              		.loc 1 94 25
 246              		.loc 1 94 9 is_stmt 0
 247 010d 0F8EFD00 		jle	.L11
 247      0000
 248 0113 4C8B5C24 		movq	40(%rsp), %r11
 248      28
 249 0118 8D50FF   		leal	-1(%rax), %edx
 250 011b 31C9     		xorl	%ecx, %ecx
 251              	.LBE5:
  93:misc.c        ****         for (int i = 0; i < 3*height*width; i++)
 252              		.loc 1 93 18
 253 011d 4531ED   		xorl	%r13d, %r13d
  93:misc.c        ****         for (int i = 0; i < 3*height*width; i++)
 254              		.loc 1 93 42
 255 0120 31DB     		xorl	%ebx, %ebx
 256              	.LVL18:
  93:misc.c        ****         for (int i = 0; i < 3*height*width; i++)
 257              		.loc 1 93 31
 258 0122 41BAFFFF 		movl	$-1, %r10d
 258      FFFF
 259 0128 EB09     		jmp	.L13
 260              	.LVL19:
 261 012a 660F1F44 		.p2align 4,,10
 261      0000
 262              		.p2align 3
 263              	.L16:
 264              	.LBB6:
 265              		.loc 1 94 9
 266 0130 4889C1   		movq	%rax, %rcx
 267              	.LVL20:
 268              	.L13:
  95:misc.c        ****         {
  96:misc.c        ****             pixels_out[i] = abs(pixels_in1[i] - pixels_in2[i]);
 269              		.loc 1 96 13 is_stmt 1
 270              		.loc 1 96 59 is_stmt 0
 271 0133 450FB624 		movzbl	(%r15,%rcx), %r12d
 271      0F
 272              		.loc 1 96 43
 273 0138 410FB604 		movzbl	(%r14,%rcx), %eax
 273      0E
 274 013d 4189C1   		movl	%eax, %r9d
 275              		.loc 1 96 47
 276 0140 4429E0   		subl	%r12d, %eax
 277              		.loc 1 96 59
 278 0143 4589E0   		movl	%r12d, %r8d
 279              		.loc 1 96 29
 280 0146 4189C4   		movl	%eax, %r12d
 281 0149 41C1FC1F 		sarl	$31, %r12d
 282 014d 4431E0   		xorl	%r12d, %eax
 283 0150 4429E0   		subl	%r12d, %eax
 284 0153 450FBEE5 		movsbl	%r13b, %r12d
 285              		.loc 1 96 27
 286 0157 4188040B 		movb	%al, (%r11,%rcx)
  97:misc.c        ****             if (pixels_out[i] != 0)
 287              		.loc 1 97 13 is_stmt 1
 288              		.loc 1 97 16 is_stmt 0
 289 015b 4538C1   		cmpb	%r8b, %r9b
 290 015e 7411     		je	.L12
  98:misc.c        ****             {
  99:misc.c        ****                 diff++;
 291              		.loc 1 99 17 is_stmt 1
 292              		.loc 1 99 21 is_stmt 0
 293 0160 FFC3     		incl	%ebx
 294              	.LVL21:
 100:misc.c        ****                 if (pixels_out[i] > max_diff)
 295              		.loc 1 100 17 is_stmt 1
 296              		.loc 1 100 20 is_stmt 0
 297 0162 4439E0   		cmpl	%r12d, %eax
 298 0165 7E0A     		jle	.L12
 101:misc.c        ****                 {
 102:misc.c        ****                     max_diff = pixels_out[i];
 299              		.loc 1 102 21 is_stmt 1
 300              	.LVL22:
 301              		.loc 1 102 30 is_stmt 0
 302 0167 4189C5   		movl	%eax, %r13d
 103:misc.c        ****                     max_idx = i;
 303              		.loc 1 103 21 is_stmt 1
 304              	.LVL23:
 305 016a 440FBEE0 		movsbl	%al, %r12d
 102:misc.c        ****                     max_idx = i;
 306              		.loc 1 102 30 is_stmt 0
 307 016e 4189CA   		movl	%ecx, %r10d
 308              	.LVL24:
 309              	.L12:
  94:misc.c        ****         {
 310              		.loc 1 94 45 is_stmt 1
  94:misc.c        ****         {
 311              		.loc 1 94 25
 312 0171 488D4101 		leaq	1(%rcx), %rax
  94:misc.c        ****         {
 313              		.loc 1 94 9 is_stmt 0
 314 0175 4839CA   		cmpq	%rcx, %rdx
 315 0178 75B6     		jne	.L16
 316 017a 44895424 		movl	%r10d, 16(%rsp)
 316      10
 317              	.LVL25:
 318              	.LBE6:
 104:misc.c        ****                 }
 105:misc.c        ****             }
 106:misc.c        ****         }
 107:misc.c        ****         dummy(image_in1, image_out);
 319              		.loc 1 107 9 is_stmt 1 discriminator 2
 320 017f E8000000 		call	dummy
 320      00
 321              	.LVL26:
  91:misc.c        ****     {
 322              		.loc 1 91 37 discriminator 2
  91:misc.c        ****     {
 323              		.loc 1 91 22 discriminator 2
 324              	.LBE8:
 108:misc.c        ****     }
 109:misc.c        ****     end_t = get_wall_time(); wall_dif = end_t - start_t;
 325              		.loc 1 109 5 discriminator 2
 326              		.loc 1 109 13 is_stmt 0 discriminator 2
 327 0184 31C0     		xorl	%eax, %eax
 328 0186 E8000000 		call	get_wall_time
 328      00
 329              	.LVL27:
 330              		.loc 1 109 30 is_stmt 1 discriminator 2
 331 018b C5C157FF 		vxorpd	%xmm7, %xmm7, %xmm7
 110:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 332              		.loc 1 110 5 is_stmt 0 discriminator 2
 333 018f 4584ED   		testb	%r13b, %r13b
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 334              		.loc 1 109 39 discriminator 2
 335 0192 C5FB5C44 		vsubsd	32(%rsp), %xmm0, %xmm0
 335      2420
 336              	.LVL28:
 337              		.loc 1 110 5 is_stmt 1 discriminator 2
 338 0198 C5C32AD3 		vcvtsi2sdl	%ebx, %xmm7, %xmm2
 339 019c 448B5424 		movl	16(%rsp), %r10d
 339      10
 340 01a1 C5EB5915 		vmulsd	.LC10(%rip), %xmm2, %xmm2
 340      00000000 
 341 01a9 41B80000 		movl	$.LC8, %r8d
 341      0000
 342 01af 747E     		je	.L19
 343              	.LVL29:
 344              	.L15:
 345              		.loc 1 110 5 is_stmt 0 discriminator 4
 346 01b1 C5D157ED 		vxorpd	%xmm5, %xmm5, %xmm5
 347 01b5 4489E2   		movl	%r12d, %edx
 348 01b8 4489D1   		movl	%r10d, %ecx
 349 01bb BE000000 		movl	$.LC11, %esi
 349      00
 350 01c0 C5D32ACD 		vcvtsi2sdl	%ebp, %xmm5, %xmm1
 351 01c4 BF000000 		movl	$.LC12, %edi
 351      00
 352 01c9 B8040000 		movl	$4, %eax
 352      00
 111:misc.c        ****            "cmpColor",
 112:misc.c        ****            wall_dif, wall_dif*1e9/(NITER/10*height*width),
 113:misc.c        ****            (NITER/10*height*width)/(1e9*wall_dif), (double) 100.0*diff/(3*height*width),
 353              		.loc 1 113 40 discriminator 4
 354 01ce C5FB5925 		vmulsd	.LC2(%rip), %xmm0, %xmm4
 354      00000000 
 110:misc.c        ****            "cmpColor",
 355              		.loc 1 110 5 discriminator 4
 356 01d6 C5D32A5C 		vcvtsi2sdl	12(%rsp), %xmm5, %xmm3
 356      240C
 357 01dc C5EB5EDB 		vdivsd	%xmm3, %xmm2, %xmm3
 358 01e0 C5F35ED4 		vdivsd	%xmm4, %xmm1, %xmm2
 359 01e4 C5DB5EC9 		vdivsd	%xmm1, %xmm4, %xmm1
 360 01e8 E8000000 		call	printf
 360      00
 361              	.LVL30:
 114:misc.c        ****            max_diff, max_idx, max_diff == 0? "OK":"ERROR");
 115:misc.c        ****     printf("        funci贸n      Time    ns/px    Gpixels/s  %%diff  max_dif  (max_idx)\n");
 362              		.loc 1 115 5 is_stmt 1 discriminator 4
 363 01ed BF000000 		movl	$.LC13, %edi
 363      00
 364 01f2 31C0     		xorl	%eax, %eax
 365 01f4 E8000000 		call	printf
 365      00
 366              	.LVL31:
 116:misc.c        **** 
 117:misc.c        ****     return(max_diff);
 367              		.loc 1 117 5 discriminator 4
 118:misc.c        **** }
 368              		.loc 1 118 1 is_stmt 0 discriminator 4
 369 01f9 4883C438 		addq	$56, %rsp
 370              		.cfi_remember_state
 371              		.cfi_def_cfa_offset 56
 372 01fd 4489E0   		movl	%r12d, %eax
 373 0200 5B       		popq	%rbx
 374              		.cfi_def_cfa_offset 48
 375 0201 5D       		popq	%rbp
 376              		.cfi_def_cfa_offset 40
 377 0202 415C     		popq	%r12
 378              		.cfi_def_cfa_offset 32
 379 0204 415D     		popq	%r13
 380              		.cfi_def_cfa_offset 24
 381 0206 415E     		popq	%r14
 382              		.cfi_def_cfa_offset 16
 383              	.LVL32:
 384 0208 415F     		popq	%r15
 385              		.cfi_def_cfa_offset 8
 386              	.LVL33:
 387 020a C3       		ret
 388              	.LVL34:
 389 020b 0F1F4400 		.p2align 4,,10
 389      00
 390              		.p2align 3
 391              	.L11:
 392              		.cfi_restore_state
 393              	.LBB9:
 107:misc.c        ****     }
 394              		.loc 1 107 9 is_stmt 1
 395 0210 E8000000 		call	dummy
 395      00
 396              	.LVL35:
  91:misc.c        ****     {
 397              		.loc 1 91 37
  91:misc.c        ****     {
 398              		.loc 1 91 22
 399              	.LBE9:
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 400              		.loc 1 109 5
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 401              		.loc 1 109 13 is_stmt 0
 402 0215 31C0     		xorl	%eax, %eax
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 403              		.loc 1 109 39
 404 0217 4531E4   		xorl	%r12d, %r12d
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 405              		.loc 1 109 13
 406 021a E8000000 		call	get_wall_time
 406      00
 407              	.LVL36:
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 408              		.loc 1 109 30 is_stmt 1
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 409              		.loc 1 109 39 is_stmt 0
 410 021f C5FB5C44 		vsubsd	32(%rsp), %xmm0, %xmm0
 410      2420
 411              	.LVL37:
 110:misc.c        ****            "cmpColor",
 412              		.loc 1 110 5 is_stmt 1
 109:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f     %4.1f%%   %4hhd    (%7d)  %s\n",
 413              		.loc 1 109 39 is_stmt 0
 414 0225 C5E957D2 		vxorpd	%xmm2, %xmm2, %xmm2
 415              	.LBB10:
  93:misc.c        ****         for (int i = 0; i < 3*height*width; i++)
 416              		.loc 1 93 31
 417 0229 41BAFFFF 		movl	$-1, %r10d
 417      FFFF
 418              	.LVL38:
 419              	.L19:
 420              	.LBE10:
 110:misc.c        ****            "cmpColor",
 421              		.loc 1 110 5
 422 022f 41B80000 		movl	$.LC7, %r8d
 422      0000
 423 0235 E977FFFF 		jmp	.L15
 423      FF
 424              	.LVL39:
 425              	.L20:
  79:misc.c        ****         exit(-1);
 426              		.loc 1 79 9 is_stmt 1
 427 023a BF000000 		movl	$.LC9, %edi
 427      00
 428              	.LVL40:
 429 023f E8000000 		call	puts
 429      00
 430              	.LVL41:
  80:misc.c        ****     }
 431              		.loc 1 80 9
 432 0244 83CFFF   		orl	$-1, %edi
 433 0247 E8000000 		call	exit
 433      00
 434              	.LVL42:
 435              		.cfi_endproc
 436              	.LFE10:
 438              		.section	.rodata.str1.8
 439 00ee 0000     		.align 8
 440              	.LC14:
 441 00f0 4552524F 		.string	"ERROR: input image has to be GRAY"
 441      523A2069 
 441      6E707574 
 441      20696D61 
 441      67652068 
 442              		.section	.rodata.str1.1
 443              	.LC16:
 444 0012 636D7047 		.string	"cmpGray"
 444      72617900 
 445              		.section	.rodata.str1.8
 446 0112 00000000 		.align 8
 446      0000
 447              	.LC17:
 448 0118 25313873 		.string	"%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %hhd (%d)\n"
 448      20202535 
 448      2E316620 
 448      20202025 
 448      342E3166 
 449              		.text
 450 024c 0F1F4000 		.p2align 4
 451              		.globl	cmpGray
 453              	cmpGray:
 454              	.LFB11:
 119:misc.c        **** //----------------------------------------------------------------------------
 120:misc.c        **** 
 121:misc.c        **** int
 122:misc.c        **** cmpGray(image_t * image_in1, image_t * image_in2, image_t * image_out)
 123:misc.c        **** {
 455              		.loc 1 123 1
 456              		.cfi_startproc
 457              	.LVL43:
 124:misc.c        ****     double start_t, end_t, wall_dif;
 458              		.loc 1 124 5
 125:misc.c        ****     const int height = image_in1->height;
 459              		.loc 1 125 5
 123:misc.c        ****     double start_t, end_t, wall_dif;
 460              		.loc 1 123 1 is_stmt 0
 461 0250 4157     		pushq	%r15
 462              		.cfi_def_cfa_offset 16
 463              		.cfi_offset 15, -16
 464 0252 4989FF   		movq	%rdi, %r15
 465 0255 4156     		pushq	%r14
 466              		.cfi_def_cfa_offset 24
 467              		.cfi_offset 14, -24
 468 0257 4155     		pushq	%r13
 469              		.cfi_def_cfa_offset 32
 470              		.cfi_offset 13, -32
 471 0259 4154     		pushq	%r12
 472              		.cfi_def_cfa_offset 40
 473              		.cfi_offset 12, -40
 474 025b 55       		pushq	%rbp
 475              		.cfi_def_cfa_offset 48
 476              		.cfi_offset 6, -48
 477 025c 53       		pushq	%rbx
 478              		.cfi_def_cfa_offset 56
 479              		.cfi_offset 3, -56
 480 025d 4883EC28 		subq	$40, %rsp
 481              		.cfi_def_cfa_offset 96
 126:misc.c        ****     const int width =  image_in1->width;
 127:misc.c        ****     unsigned char * pixels_in1 = image_in1->pixels;
 128:misc.c        ****     unsigned char * pixels_in2 = image_in2->pixels;
 129:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
 130:misc.c        ****     int max_idx, diff;
 131:misc.c        ****     char max_gray_diff; /* can be negative */
 132:misc.c        **** 
 133:misc.c        ****     if (image_in1->bytes_per_pixel != 1)
 482              		.loc 1 133 8
 483 0261 41837F10 		cmpl	$1, 16(%r15)
 483      01
 125:misc.c        ****     const int width =  image_in1->width;
 484              		.loc 1 125 15
 485 0266 448B770C 		movl	12(%rdi), %r14d
 486              	.LVL44:
 126:misc.c        ****     const int width =  image_in1->width;
 487              		.loc 1 126 5 is_stmt 1
 126:misc.c        ****     const int width =  image_in1->width;
 488              		.loc 1 126 15 is_stmt 0
 489 026a 8B5F08   		movl	8(%rdi), %ebx
 490              	.LVL45:
 127:misc.c        ****     unsigned char * pixels_in2 = image_in2->pixels;
 491              		.loc 1 127 5 is_stmt 1
 127:misc.c        ****     unsigned char * pixels_in2 = image_in2->pixels;
 492              		.loc 1 127 21 is_stmt 0
 493 026d 488B2F   		movq	(%rdi), %rbp
 494              	.LVL46:
 128:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
 495              		.loc 1 128 5 is_stmt 1
 128:misc.c        ****     unsigned char * pixels_out = image_out->pixels;
 496              		.loc 1 128 21 is_stmt 0
 497 0270 4C8B2E   		movq	(%rsi), %r13
 498              	.LVL47:
 129:misc.c        ****     int max_idx, diff;
 499              		.loc 1 129 5 is_stmt 1
 129:misc.c        ****     int max_idx, diff;
 500              		.loc 1 129 21 is_stmt 0
 501 0273 488B3A   		movq	(%rdx), %rdi
 502              	.LVL48:
 130:misc.c        ****     char max_gray_diff; /* can be negative */
 503              		.loc 1 130 5 is_stmt 1
 131:misc.c        **** 
 504              		.loc 1 131 5
 505              		.loc 1 133 5
 506              		.loc 1 133 8 is_stmt 0
 507 0276 0F855401 		jne	.L29
 507      0000
 134:misc.c        ****     {
 135:misc.c        ****         printf("ERROR: input image has to be GRAY\n");
 136:misc.c        ****         exit(-1);
 137:misc.c        ****     }
 138:misc.c        ****     
 139:misc.c        ****     /* fill struct fields */
 140:misc.c        ****     image_out->width  = width;
 141:misc.c        ****     image_out->height = height;
 142:misc.c        ****     image_out->bytes_per_pixel = 1;
 508              		.loc 1 142 32
 509 027c 48B80100 		movabsq	$4294967297, %rax
 509      00000100 
 509      0000
 141:misc.c        ****     image_out->bytes_per_pixel = 1;
 510              		.loc 1 141 23
 511 0286 4489720C 		movl	%r14d, 12(%rdx)
 512              	.LBB11:
 513              	.LBB12:
 143:misc.c        ****     image_out->color_space = JCS_GRAYSCALE;
 144:misc.c        **** 
 145:misc.c        ****     start_t = get_wall_time();
 146:misc.c        **** 
 147:misc.c        ****     for (int it = 0; it < NITER/10; it++)
 148:misc.c        ****     {
 149:misc.c        ****         max_gray_diff = 0; max_idx = -1; diff = 0;
 150:misc.c        **** 
 151:misc.c        ****         for (int i = 0; i < height*width; i++)
 514              		.loc 1 151 35
 515 028a 440FAFF3 		imull	%ebx, %r14d
 516              	.LVL49:
 517              	.LBE12:
 518              	.LBE11:
 142:misc.c        ****     image_out->color_space = JCS_GRAYSCALE;
 519              		.loc 1 142 32
 520 028e 48894210 		movq	%rax, 16(%rdx)
 145:misc.c        **** 
 521              		.loc 1 145 15
 522 0292 31C0     		xorl	%eax, %eax
 140:misc.c        ****     image_out->height = height;
 523              		.loc 1 140 23
 524 0294 895A08   		movl	%ebx, 8(%rdx)
 525 0297 48897C24 		movq	%rdi, 24(%rsp)
 525      18
 140:misc.c        ****     image_out->height = height;
 526              		.loc 1 140 5 is_stmt 1
 141:misc.c        ****     image_out->bytes_per_pixel = 1;
 527              		.loc 1 141 5
 142:misc.c        ****     image_out->color_space = JCS_GRAYSCALE;
 528              		.loc 1 142 5
 143:misc.c        **** 
 529              		.loc 1 143 5
 142:misc.c        ****     image_out->color_space = JCS_GRAYSCALE;
 530              		.loc 1 142 32 is_stmt 0
 531 029c 48895424 		movq	%rdx, 16(%rsp)
 531      10
 145:misc.c        **** 
 532              		.loc 1 145 5 is_stmt 1
 145:misc.c        **** 
 533              		.loc 1 145 15 is_stmt 0
 534 02a1 E8000000 		call	get_wall_time
 534      00
 535              	.LVL50:
 536              	.LBB17:
 537              	.LBB13:
 538              		.loc 1 151 9
 539 02a6 4585F6   		testl	%r14d, %r14d
 540 02a9 488B7424 		movq	16(%rsp), %rsi
 540      10
 541              	.LBE13:
 542              	.LBE17:
 145:misc.c        **** 
 543              		.loc 1 145 15
 544 02ae C5FB1144 		vmovsd	%xmm0, 8(%rsp)
 544      2408
 545              	.LVL51:
 147:misc.c        ****     {
 546              		.loc 1 147 5 is_stmt 1
 547              	.LBB18:
 147:misc.c        ****     {
 548              		.loc 1 147 10
 147:misc.c        ****     {
 549              		.loc 1 147 22
 550              	.LBB14:
 551              		.loc 1 151 25
 552              		.loc 1 151 9 is_stmt 0
 553 02b4 0F8E0601 		jle	.L26
 553      0000
 554 02ba 488B7C24 		movq	24(%rsp), %rdi
 554      18
 555 02bf 418D56FF 		leal	-1(%r14), %edx
 556 02c3 31C9     		xorl	%ecx, %ecx
 557              	.LBE14:
 149:misc.c        **** 
 558              		.loc 1 149 23
 559 02c5 4531D2   		xorl	%r10d, %r10d
 149:misc.c        **** 
 560              		.loc 1 149 47
 561 02c8 31DB     		xorl	%ebx, %ebx
 562              	.LVL52:
 149:misc.c        **** 
 563              		.loc 1 149 36
 564 02ca 41BBFFFF 		movl	$-1, %r11d
 564      FFFF
 565 02d0 EB09     		jmp	.L25
 566              	.LVL53:
 567              		.p2align 4,,10
 568 02d2 660F1F44 		.p2align 3
 568      0000
 569              	.L27:
 570              	.LBB15:
 571              		.loc 1 151 9
 572 02d8 4889C1   		movq	%rax, %rcx
 573              	.LVL54:
 574              	.L25:
 152:misc.c        ****         {
 153:misc.c        ****             pixels_out[i] = abs(pixels_in1[i] - pixels_in2[i]);
 575              		.loc 1 153 13 is_stmt 1
 576              		.loc 1 153 59 is_stmt 0
 577 02db 450FB664 		movzbl	0(%r13,%rcx), %r12d
 577      0D00
 578              		.loc 1 153 43
 579 02e1 0FB6440D 		movzbl	0(%rbp,%rcx), %eax
 579      00
 580 02e6 4189C1   		movl	%eax, %r9d
 581              		.loc 1 153 47
 582 02e9 4429E0   		subl	%r12d, %eax
 583              		.loc 1 153 59
 584 02ec 4589E0   		movl	%r12d, %r8d
 585              		.loc 1 153 29
 586 02ef 4189C4   		movl	%eax, %r12d
 587 02f2 41C1FC1F 		sarl	$31, %r12d
 588 02f6 4431E0   		xorl	%r12d, %eax
 589 02f9 4429E0   		subl	%r12d, %eax
 590 02fc 450FBEE2 		movsbl	%r10b, %r12d
 591              		.loc 1 153 27
 592 0300 88040F   		movb	%al, (%rdi,%rcx)
 154:misc.c        ****             if (pixels_out[i] != 0)
 593              		.loc 1 154 13 is_stmt 1
 594              		.loc 1 154 16 is_stmt 0
 595 0303 4538C1   		cmpb	%r8b, %r9b
 596 0306 7411     		je	.L24
 155:misc.c        ****             {
 156:misc.c        ****                 diff++;
 597              		.loc 1 156 17 is_stmt 1
 598              		.loc 1 156 21 is_stmt 0
 599 0308 FFC3     		incl	%ebx
 600              	.LVL55:
 157:misc.c        ****                 if (pixels_out[i] > max_gray_diff)
 601              		.loc 1 157 17 is_stmt 1
 602              		.loc 1 157 20 is_stmt 0
 603 030a 4439E0   		cmpl	%r12d, %eax
 604 030d 7E0A     		jle	.L24
 158:misc.c        ****                 {
 159:misc.c        ****                     max_gray_diff = pixels_out[i];
 605              		.loc 1 159 21 is_stmt 1
 606              		.loc 1 159 35 is_stmt 0
 607 030f 4189C2   		movl	%eax, %r10d
 608              	.LVL56:
 160:misc.c        ****                     max_idx = i;
 609              		.loc 1 160 21 is_stmt 1
 610 0312 440FBEE0 		movsbl	%al, %r12d
 159:misc.c        ****                     max_idx = i;
 611              		.loc 1 159 35 is_stmt 0
 612 0316 4189CB   		movl	%ecx, %r11d
 613              	.LVL57:
 614              	.L24:
 151:misc.c        ****         {
 615              		.loc 1 151 43 is_stmt 1
 151:misc.c        ****         {
 616              		.loc 1 151 25
 617 0319 488D4101 		leaq	1(%rcx), %rax
 151:misc.c        ****         {
 618              		.loc 1 151 9 is_stmt 0
 619 031d 4839CA   		cmpq	%rcx, %rdx
 620 0320 75B6     		jne	.L27
 621              	.LVL58:
 622              	.L23:
 623              	.LBE15:
 161:misc.c        ****                 }
 162:misc.c        ****             }
 163:misc.c        ****         }
 164:misc.c        ****         dummy(image_in1, image_out);
 624              		.loc 1 164 9 discriminator 2
 625 0322 4C89FF   		movq	%r15, %rdi
 626 0325 44895C24 		movl	%r11d, 16(%rsp)
 626      10
 627              	.LVL59:
 628              		.loc 1 164 9 is_stmt 1 discriminator 2
 629 032a E8000000 		call	dummy
 629      00
 630              	.LVL60:
 147:misc.c        ****     {
 631              		.loc 1 147 37 discriminator 2
 147:misc.c        ****     {
 632              		.loc 1 147 22 discriminator 2
 633              	.LBE18:
 165:misc.c        ****     }
 166:misc.c        ****     end_t = get_wall_time(); wall_dif = end_t - start_t;
 634              		.loc 1 166 5 discriminator 2
 635              		.loc 1 166 13 is_stmt 0 discriminator 2
 636 032f 31C0     		xorl	%eax, %eax
 637 0331 E8000000 		call	get_wall_time
 637      00
 638              	.LVL61:
 639              		.loc 1 166 30 is_stmt 1 discriminator 2
 167:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %hhd (%d)\n",
 640              		.loc 1 167 5 is_stmt 0 discriminator 2
 641 0336 C5E857D2 		vxorps	%xmm2, %xmm2, %xmm2
 168:misc.c        ****            "cmpGray", 1e4*wall_dif/NITER, 1e9*wall_dif/(NITER/10*height*width),
 169:misc.c        ****            (NITER*height*width)/(1e9*wall_dif), (double) 100.0*diff/(height*width), max_gray_diff, 
 642              		.loc 1 169 25 discriminator 2
 643 033a 438D04B6 		leal	(%r14,%r14,4), %eax
 167:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %hhd (%d)\n",
 644              		.loc 1 167 5 discriminator 2
 645 033e 4489E2   		movl	%r12d, %edx
 646              		.loc 1 169 63 discriminator 2
 647 0341 C5EB2ADB 		vcvtsi2sdl	%ebx, %xmm2, %xmm3
 648              		.loc 1 169 25 discriminator 2
 649 0345 01C0     		addl	%eax, %eax
 167:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %hhd (%d)\n",
 650              		.loc 1 167 5 discriminator 2
 651 0347 448B5C24 		movl	16(%rsp), %r11d
 651      10
 652 034c BE000000 		movl	$.LC16, %esi
 652      00
 653 0351 C4C16B2A 		vcvtsi2sdl	%r14d, %xmm2, %xmm1
 653      CE
 166:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %hhd (%d)\n",
 654              		.loc 1 166 39 discriminator 2
 655 0356 C5FB5C44 		vsubsd	8(%rsp), %xmm0, %xmm0
 655      2408
 656              	.LVL62:
 167:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %hhd (%d)\n",
 657              		.loc 1 167 5 is_stmt 1 discriminator 2
 658 035c BF000000 		movl	$.LC17, %edi
 658      00
 659              		.loc 1 169 37 is_stmt 0 discriminator 2
 660 0361 C5FB5925 		vmulsd	.LC2(%rip), %xmm0, %xmm4
 660      00000000 
 167:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %hhd (%d)\n",
 661              		.loc 1 167 5 discriminator 2
 662 0369 C5EB2AD0 		vcvtsi2sdl	%eax, %xmm2, %xmm2
 663 036d 4489D9   		movl	%r11d, %ecx
 664 0370 B8040000 		movl	$4, %eax
 664      00
 665              		.loc 1 169 63 discriminator 2
 666 0375 C5E3591D 		vmulsd	.LC10(%rip), %xmm3, %xmm3
 666      00000000 
 168:misc.c        ****            "cmpGray", 1e4*wall_dif/NITER, 1e9*wall_dif/(NITER/10*height*width),
 667              		.loc 1 168 26 discriminator 2
 668 037d C5FB5905 		vmulsd	.LC15(%rip), %xmm0, %xmm0
 668      00000000 
 669              	.LVL63:
 167:misc.c        ****     printf("%18s  %5.1f    %4.1f       %4.2f    %5.1f%%  %hhd (%d)\n",
 670              		.loc 1 167 5 discriminator 2
 671 0385 C5FB5E05 		vdivsd	.LC4(%rip), %xmm0, %xmm0
 671      00000000 
 672 038d C5EB5ED4 		vdivsd	%xmm4, %xmm2, %xmm2
 673 0391 C5E35ED9 		vdivsd	%xmm1, %xmm3, %xmm3
 674 0395 C5DB5EC9 		vdivsd	%xmm1, %xmm4, %xmm1
 675 0399 E8000000 		call	printf
 675      00
 676              	.LVL64:
 170:misc.c        ****     printf("\n");
 677              		.loc 1 170 5 is_stmt 1 discriminator 2
 678 039e BF0A0000 		movl	$10, %edi
 678      00
 679 03a3 E8000000 		call	putchar
 679      00
 680              	.LVL65:
 171:misc.c        ****     return(max_gray_diff);
 681              		.loc 1 171 5 discriminator 2
 172:misc.c        **** }
 682              		.loc 1 172 1 is_stmt 0 discriminator 2
 683 03a8 4883C428 		addq	$40, %rsp
 684              		.cfi_remember_state
 685              		.cfi_def_cfa_offset 56
 686 03ac 4489E0   		movl	%r12d, %eax
 687 03af 5B       		popq	%rbx
 688              		.cfi_def_cfa_offset 48
 689              	.LVL66:
 690 03b0 5D       		popq	%rbp
 691              		.cfi_def_cfa_offset 40
 692              	.LVL67:
 693 03b1 415C     		popq	%r12
 694              		.cfi_def_cfa_offset 32
 695 03b3 415D     		popq	%r13
 696              		.cfi_def_cfa_offset 24
 697              	.LVL68:
 698 03b5 415E     		popq	%r14
 699              		.cfi_def_cfa_offset 16
 700 03b7 415F     		popq	%r15
 701              		.cfi_def_cfa_offset 8
 702              	.LVL69:
 703 03b9 C3       		ret
 704              	.LVL70:
 705 03ba 660F1F44 		.p2align 4,,10
 705      0000
 706              		.p2align 3
 707              	.L26:
 708              		.cfi_restore_state
 709              	.LBB19:
 710              	.LBB16:
 151:misc.c        ****         {
 711              		.loc 1 151 9
 712 03c0 4531E4   		xorl	%r12d, %r12d
 713              	.LBE16:
 149:misc.c        **** 
 714              		.loc 1 149 47
 715 03c3 31DB     		xorl	%ebx, %ebx
 716              	.LVL71:
 149:misc.c        **** 
 717              		.loc 1 149 36
 718 03c5 41BBFFFF 		movl	$-1, %r11d
 718      FFFF
 719 03cb E952FFFF 		jmp	.L23
 719      FF
 720              	.LVL72:
 721              	.L29:
 722              	.LBE19:
 135:misc.c        ****         exit(-1);
 723              		.loc 1 135 9 is_stmt 1
 724 03d0 BF000000 		movl	$.LC14, %edi
 724      00
 725              	.LVL73:
 726 03d5 E8000000 		call	puts
 726      00
 727              	.LVL74:
 136:misc.c        ****     }
 728              		.loc 1 136 9
 729 03da 83CFFF   		orl	$-1, %edi
 730 03dd E8000000 		call	exit
 730      00
 731              	.LVL75:
 732              		.cfi_endproc
 733              	.LFE11:
 735              		.section	.rodata.str1.8
 736              		.align 8
 737              	.LC18:
 738 0150 4552524F 		.string	"ERROR: input image has to be gray"
 738      523A2069 
 738      6E707574 
 738      20696D61 
 738      67652068 
 739              		.section	.rodata.str1.1
 740              	.LC19:
 741 001a 7700     		.string	"w"
 742              		.section	.rodata.str1.8
 743 0172 00000000 		.align 8
 743      0000
 744              	.LC20:
 745 0178 4552524F 		.string	"ERROR: no se ha indicado fichero de salida"
 745      523A206E 
 745      6F207365 
 745      20686120 
 745      696E6469 
 746              		.section	.rodata.str1.1
 747              	.LC21:
 748 001c 50322025 		.string	"P2 %u %u 255\n"
 748      75202575 
 748      20323535 
 748      0A00
 749              	.LC22:
 750 002a 25750A00 		.string	"%u\n"
 751              	.LC23:
 752 002e 77726974 		.string	"write_PGM"
 752      655F5047 
 752      4D00
 753              		.text
 754 03e2 0F1F4000 		.p2align 4
 754      662E0F1F 
 754      84000000 
 754      0000
 755              		.globl	write_PGM
 757              	write_PGM:
 758              	.LFB12:
 173:misc.c        **** //----------------------------------------------------------------------------
 174:misc.c        **** 
 175:misc.c        **** int
 176:misc.c        **** write_PGM(char *filename, image_t * image)
 177:misc.c        **** {
 759              		.loc 1 177 1
 760              		.cfi_startproc
 761              	.LVL76:
 178:misc.c        ****     double start_t, end_t;
 762              		.loc 1 178 5
 179:misc.c        ****     const int height = image->height;
 763              		.loc 1 179 5
 177:misc.c        ****     double start_t, end_t;
 764              		.loc 1 177 1 is_stmt 0
 765 03f0 4155     		pushq	%r13
 766              		.cfi_def_cfa_offset 16
 767              		.cfi_offset 13, -16
 768 03f2 4154     		pushq	%r12
 769              		.cfi_def_cfa_offset 24
 770              		.cfi_offset 12, -24
 771 03f4 55       		pushq	%rbp
 772              		.cfi_def_cfa_offset 32
 773              		.cfi_offset 6, -32
 774 03f5 53       		pushq	%rbx
 775              		.cfi_def_cfa_offset 40
 776              		.cfi_offset 3, -40
 777 03f6 4883EC18 		subq	$24, %rsp
 778              		.cfi_def_cfa_offset 64
 180:misc.c        ****     const int width =  image->width;
 181:misc.c        ****     unsigned char * pixels  = image->pixels;
 182:misc.c        **** 
 183:misc.c        ****     if (image->bytes_per_pixel != 1)
 779              		.loc 1 183 8
 780 03fa 837E1001 		cmpl	$1, 16(%rsi)
 179:misc.c        ****     const int width =  image->width;
 781              		.loc 1 179 15
 782 03fe 448B660C 		movl	12(%rsi), %r12d
 783              	.LVL77:
 180:misc.c        ****     const int width =  image->width;
 784              		.loc 1 180 5 is_stmt 1
 180:misc.c        ****     const int width =  image->width;
 785              		.loc 1 180 15 is_stmt 0
 786 0402 448B6E08 		movl	8(%rsi), %r13d
 787              	.LVL78:
 181:misc.c        **** 
 788              		.loc 1 181 5 is_stmt 1
 181:misc.c        **** 
 789              		.loc 1 181 21 is_stmt 0
 790 0406 488B1E   		movq	(%rsi), %rbx
 791              	.LVL79:
 792              		.loc 1 183 5 is_stmt 1
 793              		.loc 1 183 8 is_stmt 0
 794 0409 0F85B500 		jne	.L39
 794      0000
 795 040f 4889FD   		movq	%rdi, %rbp
 184:misc.c        ****     {
 185:misc.c        ****         printf("ERROR: input image has to be gray\n");
 186:misc.c        ****         exit(-1);
 187:misc.c        ****     }
 188:misc.c        **** 
 189:misc.c        ****     start_t = get_wall_time();
 796              		.loc 1 189 5 is_stmt 1
 797              		.loc 1 189 15 is_stmt 0
 798 0412 31C0     		xorl	%eax, %eax
 799 0414 E8000000 		call	get_wall_time
 799      00
 800              	.LVL80:
 190:misc.c        **** 
 191:misc.c        ****     FILE *outfile = fopen(filename, "w");
 801              		.loc 1 191 21
 802 0419 4889EF   		movq	%rbp, %rdi
 803 041c BE000000 		movl	$.LC19, %esi
 803      00
 189:misc.c        **** 
 804              		.loc 1 189 15
 805 0421 C5FB1144 		vmovsd	%xmm0, 8(%rsp)
 805      2408
 806              	.LVL81:
 807              		.loc 1 191 5 is_stmt 1
 808              		.loc 1 191 21 is_stmt 0
 809 0427 E8000000 		call	fopen
 809      00
 810              	.LVL82:
 811 042c 4889C5   		movq	%rax, %rbp
 812              	.LVL83:
 192:misc.c        ****     if (!outfile)
 813              		.loc 1 192 5 is_stmt 1
 814              		.loc 1 192 8 is_stmt 0
 815 042f 4885C0   		testq	%rax, %rax
 816 0432 747F     		je	.L40
 193:misc.c        ****     {
 194:misc.c        ****         printf("ERROR: no se ha indicado fichero de salida\n");
 195:misc.c        ****         return -1;
 196:misc.c        ****     }
 197:misc.c        **** 
 198:misc.c        ****     /* PGM header */
 199:misc.c        ****     fprintf(outfile, "P2 %u %u 255\n", width, height);
 817              		.loc 1 199 5 is_stmt 1
 818 0434 4489EA   		movl	%r13d, %edx
 819              	.LBB20:
 200:misc.c        **** 
 201:misc.c        ****     for (int i = 0; i < height*width; i++)
 820              		.loc 1 201 31 is_stmt 0
 821 0437 450FAFEC 		imull	%r12d, %r13d
 822              	.LVL84:
 823              	.LBE20:
 199:misc.c        **** 
 824              		.loc 1 199 5
 825 043b 4889C7   		movq	%rax, %rdi
 826 043e 4489E1   		movl	%r12d, %ecx
 827 0441 BE000000 		movl	$.LC21, %esi
 827      00
 828 0446 31C0     		xorl	%eax, %eax
 829              	.LVL85:
 830 0448 E8000000 		call	fprintf
 830      00
 831              	.LVL86:
 832              		.loc 1 201 5 is_stmt 1
 833              	.LBB21:
 834              		.loc 1 201 10
 835              		.loc 1 201 21
 836              		.loc 1 201 5 is_stmt 0
 837 044d 4585ED   		testl	%r13d, %r13d
 838 0450 7E28     		jle	.L34
 839 0452 418D45FF 		leal	-1(%r13), %eax
 840 0456 4C8D6403 		leaq	1(%rbx,%rax), %r12
 840      01
 841              	.LVL87:
 842 045b 0F1F4400 		.p2align 4,,10
 842      00
 843              		.p2align 3
 844              	.L35:
 202:misc.c        ****     {
 203:misc.c        ****         fprintf(outfile, "%u\n", pixels[i]);
 845              		.loc 1 203 9 is_stmt 1 discriminator 3
 846 0460 0FB613   		movzbl	(%rbx), %edx
 847 0463 BE000000 		movl	$.LC22, %esi
 847      00
 848 0468 4889EF   		movq	%rbp, %rdi
 849 046b 31C0     		xorl	%eax, %eax
 850 046d 48FFC3   		incq	%rbx
 851 0470 E8000000 		call	fprintf
 851      00
 852              	.LVL88:
 201:misc.c        ****     {
 853              		.loc 1 201 39 discriminator 3
 201:misc.c        ****     {
 854              		.loc 1 201 21 discriminator 3
 201:misc.c        ****     {
 855              		.loc 1 201 5 is_stmt 0 discriminator 3
 856 0475 4C39E3   		cmpq	%r12, %rbx
 857 0478 75E6     		jne	.L35
 858              	.L34:
 859              	.LBE21:
 204:misc.c        ****     }
 205:misc.c        **** 
 206:misc.c        ****     fclose(outfile);
 860              		.loc 1 206 5 is_stmt 1
 861 047a 4889EF   		movq	%rbp, %rdi
 862 047d E8000000 		call	fclose
 862      00
 863              	.LVL89:
 207:misc.c        **** 
 208:misc.c        ****     end_t = get_wall_time();
 864              		.loc 1 208 5
 865              		.loc 1 208 13 is_stmt 0
 866 0482 31C0     		xorl	%eax, %eax
 867 0484 E8000000 		call	get_wall_time
 867      00
 868              	.LVL90:
 209:misc.c        ****     results(end_t - start_t, height*width, "write_PGM");
 869              		.loc 1 209 5 is_stmt 1
 870 0489 C5FB5C44 		vsubsd	8(%rsp), %xmm0, %xmm0
 870      2408
 871              	.LVL91:
 872 048f BE000000 		movl	$.LC23, %esi
 872      00
 873 0494 4489EF   		movl	%r13d, %edi
 874 0497 E8000000 		call	results
 874      00
 875              	.LVL92:
 210:misc.c        ****     printf("\n");
 876              		.loc 1 210 5
 877 049c BF0A0000 		movl	$10, %edi
 877      00
 878 04a1 E8000000 		call	putchar
 878      00
 879              	.LVL93:
 211:misc.c        ****     return 0;
 880              		.loc 1 211 5
 881              		.loc 1 211 12 is_stmt 0
 882 04a6 31C0     		xorl	%eax, %eax
 883              	.L37:
 212:misc.c        **** }
 884              		.loc 1 212 1
 885 04a8 4883C418 		addq	$24, %rsp
 886              		.cfi_remember_state
 887              		.cfi_def_cfa_offset 40
 888 04ac 5B       		popq	%rbx
 889              		.cfi_def_cfa_offset 32
 890 04ad 5D       		popq	%rbp
 891              		.cfi_def_cfa_offset 24
 892              	.LVL94:
 893 04ae 415C     		popq	%r12
 894              		.cfi_def_cfa_offset 16
 895 04b0 415D     		popq	%r13
 896              		.cfi_def_cfa_offset 8
 897 04b2 C3       		ret
 898              	.LVL95:
 899              	.L40:
 900              		.cfi_restore_state
 194:misc.c        ****         return -1;
 901              		.loc 1 194 9 is_stmt 1
 902 04b3 BF000000 		movl	$.LC20, %edi
 902      00
 903 04b8 E8000000 		call	puts
 903      00
 904              	.LVL96:
 195:misc.c        ****     }
 905              		.loc 1 195 9
 195:misc.c        ****     }
 906              		.loc 1 195 16 is_stmt 0
 907 04bd B8FFFFFF 		movl	$-1, %eax
 907      FF
 908 04c2 EBE4     		jmp	.L37
 909              	.LVL97:
 910              	.L39:
 185:misc.c        ****         exit(-1);
 911              		.loc 1 185 9 is_stmt 1
 912 04c4 BF000000 		movl	$.LC18, %edi
 912      00
 913              	.LVL98:
 914 04c9 E8000000 		call	puts
 914      00
 915              	.LVL99:
 186:misc.c        ****     }
 916              		.loc 1 186 9
 917 04ce 83CFFF   		orl	$-1, %edi
 918 04d1 E8000000 		call	exit
 918      00
 919              	.LVL100:
 920              		.cfi_endproc
 921              	.LFE12:
 923              		.section	.rodata.str1.8
 924 01a3 00000000 		.align 8
 924      00
 925              	.LC24:
 926 01a8 4552524F 		.string	"ERROR: bad format number (3 or 6)"
 926      523A2062 
 926      61642066 
 926      6F726D61 
 926      74206E75 
 927              		.section	.rodata.str1.1
 928              	.LC25:
 929 0038 50257520 		.string	"P%u %u %u 255\n"
 929      25752025 
 929      75203235 
 929      350A00
 930              	.LC26:
 931 0047 25752025 		.string	"%u %u %u\n"
 931      75202575 
 931      0A00
 932              	.LC27:
 933 0051 77726974 		.string	"write_PPM"
 933      655F5050 
 933      4D00
 934              		.text
 935 04d6 662E0F1F 		.p2align 4
 935      84000000 
 935      0000
 936              		.globl	write_PPM
 938              	write_PPM:
 939              	.LFB13:
 213:misc.c        **** //----------------------------------------------------------------------------
 214:misc.c        **** 
 215:misc.c        **** // format: 3 -> ascii  (P3 magic number)
 216:misc.c        **** // format: 6 -> binary (P6 magic number)
 217:misc.c        **** int
 218:misc.c        **** write_PPM(char *filename, image_t * image, int format)
 219:misc.c        **** {
 940              		.loc 1 219 1
 941              		.cfi_startproc
 942              	.LVL101:
 220:misc.c        ****     double start_t, end_t;
 943              		.loc 1 220 5
 221:misc.c        ****     const int height = image->height;
 944              		.loc 1 221 5
 219:misc.c        ****     double start_t, end_t;
 945              		.loc 1 219 1 is_stmt 0
 946 04e0 4156     		pushq	%r14
 947              		.cfi_def_cfa_offset 16
 948              		.cfi_offset 14, -16
 949 04e2 4155     		pushq	%r13
 950              		.cfi_def_cfa_offset 24
 951              		.cfi_offset 13, -24
 952 04e4 4154     		pushq	%r12
 953              		.cfi_def_cfa_offset 32
 954              		.cfi_offset 12, -32
 955 04e6 55       		pushq	%rbp
 956              		.cfi_def_cfa_offset 40
 957              		.cfi_offset 6, -40
 958 04e7 53       		pushq	%rbx
 959              		.cfi_def_cfa_offset 48
 960              		.cfi_offset 3, -48
 961 04e8 4883EC10 		subq	$16, %rsp
 962              		.cfi_def_cfa_offset 64
 222:misc.c        ****     const int width =  image->width;
 223:misc.c        ****     unsigned char * pixels  = image->pixels;
 224:misc.c        **** 
 225:misc.c        ****     if (image->bytes_per_pixel != 3)
 963              		.loc 1 225 8
 964 04ec 837E1003 		cmpl	$3, 16(%rsi)
 221:misc.c        ****     const int width =  image->width;
 965              		.loc 1 221 15
 966 04f0 448B760C 		movl	12(%rsi), %r14d
 967              	.LVL102:
 222:misc.c        ****     const int width =  image->width;
 968              		.loc 1 222 5 is_stmt 1
 222:misc.c        ****     const int width =  image->width;
 969              		.loc 1 222 15 is_stmt 0
 970 04f4 448B6E08 		movl	8(%rsi), %r13d
 971              	.LVL103:
 223:misc.c        **** 
 972              		.loc 1 223 5 is_stmt 1
 223:misc.c        **** 
 973              		.loc 1 223 21 is_stmt 0
 974 04f8 488B2E   		movq	(%rsi), %rbp
 975              	.LVL104:
 976              		.loc 1 225 5 is_stmt 1
 977              		.loc 1 225 8 is_stmt 0
 978 04fb 0F851001 		jne	.L60
 978      0000
 979 0501 4989FC   		movq	%rdi, %r12
 980 0504 89D3     		movl	%edx, %ebx
 226:misc.c        ****     {
 227:misc.c        ****         printf("ERROR: input image has to be RGB or YCbCr\n");
 228:misc.c        ****         exit(-1);
 229:misc.c        ****     }
 230:misc.c        ****     if ((format != 3) && (format != 6))
 981              		.loc 1 230 5 is_stmt 1
 982              		.loc 1 230 8 is_stmt 0
 983 0506 83FA03   		cmpl	$3, %edx
 984 0509 7409     		je	.L43
 985 050b 83FA06   		cmpl	$6, %edx
 986 050e 0F85D600 		jne	.L61
 986      0000
 987              	.L43:
 231:misc.c        ****     {
 232:misc.c        ****         printf("ERROR: bad format number (3 or 6)\n");
 233:misc.c        ****         exit(-1);
 234:misc.c        ****     }
 235:misc.c        **** 
 236:misc.c        ****     start_t = get_wall_time();
 988              		.loc 1 236 5 is_stmt 1
 989              		.loc 1 236 15 is_stmt 0
 990 0514 31C0     		xorl	%eax, %eax
 991 0516 E8000000 		call	get_wall_time
 991      00
 992              	.LVL105:
 237:misc.c        **** 
 238:misc.c        ****     FILE *outfile = fopen(filename, "w");
 993              		.loc 1 238 21
 994 051b 4C89E7   		movq	%r12, %rdi
 995 051e BE000000 		movl	$.LC19, %esi
 995      00
 236:misc.c        **** 
 996              		.loc 1 236 15
 997 0523 C5FB1144 		vmovsd	%xmm0, 8(%rsp)
 997      2408
 998              	.LVL106:
 999              		.loc 1 238 5 is_stmt 1
 1000              		.loc 1 238 21 is_stmt 0
 1001 0529 E8000000 		call	fopen
 1001      00
 1002              	.LVL107:
 1003 052e 4989C4   		movq	%rax, %r12
 1004              	.LVL108:
 239:misc.c        ****     if (!outfile)
 1005              		.loc 1 239 5 is_stmt 1
 1006              		.loc 1 239 8 is_stmt 0
 1007 0531 4885C0   		testq	%rax, %rax
 1008 0534 0F84C600 		je	.L62
 1008      0000
 240:misc.c        ****     {
 241:misc.c        ****         printf("ERROR: no se ha indicado fichero de salida\n");
 242:misc.c        ****         return -1;
 243:misc.c        ****     }
 244:misc.c        **** 
 245:misc.c        ****     /* PPM header */
 246:misc.c        ****     fprintf(outfile, "P%u %u %u 255\n", format, width, height);
 1009              		.loc 1 246 5 is_stmt 1
 1010 053a 4489E9   		movl	%r13d, %ecx
 1011 053d 4889C7   		movq	%rax, %rdi
 1012 0540 4589F0   		movl	%r14d, %r8d
 1013 0543 89DA     		movl	%ebx, %edx
 1014 0545 BE000000 		movl	$.LC25, %esi
 1014      00
 1015 054a 450FAFEE 		imull	%r14d, %r13d
 1016              	.LVL109:
 1017 054e 31C0     		xorl	%eax, %eax
 1018              	.LVL110:
 1019 0550 E8000000 		call	fprintf
 1019      00
 1020              	.LVL111:
 247:misc.c        **** 
 248:misc.c        ****     if (format == 3)
 1021              		.loc 1 248 5
 1022              		.loc 1 248 8 is_stmt 0
 1023 0555 83FB03   		cmpl	$3, %ebx
 1024 0558 7576     		jne	.L46
 1025              	.LVL112:
 1026              	.LBB22:
 249:misc.c        ****     {
 250:misc.c        ****         for (int i = 0; i < height*width; i++)
 1027              		.loc 1 250 25 is_stmt 1
 1028              		.loc 1 250 9 is_stmt 0
 1029 055a 4585ED   		testl	%r13d, %r13d
 1030 055d 7E35     		jle	.L48
 1031 055f 418D45FF 		leal	-1(%r13), %eax
 1032 0563 4889EB   		movq	%rbp, %rbx
 1033              	.LVL113:
 1034 0566 488D0440 		leaq	(%rax,%rax,2), %rax
 1035 056a 488D6C05 		leaq	3(%rbp,%rax), %rbp
 1035      03
 1036              	.LVL114:
 1037 056f 90       		.p2align 4,,10
 1038              		.p2align 3
 1039              	.L49:
 251:misc.c        ****         {
 252:misc.c        ****             fprintf(outfile, "%u %u %u\n",
 1040              		.loc 1 252 13 is_stmt 1 discriminator 3
 1041 0570 0FB64B01 		movzbl	1(%rbx), %ecx
 1042 0574 0FB613   		movzbl	(%rbx), %edx
 1043 0577 BE000000 		movl	$.LC26, %esi
 1043      00
 1044 057c 4C89E7   		movq	%r12, %rdi
 1045 057f 440FB643 		movzbl	2(%rbx), %r8d
 1045      02
 1046 0584 31C0     		xorl	%eax, %eax
 1047 0586 4883C303 		addq	$3, %rbx
 1048 058a E8000000 		call	fprintf
 1048      00
 1049              	.LVL115:
 250:misc.c        ****         {
 1050              		.loc 1 250 43 discriminator 3
 250:misc.c        ****         {
 1051              		.loc 1 250 25 discriminator 3
 250:misc.c        ****         {
 1052              		.loc 1 250 9 is_stmt 0 discriminator 3
 1053 058f 4839DD   		cmpq	%rbx, %rbp
 1054 0592 75DC     		jne	.L49
 1055              	.L48:
 1056              	.LBE22:
 253:misc.c        ****                         pixels[3*i+0],
 254:misc.c        ****                         pixels[3*i+1],
 255:misc.c        ****                         pixels[3*i+2]);
 256:misc.c        ****         }
 257:misc.c        ****     }
 258:misc.c        ****     else
 259:misc.c        ****     {
 260:misc.c        ****         fwrite(pixels, sizeof(unsigned char), 3*height*width, outfile);
 261:misc.c        ****     }
 262:misc.c        ****     fclose(outfile);
 1057              		.loc 1 262 5 is_stmt 1
 1058 0594 4C89E7   		movq	%r12, %rdi
 1059 0597 E8000000 		call	fclose
 1059      00
 1060              	.LVL116:
 263:misc.c        **** 
 264:misc.c        ****     end_t = get_wall_time();
 1061              		.loc 1 264 5
 1062              		.loc 1 264 13 is_stmt 0
 1063 059c 31C0     		xorl	%eax, %eax
 1064 059e E8000000 		call	get_wall_time
 1064      00
 1065              	.LVL117:
 265:misc.c        ****     results(end_t - start_t, height*width, "write_PPM");
 1066              		.loc 1 265 5 is_stmt 1
 1067 05a3 C5FB5C44 		vsubsd	8(%rsp), %xmm0, %xmm0
 1067      2408
 1068              	.LVL118:
 1069 05a9 BE000000 		movl	$.LC27, %esi
 1069      00
 1070 05ae 4489EF   		movl	%r13d, %edi
 1071 05b1 E8000000 		call	results
 1071      00
 1072              	.LVL119:
 266:misc.c        ****     printf("\n");
 1073              		.loc 1 266 5
 1074 05b6 BF0A0000 		movl	$10, %edi
 1074      00
 1075 05bb E8000000 		call	putchar
 1075      00
 1076              	.LVL120:
 267:misc.c        ****     return 0;
 1077              		.loc 1 267 5
 1078              		.loc 1 267 12 is_stmt 0
 1079 05c0 31C0     		xorl	%eax, %eax
 1080              	.L58:
 268:misc.c        **** }
 1081              		.loc 1 268 1
 1082 05c2 4883C410 		addq	$16, %rsp
 1083              		.cfi_remember_state
 1084              		.cfi_def_cfa_offset 48
 1085 05c6 5B       		popq	%rbx
 1086              		.cfi_def_cfa_offset 40
 1087 05c7 5D       		popq	%rbp
 1088              		.cfi_def_cfa_offset 32
 1089 05c8 415C     		popq	%r12
 1090              		.cfi_def_cfa_offset 24
 1091              	.LVL121:
 1092 05ca 415D     		popq	%r13
 1093              		.cfi_def_cfa_offset 16
 1094 05cc 415E     		popq	%r14
 1095              		.cfi_def_cfa_offset 8
 1096              	.LVL122:
 1097 05ce C3       		ret
 1098              	.LVL123:
 1099 05cf 90       		.p2align 4,,10
 1100              		.p2align 3
 1101              	.L46:
 1102              		.cfi_restore_state
 260:misc.c        ****     }
 1103              		.loc 1 260 9 is_stmt 1
 260:misc.c        ****     }
 1104              		.loc 1 260 55 is_stmt 0
 1105 05d0 438D546D 		leal	0(%r13,%r13,2), %edx
 1105      00
 260:misc.c        ****     }
 1106              		.loc 1 260 9
 1107 05d5 4C89E1   		movq	%r12, %rcx
 1108 05d8 BE010000 		movl	$1, %esi
 1108      00
 1109 05dd 4889EF   		movq	%rbp, %rdi
 1110 05e0 4863D2   		movslq	%edx, %rdx
 1111 05e3 E8000000 		call	fwrite
 1111      00
 1112              	.LVL124:
 1113 05e8 EBAA     		jmp	.L48
 1114              	.LVL125:
 1115              	.L61:
 232:misc.c        ****         exit(-1);
 1116              		.loc 1 232 9 is_stmt 1
 1117 05ea BF000000 		movl	$.LC24, %edi
 1117      00
 1118              	.LVL126:
 1119 05ef E8000000 		call	puts
 1119      00
 1120              	.LVL127:
 233:misc.c        ****     }
 1121              		.loc 1 233 9
 1122 05f4 83CFFF   		orl	$-1, %edi
 1123 05f7 E8000000 		call	exit
 1123      00
 1124              	.LVL128:
 1125 05fc 0F1F4000 		.p2align 4,,10
 1126              		.p2align 3
 1127              	.L62:
 241:misc.c        ****         return -1;
 1128              		.loc 1 241 9
 1129 0600 BF000000 		movl	$.LC20, %edi
 1129      00
 1130 0605 E8000000 		call	puts
 1130      00
 1131              	.LVL129:
 242:misc.c        ****     }
 1132              		.loc 1 242 9
 242:misc.c        ****     }
 1133              		.loc 1 242 16 is_stmt 0
 1134 060a B8FFFFFF 		movl	$-1, %eax
 1134      FF
 1135 060f EBB1     		jmp	.L58
 1136              	.LVL130:
 1137              	.L60:
 227:misc.c        ****         exit(-1);
 1138              		.loc 1 227 9 is_stmt 1
 1139 0611 BF000000 		movl	$.LC9, %edi
 1139      00
 1140              	.LVL131:
 1141 0616 E8000000 		call	puts
 1141      00
 1142              	.LVL132:
 228:misc.c        ****     }
 1143              		.loc 1 228 9
 1144 061b 83CFFF   		orl	$-1, %edi
 1145 061e E8000000 		call	exit
 1145      00
 1146              	.LVL133:
 1147              		.cfi_endproc
 1148              	.LFE13:
 1150              		.section	.rodata.str1.1
 1151              	.LC28:
 1152 005b 7200     		.string	"r"
 1153              		.section	.rodata.str1.8
 1154 01ca 00000000 		.align 8
 1154      0000
 1155              	.LC29:
 1156 01d0 4552524F 		.string	"ERROR: no se ha encontrado el fichero %s\n"
 1156      523A206E 
 1156      6F207365 
 1156      20686120 
 1156      656E636F 
 1157 01fa 00000000 		.align 8
 1157      0000
 1158              	.LC30:
 1159 0200 4552524F 		.string	"ERROR: PGM image has no header"
 1159      523A2050 
 1159      474D2069 
 1159      6D616765 
 1159      20686173 
 1160 021f 00       		.align 8
 1161              	.LC31:
 1162 0220 4552524F 		.string	"ERROR: image has different size than expected: %u x %u instead of %u x %u\n"
 1162      523A2069 
 1162      6D616765 
 1162      20686173 
 1162      20646966 
 1163              		.section	.rodata.str1.1
 1164              	.LC32:
 1165 005d 4552524F 		.string	"ERROR: unexpected EOF"
 1165      523A2075 
 1165      6E657870 
 1165      65637465 
 1165      6420454F 
 1166              	.LC33:
 1167 0073 25686875 		.string	"%hhu\n"
 1167      0A00
 1168              	.LC34:
 1169 0079 72656164 		.string	"read_PGM"
 1169      5F50474D 
 1169      00
 1170              		.text
 1171 0623 0F1F0066 		.p2align 4
 1171      2E0F1F84 
 1171      00000000 
 1171      00
 1172              		.globl	read_PGM
 1174              	read_PGM:
 1175              	.LFB14:
 269:misc.c        **** //----------------------------------------------------------------------------
 270:misc.c        **** 
 271:misc.c        **** int
 272:misc.c        **** read_PGM(char *filename, image_t * image)
 273:misc.c        **** {
 1176              		.loc 1 273 1
 1177              		.cfi_startproc
 1178              	.LVL134:
 274:misc.c        ****     double start_t, end_t;
 1179              		.loc 1 274 5
 275:misc.c        ****     int height = 0, width =  0;
 1180              		.loc 1 275 5
 273:misc.c        ****     double start_t, end_t;
 1181              		.loc 1 273 1 is_stmt 0
 1182 0630 4155     		pushq	%r13
 1183              		.cfi_def_cfa_offset 16
 1184              		.cfi_offset 13, -16
 276:misc.c        ****     unsigned char *pixels  = image->pixels;
 277:misc.c        ****     char buf[256] = { 0 };
 1185              		.loc 1 277 10
 1186 0632 C5F9EFC0 		vpxor	%xmm0, %xmm0, %xmm0
 273:misc.c        ****     double start_t, end_t;
 1187              		.loc 1 273 1
 1188 0636 4989FD   		movq	%rdi, %r13
 278:misc.c        **** 
 279:misc.c        ****     start_t = get_wall_time();
 1189              		.loc 1 279 15
 1190 0639 31C0     		xorl	%eax, %eax
 273:misc.c        ****     double start_t, end_t;
 1191              		.loc 1 273 1
 1192 063b 4154     		pushq	%r12
 1193              		.cfi_def_cfa_offset 24
 1194              		.cfi_offset 12, -24
 1195 063d 55       		pushq	%rbp
 1196              		.cfi_def_cfa_offset 32
 1197              		.cfi_offset 6, -32
 1198 063e 53       		pushq	%rbx
 1199              		.cfi_def_cfa_offset 40
 1200              		.cfi_offset 3, -40
 1201 063f 4889F3   		movq	%rsi, %rbx
 1202 0642 4881EC28 		subq	$296, %rsp
 1202      010000
 1203              		.cfi_def_cfa_offset 336
 276:misc.c        ****     unsigned char *pixels  = image->pixels;
 1204              		.loc 1 276 20
 1205 0649 4C8B26   		movq	(%rsi), %r12
 275:misc.c        ****     unsigned char *pixels  = image->pixels;
 1206              		.loc 1 275 9
 1207 064c C7442418 		movl	$0, 24(%rsp)
 1207      00000000 
 275:misc.c        ****     unsigned char *pixels  = image->pixels;
 1208              		.loc 1 275 21
 1209 0654 C744241C 		movl	$0, 28(%rsp)
 1209      00000000 
 276:misc.c        ****     char buf[256] = { 0 };
 1210              		.loc 1 276 5 is_stmt 1
 1211              	.LVL135:
 277:misc.c        **** 
 1212              		.loc 1 277 5
 277:misc.c        **** 
 1213              		.loc 1 277 10 is_stmt 0
 1214 065c C5F82944 		vmovaps	%xmm0, 32(%rsp)
 1214      2420
 1215 0662 C5F82944 		vmovaps	%xmm0, 48(%rsp)
 1215      2430
 1216 0668 C5F82944 		vmovaps	%xmm0, 64(%rsp)
 1216      2440
 1217 066e C5F82944 		vmovaps	%xmm0, 80(%rsp)
 1217      2450
 1218 0674 C5F82944 		vmovaps	%xmm0, 96(%rsp)
 1218      2460
 1219 067a C5F82944 		vmovaps	%xmm0, 112(%rsp)
 1219      2470
 1220 0680 C5F82984 		vmovaps	%xmm0, 128(%rsp)
 1220      24800000 
 1220      00
 1221 0689 C5F82984 		vmovaps	%xmm0, 144(%rsp)
 1221      24900000 
 1221      00
 1222 0692 C5F82984 		vmovaps	%xmm0, 160(%rsp)
 1222      24A00000 
 1222      00
 1223 069b C5F82984 		vmovaps	%xmm0, 176(%rsp)
 1223      24B00000 
 1223      00
 1224 06a4 C5F82984 		vmovaps	%xmm0, 192(%rsp)
 1224      24C00000 
 1224      00
 1225 06ad C5F82984 		vmovaps	%xmm0, 208(%rsp)
 1225      24D00000 
 1225      00
 1226 06b6 C5F82984 		vmovaps	%xmm0, 224(%rsp)
 1226      24E00000 
 1226      00
 1227 06bf C5F82984 		vmovaps	%xmm0, 240(%rsp)
 1227      24F00000 
 1227      00
 1228 06c8 C5F82984 		vmovaps	%xmm0, 256(%rsp)
 1228      24000100 
 1228      00
 1229 06d1 C5F82984 		vmovaps	%xmm0, 272(%rsp)
 1229      24100100 
 1229      00
 1230              		.loc 1 279 5 is_stmt 1
 1231              		.loc 1 279 15 is_stmt 0
 1232 06da E8000000 		call	get_wall_time
 1232      00
 1233              	.LVL136:
 280:misc.c        **** 
 281:misc.c        ****     FILE *infile = fopen(filename, "r");
 1234              		.loc 1 281 20
 1235 06df BE000000 		movl	$.LC28, %esi
 1235      00
 1236 06e4 4C89EF   		movq	%r13, %rdi
 279:misc.c        **** 
 1237              		.loc 1 279 15
 1238 06e7 C5FB1144 		vmovsd	%xmm0, 8(%rsp)
 1238      2408
 1239              	.LVL137:
 1240              		.loc 1 281 5 is_stmt 1
 1241              		.loc 1 281 20 is_stmt 0
 1242 06ed E8000000 		call	fopen
 1242      00
 1243              	.LVL138:
 282:misc.c        ****     if (!infile)
 1244              		.loc 1 282 5 is_stmt 1
 1245              		.loc 1 282 8 is_stmt 0
 1246 06f2 4885C0   		testq	%rax, %rax
 1247 06f5 0F841C01 		je	.L76
 1247      0000
 283:misc.c        ****     {
 284:misc.c        ****         printf("ERROR: no se ha encontrado el fichero %s\n", filename);
 285:misc.c        ****         exit(-1);
 286:misc.c        ****     }
 287:misc.c        ****     
 288:misc.c        ****     /* PGM header */
 289:misc.c        ****     if (fgets(buf, sizeof(buf), infile) == NULL)
 1248              		.loc 1 289 9
 1249 06fb 4889C2   		movq	%rax, %rdx
 1250 06fe BE000100 		movl	$256, %esi
 1250      00
 1251 0703 488D7C24 		leaq	32(%rsp), %rdi
 1251      20
 1252 0708 4889C5   		movq	%rax, %rbp
 1253              		.loc 1 289 5 is_stmt 1
 1254              		.loc 1 289 9 is_stmt 0
 1255 070b E8000000 		call	fgets
 1255      00
 1256              	.LVL139:
 1257              		.loc 1 289 8
 1258 0710 4885C0   		testq	%rax, %rax
 1259 0713 0F84EC00 		je	.L77
 1259      0000
 290:misc.c        ****     {
 291:misc.c        ****         printf("ERROR: PGM image has no header\n");
 292:misc.c        ****         exit(-1);
 293:misc.c        ****     }
 294:misc.c        ****     sscanf(buf, "P2 %u %u 255\n",  &width, &height);
 1260              		.loc 1 294 5 is_stmt 1
 1261 0719 488D5424 		leaq	28(%rsp), %rdx
 1261      1C
 1262 071e BE000000 		movl	$.LC21, %esi
 1262      00
 1263 0723 488D4C24 		leaq	24(%rsp), %rcx
 1263      18
 1264 0728 31C0     		xorl	%eax, %eax
 1265 072a 488D7C24 		leaq	32(%rsp), %rdi
 1265      20
 1266 072f E8000000 		call	__isoc99_sscanf
 1266      00
 1267              	.LVL140:
 295:misc.c        ****     if ((width != image->width) || (height != image->height))
 1268              		.loc 1 295 5
 1269              		.loc 1 295 24 is_stmt 0
 1270 0734 8B5308   		movl	8(%rbx), %edx
 1271              		.loc 1 295 16
 1272 0737 8B74241C 		movl	28(%rsp), %esi
 1273 073b 448B4C24 		movl	24(%rsp), %r9d
 1273      18
 1274              		.loc 1 295 8
 1275 0740 39F2     		cmpl	%esi, %edx
 1276 0742 0F85A000 		jne	.L66
 1276      0000
 1277              		.loc 1 295 33 discriminator 1
 1278 0748 44394B0C 		cmpl	%r9d, 12(%rbx)
 1279 074c 0F859600 		jne	.L66
 1279      0000
 1280              	.LVL141:
 1281              	.LBB23:
 296:misc.c        ****     {
 297:misc.c        ****         printf("ERROR: image has different size than expected: %u x %u instead of %u x %u\n", width
 298:misc.c        ****         exit(-1);
 299:misc.c        ****     }
 300:misc.c        ****     
 301:misc.c        ****     for (int i=0; i < height*width; i++)
 1282              		.loc 1 301 19 is_stmt 1
 1283              		.loc 1 301 29 is_stmt 0
 1284 0752 410FAFD1 		imull	%r9d, %edx
 1285              		.loc 1 301 5
 1286 0756 31DB     		xorl	%ebx, %ebx
 1287              	.LVL142:
 1288 0758 85D2     		testl	%edx, %edx
 1289 075a 7E40     		jle	.L68
 1290              	.LVL143:
 1291 075c 0F1F4000 		.p2align 4,,10
 1292              		.p2align 3
 1293              	.L67:
 302:misc.c        ****     {
 303:misc.c        ****         if (fgets(buf, sizeof(buf), infile) == NULL)
 1294              		.loc 1 303 9 is_stmt 1
 1295              		.loc 1 303 13 is_stmt 0
 1296 0760 4889EA   		movq	%rbp, %rdx
 1297 0763 BE000100 		movl	$256, %esi
 1297      00
 1298 0768 488D7C24 		leaq	32(%rsp), %rdi
 1298      20
 1299 076d E8000000 		call	fgets
 1299      00
 1300              	.LVL144:
 1301              		.loc 1 303 12
 1302 0772 4885C0   		testq	%rax, %rax
 1303 0775 745D     		je	.L78
 304:misc.c        ****         {
 305:misc.c        ****             printf("ERROR: unexpected EOF\n");
 306:misc.c        ****             exit(-1);
 307:misc.c        ****         }
 308:misc.c        ****         sscanf(buf, "%hhu\n", &pixels[i]);
 1304              		.loc 1 308 9 is_stmt 1 discriminator 2
 1305 0777 498D141C 		leaq	(%r12,%rbx), %rdx
 1306 077b BE000000 		movl	$.LC33, %esi
 1306      00
 1307 0780 488D7C24 		leaq	32(%rsp), %rdi
 1307      20
 1308 0785 31C0     		xorl	%eax, %eax
 1309 0787 E8000000 		call	__isoc99_sscanf
 1309      00
 1310              	.LVL145:
 301:misc.c        ****     {
 1311              		.loc 1 301 37 discriminator 2
 301:misc.c        ****     {
 1312              		.loc 1 301 19 discriminator 2
 301:misc.c        ****     {
 1313              		.loc 1 301 29 is_stmt 0 discriminator 2
 1314 078c 8B442418 		movl	24(%rsp), %eax
 1315 0790 0FAF4424 		imull	28(%rsp), %eax
 1315      1C
 1316 0795 48FFC3   		incq	%rbx
 1317              	.LVL146:
 301:misc.c        ****     {
 1318              		.loc 1 301 5 discriminator 2
 1319 0798 39D8     		cmpl	%ebx, %eax
 1320 079a 7FC4     		jg	.L67
 1321              	.L68:
 1322              	.LBE23:
 309:misc.c        ****     }
 310:misc.c        **** 
 311:misc.c        ****     fclose(infile);
 1323              		.loc 1 311 5 is_stmt 1
 1324 079c 4889EF   		movq	%rbp, %rdi
 1325 079f E8000000 		call	fclose
 1325      00
 1326              	.LVL147:
 312:misc.c        **** 
 313:misc.c        ****     end_t = get_wall_time();
 1327              		.loc 1 313 5
 1328              		.loc 1 313 13 is_stmt 0
 1329 07a4 31C0     		xorl	%eax, %eax
 1330 07a6 E8000000 		call	get_wall_time
 1330      00
 1331              	.LVL148:
 314:misc.c        ****     results(end_t - start_t, height*width, "read_PGM");
 1332              		.loc 1 314 5 is_stmt 1
 1333 07ab 8B7C2418 		movl	24(%rsp), %edi
 1334 07af C5FB5C44 		vsubsd	8(%rsp), %xmm0, %xmm0
 1334      2408
 1335              	.LVL149:
 1336 07b5 BE000000 		movl	$.LC34, %esi
 1336      00
 1337 07ba 0FAF7C24 		imull	28(%rsp), %edi
 1337      1C
 1338 07bf E8000000 		call	results
 1338      00
 1339              	.LVL150:
 315:misc.c        ****     return 0;
 1340              		.loc 1 315 5
 316:misc.c        **** }
 1341              		.loc 1 316 1 is_stmt 0
 1342 07c4 4881C428 		addq	$296, %rsp
 1342      010000
 1343              		.cfi_remember_state
 1344              		.cfi_def_cfa_offset 40
 1345 07cb 31C0     		xorl	%eax, %eax
 1346 07cd 5B       		popq	%rbx
 1347              		.cfi_def_cfa_offset 32
 1348 07ce 5D       		popq	%rbp
 1349              		.cfi_def_cfa_offset 24
 1350              	.LVL151:
 1351 07cf 415C     		popq	%r12
 1352              		.cfi_def_cfa_offset 16
 1353              	.LVL152:
 1354 07d1 415D     		popq	%r13
 1355              		.cfi_def_cfa_offset 8
 1356              	.LVL153:
 1357 07d3 C3       		ret
 1358              	.LVL154:
 1359              	.L78:
 1360              		.cfi_restore_state
 1361              	.LBB24:
 305:misc.c        ****             exit(-1);
 1362              		.loc 1 305 13 is_stmt 1
 1363 07d4 BF000000 		movl	$.LC32, %edi
 1363      00
 1364 07d9 E8000000 		call	puts
 1364      00
 1365              	.LVL155:
 306:misc.c        ****         }
 1366              		.loc 1 306 13
 1367 07de BFFFFFFF 		movl	$-1, %edi
 1367      FF
 1368 07e3 E8000000 		call	exit
 1368      00
 1369              	.LVL156:
 1370              	.L66:
 1371              	.LBE24:
 297:misc.c        ****         exit(-1);
 1372              		.loc 1 297 9
 1373 07e8 448B430C 		movl	12(%rbx), %r8d
 1374 07ec 89D1     		movl	%edx, %ecx
 1375 07ee BF000000 		movl	$.LC31, %edi
 1375      00
 1376 07f3 4489CA   		movl	%r9d, %edx
 1377 07f6 31C0     		xorl	%eax, %eax
 1378 07f8 E8000000 		call	printf
 1378      00
 1379              	.LVL157:
 298:misc.c        ****     }
 1380              		.loc 1 298 9
 1381 07fd 83CFFF   		orl	$-1, %edi
 1382 0800 E8000000 		call	exit
 1382      00
 1383              	.LVL158:
 1384              	.L77:
 291:misc.c        ****         exit(-1);
 1385              		.loc 1 291 9
 1386 0805 BF000000 		movl	$.LC30, %edi
 1386      00
 1387 080a E8000000 		call	puts
 1387      00
 1388              	.LVL159:
 292:misc.c        ****     }
 1389              		.loc 1 292 9
 1390 080f 83CFFF   		orl	$-1, %edi
 1391 0812 E8000000 		call	exit
 1391      00
 1392              	.LVL160:
 1393              	.L76:
 284:misc.c        ****         exit(-1);
 1394              		.loc 1 284 9
 1395 0817 BF000000 		movl	$.LC29, %edi
 1395      00
 1396 081c 4C89EE   		movq	%r13, %rsi
 1397 081f 31C0     		xorl	%eax, %eax
 1398              	.LVL161:
 1399 0821 E8000000 		call	printf
 1399      00
 1400              	.LVL162:
 285:misc.c        ****     }
 1401              		.loc 1 285 9
 1402 0826 83CFFF   		orl	$-1, %edi
 1403 0829 E8000000 		call	exit
 1403      00
 1404              	.LVL163:
 1405              		.cfi_endproc
 1406              	.LFE14:
 1408              		.section	.rodata.str1.8
 1409 026b 00000000 		.align 8
 1409      00
 1410              	.LC35:
 1411 0270 4552524F 		.string	"ERROR: PPM image has no header"
 1411      523A2050 
 1411      504D2069 
 1411      6D616765 
 1411      20686173 
 1412 028f 00       		.align 8
 1413              	.LC36:
 1414 0290 4552524F 		.string	"ERROR: image has different format (%u) than expected (%u)\n"
 1414      523A2069 
 1414      6D616765 
 1414      20686173 
 1414      20646966 
 1415              		.section	.rodata.str1.1
 1416              	.LC37:
 1417 0082 72656164 		.string	"read_PPM"
 1417      5F50504D 
 1417      00
 1418              	.LC38:
 1419 008b 25686875 		.string	"%hhu %hhu %hhu\n"
 1419      20256868 
 1419      75202568 
 1419      68750A00 
 1420              		.text
 1421 082e 6690     		.p2align 4
 1422              		.globl	read_PPM
 1424              	read_PPM:
 1425              	.LFB15:
 317:misc.c        **** //----------------------------------------------------------------------------
 318:misc.c        **** 
 319:misc.c        **** // format: 3 -> ascii  (P3 magic number)
 320:misc.c        **** // format: 6 -> binary (P6 magic number)
 321:misc.c        **** int
 322:misc.c        **** read_PPM(char *filename, image_t * image, int format)
 323:misc.c        **** {
 1426              		.loc 1 323 1
 1427              		.cfi_startproc
 1428              	.LVL164:
 324:misc.c        ****     double start_t, end_t;
 1429              		.loc 1 324 5
 325:misc.c        ****     int n = 0, height = 0, width =  0;
 1430              		.loc 1 325 5
 323:misc.c        ****     double start_t, end_t;
 1431              		.loc 1 323 1 is_stmt 0
 1432 0830 4157     		pushq	%r15
 1433              		.cfi_def_cfa_offset 16
 1434              		.cfi_offset 15, -16
 326:misc.c        ****     int img_format = 0;
 327:misc.c        ****     unsigned char *pixels  = image->pixels;
 328:misc.c        ****     char buf[256] = { 0 };
 1435              		.loc 1 328 10
 1436 0832 C5F9EFC0 		vpxor	%xmm0, %xmm0, %xmm0
 329:misc.c        **** 
 330:misc.c        ****     start_t = get_wall_time();
 1437              		.loc 1 330 15
 1438 0836 31C0     		xorl	%eax, %eax
 323:misc.c        ****     double start_t, end_t;
 1439              		.loc 1 323 1
 1440 0838 4189D7   		movl	%edx, %r15d
 1441 083b 4156     		pushq	%r14
 1442              		.cfi_def_cfa_offset 24
 1443              		.cfi_offset 14, -24
 1444 083d 4989FE   		movq	%rdi, %r14
 1445 0840 4155     		pushq	%r13
 1446              		.cfi_def_cfa_offset 32
 1447              		.cfi_offset 13, -32
 1448 0842 4989F5   		movq	%rsi, %r13
 1449 0845 4154     		pushq	%r12
 1450              		.cfi_def_cfa_offset 40
 1451              		.cfi_offset 12, -40
 1452 0847 55       		pushq	%rbp
 1453              		.cfi_def_cfa_offset 48
 1454              		.cfi_offset 6, -48
 1455 0848 53       		pushq	%rbx
 1456              		.cfi_def_cfa_offset 56
 1457              		.cfi_offset 3, -56
 1458 0849 4881EC28 		subq	$296, %rsp
 1458      010000
 1459              		.cfi_def_cfa_offset 352
 327:misc.c        ****     char buf[256] = { 0 };
 1460              		.loc 1 327 20
 1461 0850 488B1E   		movq	(%rsi), %rbx
 325:misc.c        ****     int img_format = 0;
 1462              		.loc 1 325 16
 1463 0853 C7442414 		movl	$0, 20(%rsp)
 1463      00000000 
 325:misc.c        ****     int img_format = 0;
 1464              		.loc 1 325 28
 1465 085b C7442418 		movl	$0, 24(%rsp)
 1465      00000000 
 326:misc.c        ****     unsigned char *pixels  = image->pixels;
 1466              		.loc 1 326 5 is_stmt 1
 326:misc.c        ****     unsigned char *pixels  = image->pixels;
 1467              		.loc 1 326 9 is_stmt 0
 1468 0863 C744241C 		movl	$0, 28(%rsp)
 1468      00000000 
 327:misc.c        ****     char buf[256] = { 0 };
 1469              		.loc 1 327 5 is_stmt 1
 1470              	.LVL165:
 328:misc.c        **** 
 1471              		.loc 1 328 5
 328:misc.c        **** 
 1472              		.loc 1 328 10 is_stmt 0
 1473 086b C5F82944 		vmovaps	%xmm0, 32(%rsp)
 1473      2420
 1474 0871 C5F82944 		vmovaps	%xmm0, 48(%rsp)
 1474      2430
 1475 0877 C5F82944 		vmovaps	%xmm0, 64(%rsp)
 1475      2440
 1476 087d C5F82944 		vmovaps	%xmm0, 80(%rsp)
 1476      2450
 1477 0883 C5F82944 		vmovaps	%xmm0, 96(%rsp)
 1477      2460
 1478 0889 C5F82944 		vmovaps	%xmm0, 112(%rsp)
 1478      2470
 1479 088f C5F82984 		vmovaps	%xmm0, 128(%rsp)
 1479      24800000 
 1479      00
 1480 0898 C5F82984 		vmovaps	%xmm0, 144(%rsp)
 1480      24900000 
 1480      00
 1481 08a1 C5F82984 		vmovaps	%xmm0, 160(%rsp)
 1481      24A00000 
 1481      00
 1482 08aa C5F82984 		vmovaps	%xmm0, 176(%rsp)
 1482      24B00000 
 1482      00
 1483 08b3 C5F82984 		vmovaps	%xmm0, 192(%rsp)
 1483      24C00000 
 1483      00
 1484 08bc C5F82984 		vmovaps	%xmm0, 208(%rsp)
 1484      24D00000 
 1484      00
 1485 08c5 C5F82984 		vmovaps	%xmm0, 224(%rsp)
 1485      24E00000 
 1485      00
 1486 08ce C5F82984 		vmovaps	%xmm0, 240(%rsp)
 1486      24F00000 
 1486      00
 1487 08d7 C5F82984 		vmovaps	%xmm0, 256(%rsp)
 1487      24000100 
 1487      00
 1488 08e0 C5F82984 		vmovaps	%xmm0, 272(%rsp)
 1488      24100100 
 1488      00
 1489              		.loc 1 330 5 is_stmt 1
 1490              		.loc 1 330 15 is_stmt 0
 1491 08e9 E8000000 		call	get_wall_time
 1491      00
 1492              	.LVL166:
 331:misc.c        **** 
 332:misc.c        ****     FILE *infile = fopen(filename, "r");
 1493              		.loc 1 332 20
 1494 08ee BE000000 		movl	$.LC28, %esi
 1494      00
 1495 08f3 4C89F7   		movq	%r14, %rdi
 330:misc.c        **** 
 1496              		.loc 1 330 15
 1497 08f6 C5FB1144 		vmovsd	%xmm0, 8(%rsp)
 1497      2408
 1498              	.LVL167:
 1499              		.loc 1 332 5 is_stmt 1
 1500              		.loc 1 332 20 is_stmt 0
 1501 08fc E8000000 		call	fopen
 1501      00
 1502              	.LVL168:
 333:misc.c        ****     if (!infile)
 1503              		.loc 1 333 5 is_stmt 1
 1504              		.loc 1 333 8 is_stmt 0
 1505 0901 4885C0   		testq	%rax, %rax
 1506 0904 0F847401 		je	.L102
 1506      0000
 1507 090a 4989C4   		movq	%rax, %r12
 334:misc.c        ****     {
 335:misc.c        ****         printf("ERROR: no se ha encontrado el fichero %s\n", filename);
 336:misc.c        ****         exit(-1);
 337:misc.c        ****     }
 338:misc.c        ****     if ((format != 3) && (format != 6))
 1508              		.loc 1 338 5 is_stmt 1
 1509              		.loc 1 338 8 is_stmt 0
 1510 090d 4183FF03 		cmpl	$3, %r15d
 1511 0911 740A     		je	.L81
 1512 0913 4183FF06 		cmpl	$6, %r15d
 1513 0917 0F85A101 		jne	.L103
 1513      0000
 1514              	.L81:
 339:misc.c        ****     {
 340:misc.c        ****         printf("ERROR: bad format number (3 or 6)\n");
 341:misc.c        ****         exit(-1);
 342:misc.c        ****     }
 343:misc.c        ****     
 344:misc.c        ****     /* PPM header */
 345:misc.c        ****     if (fgets(buf, sizeof(buf), infile) == NULL)
 1515              		.loc 1 345 5 is_stmt 1
 1516              		.loc 1 345 9 is_stmt 0
 1517 091d 4C89E2   		movq	%r12, %rdx
 1518 0920 BE000100 		movl	$256, %esi
 1518      00
 1519 0925 488D7C24 		leaq	32(%rsp), %rdi
 1519      20
 1520 092a E8000000 		call	fgets
 1520      00
 1521              	.LVL169:
 1522              		.loc 1 345 8
 1523 092f 4885C0   		testq	%rax, %rax
 1524 0932 0F847401 		je	.L104
 1524      0000
 346:misc.c        ****     {
 347:misc.c        ****         printf("ERROR: PPM image has no header\n");
 348:misc.c        ****         exit(-1);
 349:misc.c        ****     }
 350:misc.c        ****     sscanf(buf, "P%u %u %u 255\n", &img_format, &width, &height);
 1525              		.loc 1 350 5 is_stmt 1
 1526 0938 BE000000 		movl	$.LC25, %esi
 1526      00
 1527 093d 4C8D4424 		leaq	20(%rsp), %r8
 1527      14
 1528 0942 488D4C24 		leaq	24(%rsp), %rcx
 1528      18
 1529 0947 31C0     		xorl	%eax, %eax
 1530 0949 488D5424 		leaq	28(%rsp), %rdx
 1530      1C
 1531 094e 488D7C24 		leaq	32(%rsp), %rdi
 1531      20
 1532 0953 E8000000 		call	__isoc99_sscanf
 1532      00
 1533              	.LVL170:
 351:misc.c        ****     if (img_format != format)
 1534              		.loc 1 351 5
 1535              		.loc 1 351 20 is_stmt 0
 1536 0958 8B74241C 		movl	28(%rsp), %esi
 1537              		.loc 1 351 8
 1538 095c 4439FE   		cmpl	%r15d, %esi
 1539 095f 0F853001 		jne	.L105
 1539      0000
 352:misc.c        ****     {
 353:misc.c        ****         printf("ERROR: image has different format (%u) than expected (%u)\n", img_format, format);
 354:misc.c        ****         exit(-1);
 355:misc.c        ****     }
 356:misc.c        ****     if ((width != image->width) || (height != image->height))
 1540              		.loc 1 356 5 is_stmt 1
 1541              		.loc 1 356 24 is_stmt 0
 1542 0965 418B5508 		movl	8(%r13), %edx
 1543              		.loc 1 356 16
 1544 0969 8B742418 		movl	24(%rsp), %esi
 1545 096d 458B450C 		movl	12(%r13), %r8d
 1546 0971 448B4C24 		movl	20(%rsp), %r9d
 1546      14
 1547              		.loc 1 356 8
 1548 0976 39F2     		cmpl	%esi, %edx
 1549 0978 0F85E700 		jne	.L84
 1549      0000
 1550              		.loc 1 356 33 discriminator 1
 1551 097e 4539C1   		cmpl	%r8d, %r9d
 1552 0981 0F85DE00 		jne	.L84
 1552      0000
 357:misc.c        ****     {
 358:misc.c        ****         printf("ERROR: image has different size than expected: %u x %u instead of %u x %u\n", width
 359:misc.c        ****         exit(-1);
 360:misc.c        ****     }
 361:misc.c        ****     
 362:misc.c        ****     if (format == 3)
 1553              		.loc 1 362 5 is_stmt 1
 1554 0987 410FAFD1 		imull	%r9d, %edx
 1555              		.loc 1 362 8 is_stmt 0
 1556 098b 4183FF03 		cmpl	$3, %r15d
 1557 098f 0F859B00 		jne	.L86
 1557      0000
 1558              	.LVL171:
 1559              	.LBB25:
 363:misc.c        ****     {
 364:misc.c        ****         for (int i=0; i<height*width; i++)
 1560              		.loc 1 364 23 is_stmt 1
 1561              		.loc 1 364 18 is_stmt 0
 1562 0995 31ED     		xorl	%ebp, %ebp
 1563              		.loc 1 364 9
 1564 0997 85D2     		testl	%edx, %edx
 1565 0999 7E4F     		jle	.L91
 1566              	.LVL172:
 1567 099b 0F1F4400 		.p2align 4,,10
 1567      00
 1568              		.p2align 3
 1569              	.L90:
 365:misc.c        ****         {
 366:misc.c        ****             if (fgets(buf, sizeof(buf), infile) == NULL)
 1570              		.loc 1 366 13 is_stmt 1
 1571              		.loc 1 366 17 is_stmt 0
 1572 09a0 4C89E2   		movq	%r12, %rdx
 1573 09a3 BE000100 		movl	$256, %esi
 1573      00
 1574 09a8 488D7C24 		leaq	32(%rsp), %rdi
 1574      20
 1575 09ad E8000000 		call	fgets
 1575      00
 1576              	.LVL173:
 1577              		.loc 1 366 16
 1578 09b2 4885C0   		testq	%rax, %rax
 1579 09b5 0F849600 		je	.L106
 1579      0000
 367:misc.c        ****             {
 368:misc.c        ****                 printf("ERROR: unexpected EOF\n");
 369:misc.c        ****                 exit(-1);
 370:misc.c        ****             }
 371:misc.c        ****             sscanf(buf, "%hhu %hhu %hhu\n",
 1580              		.loc 1 371 13 is_stmt 1 discriminator 2
 1581 09bb 488D4B01 		leaq	1(%rbx), %rcx
 1582 09bf 4C8D4302 		leaq	2(%rbx), %r8
 1583 09c3 4889DA   		movq	%rbx, %rdx
 1584 09c6 BE000000 		movl	$.LC38, %esi
 1584      00
 1585 09cb 488D7C24 		leaq	32(%rsp), %rdi
 1585      20
 1586 09d0 31C0     		xorl	%eax, %eax
 364:misc.c        ****         {
 1587              		.loc 1 364 40 is_stmt 0 discriminator 2
 1588 09d2 FFC5     		incl	%ebp
 1589              	.LVL174:
 1590 09d4 4883C303 		addq	$3, %rbx
 1591              		.loc 1 371 13 discriminator 2
 1592 09d8 E8000000 		call	__isoc99_sscanf
 1592      00
 1593              	.LVL175:
 364:misc.c        ****         {
 1594              		.loc 1 364 39 is_stmt 1 discriminator 2
 364:misc.c        ****         {
 1595              		.loc 1 364 23 discriminator 2
 364:misc.c        ****         {
 1596              		.loc 1 364 31 is_stmt 0 discriminator 2
 1597 09dd 8B442414 		movl	20(%rsp), %eax
 1598 09e1 0FAF4424 		imull	24(%rsp), %eax
 1598      18
 364:misc.c        ****         {
 1599              		.loc 1 364 9 discriminator 2
 1600 09e6 39E8     		cmpl	%ebp, %eax
 1601 09e8 7FB6     		jg	.L90
 1602              	.LVL176:
 1603              	.L91:
 1604              	.LBE25:
 372:misc.c        ****                     &pixels[3*i+0],
 373:misc.c        ****                     &pixels[3*i+1],
 374:misc.c        ****                     &pixels[3*i+2]);
 375:misc.c        ****         }
 376:misc.c        ****     }
 377:misc.c        ****     else
 378:misc.c        ****     {
 379:misc.c        ****         n = fread(pixels, sizeof(unsigned char), 3*height*width, infile);
 380:misc.c        ****         if (n == 0) return -1;
 381:misc.c        ****     }
 382:misc.c        **** 
 383:misc.c        ****     fclose(infile);
 1605              		.loc 1 383 5 is_stmt 1
 1606 09ea 4C89E7   		movq	%r12, %rdi
 1607 09ed E8000000 		call	fclose
 1607      00
 1608              	.LVL177:
 384:misc.c        **** 
 385:misc.c        ****     end_t = get_wall_time();
 1609              		.loc 1 385 5
 1610              		.loc 1 385 13 is_stmt 0
 1611 09f2 31C0     		xorl	%eax, %eax
 1612 09f4 E8000000 		call	get_wall_time
 1612      00
 1613              	.LVL178:
 386:misc.c        ****     results(end_t - start_t, height*width, "read_PPM");
 1614              		.loc 1 386 5 is_stmt 1
 1615 09f9 8B7C2414 		movl	20(%rsp), %edi
 1616 09fd C5FB5C44 		vsubsd	8(%rsp), %xmm0, %xmm0
 1616      2408
 1617              	.LVL179:
 1618 0a03 BE000000 		movl	$.LC37, %esi
 1618      00
 1619 0a08 0FAF7C24 		imull	24(%rsp), %edi
 1619      18
 1620 0a0d E8000000 		call	results
 1620      00
 1621              	.LVL180:
 387:misc.c        ****     return 0;
 1622              		.loc 1 387 5
 1623              		.loc 1 387 12 is_stmt 0
 1624 0a12 31C0     		xorl	%eax, %eax
 1625              	.L100:
 388:misc.c        **** }
 1626              		.loc 1 388 1
 1627 0a14 4881C428 		addq	$296, %rsp
 1627      010000
 1628              		.cfi_remember_state
 1629              		.cfi_def_cfa_offset 56
 1630 0a1b 5B       		popq	%rbx
 1631              		.cfi_def_cfa_offset 48
 1632 0a1c 5D       		popq	%rbp
 1633              		.cfi_def_cfa_offset 40
 1634 0a1d 415C     		popq	%r12
 1635              		.cfi_def_cfa_offset 32
 1636              	.LVL181:
 1637 0a1f 415D     		popq	%r13
 1638              		.cfi_def_cfa_offset 24
 1639              	.LVL182:
 1640 0a21 415E     		popq	%r14
 1641              		.cfi_def_cfa_offset 16
 1642              	.LVL183:
 1643 0a23 415F     		popq	%r15
 1644              		.cfi_def_cfa_offset 8
 1645              	.LVL184:
 1646 0a25 C3       		ret
 1647              	.LVL185:
 1648 0a26 662E0F1F 		.p2align 4,,10
 1648      84000000 
 1648      0000
 1649              		.p2align 3
 1650              	.L86:
 1651              		.cfi_restore_state
 379:misc.c        ****         if (n == 0) return -1;
 1652              		.loc 1 379 9 is_stmt 1
 379:misc.c        ****         if (n == 0) return -1;
 1653              		.loc 1 379 58 is_stmt 0
 1654 0a30 8D1452   		leal	(%rdx,%rdx,2), %edx
 379:misc.c        ****         if (n == 0) return -1;
 1655              		.loc 1 379 13
 1656 0a33 4C89E1   		movq	%r12, %rcx
 1657 0a36 BE010000 		movl	$1, %esi
 1657      00
 1658 0a3b 4889DF   		movq	%rbx, %rdi
 1659 0a3e 4863D2   		movslq	%edx, %rdx
 1660 0a41 E8000000 		call	fread
 1660      00
 1661              	.LVL186:
 380:misc.c        ****     }
 1662              		.loc 1 380 9 is_stmt 1
 380:misc.c        ****     }
 1663              		.loc 1 380 12 is_stmt 0
 1664 0a46 85C0     		testl	%eax, %eax
 1665 0a48 75A0     		jne	.L91
 380:misc.c        ****     }
 1666              		.loc 1 380 28
 1667 0a4a B8FFFFFF 		movl	$-1, %eax
 1667      FF
 1668              	.LVL187:
 1669 0a4f EBC3     		jmp	.L100
 1670              	.LVL188:
 1671              	.L106:
 1672              	.LBB26:
 368:misc.c        ****                 exit(-1);
 1673              		.loc 1 368 17 is_stmt 1
 1674 0a51 BF000000 		movl	$.LC32, %edi
 1674      00
 1675 0a56 E8000000 		call	puts
 1675      00
 1676              	.LVL189:
 369:misc.c        ****             }
 1677              		.loc 1 369 17
 1678 0a5b BFFFFFFF 		movl	$-1, %edi
 1678      FF
 1679 0a60 E8000000 		call	exit
 1679      00
 1680              	.LVL190:
 1681              	.L84:
 1682              	.LBE26:
 358:misc.c        ****         exit(-1);
 1683              		.loc 1 358 9
 1684 0a65 89D1     		movl	%edx, %ecx
 1685 0a67 BF000000 		movl	$.LC31, %edi
 1685      00
 1686 0a6c 4489CA   		movl	%r9d, %edx
 1687 0a6f 31C0     		xorl	%eax, %eax
 1688 0a71 E8000000 		call	printf
 1688      00
 1689              	.LVL191:
 359:misc.c        ****     }
 1690              		.loc 1 359 9
 1691 0a76 83CFFF   		orl	$-1, %edi
 1692 0a79 E8000000 		call	exit
 1692      00
 1693              	.LVL192:
 1694              	.L102:
 335:misc.c        ****         exit(-1);
 1695              		.loc 1 335 9
 1696 0a7e BF000000 		movl	$.LC29, %edi
 1696      00
 1697 0a83 4C89F6   		movq	%r14, %rsi
 1698 0a86 31C0     		xorl	%eax, %eax
 1699              	.LVL193:
 1700 0a88 E8000000 		call	printf
 1700      00
 1701              	.LVL194:
 336:misc.c        ****     }
 1702              		.loc 1 336 9
 1703 0a8d 83CFFF   		orl	$-1, %edi
 1704 0a90 E8000000 		call	exit
 1704      00
 1705              	.LVL195:
 1706              	.L105:
 353:misc.c        ****         exit(-1);
 1707              		.loc 1 353 9
 1708 0a95 BF000000 		movl	$.LC36, %edi
 1708      00
 1709 0a9a 4489FA   		movl	%r15d, %edx
 1710 0a9d 31C0     		xorl	%eax, %eax
 1711 0a9f E8000000 		call	printf
 1711      00
 1712              	.LVL196:
 354:misc.c        ****     }
 1713              		.loc 1 354 9
 1714 0aa4 83CFFF   		orl	$-1, %edi
 1715 0aa7 E8000000 		call	exit
 1715      00
 1716              	.LVL197:
 1717              	.L104:
 347:misc.c        ****         exit(-1);
 1718              		.loc 1 347 9
 1719 0aac BF000000 		movl	$.LC35, %edi
 1719      00
 1720 0ab1 E8000000 		call	puts
 1720      00
 1721              	.LVL198:
 348:misc.c        ****     }
 1722              		.loc 1 348 9
 1723 0ab6 83CFFF   		orl	$-1, %edi
 1724 0ab9 E8000000 		call	exit
 1724      00
 1725              	.LVL199:
 1726              	.L103:
 340:misc.c        ****         exit(-1);
 1727              		.loc 1 340 9
 1728 0abe BF000000 		movl	$.LC24, %edi
 1728      00
 1729 0ac3 E8000000 		call	puts
 1729      00
 1730              	.LVL200:
 341:misc.c        ****     }
 1731              		.loc 1 341 9
 1732 0ac8 83CFFF   		orl	$-1, %edi
 1733 0acb E8000000 		call	exit
 1733      00
 1734              	.LVL201:
 1735              		.cfi_endproc
 1736              	.LFE15:
 1738              		.section	.rodata.cst8,"aM",@progbits,8
 1739              		.align 8
 1740              	.LC0:
 1741 0000 8DEDB5A0 		.long	2696277389
 1742 0004 F7C6B03E 		.long	1051772663
 1743              		.align 8
 1744              	.LC1:
 1745 0008 00000000 		.long	0
 1746 000c 80842E41 		.long	1093567616
 1747              		.align 8
 1748              	.LC2:
 1749 0010 00000000 		.long	0
 1750 0014 65CDCD41 		.long	1104006501
 1751              		.align 8
 1752              	.LC3:
 1753 0018 00000000 		.long	0
 1754 001c 00408F40 		.long	1083129856
 1755              		.align 8
 1756              	.LC4:
 1757 0020 00000000 		.long	0
 1758 0024 00002440 		.long	1076101120
 1759              		.align 8
 1760              	.LC10:
 1761 0028 00000000 		.long	0
 1762 002c 00005940 		.long	1079574528
 1763              		.align 8
 1764              	.LC15:
 1765 0030 00000000 		.long	0
 1766 0034 0088C340 		.long	1086556160
 1767              		.text
 1768              	.Letext0:
 1769              		.file 2 "/usr/local/gcc/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/stddef.h"
 1770              		.file 3 "/usr/include/bits/types.h"
 1771              		.file 4 "/usr/include/stdio.h"
 1772              		.file 5 "/usr/include/libio.h"
 1773              		.file 6 "/usr/include/time.h"
 1774              		.file 7 "/usr/include/bits/time.h"
 1775              		.file 8 "/usr/include/malloc.h"
 1776              		.file 9 "jpeg_handler.h"
 1777              		.file 10 "/usr/include/stdlib.h"
 1778              		.file 11 "<interno>"
 1779              		.file 12 "/usr/include/sys/time.h"
 1780              		.file 13 "include/jpeglib.h"
