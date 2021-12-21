Ensamblador de GNU versi髇 2.27 (x86_64-redhat-linux)
	 utilizando BFD versi髇 version 2.27-34.base.el7.
 opciones pasadas	: --64 -adghln=assembler/RGB2YCbCr.gcc.s 
 fich entrada  	: /tmp/ccBtFdOu.s
 fich salida   	: RGB2YCbCr.o
 objetivo      	: x86_64-redhat-linux-gnu
 marca tiempo  	: 2020-03-31T19:43:51.000+0200

   1              		.file	"RGB2YCbCr.c"
   2              		.text
   3              	.Ltext0:
   4              		.section	.rodata.str1.8,"aMS",@progbits,1
   5              		.align 8
   6              	.LC0:
   7 0000 4552524F 		.string	"ERROR: input image has to be RGB"
   7      523A2069 
   7      6E707574 
   7      20696D61 
   7      67652068 
   8              		.section	.rodata.str1.1,"aMS",@progbits,1
   9              	.LC11:
  10 0000 52474232 		.string	"RGB2YCbCr_roundf0"
  10      59436243 
  10      725F726F 
  10      756E6466 
  10      3000
  11              		.text
  12              		.p2align 4
  13              		.globl	RGB2YCbCr_roundf0
  15              	RGB2YCbCr_roundf0:
  16              	.LFB14:
  17              		.file 1 "RGB2YCbCr.c"
   1:RGB2YCbCr.c   **** /* Conversi贸n de imagen RGB a YCbCr
   2:RGB2YCbCr.c   ****  * (implementaciones varias para evaluar su rendimiento) */
   3:RGB2YCbCr.c   **** 
   4:RGB2YCbCr.c   **** /* https://en.wikipedia.org/wiki/YCbCr#JPEG_conversion
   5:RGB2YCbCr.c   ****  */
   6:RGB2YCbCr.c   **** 
   7:RGB2YCbCr.c   **** /* Jes煤s Alastruey Bened茅
   8:RGB2YCbCr.c   ****  * v2.0, 12-marzo-2020
   9:RGB2YCbCr.c   ****  */
  10:RGB2YCbCr.c   **** 
  11:RGB2YCbCr.c   **** #define _POSIX_C_SOURCE 200112L     /* para evitar el aviso al compilar
  12:RGB2YCbCr.c   ****                                        con la funci贸n posix_memalign() */
  13:RGB2YCbCr.c   **** #include <stdio.h>
  14:RGB2YCbCr.c   **** #include <stdlib.h>
  15:RGB2YCbCr.c   **** #include <time.h>
  16:RGB2YCbCr.c   **** #include <sys/time.h>
  17:RGB2YCbCr.c   **** #include <sys/times.h>
  18:RGB2YCbCr.c   **** #include <malloc.h>
  19:RGB2YCbCr.c   **** #include <math.h>
  20:RGB2YCbCr.c   **** #include "jpeg_handler.h"
  21:RGB2YCbCr.c   **** #include "include/jpeglib.h"
  22:RGB2YCbCr.c   **** #include "RGB2YCbCr.h"
  23:RGB2YCbCr.c   **** #include "misc.h"
  24:RGB2YCbCr.c   **** 
  25:RGB2YCbCr.c   **** 
  26:RGB2YCbCr.c   **** int dummy(image_t *im1, image_t *im2);
  27:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
  28:RGB2YCbCr.c   **** 
  29:RGB2YCbCr.c   **** /* factores y desplazamientos para conversi贸n RGB -> YCbCr */
  30:RGB2YCbCr.c   **** static const float
  31:RGB2YCbCr.c   **** RGB2YCbCr[3][3] = {
  32:RGB2YCbCr.c   ****    { 0.299,     0.587,     0.114    },
  33:RGB2YCbCr.c   ****    {-0.168736, -0.331264,  0.500    },
  34:RGB2YCbCr.c   ****    { 0.500,    -0.418688, -0.081312 }
  35:RGB2YCbCr.c   **** };
  36:RGB2YCbCr.c   **** static const float
  37:RGB2YCbCr.c   **** RGB2YCbCr_offset[3] = { 0.0,  128.0,  128.0 };
  38:RGB2YCbCr.c   **** 
  39:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
  40:RGB2YCbCr.c   **** 
  41:RGB2YCbCr.c   **** void
  42:RGB2YCbCr.c   **** RGB2YCbCr_roundf0(image_t * image_in, image_t * image_out)
  43:RGB2YCbCr.c   **** {
  18              		.loc 1 43 1
  19              		.cfi_startproc
  20              	.LVL0:
  44:RGB2YCbCr.c   ****     double start_t, end_t;
  21              		.loc 1 44 5
  45:RGB2YCbCr.c   ****     const int height = image_in->height;
  22              		.loc 1 45 5
  43:RGB2YCbCr.c   ****     double start_t, end_t;
  23              		.loc 1 43 1 is_stmt 0
  24 0000 4157     		pushq	%r15
  25              		.cfi_def_cfa_offset 16
  26              		.cfi_offset 15, -16
  27 0002 4156     		pushq	%r14
  28              		.cfi_def_cfa_offset 24
  29              		.cfi_offset 14, -24
  30 0004 4155     		pushq	%r13
  31              		.cfi_def_cfa_offset 32
  32              		.cfi_offset 13, -32
  33 0006 4154     		pushq	%r12
  34              		.cfi_def_cfa_offset 40
  35              		.cfi_offset 12, -40
  36 0008 55       		pushq	%rbp
  37              		.cfi_def_cfa_offset 48
  38              		.cfi_offset 6, -48
  39 0009 53       		pushq	%rbx
  40              		.cfi_def_cfa_offset 56
  41              		.cfi_offset 3, -56
  42 000a 4883EC18 		subq	$24, %rsp
  43              		.cfi_def_cfa_offset 80
  46:RGB2YCbCr.c   ****     const int width =  image_in->width;
  47:RGB2YCbCr.c   **** 
  48:RGB2YCbCr.c   ****     if (image_in->bytes_per_pixel != 3)
  44              		.loc 1 48 8
  45 000e 837F1003 		cmpl	$3, 16(%rdi)
  45:RGB2YCbCr.c   ****     const int width =  image_in->width;
  46              		.loc 1 45 15
  47 0012 448B7F0C 		movl	12(%rdi), %r15d
  48              	.LVL1:
  46:RGB2YCbCr.c   ****     const int width =  image_in->width;
  49              		.loc 1 46 5 is_stmt 1
  46:RGB2YCbCr.c   ****     const int width =  image_in->width;
  50              		.loc 1 46 15 is_stmt 0
  51 0016 8B5F08   		movl	8(%rdi), %ebx
  52              	.LVL2:
  53              		.loc 1 48 5 is_stmt 1
  54              		.loc 1 48 8 is_stmt 0
  55 0019 0F85AE01 		jne	.L11
  55      0000
  49:RGB2YCbCr.c   ****     {
  50:RGB2YCbCr.c   ****         printf("ERROR: input image has to be RGB\n");
  51:RGB2YCbCr.c   ****         exit(-1);
  52:RGB2YCbCr.c   ****     }
  53:RGB2YCbCr.c   ****     
  54:RGB2YCbCr.c   ****     /* fill struct fields */
  55:RGB2YCbCr.c   ****     image_out->width  = width;
  56:RGB2YCbCr.c   ****     image_out->height = height;
  56              		.loc 1 56 23
  57 001f 44897E0C 		movl	%r15d, 12(%rsi)
  58              	.LBB2:
  59              	.LBB3:
  57:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
  58:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
  59:RGB2YCbCr.c   **** 
  60:RGB2YCbCr.c   ****     start_t = get_wall_time();
  61:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
  62:RGB2YCbCr.c   ****     {
  63:RGB2YCbCr.c   ****         for (int i = 0; i < height*width; i++)
  60              		.loc 1 63 35
  61 0023 440FAFFB 		imull	%ebx, %r15d
  62              	.LVL3:
  63 0027 4989FC   		movq	%rdi, %r12
  64 002a 4889F5   		movq	%rsi, %rbp
  65              	.LBE3:
  66              	.LBE2:
  55:RGB2YCbCr.c   ****     image_out->height = height;
  67              		.loc 1 55 5 is_stmt 1
  57:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
  68              		.loc 1 57 32 is_stmt 0
  69 002d 48B80300 		movabsq	$12884901891, %rax
  69      00000300 
  69      0000
  55:RGB2YCbCr.c   ****     image_out->height = height;
  70              		.loc 1 55 23
  71 0037 895E08   		movl	%ebx, 8(%rsi)
  56:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
  72              		.loc 1 56 5 is_stmt 1
  57:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
  73              		.loc 1 57 5
  58:RGB2YCbCr.c   **** 
  74              		.loc 1 58 5
  75              	.LBB6:
  76              	.LBB4:
  77              		.loc 1 63 35 is_stmt 0
  78 003a 41BE0A00 		movl	$10, %r14d
  78      0000
  79              	.LBE4:
  80              	.LBE6:
  57:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
  81              		.loc 1 57 32
  82 0040 48894610 		movq	%rax, 16(%rsi)
  60:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
  83              		.loc 1 60 5 is_stmt 1
  60:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
  84              		.loc 1 60 15 is_stmt 0
  85 0044 31C0     		xorl	%eax, %eax
  86 0046 E8000000 		call	get_wall_time
  86      00
  87              	.LVL4:
  88 004b 418D47FF 		leal	-1(%r15), %eax
  89 004f C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
  90 0053 C5FB1144 		vmovsd	%xmm0, 8(%rsp)
  90      2408
  91              	.LVL5:
  61:RGB2YCbCr.c   ****     {
  92              		.loc 1 61 5 is_stmt 1
  93              	.LBB7:
  61:RGB2YCbCr.c   ****     {
  94              		.loc 1 61 10
  61:RGB2YCbCr.c   ****     {
  95              		.loc 1 61 22
  96 0059 4C8D6C40 		leaq	3(%rax,%rax,2), %r13
  96      03
  97              	.LVL6:
  98 005e 6690     		.p2align 4,,10
  99              		.p2align 3
 100              	.L3:
 101              	.LBB5:
 102              		.loc 1 63 25
 103              		.loc 1 63 9 is_stmt 0
 104 0060 31DB     		xorl	%ebx, %ebx
 105 0062 4585FF   		testl	%r15d, %r15d
 106 0065 0F8E2201 		jle	.L6
 106      0000
 107              	.LVL7:
 108 006b 0F1F4400 		.p2align 4,,10
 108      00
 109              		.p2align 3
 110              	.L4:
  64:RGB2YCbCr.c   ****         {
  65:RGB2YCbCr.c   ****             /* Y */
  66:RGB2YCbCr.c   ****             image_out->pixels[3*i + 0] = roundf(
 111              		.loc 1 66 13 is_stmt 1 discriminator 3
  67:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
  68:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*image_in->pixels[3*i + 0] + 
 112              		.loc 1 68 17 is_stmt 0 discriminator 3
 113 0070 498B1424 		movq	(%r12), %rdx
  67:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 114              		.loc 1 67 37 discriminator 3
 115 0074 C5E057DB 		vxorps	%xmm3, %xmm3, %xmm3
 116              		.loc 1 68 49 discriminator 3
 117 0078 0FB6041A 		movzbl	(%rdx,%rbx), %eax
 118              		.loc 1 68 32 discriminator 3
 119 007c C5F22AC0 		vcvtsi2ssl	%eax, %xmm1, %xmm0
 120 0080 C5FA5905 		vmulss	.LC1(%rip), %xmm0, %xmm0
 120      00000000 
  69:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*image_in->pixels[3*i + 1] + 
 121              		.loc 1 69 49 discriminator 3
 122 0088 0FB6441A 		movzbl	1(%rdx,%rbx), %eax
 122      01
 123              		.loc 1 69 32 discriminator 3
 124 008d C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 125 0091 C5EA5915 		vmulss	.LC3(%rip), %xmm2, %xmm2
 125      00000000 
  70:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*image_in->pixels[3*i + 2]);
 126              		.loc 1 70 49 discriminator 3
 127 0099 0FB6441A 		movzbl	2(%rdx,%rbx), %eax
 127      02
  67:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 128              		.loc 1 67 37 discriminator 3
 129 009e C5FA58C3 		vaddss	%xmm3, %xmm0, %xmm0
  68:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*image_in->pixels[3*i + 1] + 
 130              		.loc 1 68 59 discriminator 3
 131 00a2 C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 132              		.loc 1 70 32 discriminator 3
 133 00a6 C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 134 00aa C5EA5915 		vmulss	.LC4(%rip), %xmm2, %xmm2
 134      00000000 
  66:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 135              		.loc 1 66 42 discriminator 3
 136 00b2 C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 137 00b6 E8000000 		call	roundf
 137      00
 138              	.LVL8:
  66:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 139              		.loc 1 66 40 discriminator 3
 140 00bb 488B5500 		movq	0(%rbp), %rdx
  71:RGB2YCbCr.c   ****             /* Cb */
  72:RGB2YCbCr.c   ****             image_out->pixels[3*i + 1] = roundf(
  73:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
  74:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*image_in->pixels[3*i + 0] + 
 141              		.loc 1 74 32 discriminator 3
 142 00bf C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
  66:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 143              		.loc 1 66 40 discriminator 3
 144 00c3 C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 145 00c7 88041A   		movb	%al, (%rdx,%rbx)
  72:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 146              		.loc 1 72 13 is_stmt 1 discriminator 3
 147              		.loc 1 74 17 is_stmt 0 discriminator 3
 148 00ca 498B1424 		movq	(%r12), %rdx
 149              		.loc 1 74 49 discriminator 3
 150 00ce 0FB6041A 		movzbl	(%rdx,%rbx), %eax
 151              		.loc 1 74 32 discriminator 3
 152 00d2 C5F22AC0 		vcvtsi2ssl	%eax, %xmm1, %xmm0
  75:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*image_in->pixels[3*i + 1] + 
 153              		.loc 1 75 49 discriminator 3
 154 00d6 0FB6441A 		movzbl	1(%rdx,%rbx), %eax
 154      01
  74:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*image_in->pixels[3*i + 1] + 
 155              		.loc 1 74 32 discriminator 3
 156 00db C5FA5905 		vmulss	.LC5(%rip), %xmm0, %xmm0
 156      00000000 
  73:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*image_in->pixels[3*i + 0] + 
 157              		.loc 1 73 37 discriminator 3
 158 00e3 C5FA5805 		vaddss	.LC6(%rip), %xmm0, %xmm0
 158      00000000 
 159              		.loc 1 75 32 discriminator 3
 160 00eb C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 161 00ef C5EA5915 		vmulss	.LC7(%rip), %xmm2, %xmm2
 161      00000000 
  76:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*image_in->pixels[3*i + 2]);
 162              		.loc 1 76 49 discriminator 3
 163 00f7 0FB6441A 		movzbl	2(%rdx,%rbx), %eax
 163      02
  74:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*image_in->pixels[3*i + 1] + 
 164              		.loc 1 74 59 discriminator 3
 165 00fc C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 166              		.loc 1 76 32 discriminator 3
 167 0100 C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 168 0104 C5EA5915 		vmulss	.LC8(%rip), %xmm2, %xmm2
 168      00000000 
  72:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 169              		.loc 1 72 42 discriminator 3
 170 010c C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 171 0110 E8000000 		call	roundf
 171      00
 172              	.LVL9:
  72:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 173              		.loc 1 72 40 discriminator 3
 174 0115 488B5500 		movq	0(%rbp), %rdx
  77:RGB2YCbCr.c   ****             /* Cr */
  78:RGB2YCbCr.c   ****             image_out->pixels[3*i + 2] = roundf(
  79:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
  80:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*image_in->pixels[3*i + 0] + 
 175              		.loc 1 80 32 discriminator 3
 176 0119 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
  72:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 177              		.loc 1 72 40 discriminator 3
 178 011d C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 179 0121 88441A01 		movb	%al, 1(%rdx,%rbx)
  78:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 180              		.loc 1 78 13 is_stmt 1 discriminator 3
 181              		.loc 1 80 17 is_stmt 0 discriminator 3
 182 0125 498B1424 		movq	(%r12), %rdx
 183              		.loc 1 80 49 discriminator 3
 184 0129 0FB6041A 		movzbl	(%rdx,%rbx), %eax
 185              		.loc 1 80 32 discriminator 3
 186 012d C5F22AC0 		vcvtsi2ssl	%eax, %xmm1, %xmm0
  81:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*image_in->pixels[3*i + 1] + 
 187              		.loc 1 81 49 discriminator 3
 188 0131 0FB6441A 		movzbl	1(%rdx,%rbx), %eax
 188      01
  80:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*image_in->pixels[3*i + 1] + 
 189              		.loc 1 80 32 discriminator 3
 190 0136 C5FA5905 		vmulss	.LC8(%rip), %xmm0, %xmm0
 190      00000000 
  79:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*image_in->pixels[3*i + 0] + 
 191              		.loc 1 79 37 discriminator 3
 192 013e C5FA5805 		vaddss	.LC6(%rip), %xmm0, %xmm0
 192      00000000 
 193              		.loc 1 81 32 discriminator 3
 194 0146 C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 195 014a C5EA5915 		vmulss	.LC9(%rip), %xmm2, %xmm2
 195      00000000 
  82:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*image_in->pixels[3*i + 2]);
 196              		.loc 1 82 49 discriminator 3
 197 0152 0FB6441A 		movzbl	2(%rdx,%rbx), %eax
 197      02
  80:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*image_in->pixels[3*i + 1] + 
 198              		.loc 1 80 59 discriminator 3
 199 0157 C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 200              		.loc 1 82 32 discriminator 3
 201 015b C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 202 015f C5EA5915 		vmulss	.LC10(%rip), %xmm2, %xmm2
 202      00000000 
  78:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 203              		.loc 1 78 42 discriminator 3
 204 0167 C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 205 016b E8000000 		call	roundf
 205      00
 206              	.LVL10:
  78:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 207              		.loc 1 78 40 discriminator 3
 208 0170 488B5500 		movq	0(%rbp), %rdx
  63:RGB2YCbCr.c   ****         {
 209              		.loc 1 63 9 discriminator 3
 210 0174 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
  78:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 211              		.loc 1 78 40 discriminator 3
 212 0178 C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 213 017c 88441A02 		movb	%al, 2(%rdx,%rbx)
  63:RGB2YCbCr.c   ****         {
 214              		.loc 1 63 43 is_stmt 1 discriminator 3
  63:RGB2YCbCr.c   ****         {
 215              		.loc 1 63 25 discriminator 3
 216 0180 4883C303 		addq	$3, %rbx
  63:RGB2YCbCr.c   ****         {
 217              		.loc 1 63 9 is_stmt 0 discriminator 3
 218 0184 4C39EB   		cmpq	%r13, %rbx
 219 0187 0F85E3FE 		jne	.L4
 219      FFFF
 220              	.L6:
 221              	.LBE5:
  83:RGB2YCbCr.c   **** 
  84:RGB2YCbCr.c   ****         }
  85:RGB2YCbCr.c   ****         dummy(image_in, image_out);
 222              		.loc 1 85 9 is_stmt 1
 223 018d 4889EE   		movq	%rbp, %rsi
 224 0190 4C89E7   		movq	%r12, %rdi
 225 0193 E8000000 		call	dummy
 225      00
 226              	.LVL11:
  61:RGB2YCbCr.c   ****     {
 227              		.loc 1 61 34
  61:RGB2YCbCr.c   ****     {
 228              		.loc 1 61 22
  61:RGB2YCbCr.c   ****     {
 229              		.loc 1 61 5 is_stmt 0
 230 0198 41FFCE   		decl	%r14d
 231 019b C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 232 019f 0F85BBFE 		jne	.L3
 232      FFFF
 233              	.LBE7:
  86:RGB2YCbCr.c   ****     }
  87:RGB2YCbCr.c   ****     end_t = get_wall_time();
 234              		.loc 1 87 5 is_stmt 1
 235              		.loc 1 87 13 is_stmt 0
 236 01a5 31C0     		xorl	%eax, %eax
 237 01a7 E8000000 		call	get_wall_time
 237      00
 238              	.LVL12:
  88:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2YCbCr_roundf0");
 239              		.loc 1 88 5 is_stmt 1
 240 01ac C5FB5C44 		vsubsd	8(%rsp), %xmm0, %xmm0
 240      2408
 241              	.LVL13:
  89:RGB2YCbCr.c   **** }
 242              		.loc 1 89 1 is_stmt 0
 243 01b2 4883C418 		addq	$24, %rsp
 244              		.cfi_remember_state
 245              		.cfi_def_cfa_offset 56
  88:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2YCbCr_roundf0");
 246              		.loc 1 88 5
 247 01b6 4489FF   		movl	%r15d, %edi
 248              		.loc 1 89 1
 249 01b9 5B       		popq	%rbx
 250              		.cfi_def_cfa_offset 48
  88:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2YCbCr_roundf0");
 251              		.loc 1 88 5
 252 01ba BE000000 		movl	$.LC11, %esi
 252      00
 253              		.loc 1 89 1
 254 01bf 5D       		popq	%rbp
 255              		.cfi_def_cfa_offset 40
 256              	.LVL14:
 257 01c0 415C     		popq	%r12
 258              		.cfi_def_cfa_offset 32
 259              	.LVL15:
 260 01c2 415D     		popq	%r13
 261              		.cfi_def_cfa_offset 24
 262 01c4 415E     		popq	%r14
 263              		.cfi_def_cfa_offset 16
 264 01c6 415F     		popq	%r15
 265              		.cfi_def_cfa_offset 8
  88:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2YCbCr_roundf0");
 266              		.loc 1 88 5
 267 01c8 E9000000 		jmp	results
 267      00
 268              	.LVL16:
 269              	.L11:
 270              		.cfi_restore_state
  50:RGB2YCbCr.c   ****         exit(-1);
 271              		.loc 1 50 9 is_stmt 1
 272 01cd BF000000 		movl	$.LC0, %edi
 272      00
 273              	.LVL17:
 274 01d2 E8000000 		call	puts
 274      00
 275              	.LVL18:
  51:RGB2YCbCr.c   ****     }
 276              		.loc 1 51 9
 277 01d7 83CFFF   		orl	$-1, %edi
 278 01da E8000000 		call	exit
 278      00
 279              	.LVL19:
 280              		.cfi_endproc
 281              	.LFE14:
 283              		.section	.rodata.str1.1
 284              	.LC12:
 285 0012 52474232 		.string	"RGB2YCbCr_roundf1"
 285      59436243 
 285      725F726F 
 285      756E6466 
 285      3100
 286              		.text
 287 01df 90       		.p2align 4
 288              		.globl	RGB2YCbCr_roundf1
 290              	RGB2YCbCr_roundf1:
 291              	.LFB15:
  90:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
  91:RGB2YCbCr.c   **** 
  92:RGB2YCbCr.c   **** /* cambios respecto RGB2Gray_roundf_0(): restricts, #pragma GCC ivdep */
  93:RGB2YCbCr.c   **** void
  94:RGB2YCbCr.c   **** RGB2YCbCr_roundf1(image_t * restrict image_in, image_t * restrict image_out)
  95:RGB2YCbCr.c   **** {
 292              		.loc 1 95 1
 293              		.cfi_startproc
 294              	.LVL20:
  96:RGB2YCbCr.c   ****     double start_t, end_t;
 295              		.loc 1 96 5
  97:RGB2YCbCr.c   ****     const int height = image_in->height;
 296              		.loc 1 97 5
  95:RGB2YCbCr.c   ****     double start_t, end_t;
 297              		.loc 1 95 1 is_stmt 0
 298 01e0 4157     		pushq	%r15
 299              		.cfi_def_cfa_offset 16
 300              		.cfi_offset 15, -16
 301 01e2 4156     		pushq	%r14
 302              		.cfi_def_cfa_offset 24
 303              		.cfi_offset 14, -24
 304 01e4 4155     		pushq	%r13
 305              		.cfi_def_cfa_offset 32
 306              		.cfi_offset 13, -32
 307 01e6 4154     		pushq	%r12
 308              		.cfi_def_cfa_offset 40
 309              		.cfi_offset 12, -40
 310 01e8 55       		pushq	%rbp
 311              		.cfi_def_cfa_offset 48
 312              		.cfi_offset 6, -48
 313 01e9 53       		pushq	%rbx
 314              		.cfi_def_cfa_offset 56
 315              		.cfi_offset 3, -56
 316 01ea 4883EC28 		subq	$40, %rsp
 317              		.cfi_def_cfa_offset 96
  98:RGB2YCbCr.c   ****     const int width =  image_in->width;
  99:RGB2YCbCr.c   ****     unsigned char * restrict pixels_in  = image_in->pixels;
 318              		.loc 1 99 30
 319 01ee 488B07   		movq	(%rdi), %rax
 100:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 101:RGB2YCbCr.c   **** 
 102:RGB2YCbCr.c   ****     if (image_in->bytes_per_pixel != 3)
 320              		.loc 1 102 8
 321 01f1 837F1003 		cmpl	$3, 16(%rdi)
  97:RGB2YCbCr.c   ****     const int width =  image_in->width;
 322              		.loc 1 97 15
 323 01f5 448B7F0C 		movl	12(%rdi), %r15d
 324              	.LVL21:
  98:RGB2YCbCr.c   ****     const int width =  image_in->width;
 325              		.loc 1 98 5 is_stmt 1
  98:RGB2YCbCr.c   ****     const int width =  image_in->width;
 326              		.loc 1 98 15 is_stmt 0
 327 01f9 8B5F08   		movl	8(%rdi), %ebx
 328              	.LVL22:
  99:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 329              		.loc 1 99 5 is_stmt 1
  99:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 330              		.loc 1 99 30 is_stmt 0
 331 01fc 48894424 		movq	%rax, 8(%rsp)
 331      08
 332              	.LVL23:
 100:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 333              		.loc 1 100 5 is_stmt 1
 100:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 334              		.loc 1 100 30 is_stmt 0
 335 0201 488B06   		movq	(%rsi), %rax
 336              	.LVL24:
 337 0204 48894424 		movq	%rax, 16(%rsp)
 337      10
 338              	.LVL25:
 339              		.loc 1 102 5 is_stmt 1
 340              		.loc 1 102 8 is_stmt 0
 341 0209 0F85BB01 		jne	.L21
 341      0000
 103:RGB2YCbCr.c   ****     {
 104:RGB2YCbCr.c   ****         printf("ERROR: input image has to be RGB\n");
 105:RGB2YCbCr.c   ****         exit(-1);
 106:RGB2YCbCr.c   ****     }
 107:RGB2YCbCr.c   ****     
 108:RGB2YCbCr.c   ****     /* fill struct fields */
 109:RGB2YCbCr.c   ****     image_out->width  = width;
 110:RGB2YCbCr.c   ****     image_out->height = height;
 342              		.loc 1 110 23
 343 020f 44897E0C 		movl	%r15d, 12(%rsi)
 344              	.LBB8:
 345              	.LBB9:
 111:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 112:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 113:RGB2YCbCr.c   **** 
 114:RGB2YCbCr.c   ****     start_t = get_wall_time();
 115:RGB2YCbCr.c   ****     for (int it=0; it < NITER; it++)
 116:RGB2YCbCr.c   ****     {
 117:RGB2YCbCr.c   ****         #pragma GCC ivdep
 118:RGB2YCbCr.c   ****         for (int i = 0; i < height*width; i++)
 346              		.loc 1 118 35
 347 0213 440FAFFB 		imull	%ebx, %r15d
 348              	.LVL26:
 349 0217 4989FE   		movq	%rdi, %r14
 350 021a 4989F5   		movq	%rsi, %r13
 351              	.LBE9:
 352              	.LBE8:
 109:RGB2YCbCr.c   ****     image_out->height = height;
 353              		.loc 1 109 5 is_stmt 1
 111:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 354              		.loc 1 111 32 is_stmt 0
 355 021d 48B80300 		movabsq	$12884901891, %rax
 355      00000300 
 355      0000
 356              	.LVL27:
 109:RGB2YCbCr.c   ****     image_out->height = height;
 357              		.loc 1 109 23
 358 0227 895E08   		movl	%ebx, 8(%rsi)
 110:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 359              		.loc 1 110 5 is_stmt 1
 111:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 360              		.loc 1 111 5
 112:RGB2YCbCr.c   **** 
 361              		.loc 1 112 5
 362              	.LBB13:
 363              	.LBB10:
 364              		.loc 1 118 35 is_stmt 0
 365 022a 41BC0A00 		movl	$10, %r12d
 365      0000
 366              	.LBE10:
 367              	.LBE13:
 111:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 368              		.loc 1 111 32
 369 0230 48894610 		movq	%rax, 16(%rsi)
 114:RGB2YCbCr.c   ****     for (int it=0; it < NITER; it++)
 370              		.loc 1 114 5 is_stmt 1
 114:RGB2YCbCr.c   ****     for (int it=0; it < NITER; it++)
 371              		.loc 1 114 15 is_stmt 0
 372 0234 31C0     		xorl	%eax, %eax
 373 0236 E8000000 		call	get_wall_time
 373      00
 374              	.LVL28:
 375 023b 488B5424 		movq	8(%rsp), %rdx
 375      08
 376 0240 418D47FF 		leal	-1(%r15), %eax
 377              	.LBB14:
 378              	.LBB11:
 379              		.loc 1 118 35
 380 0244 44897C24 		movl	%r15d, 4(%rsp)
 380      04
 381 0249 488D0440 		leaq	(%rax,%rax,2), %rax
 382              	.LBE11:
 383              	.LBE14:
 114:RGB2YCbCr.c   ****     for (int it=0; it < NITER; it++)
 384              		.loc 1 114 15
 385 024d C5FB1144 		vmovsd	%xmm0, 24(%rsp)
 385      2418
 386              	.LVL29:
 115:RGB2YCbCr.c   ****     {
 387              		.loc 1 115 5 is_stmt 1
 388              	.LBB15:
 115:RGB2YCbCr.c   ****     {
 389              		.loc 1 115 10
 115:RGB2YCbCr.c   ****     {
 390              		.loc 1 115 20
 391 0253 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 392 0257 488D6C02 		leaq	3(%rdx,%rax), %rbp
 392      03
 393              	.LVL30:
 394 025c 0F1F4000 		.p2align 4,,10
 395              		.p2align 3
 396              	.L14:
 397              	.LBB12:
 398              		.loc 1 118 25
 399              		.loc 1 118 9 is_stmt 0
 400 0260 8B442404 		movl	4(%rsp), %eax
 401 0264 85C0     		testl	%eax, %eax
 402 0266 0F8E1D01 		jle	.L18
 402      0000
 403 026c 488B5C24 		movq	16(%rsp), %rbx
 403      10
 404 0271 4C8B7C24 		movq	8(%rsp), %r15
 404      08
 405              	.LVL31:
 406 0276 662E0F1F 		.p2align 4,,10
 406      84000000 
 406      0000
 407              		.p2align 3
 408              	.L15:
 119:RGB2YCbCr.c   ****         {
 120:RGB2YCbCr.c   ****             /* R */
 121:RGB2YCbCr.c   ****             pixels_out[3*i + 0] = roundf(
 409              		.loc 1 121 13 is_stmt 1 discriminator 3
 122:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 123:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 410              		.loc 1 123 42 is_stmt 0 discriminator 3
 411 0280 410FB607 		movzbl	(%r15), %eax
 122:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 412              		.loc 1 122 37 discriminator 3
 413 0284 C5E057DB 		vxorps	%xmm3, %xmm3, %xmm3
 414 0288 4983C703 		addq	$3, %r15
 415 028c 4883C303 		addq	$3, %rbx
 416              		.loc 1 123 32 discriminator 3
 417 0290 C5F22AC0 		vcvtsi2ssl	%eax, %xmm1, %xmm0
 418 0294 C5FA5905 		vmulss	.LC1(%rip), %xmm0, %xmm0
 418      00000000 
 124:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 419              		.loc 1 124 42 discriminator 3
 420 029c 410FB647 		movzbl	-2(%r15), %eax
 420      FE
 421              		.loc 1 124 32 discriminator 3
 422 02a1 C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 423 02a5 C5EA5915 		vmulss	.LC3(%rip), %xmm2, %xmm2
 423      00000000 
 125:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 424              		.loc 1 125 42 discriminator 3
 425 02ad 410FB647 		movzbl	-1(%r15), %eax
 425      FF
 122:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 426              		.loc 1 122 37 discriminator 3
 427 02b2 C5FA58C3 		vaddss	%xmm3, %xmm0, %xmm0
 123:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 428              		.loc 1 123 52 discriminator 3
 429 02b6 C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 430              		.loc 1 125 32 discriminator 3
 431 02ba C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 432 02be C5EA5915 		vmulss	.LC4(%rip), %xmm2, %xmm2
 432      00000000 
 121:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 433              		.loc 1 121 35 discriminator 3
 434 02c6 C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 435 02ca E8000000 		call	roundf
 435      00
 436              	.LVL32:
 126:RGB2YCbCr.c   ****             /* G */
 127:RGB2YCbCr.c   ****             pixels_out[3*i + 1] = roundf(
 128:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 129:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 437              		.loc 1 129 32 discriminator 3
 438 02cf C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 121:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 439              		.loc 1 121 33 discriminator 3
 440 02d3 C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 441 02d7 8843FD   		movb	%al, -3(%rbx)
 127:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 442              		.loc 1 127 13 is_stmt 1 discriminator 3
 443              		.loc 1 129 42 is_stmt 0 discriminator 3
 444 02da 410FB647 		movzbl	-3(%r15), %eax
 444      FD
 445              		.loc 1 129 32 discriminator 3
 446 02df C5F22AC0 		vcvtsi2ssl	%eax, %xmm1, %xmm0
 130:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 447              		.loc 1 130 42 discriminator 3
 448 02e3 410FB647 		movzbl	-2(%r15), %eax
 448      FE
 129:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 449              		.loc 1 129 32 discriminator 3
 450 02e8 C5FA5905 		vmulss	.LC5(%rip), %xmm0, %xmm0
 450      00000000 
 128:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 451              		.loc 1 128 37 discriminator 3
 452 02f0 C5FA5805 		vaddss	.LC6(%rip), %xmm0, %xmm0
 452      00000000 
 453              		.loc 1 130 32 discriminator 3
 454 02f8 C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 455 02fc C5EA5915 		vmulss	.LC7(%rip), %xmm2, %xmm2
 455      00000000 
 131:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 456              		.loc 1 131 42 discriminator 3
 457 0304 410FB647 		movzbl	-1(%r15), %eax
 457      FF
 129:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 458              		.loc 1 129 52 discriminator 3
 459 0309 C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 460              		.loc 1 131 32 discriminator 3
 461 030d C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 462 0311 C5EA5915 		vmulss	.LC8(%rip), %xmm2, %xmm2
 462      00000000 
 127:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 463              		.loc 1 127 35 discriminator 3
 464 0319 C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 465 031d E8000000 		call	roundf
 465      00
 466              	.LVL33:
 132:RGB2YCbCr.c   ****             /* B */
 133:RGB2YCbCr.c   ****             pixels_out[3*i + 2] = roundf(
 134:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 135:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 467              		.loc 1 135 32 discriminator 3
 468 0322 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 127:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 469              		.loc 1 127 33 discriminator 3
 470 0326 C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 471 032a 8843FE   		movb	%al, -2(%rbx)
 133:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 472              		.loc 1 133 13 is_stmt 1 discriminator 3
 473              		.loc 1 135 42 is_stmt 0 discriminator 3
 474 032d 410FB647 		movzbl	-3(%r15), %eax
 474      FD
 475              		.loc 1 135 32 discriminator 3
 476 0332 C5F22AC0 		vcvtsi2ssl	%eax, %xmm1, %xmm0
 136:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 477              		.loc 1 136 42 discriminator 3
 478 0336 410FB647 		movzbl	-2(%r15), %eax
 478      FE
 135:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 479              		.loc 1 135 32 discriminator 3
 480 033b C5FA5905 		vmulss	.LC8(%rip), %xmm0, %xmm0
 480      00000000 
 134:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 481              		.loc 1 134 37 discriminator 3
 482 0343 C5FA5805 		vaddss	.LC6(%rip), %xmm0, %xmm0
 482      00000000 
 483              		.loc 1 136 32 discriminator 3
 484 034b C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 485 034f C5EA5915 		vmulss	.LC9(%rip), %xmm2, %xmm2
 485      00000000 
 137:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 486              		.loc 1 137 42 discriminator 3
 487 0357 410FB647 		movzbl	-1(%r15), %eax
 487      FF
 135:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 488              		.loc 1 135 52 discriminator 3
 489 035c C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 490              		.loc 1 137 32 discriminator 3
 491 0360 C5F22AD0 		vcvtsi2ssl	%eax, %xmm1, %xmm2
 492 0364 C5EA5915 		vmulss	.LC10(%rip), %xmm2, %xmm2
 492      00000000 
 133:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 493              		.loc 1 133 35 discriminator 3
 494 036c C5FA58C2 		vaddss	%xmm2, %xmm0, %xmm0
 495 0370 E8000000 		call	roundf
 495      00
 496              	.LVL34:
 118:RGB2YCbCr.c   ****         {
 497              		.loc 1 118 9 discriminator 3
 498 0375 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 133:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 499              		.loc 1 133 33 discriminator 3
 500 0379 C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 501 037d 8843FF   		movb	%al, -1(%rbx)
 118:RGB2YCbCr.c   ****         {
 502              		.loc 1 118 43 is_stmt 1 discriminator 3
 118:RGB2YCbCr.c   ****         {
 503              		.loc 1 118 25 discriminator 3
 118:RGB2YCbCr.c   ****         {
 504              		.loc 1 118 9 is_stmt 0 discriminator 3
 505 0380 4939EF   		cmpq	%rbp, %r15
 506 0383 0F85F7FE 		jne	.L15
 506      FFFF
 507              	.L18:
 508              	.LBE12:
 138:RGB2YCbCr.c   ****         }
 139:RGB2YCbCr.c   ****         dummy(image_in, image_out);
 509              		.loc 1 139 9 is_stmt 1
 510 0389 4C89EE   		movq	%r13, %rsi
 511 038c 4C89F7   		movq	%r14, %rdi
 512 038f E8000000 		call	dummy
 512      00
 513              	.LVL35:
 115:RGB2YCbCr.c   ****     {
 514              		.loc 1 115 32
 115:RGB2YCbCr.c   ****     {
 515              		.loc 1 115 20
 115:RGB2YCbCr.c   ****     {
 516              		.loc 1 115 5 is_stmt 0
 517 0394 41FFCC   		decl	%r12d
 518 0397 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 519 039b 0F85BFFE 		jne	.L14
 519      FFFF
 520              	.LBE15:
 140:RGB2YCbCr.c   ****     }
 141:RGB2YCbCr.c   ****     end_t = get_wall_time();
 521              		.loc 1 141 5 is_stmt 1
 522              		.loc 1 141 13 is_stmt 0
 523 03a1 31C0     		xorl	%eax, %eax
 524 03a3 E8000000 		call	get_wall_time
 524      00
 525              	.LVL36:
 142:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2YCbCr_roundf1");
 526              		.loc 1 142 5 is_stmt 1
 527 03a8 C5FB5C44 		vsubsd	24(%rsp), %xmm0, %xmm0
 527      2418
 528              	.LVL37:
 529 03ae 8B7C2404 		movl	4(%rsp), %edi
 143:RGB2YCbCr.c   **** }
 530              		.loc 1 143 1 is_stmt 0
 531 03b2 4883C428 		addq	$40, %rsp
 532              		.cfi_remember_state
 533              		.cfi_def_cfa_offset 56
 534 03b6 5B       		popq	%rbx
 535              		.cfi_def_cfa_offset 48
 142:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2YCbCr_roundf1");
 536              		.loc 1 142 5
 537 03b7 BE000000 		movl	$.LC12, %esi
 537      00
 538              		.loc 1 143 1
 539 03bc 5D       		popq	%rbp
 540              		.cfi_def_cfa_offset 40
 541 03bd 415C     		popq	%r12
 542              		.cfi_def_cfa_offset 32
 543 03bf 415D     		popq	%r13
 544              		.cfi_def_cfa_offset 24
 545              	.LVL38:
 546 03c1 415E     		popq	%r14
 547              		.cfi_def_cfa_offset 16
 548              	.LVL39:
 549 03c3 415F     		popq	%r15
 550              		.cfi_def_cfa_offset 8
 142:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2YCbCr_roundf1");
 551              		.loc 1 142 5
 552 03c5 E9000000 		jmp	results
 552      00
 553              	.LVL40:
 554              	.L21:
 555              		.cfi_restore_state
 104:RGB2YCbCr.c   ****         exit(-1);
 556              		.loc 1 104 9 is_stmt 1
 557 03ca BF000000 		movl	$.LC0, %edi
 557      00
 558              	.LVL41:
 559 03cf E8000000 		call	puts
 559      00
 560              	.LVL42:
 105:RGB2YCbCr.c   ****     }
 561              		.loc 1 105 9
 562 03d4 83CFFF   		orl	$-1, %edi
 563 03d7 E8000000 		call	exit
 563      00
 564              	.LVL43:
 565              		.cfi_endproc
 566              	.LFE15:
 568              		.section	.rodata.str1.1
 569              	.LC63:
 570 0024 52474232 		.string	"RGB2Gray_cast0"
 570      47726179 
 570      5F636173 
 570      743000
 571              		.text
 572 03dc 0F1F4000 		.p2align 4
 573              		.globl	RGB2YCbCr_cast0
 575              	RGB2YCbCr_cast0:
 576              	.LFB16:
 144:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
 145:RGB2YCbCr.c   **** 
 146:RGB2YCbCr.c   **** /* cambios respecto RGB2YCbCr_roundf2(): cast en lugar de roundf() */
 147:RGB2YCbCr.c   **** /* https://www.cs.tut.fi/~jkorpela/round.html */
 148:RGB2YCbCr.c   **** void
 149:RGB2YCbCr.c   **** RGB2YCbCr_cast0(image_t * restrict image_in, image_t * restrict image_out)
 150:RGB2YCbCr.c   **** {
 577              		.loc 1 150 1
 578              		.cfi_startproc
 579              	.LVL44:
 151:RGB2YCbCr.c   ****     double start_t, end_t;
 580              		.loc 1 151 5
 152:RGB2YCbCr.c   ****     const int height = image_in->height;
 581              		.loc 1 152 5
 150:RGB2YCbCr.c   ****     double start_t, end_t;
 582              		.loc 1 150 1 is_stmt 0
 583 03e0 4155     		pushq	%r13
 584              		.cfi_def_cfa_offset 16
 585              		.cfi_offset 13, -16
 586 03e2 4C8D6C24 		leaq	16(%rsp), %r13
 586      10
 587              		.cfi_def_cfa 13, 0
 588 03e7 4883E4E0 		andq	$-32, %rsp
 589 03eb 41FF75F8 		pushq	-8(%r13)
 590 03ef 55       		pushq	%rbp
 591              		.cfi_escape 0x10,0x6,0x2,0x76,0
 592 03f0 4889E5   		movq	%rsp, %rbp
 593 03f3 4157     		pushq	%r15
 594 03f5 4156     		pushq	%r14
 595 03f7 4155     		pushq	%r13
 596              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 597              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 598              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 599 03f9 4154     		pushq	%r12
 600 03fb 53       		pushq	%rbx
 601 03fc 4881EC88 		subq	$392, %rsp
 601      010000
 602              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 603              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
 153:RGB2YCbCr.c   ****     const int width =  image_in->width;
 154:RGB2YCbCr.c   ****     unsigned char * restrict pixels_in  = image_in->pixels;
 604              		.loc 1 154 30
 605 0403 488B07   		movq	(%rdi), %rax
 155:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 156:RGB2YCbCr.c   **** 
 157:RGB2YCbCr.c   ****     if (image_in->bytes_per_pixel != 3)
 606              		.loc 1 157 8
 607 0406 837F1003 		cmpl	$3, 16(%rdi)
 152:RGB2YCbCr.c   ****     const int width =  image_in->width;
 608              		.loc 1 152 15
 609 040a 8B5F0C   		movl	12(%rdi), %ebx
 610              	.LVL45:
 153:RGB2YCbCr.c   ****     const int width =  image_in->width;
 611              		.loc 1 153 5 is_stmt 1
 153:RGB2YCbCr.c   ****     const int width =  image_in->width;
 612              		.loc 1 153 15 is_stmt 0
 613 040d 448B6F08 		movl	8(%rdi), %r13d
 614              	.LVL46:
 154:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 615              		.loc 1 154 5 is_stmt 1
 154:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 616              		.loc 1 154 30 is_stmt 0
 617 0411 48898568 		movq	%rax, -408(%rbp)
 617      FEFFFF
 618              	.LVL47:
 155:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 619              		.loc 1 155 5 is_stmt 1
 155:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 620              		.loc 1 155 30 is_stmt 0
 621 0418 488B06   		movq	(%rsi), %rax
 622              	.LVL48:
 623 041b 48898560 		movq	%rax, -416(%rbp)
 623      FEFFFF
 624              	.LVL49:
 625              		.loc 1 157 5 is_stmt 1
 626              		.loc 1 157 8 is_stmt 0
 627 0422 0F85B40C 		jne	.L37
 627      0000
 158:RGB2YCbCr.c   ****     {
 159:RGB2YCbCr.c   ****         printf("ERROR: input image has to be RGB\n");
 160:RGB2YCbCr.c   ****         exit(-1);
 161:RGB2YCbCr.c   ****     }
 162:RGB2YCbCr.c   ****     
 163:RGB2YCbCr.c   ****     /* fill struct fields */
 164:RGB2YCbCr.c   ****     image_out->width  = width;
 165:RGB2YCbCr.c   ****     image_out->height = height;
 166:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 628              		.loc 1 166 32
 629 0428 48B80300 		movabsq	$12884901891, %rax
 629      00000300 
 629      0000
 630              	.LVL50:
 164:RGB2YCbCr.c   ****     image_out->height = height;
 631              		.loc 1 164 23
 632 0432 44896E08 		movl	%r13d, 8(%rsi)
 633              	.LBB16:
 634              	.LBB17:
 167:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 168:RGB2YCbCr.c   **** 
 169:RGB2YCbCr.c   ****     start_t = get_wall_time();
 170:RGB2YCbCr.c   **** 
 171:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 172:RGB2YCbCr.c   ****     {
 173:RGB2YCbCr.c   ****         #pragma GCC ivdep
 174:RGB2YCbCr.c   ****         for (int i = 0; i < height*width; i++)
 635              		.loc 1 174 35
 636 0436 440FAFEB 		imull	%ebx, %r13d
 637              	.LVL51:
 638 043a 4989FF   		movq	%rdi, %r15
 639              	.LBE17:
 640              	.LBE16:
 165:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 641              		.loc 1 165 23
 642 043d 895E0C   		movl	%ebx, 12(%rsi)
 643 0440 4989F6   		movq	%rsi, %r14
 164:RGB2YCbCr.c   ****     image_out->height = height;
 644              		.loc 1 164 5 is_stmt 1
 165:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 645              		.loc 1 165 5
 166:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 646              		.loc 1 166 5
 167:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 647              		.loc 1 167 5
 648              	.LBB21:
 649              	.LBB18:
 650              		.loc 1 174 35 is_stmt 0
 651 0443 BB0A0000 		movl	$10, %ebx
 651      00
 652              	.LVL52:
 653              	.LBE18:
 654              	.LBE21:
 166:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 655              		.loc 1 166 32
 656 0448 48894610 		movq	%rax, 16(%rsi)
 169:RGB2YCbCr.c   **** 
 657              		.loc 1 169 5 is_stmt 1
 169:RGB2YCbCr.c   **** 
 658              		.loc 1 169 15 is_stmt 0
 659 044c 31C0     		xorl	%eax, %eax
 660 044e E8000000 		call	get_wall_time
 660      00
 661              	.LVL53:
 662 0453 418D45FF 		leal	-1(%r13), %eax
 663 0457 89855CFE 		movl	%eax, -420(%rbp)
 663      FFFF
 664 045d 4489E8   		movl	%r13d, %eax
 665 0460 C1E805   		shrl	$5, %eax
 666 0463 C5FB1185 		vmovsd	%xmm0, -432(%rbp)
 666      50FEFFFF 
 667              	.LVL54:
 171:RGB2YCbCr.c   ****     {
 668              		.loc 1 171 5 is_stmt 1
 669              	.LBB22:
 171:RGB2YCbCr.c   ****     {
 670              		.loc 1 171 10
 171:RGB2YCbCr.c   ****     {
 671              		.loc 1 171 22
 672 046b 4C8D0C40 		leaq	(%rax,%rax,2), %r9
 673 046f 488B8568 		movq	-408(%rbp), %rax
 673      FEFFFF
 674 0476 49C1E105 		salq	$5, %r9
 675 047a 4D8D2401 		leaq	(%r9,%rax), %r12
 676 047e 4489E8   		movl	%r13d, %eax
 677 0481 83E0E0   		andl	$-32, %eax
 678 0484 898558FE 		movl	%eax, -424(%rbp)
 678      FFFF
 679              	.LVL55:
 680 048a 660F1F44 		.p2align 4,,10
 680      0000
 681              		.p2align 3
 682              	.L24:
 683              	.LBB19:
 684              		.loc 1 174 25
 685              		.loc 1 174 9 is_stmt 0
 686 0490 4585ED   		testl	%r13d, %r13d
 687 0493 0F8EDE0B 		jle	.L31
 687      0000
 688 0499 83BD5CFE 		cmpl	$30, -420(%rbp)
 688      FFFF1E
 689 04a0 0F86170C 		jbe	.L32
 689      0000
 690 04a6 488B9560 		movq	-416(%rbp), %rdx
 690      FEFFFF
 691 04ad 488B8568 		movq	-408(%rbp), %rax
 691      FEFFFF
 692              	.LVL56:
 693              		.p2align 4,,10
 694 04b4 0F1F4000 		.p2align 3
 695              	.L26:
 175:RGB2YCbCr.c   ****         {
 176:RGB2YCbCr.c   ****             /* R */
 177:RGB2YCbCr.c   ****             pixels_out[3*i + 0] = (unsigned char) (0.5 + 
 696              		.loc 1 177 13 is_stmt 1 discriminator 3
 178:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 697              		.loc 1 179 42 is_stmt 0 discriminator 3
 698 04b8 C5FE6F08 		vmovdqu	(%rax), %ymm1
 699 04bc C5FE6F60 		vmovdqu	64(%rax), %ymm4
 699      40
 700 04c1 4883C060 		addq	$96, %rax
 701 04c5 4883C260 		addq	$96, %rdx
 702 04c9 C5FE6F68 		vmovdqu	-64(%rax), %ymm5
 702      C0
 703 04ce C4E27500 		vpshufb	.LC13(%rip), %ymm1, %ymm3
 703      1D000000 
 703      00
 704 04d7 C4E25500 		vpshufb	.LC15(%rip), %ymm5, %ymm2
 704      15000000 
 704      00
 705 04e0 C4E3FD00 		vpermq	$78, %ymm3, %ymm0
 705      C34E
 706 04e6 C4E27500 		vpshufb	.LC14(%rip), %ymm1, %ymm3
 706      1D000000 
 706      00
 707 04ef C4E25500 		vpshufb	.LC21(%rip), %ymm5, %ymm6
 707      35000000 
 707      00
 708 04f8 C5E5EBD8 		vpor	%ymm0, %ymm3, %ymm3
 709 04fc C4E25D00 		vpshufb	.LC16(%rip), %ymm4, %ymm0
 709      05000000 
 709      00
 710 0505 C4E25500 		vpshufb	.LC27(%rip), %ymm5, %ymm5
 710      2D000000 
 710      00
 711 050e C5E5EBDA 		vpor	%ymm2, %ymm3, %ymm3
 712 0512 C4E3FD00 		vpermq	$78, %ymm0, %ymm2
 712      D04E
 713 0518 C4E25D00 		vpshufb	.LC18(%rip), %ymm4, %ymm0
 713      05000000 
 713      00
 714 0521 C4E26500 		vpshufb	.LC17(%rip), %ymm3, %ymm3
 714      1D000000 
 714      00
 715 052a C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 716 052e C4E27500 		vpshufb	.LC19(%rip), %ymm1, %ymm2
 716      15000000 
 716      00
 717 0537 C5E5EBD8 		vpor	%ymm0, %ymm3, %ymm3
 718 053b C4E3FD00 		vpermq	$78, %ymm2, %ymm0
 718      C24E
 719 0541 C4E27500 		vpshufb	.LC20(%rip), %ymm1, %ymm2
 719      15000000 
 719      00
 720 054a C5EDEBD0 		vpor	%ymm0, %ymm2, %ymm2
 721 054e C4E25D00 		vpshufb	.LC22(%rip), %ymm4, %ymm0
 721      05000000 
 721      00
 722 0557 C5EDEBD6 		vpor	%ymm6, %ymm2, %ymm2
 723 055b C4E3FD00 		vpermq	$78, %ymm0, %ymm6
 723      F04E
 724 0561 C4E25D00 		vpshufb	.LC24(%rip), %ymm4, %ymm0
 724      05000000 
 724      00
 725 056a C4E26D00 		vpshufb	.LC23(%rip), %ymm2, %ymm2
 725      15000000 
 725      00
 726 0573 C5FDEBC6 		vpor	%ymm6, %ymm0, %ymm0
 727 0577 C5EDEBD0 		vpor	%ymm0, %ymm2, %ymm2
 728 057b C4E27500 		vpshufb	.LC25(%rip), %ymm1, %ymm0
 728      05000000 
 728      00
 729 0584 C4E27500 		vpshufb	.LC26(%rip), %ymm1, %ymm1
 729      0D000000 
 729      00
 730 058d C4E3FD00 		vpermq	$78, %ymm0, %ymm0
 730      C04E
 731 0593 C5F5EBC0 		vpor	%ymm0, %ymm1, %ymm0
 732 0597 C4E25D00 		vpshufb	.LC28(%rip), %ymm4, %ymm1
 732      0D000000 
 732      00
 733 05a0 C5FDEBC5 		vpor	%ymm5, %ymm0, %ymm0
 734 05a4 C4E3FD00 		vpermq	$78, %ymm1, %ymm5
 734      E94E
 735 05aa C4E25D00 		vpshufb	.LC29(%rip), %ymm4, %ymm1
 735      0D000000 
 735      00
 736 05b3 C5F5EBCD 		vpor	%ymm5, %ymm1, %ymm1
 737 05b7 C4E27D30 		vpmovzxbw	%xmm3, %ymm4
 737      E3
 738 05bc C4E27D00 		vpshufb	.LC23(%rip), %ymm0, %ymm0
 738      05000000 
 738      00
 739 05c5 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 740 05c9 C4E37D39 		vextracti128	$0x1, %ymm3, %xmm1
 740      D901
 741 05cf C4E27D33 		vpmovzxwd	%xmm4, %ymm3
 741      DC
 742 05d4 C4E27D30 		vpmovzxbw	%xmm1, %ymm1
 742      C9
 743              		.loc 1 179 32 discriminator 3
 744 05d9 C57C5BFB 		vcvtdq2ps	%ymm3, %ymm15
 745              		.loc 1 179 42 discriminator 3
 746 05dd C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 746      E401
 747 05e3 C4E27D33 		vpmovzxwd	%xmm1, %ymm3
 747      D9
 748 05e8 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 748      C901
 749 05ee C4E27D33 		vpmovzxwd	%xmm4, %ymm4
 749      E4
 750 05f3 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 750      C9
 751              		.loc 1 179 32 discriminator 3
 752 05f8 C5FC5BDB 		vcvtdq2ps	%ymm3, %ymm3
 753 05fc C5FC295D 		vmovaps	%ymm3, -112(%rbp)
 753      90
 754 0601 C5FC5BFC 		vcvtdq2ps	%ymm4, %ymm7
 755 0605 C564590D 		vmulps	.LC30(%rip), %ymm3, %ymm9
 755      00000000 
 756 060d C5FC5BE9 		vcvtdq2ps	%ymm1, %ymm5
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 757              		.loc 1 180 42 discriminator 3
 758 0611 C4E27D30 		vpmovzxbw	%xmm2, %ymm3
 758      DA
 759 0616 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm1
 759      D101
 760 061c C4E27D30 		vpmovzxbw	%xmm1, %ymm1
 760      C9
 761 0621 C4E27D33 		vpmovzxwd	%xmm3, %ymm2
 761      D3
 762 0626 C4E37D39 		vextracti128	$0x1, %ymm3, %xmm3
 762      DB01
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 763              		.loc 1 179 32 discriminator 3
 764 062c C5FC297D 		vmovaps	%ymm7, -80(%rbp)
 764      B0
 765 0631 C504592D 		vmulps	.LC30(%rip), %ymm15, %ymm13
 765      00000000 
 766              		.loc 1 180 32 discriminator 3
 767 0639 C5FC5BE2 		vcvtdq2ps	%ymm2, %ymm4
 768              		.loc 1 180 42 discriminator 3
 769 063d C4E27D33 		vpmovzxwd	%xmm1, %ymm2
 769      D1
 770 0642 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 770      C901
 771 0648 C4E27D33 		vpmovzxwd	%xmm3, %ymm3
 771      DB
 772 064d C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 772      C9
 773              		.loc 1 180 32 discriminator 3
 774 0652 C57C5BC2 		vcvtdq2ps	%ymm2, %ymm8
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 775              		.loc 1 179 32 discriminator 3
 776 0656 C5FC29AD 		vmovaps	%ymm5, -144(%rbp)
 776      70FFFFFF 
 777 065e C544591D 		vmulps	.LC30(%rip), %ymm7, %ymm11
 777      00000000 
 778              		.loc 1 180 32 discriminator 3
 779 0666 C57C5BF3 		vcvtdq2ps	%ymm3, %ymm14
 780 066a C5FC5BC9 		vcvtdq2ps	%ymm1, %ymm1
 781 066e C5FC29A5 		vmovaps	%ymm4, -176(%rbp)
 781      50FFFFFF 
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 782              		.loc 1 179 32 discriminator 3
 783 0676 C5D4593D 		vmulps	.LC30(%rip), %ymm5, %ymm7
 783      00000000 
 784              		.loc 1 180 32 discriminator 3
 785 067e C57C29B5 		vmovaps	%ymm14, -208(%rbp)
 785      30FFFFFF 
 786 0686 C55C5925 		vmulps	.LC31(%rip), %ymm4, %ymm12
 786      00000000 
 787 068e C50C5915 		vmulps	.LC31(%rip), %ymm14, %ymm10
 787      00000000 
 788 0696 C57C2985 		vmovaps	%ymm8, -240(%rbp)
 788      10FFFFFF 
 789 069e C5F45935 		vmulps	.LC31(%rip), %ymm1, %ymm6
 789      00000000 
 790 06a6 C5FC298D 		vmovaps	%ymm1, -272(%rbp)
 790      F0FEFFFF 
 181:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 791              		.loc 1 181 42 discriminator 3
 792 06ae C4E27D30 		vpmovzxbw	%xmm0, %ymm1
 792      C8
 793 06b3 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 793      C001
 794 06b9 C4E27D33 		vpmovzxwd	%xmm1, %ymm2
 794      D1
 795 06be C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 795      C901
 796 06c4 C4E27D30 		vpmovzxbw	%xmm0, %ymm0
 796      C0
 182:RGB2YCbCr.c   ****             /* G */
 183:RGB2YCbCr.c   ****             pixels_out[3*i + 1] = (unsigned char) (0.5 + 
 184:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 797              		.loc 1 185 32 discriminator 3
 798 06c9 C57C29BD 		vmovaps	%ymm15, -400(%rbp)
 798      70FEFFFF 
 181:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 799              		.loc 1 181 42 discriminator 3
 800 06d1 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 800      C9
 181:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 801              		.loc 1 181 32 discriminator 3
 802 06d6 C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 803 06da C5FC2995 		vmovaps	%ymm2, -304(%rbp)
 803      D0FEFFFF 
 804 06e2 C5EC592D 		vmulps	.LC32(%rip), %ymm2, %ymm5
 804      00000000 
 805 06ea C57C5BF1 		vcvtdq2ps	%ymm1, %ymm14
 181:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 806              		.loc 1 181 42 discriminator 3
 807 06ee C4E27D33 		vpmovzxwd	%xmm0, %ymm1
 807      C8
 181:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 808              		.loc 1 181 32 discriminator 3
 809 06f3 C57C29B5 		vmovaps	%ymm14, -336(%rbp)
 809      B0FEFFFF 
 810 06fb C58C5915 		vmulps	.LC32(%rip), %ymm14, %ymm2
 810      00000000 
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 811              		.loc 1 179 32 discriminator 3
 812 0703 C4417C5A 		vcvtps2pd	%xmm13, %ymm14
 812      F5
 181:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 813              		.loc 1 181 32 discriminator 3
 814 0708 C5FC5BC9 		vcvtdq2ps	%ymm1, %ymm1
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 815              		.loc 1 179 32 discriminator 3
 816 070c C4437D19 		vextractf128	$0x1, %ymm13, %xmm13
 816      ED01
 181:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 817              		.loc 1 181 32 discriminator 3
 818 0712 C5F45925 		vmulps	.LC32(%rip), %ymm1, %ymm4
 818      00000000 
 819 071a C5FC298D 		vmovaps	%ymm1, -368(%rbp)
 819      90FEFFFF 
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 820              		.loc 1 179 32 discriminator 3
 821 0722 C4417C5A 		vcvtps2pd	%xmm13, %ymm13
 821      ED
 178:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 822              		.loc 1 178 37 discriminator 3
 823 0727 C58D580D 		vaddpd	.LC33(%rip), %ymm14, %ymm1
 823      00000000 
 824 072f C515582D 		vaddpd	.LC33(%rip), %ymm13, %ymm13
 824      00000000 
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 825              		.loc 1 180 32 discriminator 3
 826 0737 C4417C5A 		vcvtps2pd	%xmm12, %ymm14
 826      F4
 827 073c C4437D19 		vextractf128	$0x1, %ymm12, %xmm12
 827      E401
 181:RGB2YCbCr.c   ****             /* G */
 828              		.loc 1 181 42 discriminator 3
 829 0742 C4E37D39 		vextracti128	$0x1, %ymm0, %xmm0
 829      C001
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 830              		.loc 1 180 32 discriminator 3
 831 0748 C4417C5A 		vcvtps2pd	%xmm12, %ymm12
 831      E4
 832 074d C53C5905 		vmulps	.LC31(%rip), %ymm8, %ymm8
 832      00000000 
 181:RGB2YCbCr.c   ****             /* G */
 833              		.loc 1 181 42 discriminator 3
 834 0755 C4E27D33 		vpmovzxwd	%xmm0, %ymm0
 834      C0
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 835              		.loc 1 179 52 discriminator 3
 836 075a C4417558 		vaddpd	%ymm14, %ymm1, %ymm14
 836      F6
 181:RGB2YCbCr.c   ****             /* G */
 837              		.loc 1 181 32 discriminator 3
 838 075f C5FC5ACD 		vcvtps2pd	%xmm5, %ymm1
 839 0763 C4E37D19 		vextractf128	$0x1, %ymm5, %xmm5
 839      ED01
 840 0769 C5FC5BC0 		vcvtdq2ps	%ymm0, %ymm0
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 841              		.loc 1 179 52 discriminator 3
 842 076d C4411558 		vaddpd	%ymm12, %ymm13, %ymm12
 842      E4
 181:RGB2YCbCr.c   ****             /* G */
 843              		.loc 1 181 32 discriminator 3
 844 0772 C5FC5AED 		vcvtps2pd	%xmm5, %ymm5
 845 0776 C5FC591D 		vmulps	.LC32(%rip), %ymm0, %ymm3
 845      00000000 
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 846              		.loc 1 180 52 discriminator 3
 847 077e C58D58C9 		vaddpd	%ymm1, %ymm14, %ymm1
 848              		.loc 1 185 32 discriminator 3
 849 0782 C5045935 		vmulps	.LC36(%rip), %ymm15, %ymm14
 849      00000000 
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 850              		.loc 1 180 52 discriminator 3
 851 078a C51D58E5 		vaddpd	%ymm5, %ymm12, %ymm12
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 852              		.loc 1 177 35 discriminator 3
 853 078e C5FDE6C9 		vcvttpd2dqy	%ymm1, %xmm1
 854 0792 C4417DE6 		vcvttpd2dqy	%ymm12, %xmm12
 854      E4
 855 0797 C4C37538 		vinserti128	$0x1, %xmm12, %ymm1, %ymm1
 855      CC01
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 856              		.loc 1 179 32 discriminator 3
 857 079d C4417C5A 		vcvtps2pd	%xmm11, %ymm12
 857      E3
 858 07a2 C4437D19 		vextractf128	$0x1, %ymm11, %xmm11
 858      DB01
 178:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 859              		.loc 1 178 37 discriminator 3
 860 07a8 C59D582D 		vaddpd	.LC33(%rip), %ymm12, %ymm5
 860      00000000 
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 861              		.loc 1 179 32 discriminator 3
 862 07b0 C4417C5A 		vcvtps2pd	%xmm11, %ymm11
 862      DB
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 863              		.loc 1 180 32 discriminator 3
 864 07b5 C4417C5A 		vcvtps2pd	%xmm10, %ymm12
 864      E2
 865              		.loc 1 185 32 discriminator 3
 866 07ba C4417C5A 		vcvtps2pd	%xmm14, %ymm15
 866      FE
 178:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 867              		.loc 1 178 37 discriminator 3
 868 07bf C525581D 		vaddpd	.LC33(%rip), %ymm11, %ymm11
 868      00000000 
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 869              		.loc 1 180 32 discriminator 3
 870 07c7 C4437D19 		vextractf128	$0x1, %ymm10, %xmm10
 870      D201
 871              		.loc 1 185 32 discriminator 3
 872 07cd C4437D19 		vextractf128	$0x1, %ymm14, %xmm14
 872      F601
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 873              		.loc 1 180 32 discriminator 3
 874 07d3 C4417C5A 		vcvtps2pd	%xmm10, %ymm10
 874      D2
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 875              		.loc 1 177 35 discriminator 3
 876 07d8 C5F5DB0D 		vpand	.LC34(%rip), %ymm1, %ymm1
 876      00000000 
 877              		.loc 1 185 32 discriminator 3
 878 07e0 C4417C5A 		vcvtps2pd	%xmm14, %ymm14
 878      F6
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 879              		.loc 1 179 52 discriminator 3
 880 07e5 C4415558 		vaddpd	%ymm12, %ymm5, %ymm12
 880      E4
 181:RGB2YCbCr.c   ****             /* G */
 881              		.loc 1 181 32 discriminator 3
 882 07ea C5FC5AEA 		vcvtps2pd	%xmm2, %ymm5
 883 07ee C4E37D19 		vextractf128	$0x1, %ymm2, %xmm2
 883      D201
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 884              		.loc 1 179 52 discriminator 3
 885 07f4 C4412558 		vaddpd	%ymm10, %ymm11, %ymm10
 885      D2
 181:RGB2YCbCr.c   ****             /* G */
 886              		.loc 1 181 32 discriminator 3
 887 07f9 C5FC5AD2 		vcvtps2pd	%xmm2, %ymm2
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 888              		.loc 1 180 52 discriminator 3
 889 07fd C59D58ED 		vaddpd	%ymm5, %ymm12, %ymm5
 890 0801 C52D58D2 		vaddpd	%ymm2, %ymm10, %ymm10
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 891              		.loc 1 177 35 discriminator 3
 892 0805 C5FDE6ED 		vcvttpd2dqy	%ymm5, %xmm5
 893 0809 C4417DE6 		vcvttpd2dqy	%ymm10, %xmm10
 893      D2
 894 080e C4C35538 		vinserti128	$0x1, %xmm10, %ymm5, %ymm5
 894      EA01
 895 0814 C5D5DB2D 		vpand	.LC34(%rip), %ymm5, %ymm5
 895      00000000 
 896 081c C4E2752B 		vpackusdw	%ymm5, %ymm1, %ymm1
 896      CD
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 897              		.loc 1 179 32 discriminator 3
 898 0821 C4C17C5A 		vcvtps2pd	%xmm9, %ymm5
 898      E9
 899 0826 C4437D19 		vextractf128	$0x1, %ymm9, %xmm9
 899      C901
 178:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 900              		.loc 1 178 37 discriminator 3
 901 082c C5D55815 		vaddpd	.LC33(%rip), %ymm5, %ymm2
 901      00000000 
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 902              		.loc 1 179 32 discriminator 3
 903 0834 C4417C5A 		vcvtps2pd	%xmm9, %ymm9
 903      C9
 178:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 904              		.loc 1 178 37 discriminator 3
 905 0839 C535580D 		vaddpd	.LC33(%rip), %ymm9, %ymm9
 905      00000000 
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 906              		.loc 1 180 32 discriminator 3
 907 0841 C4C17C5A 		vcvtps2pd	%xmm8, %ymm5
 907      E8
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 908              		.loc 1 177 35 discriminator 3
 909 0846 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 909      C9D8
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 910              		.loc 1 180 32 discriminator 3
 911 084c C4437D19 		vextractf128	$0x1, %ymm8, %xmm8
 911      C001
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 912              		.loc 1 177 35 discriminator 3
 913 0852 C5F5DB0D 		vpand	.LC35(%rip), %ymm1, %ymm1
 913      00000000 
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 914              		.loc 1 179 52 discriminator 3
 915 085a C5ED58ED 		vaddpd	%ymm5, %ymm2, %ymm5
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 916              		.loc 1 180 32 discriminator 3
 917 085e C4417C5A 		vcvtps2pd	%xmm8, %ymm8
 917      C0
 181:RGB2YCbCr.c   ****             /* G */
 918              		.loc 1 181 32 discriminator 3
 919 0863 C5FC5AD4 		vcvtps2pd	%xmm4, %ymm2
 920 0867 C4E37D19 		vextractf128	$0x1, %ymm4, %xmm4
 920      E401
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 921              		.loc 1 179 52 discriminator 3
 922 086d C4413558 		vaddpd	%ymm8, %ymm9, %ymm8
 922      C0
 181:RGB2YCbCr.c   ****             /* G */
 923              		.loc 1 181 32 discriminator 3
 924 0872 C5FC5AE4 		vcvtps2pd	%xmm4, %ymm4
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 925              		.loc 1 180 52 discriminator 3
 926 0876 C5D558D2 		vaddpd	%ymm2, %ymm5, %ymm2
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 927              		.loc 1 179 32 discriminator 3
 928 087a C5FC5AEF 		vcvtps2pd	%xmm7, %ymm5
 929 087e C4E37D19 		vextractf128	$0x1, %ymm7, %xmm7
 929      FF01
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 930              		.loc 1 180 52 discriminator 3
 931 0884 C53D58C4 		vaddpd	%ymm4, %ymm8, %ymm8
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 932              		.loc 1 179 32 discriminator 3
 933 0888 C5FC5AFF 		vcvtps2pd	%xmm7, %ymm7
 178:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 934              		.loc 1 178 37 discriminator 3
 935 088c C5D55825 		vaddpd	.LC33(%rip), %ymm5, %ymm4
 935      00000000 
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 936              		.loc 1 180 32 discriminator 3
 937 0894 C5FC5AEE 		vcvtps2pd	%xmm6, %ymm5
 178:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 938              		.loc 1 178 37 discriminator 3
 939 0898 C5C5583D 		vaddpd	.LC33(%rip), %ymm7, %ymm7
 939      00000000 
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 940              		.loc 1 180 32 discriminator 3
 941 08a0 C4E37D19 		vextractf128	$0x1, %ymm6, %xmm6
 941      F601
 942 08a6 C5FC5AF6 		vcvtps2pd	%xmm6, %ymm6
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 943              		.loc 1 177 35 discriminator 3
 944 08aa C5FDE6D2 		vcvttpd2dqy	%ymm2, %xmm2
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 945              		.loc 1 179 52 discriminator 3
 946 08ae C5DD58ED 		vaddpd	%ymm5, %ymm4, %ymm5
 181:RGB2YCbCr.c   ****             /* G */
 947              		.loc 1 181 32 discriminator 3
 948 08b2 C5FC5AE3 		vcvtps2pd	%xmm3, %ymm4
 949 08b6 C4E37D19 		vextractf128	$0x1, %ymm3, %xmm3
 949      DB01
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 950              		.loc 1 177 35 discriminator 3
 951 08bc C4417DE6 		vcvttpd2dqy	%ymm8, %xmm8
 951      C0
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 952              		.loc 1 179 52 discriminator 3
 953 08c1 C5C558F6 		vaddpd	%ymm6, %ymm7, %ymm6
 181:RGB2YCbCr.c   ****             /* G */
 954              		.loc 1 181 32 discriminator 3
 955 08c5 C5FC5ADB 		vcvtps2pd	%xmm3, %ymm3
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 956              		.loc 1 177 35 discriminator 3
 957 08c9 C4C36D38 		vinserti128	$0x1, %xmm8, %ymm2, %ymm2
 957      D001
 958 08cf C5EDDB15 		vpand	.LC34(%rip), %ymm2, %ymm2
 958      00000000 
 959              		.loc 1 185 32 discriminator 3
 960 08d7 C5FC287D 		vmovaps	-80(%rbp), %ymm7
 960      B0
 961 08dc C5445925 		vmulps	.LC36(%rip), %ymm7, %ymm12
 961      00000000 
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 962              		.loc 1 180 52 discriminator 3
 963 08e4 C5D558E4 		vaddpd	%ymm4, %ymm5, %ymm4
 964              		.loc 1 185 32 discriminator 3
 965 08e8 C5FC28AD 		vmovaps	-144(%rbp), %ymm5
 965      70FFFFFF 
 966 08f0 C5545905 		vmulps	.LC36(%rip), %ymm5, %ymm8
 966      00000000 
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 967              		.loc 1 180 52 discriminator 3
 968 08f8 C5CD58F3 		vaddpd	%ymm3, %ymm6, %ymm6
 969              		.loc 1 185 32 discriminator 3
 970 08fc C5FC285D 		vmovaps	-112(%rbp), %ymm3
 970      90
 971 0901 C5645915 		vmulps	.LC36(%rip), %ymm3, %ymm10
 971      00000000 
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 972              		.loc 1 177 35 discriminator 3
 973 0909 C5FDE6E4 		vcvttpd2dqy	%ymm4, %xmm4
 974 090d C5FDE6F6 		vcvttpd2dqy	%ymm6, %xmm6
 975 0911 C4E35D38 		vinserti128	$0x1, %xmm6, %ymm4, %ymm4
 975      E601
 976 0917 C5DDDB25 		vpand	.LC34(%rip), %ymm4, %ymm4
 976      00000000 
 977 091f C4E26D2B 		vpackusdw	%ymm4, %ymm2, %ymm2
 977      D4
 978 0924 C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 978      D2D8
 979 092a C5EDDB15 		vpand	.LC35(%rip), %ymm2, %ymm2
 979      00000000 
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 980              		.loc 1 186 32 discriminator 3
 981 0932 C5FC28A5 		vmovaps	-176(%rbp), %ymm4
 981      50FFFFFF 
 982 093a C55C592D 		vmulps	.LC37(%rip), %ymm4, %ymm13
 982      00000000 
 184:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 983              		.loc 1 184 37 discriminator 3
 984 0942 C50D5835 		vaddpd	.LC39(%rip), %ymm14, %ymm14
 984      00000000 
 985              		.loc 1 186 32 discriminator 3
 986 094a C5FC28B5 		vmovaps	-272(%rbp), %ymm6
 986      F0FEFFFF 
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 987              		.loc 1 177 35 discriminator 3
 988 0952 C5F567CA 		vpackuswb	%ymm2, %ymm1, %ymm1
 989              		.loc 1 186 32 discriminator 3
 990 0956 C5FC2895 		vmovaps	-208(%rbp), %ymm2
 990      30FFFFFF 
 991 095e C5CC593D 		vmulps	.LC37(%rip), %ymm6, %ymm7
 991      00000000 
 187:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 992              		.loc 1 187 32 discriminator 3
 993 0966 C5FC28AD 		vmovaps	-336(%rbp), %ymm5
 993      B0FEFFFF 
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 994              		.loc 1 177 35 discriminator 3
 995 096e C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 995      C9D8
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 996              		.loc 1 183 13 is_stmt 1 discriminator 3
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 997              		.loc 1 186 32 is_stmt 0 discriminator 3
 998 0974 C56C591D 		vmulps	.LC37(%rip), %ymm2, %ymm11
 998      00000000 
 999              		.loc 1 187 32 discriminator 3
 1000 097c C5FC2895 		vmovaps	-304(%rbp), %ymm2
 1000      D0FEFFFF 
 1001 0984 C5EC5935 		vmulps	.LC38(%rip), %ymm2, %ymm6
 1001      00000000 
 184:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1002              		.loc 1 184 37 discriminator 3
 1003 098c C5855815 		vaddpd	.LC39(%rip), %ymm15, %ymm2
 1003      00000000 
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1004              		.loc 1 186 32 discriminator 3
 1005 0994 C4417C5A 		vcvtps2pd	%xmm13, %ymm15
 1005      FD
 1006 0999 C4437D19 		vextractf128	$0x1, %ymm13, %xmm13
 1006      ED01
 1007 099f C57C288D 		vmovaps	-240(%rbp), %ymm9
 1007      10FFFFFF 
 1008 09a7 C4417C5A 		vcvtps2pd	%xmm13, %ymm13
 1008      ED
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1009              		.loc 1 185 52 discriminator 3
 1010 09ac C4410D58 		vaddpd	%ymm13, %ymm14, %ymm13
 1010      ED
 1011              		.loc 1 187 32 discriminator 3
 1012 09b1 C5D45925 		vmulps	.LC38(%rip), %ymm5, %ymm4
 1012      00000000 
 1013 09b9 C5FC28AD 		vmovaps	-368(%rbp), %ymm5
 1013      90FEFFFF 
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1014              		.loc 1 185 52 discriminator 3
 1015 09c1 C4416D58 		vaddpd	%ymm15, %ymm2, %ymm15
 1015      FF
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1016              		.loc 1 186 32 discriminator 3
 1017 09c6 C534590D 		vmulps	.LC37(%rip), %ymm9, %ymm9
 1017      00000000 
 1018              		.loc 1 187 32 discriminator 3
 1019 09ce C5D4592D 		vmulps	.LC38(%rip), %ymm5, %ymm5
 1019      00000000 
 1020 09d6 C5FC5AD6 		vcvtps2pd	%xmm6, %ymm2
 1021 09da C4E37D19 		vextractf128	$0x1, %ymm6, %xmm6
 1021      F601
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1022              		.loc 1 186 52 discriminator 3
 1023 09e0 C58558D2 		vaddpd	%ymm2, %ymm15, %ymm2
 1024              		.loc 1 187 32 discriminator 3
 1025 09e4 C5FC5AF6 		vcvtps2pd	%xmm6, %ymm6
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1026              		.loc 1 186 52 discriminator 3
 1027 09e8 C51558EE 		vaddpd	%ymm6, %ymm13, %ymm13
 1028              		.loc 1 187 32 discriminator 3
 1029 09ec C5FC591D 		vmulps	.LC38(%rip), %ymm0, %ymm3
 1029      00000000 
 188:RGB2YCbCr.c   ****             /* B */
 189:RGB2YCbCr.c   ****             pixels_out[3*i + 2] =  (unsigned char) (0.5 + 
 190:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1030              		.loc 1 191 32 discriminator 3
 1031 09f4 C57C28BD 		vmovaps	-400(%rbp), %ymm15
 1031      70FEFFFF 
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1032              		.loc 1 183 35 discriminator 3
 1033 09fc C4417DE6 		vcvttpd2dqy	%ymm13, %xmm13
 1033      ED
 1034 0a01 C5FDE6D2 		vcvttpd2dqy	%ymm2, %xmm2
 1035 0a05 C4C36D38 		vinserti128	$0x1, %xmm13, %ymm2, %ymm2
 1035      D501
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1036              		.loc 1 185 32 discriminator 3
 1037 0a0b C4417C5A 		vcvtps2pd	%xmm12, %ymm13
 1037      EC
 1038 0a10 C4437D19 		vextractf128	$0x1, %ymm12, %xmm12
 1038      E401
 184:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1039              		.loc 1 184 37 discriminator 3
 1040 0a16 C5955835 		vaddpd	.LC39(%rip), %ymm13, %ymm6
 1040      00000000 
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1041              		.loc 1 186 32 discriminator 3
 1042 0a1e C4417C5A 		vcvtps2pd	%xmm11, %ymm13
 1042      EB
 1043 0a23 C4437D19 		vextractf128	$0x1, %ymm11, %xmm11
 1043      DB01
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1044              		.loc 1 185 32 discriminator 3
 1045 0a29 C4417C5A 		vcvtps2pd	%xmm12, %ymm12
 1045      E4
 184:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1046              		.loc 1 184 37 discriminator 3
 1047 0a2e C51D5825 		vaddpd	.LC39(%rip), %ymm12, %ymm12
 1047      00000000 
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1048              		.loc 1 186 32 discriminator 3
 1049 0a36 C4417C5A 		vcvtps2pd	%xmm11, %ymm11
 1049      DB
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1050              		.loc 1 183 35 discriminator 3
 1051 0a3b C5EDDB15 		vpand	.LC34(%rip), %ymm2, %ymm2
 1051      00000000 
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1052              		.loc 1 185 52 discriminator 3
 1053 0a43 C4414D58 		vaddpd	%ymm13, %ymm6, %ymm13
 1053      ED
 187:RGB2YCbCr.c   ****             /* B */
 1054              		.loc 1 187 32 discriminator 3
 1055 0a48 C5FC5AF4 		vcvtps2pd	%xmm4, %ymm6
 1056 0a4c C4E37D19 		vextractf128	$0x1, %ymm4, %xmm4
 1056      E401
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1057              		.loc 1 185 52 discriminator 3
 1058 0a52 C4411D58 		vaddpd	%ymm11, %ymm12, %ymm11
 1058      DB
 187:RGB2YCbCr.c   ****             /* B */
 1059              		.loc 1 187 32 discriminator 3
 1060 0a57 C5FC5AE4 		vcvtps2pd	%xmm4, %ymm4
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1061              		.loc 1 186 52 discriminator 3
 1062 0a5b C59558F6 		vaddpd	%ymm6, %ymm13, %ymm6
 1063 0a5f C52558DC 		vaddpd	%ymm4, %ymm11, %ymm11
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1064              		.loc 1 183 35 discriminator 3
 1065 0a63 C5FDE6F6 		vcvttpd2dqy	%ymm6, %xmm6
 1066 0a67 C4417DE6 		vcvttpd2dqy	%ymm11, %xmm11
 1066      DB
 1067 0a6c C4C34D38 		vinserti128	$0x1, %xmm11, %ymm6, %ymm6
 1067      F301
 1068 0a72 C5CDDB35 		vpand	.LC34(%rip), %ymm6, %ymm6
 1068      00000000 
 1069 0a7a C4E26D2B 		vpackusdw	%ymm6, %ymm2, %ymm2
 1069      D6
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1070              		.loc 1 185 32 discriminator 3
 1071 0a7f C4C17C5A 		vcvtps2pd	%xmm10, %ymm6
 1071      F2
 1072 0a84 C4437D19 		vextractf128	$0x1, %ymm10, %xmm10
 1072      D201
 184:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1073              		.loc 1 184 37 discriminator 3
 1074 0a8a C5CD5825 		vaddpd	.LC39(%rip), %ymm6, %ymm4
 1074      00000000 
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1075              		.loc 1 185 32 discriminator 3
 1076 0a92 C4417C5A 		vcvtps2pd	%xmm10, %ymm10
 1076      D2
 184:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1077              		.loc 1 184 37 discriminator 3
 1078 0a97 C52D5815 		vaddpd	.LC39(%rip), %ymm10, %ymm10
 1078      00000000 
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1079              		.loc 1 186 32 discriminator 3
 1080 0a9f C4C17C5A 		vcvtps2pd	%xmm9, %ymm6
 1080      F1
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1081              		.loc 1 183 35 discriminator 3
 1082 0aa4 C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 1082      D2D8
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1083              		.loc 1 186 32 discriminator 3
 1084 0aaa C4437D19 		vextractf128	$0x1, %ymm9, %xmm9
 1084      C901
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1085              		.loc 1 183 35 discriminator 3
 1086 0ab0 C5EDDB15 		vpand	.LC35(%rip), %ymm2, %ymm2
 1086      00000000 
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1087              		.loc 1 185 52 discriminator 3
 1088 0ab8 C5DD58F6 		vaddpd	%ymm6, %ymm4, %ymm6
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1089              		.loc 1 186 32 discriminator 3
 1090 0abc C4417C5A 		vcvtps2pd	%xmm9, %ymm9
 1090      C9
 187:RGB2YCbCr.c   ****             /* B */
 1091              		.loc 1 187 32 discriminator 3
 1092 0ac1 C5FC5AE5 		vcvtps2pd	%xmm5, %ymm4
 1093 0ac5 C4E37D19 		vextractf128	$0x1, %ymm5, %xmm5
 1093      ED01
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1094              		.loc 1 185 52 discriminator 3
 1095 0acb C4412D58 		vaddpd	%ymm9, %ymm10, %ymm9
 1095      C9
 187:RGB2YCbCr.c   ****             /* B */
 1096              		.loc 1 187 32 discriminator 3
 1097 0ad0 C5FC5AED 		vcvtps2pd	%xmm5, %ymm5
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1098              		.loc 1 186 52 discriminator 3
 1099 0ad4 C5CD58E4 		vaddpd	%ymm4, %ymm6, %ymm4
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1100              		.loc 1 185 32 discriminator 3
 1101 0ad8 C4C17C5A 		vcvtps2pd	%xmm8, %ymm6
 1101      F0
 1102 0add C4437D19 		vextractf128	$0x1, %ymm8, %xmm8
 1102      C001
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1103              		.loc 1 186 52 discriminator 3
 1104 0ae3 C53558CD 		vaddpd	%ymm5, %ymm9, %ymm9
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1105              		.loc 1 185 32 discriminator 3
 1106 0ae7 C4417C5A 		vcvtps2pd	%xmm8, %ymm8
 1106      C0
 184:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1107              		.loc 1 184 37 discriminator 3
 1108 0aec C5CD582D 		vaddpd	.LC39(%rip), %ymm6, %ymm5
 1108      00000000 
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1109              		.loc 1 186 32 discriminator 3
 1110 0af4 C5FC5AF7 		vcvtps2pd	%xmm7, %ymm6
 184:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1111              		.loc 1 184 37 discriminator 3
 1112 0af8 C53D5805 		vaddpd	.LC39(%rip), %ymm8, %ymm8
 1112      00000000 
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1113              		.loc 1 186 32 discriminator 3
 1114 0b00 C4E37D19 		vextractf128	$0x1, %ymm7, %xmm7
 1114      FF01
 1115 0b06 C5FC5AFF 		vcvtps2pd	%xmm7, %ymm7
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1116              		.loc 1 183 35 discriminator 3
 1117 0b0a C5FDE6E4 		vcvttpd2dqy	%ymm4, %xmm4
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1118              		.loc 1 185 52 discriminator 3
 1119 0b0e C5D558F6 		vaddpd	%ymm6, %ymm5, %ymm6
 187:RGB2YCbCr.c   ****             /* B */
 1120              		.loc 1 187 32 discriminator 3
 1121 0b12 C5FC5AEB 		vcvtps2pd	%xmm3, %ymm5
 1122 0b16 C4E37D19 		vextractf128	$0x1, %ymm3, %xmm3
 1122      DB01
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1123              		.loc 1 183 35 discriminator 3
 1124 0b1c C4417DE6 		vcvttpd2dqy	%ymm9, %xmm9
 1124      C9
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1125              		.loc 1 185 52 discriminator 3
 1126 0b21 C5BD58FF 		vaddpd	%ymm7, %ymm8, %ymm7
 187:RGB2YCbCr.c   ****             /* B */
 1127              		.loc 1 187 32 discriminator 3
 1128 0b25 C5FC5ADB 		vcvtps2pd	%xmm3, %ymm3
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1129              		.loc 1 183 35 discriminator 3
 1130 0b29 C4C35D38 		vinserti128	$0x1, %xmm9, %ymm4, %ymm4
 1130      E101
 1131 0b2f C5DDDB25 		vpand	.LC34(%rip), %ymm4, %ymm4
 1131      00000000 
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1132              		.loc 1 186 52 discriminator 3
 1133 0b37 C5CD58ED 		vaddpd	%ymm5, %ymm6, %ymm5
 1134              		.loc 1 191 32 discriminator 3
 1135 0b3b C5FC2875 		vmovaps	-80(%rbp), %ymm6
 1135      B0
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1136              		.loc 1 186 52 discriminator 3
 1137 0b40 C5C558FB 		vaddpd	%ymm3, %ymm7, %ymm7
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1138              		.loc 1 183 35 discriminator 3
 1139 0b44 C5FDE6ED 		vcvttpd2dqy	%ymm5, %xmm5
 1140 0b48 C5FDE6FF 		vcvttpd2dqy	%ymm7, %xmm7
 1141 0b4c C4E35538 		vinserti128	$0x1, %xmm7, %ymm5, %ymm5
 1141      EF01
 1142 0b52 C5D5DB2D 		vpand	.LC34(%rip), %ymm5, %ymm5
 1142      00000000 
 1143              		.loc 1 191 32 discriminator 3
 1144 0b5a C584593D 		vmulps	.LC38(%rip), %ymm15, %ymm7
 1144      00000000 
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1145              		.loc 1 183 35 discriminator 3
 1146 0b62 C4E25D2B 		vpackusdw	%ymm5, %ymm4, %ymm4
 1146      E5
 1147 0b67 C4E3FD00 		vpermq	$216, %ymm4, %ymm4
 1147      E4D8
 1148 0b6d C5DDDB25 		vpand	.LC35(%rip), %ymm4, %ymm4
 1148      00000000 
 1149              		.loc 1 191 32 discriminator 3
 1150 0b75 C5CC5935 		vmulps	.LC38(%rip), %ymm6, %ymm6
 1150      00000000 
 1151 0b7d C5FC285D 		vmovaps	-112(%rbp), %ymm3
 1151      90
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1152              		.loc 1 183 35 discriminator 3
 1153 0b82 C5ED67D4 		vpackuswb	%ymm4, %ymm2, %ymm2
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1154              		.loc 1 192 32 discriminator 3
 1155 0b86 C5FC28A5 		vmovaps	-176(%rbp), %ymm4
 1155      50FFFFFF 
 1156 0b8e C57C28B5 		vmovaps	-208(%rbp), %ymm14
 1156      30FFFFFF 
 1157 0b96 C55C591D 		vmulps	.LC40(%rip), %ymm4, %ymm11
 1157      00000000 
 193:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1158              		.loc 1 193 32 discriminator 3
 1159 0b9e C5FC28A5 		vmovaps	-368(%rbp), %ymm4
 1159      90FEFFFF 
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1160              		.loc 1 183 35 discriminator 3
 1161 0ba6 C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 1161      D2D8
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1162              		.loc 1 189 13 is_stmt 1 discriminator 3
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1163              		.loc 1 191 32 is_stmt 0 discriminator 3
 1164 0bac C5E4592D 		vmulps	.LC38(%rip), %ymm3, %ymm5
 1164      00000000 
 1165 0bb4 C5FC289D 		vmovaps	-144(%rbp), %ymm3
 1165      70FFFFFF 
 1166 0bbc C5645905 		vmulps	.LC38(%rip), %ymm3, %ymm8
 1166      00000000 
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1167              		.loc 1 192 32 discriminator 3
 1168 0bc4 C5FC289D 		vmovaps	-272(%rbp), %ymm3
 1168      F0FEFFFF 
 1169 0bcc C5645925 		vmulps	.LC40(%rip), %ymm3, %ymm12
 1169      00000000 
 1170              		.loc 1 193 32 discriminator 3
 1171 0bd4 C5FC289D 		vmovaps	-304(%rbp), %ymm3
 1171      D0FEFFFF 
 1172 0bdc C564593D 		vmulps	.LC41(%rip), %ymm3, %ymm15
 1172      00000000 
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1173              		.loc 1 191 32 discriminator 3
 1174 0be4 C5FC5ADF 		vcvtps2pd	%xmm7, %ymm3
 190:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1175              		.loc 1 190 37 discriminator 3
 1176 0be8 C5E5581D 		vaddpd	.LC39(%rip), %ymm3, %ymm3
 1176      00000000 
 1177              		.loc 1 193 32 discriminator 3
 1178 0bf0 C55C592D 		vmulps	.LC41(%rip), %ymm4, %ymm13
 1178      00000000 
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1179              		.loc 1 192 32 discriminator 3
 1180 0bf8 C4C17C5A 		vcvtps2pd	%xmm11, %ymm4
 1180      E3
 1181 0bfd C4437D19 		vextractf128	$0x1, %ymm11, %xmm11
 1181      DB01
 1182 0c03 C57C288D 		vmovaps	-240(%rbp), %ymm9
 1182      10FFFFFF 
 1183 0c0b C4417C5A 		vcvtps2pd	%xmm11, %ymm11
 1183      DB
 1184 0c10 C50C5915 		vmulps	.LC40(%rip), %ymm14, %ymm10
 1184      00000000 
 1185              		.loc 1 193 32 discriminator 3
 1186 0c18 C57C28B5 		vmovaps	-336(%rbp), %ymm14
 1186      B0FEFFFF 
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1187              		.loc 1 191 52 discriminator 3
 1188 0c20 C5E558DC 		vaddpd	%ymm4, %ymm3, %ymm3
 1189              		.loc 1 193 32 discriminator 3
 1190 0c24 C50C5935 		vmulps	.LC41(%rip), %ymm14, %ymm14
 1190      00000000 
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1191              		.loc 1 192 32 discriminator 3
 1192 0c2c C534590D 		vmulps	.LC40(%rip), %ymm9, %ymm9
 1192      00000000 
 1193              		.loc 1 193 32 discriminator 3
 1194 0c34 C4C17C5A 		vcvtps2pd	%xmm15, %ymm4
 1194      E7
 1195 0c39 C4437D19 		vextractf128	$0x1, %ymm15, %xmm15
 1195      FF01
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1196              		.loc 1 192 52 discriminator 3
 1197 0c3f C5E558DC 		vaddpd	%ymm4, %ymm3, %ymm3
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1198              		.loc 1 191 32 discriminator 3
 1199 0c43 C4E37D19 		vextractf128	$0x1, %ymm7, %xmm4
 1199      FC01
 1200              		.loc 1 193 32 discriminator 3
 1201 0c49 C4417C5A 		vcvtps2pd	%xmm15, %ymm15
 1201      FF
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1202              		.loc 1 191 32 discriminator 3
 1203 0c4e C5FC5AE4 		vcvtps2pd	%xmm4, %ymm4
 190:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1204              		.loc 1 190 37 discriminator 3
 1205 0c52 C5DD5825 		vaddpd	.LC39(%rip), %ymm4, %ymm4
 1205      00000000 
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1206              		.loc 1 192 32 discriminator 3
 1207 0c5a C4C17C5A 		vcvtps2pd	%xmm10, %ymm7
 1207      FA
 1208 0c5f C4437D19 		vextractf128	$0x1, %ymm10, %xmm10
 1208      D201
 1209 0c65 C4417C5A 		vcvtps2pd	%xmm10, %ymm10
 1209      D2
 1210              		.loc 1 193 32 discriminator 3
 1211 0c6a C5FC5905 		vmulps	.LC41(%rip), %ymm0, %ymm0
 1211      00000000 
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1212              		.loc 1 191 52 discriminator 3
 1213 0c72 C4C15D58 		vaddpd	%ymm11, %ymm4, %ymm4
 1213      E3
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1214              		.loc 1 192 52 discriminator 3
 1215 0c77 C4415D58 		vaddpd	%ymm15, %ymm4, %ymm15
 1215      FF
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1216              		.loc 1 189 36 discriminator 3
 1217 0c7c C5FDE6E3 		vcvttpd2dqy	%ymm3, %xmm4
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1218              		.loc 1 191 32 discriminator 3
 1219 0c80 C5FC5ADE 		vcvtps2pd	%xmm6, %ymm3
 1220 0c84 C4E37D19 		vextractf128	$0x1, %ymm6, %xmm6
 1220      F601
 190:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1221              		.loc 1 190 37 discriminator 3
 1222 0c8a C5E5581D 		vaddpd	.LC39(%rip), %ymm3, %ymm3
 1222      00000000 
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1223              		.loc 1 191 32 discriminator 3
 1224 0c92 C5FC5AF6 		vcvtps2pd	%xmm6, %ymm6
 190:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1225              		.loc 1 190 37 discriminator 3
 1226 0c96 C5CD5835 		vaddpd	.LC39(%rip), %ymm6, %ymm6
 1226      00000000 
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1227              		.loc 1 189 36 discriminator 3
 1228 0c9e C4417DE6 		vcvttpd2dqy	%ymm15, %xmm15
 1228      FF
 1229 0ca3 C4C35D38 		vinserti128	$0x1, %xmm15, %ymm4, %ymm4
 1229      E701
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1230              		.loc 1 191 52 discriminator 3
 1231 0ca9 C5E558DF 		vaddpd	%ymm7, %ymm3, %ymm3
 1232 0cad C4414D58 		vaddpd	%ymm10, %ymm6, %ymm10
 1232      D2
 1233              		.loc 1 193 32 discriminator 3
 1234 0cb2 C4C17C5A 		vcvtps2pd	%xmm14, %ymm7
 1234      FE
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1235              		.loc 1 192 32 discriminator 3
 1236 0cb7 C4C17C5A 		vcvtps2pd	%xmm9, %ymm6
 1236      F1
 1237              		.loc 1 193 32 discriminator 3
 1238 0cbc C4437D19 		vextractf128	$0x1, %ymm14, %xmm14
 1238      F601
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1239              		.loc 1 192 32 discriminator 3
 1240 0cc2 C4437D19 		vextractf128	$0x1, %ymm9, %xmm9
 1240      C901
 1241              		.loc 1 193 32 discriminator 3
 1242 0cc8 C4417C5A 		vcvtps2pd	%xmm14, %ymm14
 1242      F6
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1243              		.loc 1 192 32 discriminator 3
 1244 0ccd C4417C5A 		vcvtps2pd	%xmm9, %ymm9
 1244      C9
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1245              		.loc 1 192 52 discriminator 3
 1246 0cd2 C5E558DF 		vaddpd	%ymm7, %ymm3, %ymm3
 1247 0cd6 C4412D58 		vaddpd	%ymm14, %ymm10, %ymm14
 1247      F6
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1248              		.loc 1 189 36 discriminator 3
 1249 0cdb C5FDE6DB 		vcvttpd2dqy	%ymm3, %xmm3
 1250 0cdf C4417DE6 		vcvttpd2dqy	%ymm14, %xmm14
 1250      F6
 1251 0ce4 C4436538 		vinserti128	$0x1, %xmm14, %ymm3, %ymm14
 1251      F601
 1252 0cea C5DDDB1D 		vpand	.LC34(%rip), %ymm4, %ymm3
 1252      00000000 
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1253              		.loc 1 191 32 discriminator 3
 1254 0cf2 C5FC5AE5 		vcvtps2pd	%xmm5, %ymm4
 1255 0cf6 C4E37D19 		vextractf128	$0x1, %ymm5, %xmm5
 1255      ED01
 190:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1256              		.loc 1 190 37 discriminator 3
 1257 0cfc C5DD5825 		vaddpd	.LC39(%rip), %ymm4, %ymm4
 1257      00000000 
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1258              		.loc 1 189 36 discriminator 3
 1259 0d04 C50DDB35 		vpand	.LC34(%rip), %ymm14, %ymm14
 1259      00000000 
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1260              		.loc 1 191 32 discriminator 3
 1261 0d0c C5FC5AED 		vcvtps2pd	%xmm5, %ymm5
 190:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1262              		.loc 1 190 37 discriminator 3
 1263 0d10 C5D5582D 		vaddpd	.LC39(%rip), %ymm5, %ymm5
 1263      00000000 
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1264              		.loc 1 189 36 discriminator 3
 1265 0d18 C4C2652B 		vpackusdw	%ymm14, %ymm3, %ymm3
 1265      DE
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1266              		.loc 1 191 52 discriminator 3
 1267 0d1d C5DD58E6 		vaddpd	%ymm6, %ymm4, %ymm4
 1268              		.loc 1 193 32 discriminator 3
 1269 0d21 C4C17C5A 		vcvtps2pd	%xmm13, %ymm6
 1269      F5
 1270 0d26 C4437D19 		vextractf128	$0x1, %ymm13, %xmm13
 1270      ED01
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1271              		.loc 1 189 36 discriminator 3
 1272 0d2c C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 1272      DBD8
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1273              		.loc 1 191 52 discriminator 3
 1274 0d32 C4415558 		vaddpd	%ymm9, %ymm5, %ymm9
 1274      C9
 1275              		.loc 1 193 32 discriminator 3
 1276 0d37 C4417C5A 		vcvtps2pd	%xmm13, %ymm13
 1276      ED
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1277              		.loc 1 192 32 discriminator 3
 1278 0d3c C4C17C5A 		vcvtps2pd	%xmm12, %ymm5
 1278      EC
 1279 0d41 C4437D19 		vextractf128	$0x1, %ymm12, %xmm12
 1279      E401
 1280 0d47 C4417C5A 		vcvtps2pd	%xmm12, %ymm12
 1280      E4
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1281              		.loc 1 192 52 discriminator 3
 1282 0d4c C5DD58E6 		vaddpd	%ymm6, %ymm4, %ymm4
 1283 0d50 C4413558 		vaddpd	%ymm13, %ymm9, %ymm13
 1283      ED
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1284              		.loc 1 189 36 discriminator 3
 1285 0d55 C5FDE6E4 		vcvttpd2dqy	%ymm4, %xmm4
 1286 0d59 C4417DE6 		vcvttpd2dqy	%ymm13, %xmm13
 1286      ED
 1287 0d5e C4435D38 		vinserti128	$0x1, %xmm13, %ymm4, %ymm13
 1287      ED01
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1288              		.loc 1 191 32 discriminator 3
 1289 0d64 C4C17C5A 		vcvtps2pd	%xmm8, %ymm4
 1289      E0
 1290 0d69 C4437D19 		vextractf128	$0x1, %ymm8, %xmm8
 1290      C001
 190:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1291              		.loc 1 190 37 discriminator 3
 1292 0d6f C5DD5825 		vaddpd	.LC39(%rip), %ymm4, %ymm4
 1292      00000000 
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1293              		.loc 1 191 32 discriminator 3
 1294 0d77 C4417C5A 		vcvtps2pd	%xmm8, %ymm8
 1294      C0
 190:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1295              		.loc 1 190 37 discriminator 3
 1296 0d7c C53D5805 		vaddpd	.LC39(%rip), %ymm8, %ymm8
 1296      00000000 
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1297              		.loc 1 191 52 discriminator 3
 1298 0d84 C5DD58E5 		vaddpd	%ymm5, %ymm4, %ymm4
 1299 0d88 C4413D58 		vaddpd	%ymm12, %ymm8, %ymm12
 1299      E4
 1300              		.loc 1 193 32 discriminator 3
 1301 0d8d C5FC5AE8 		vcvtps2pd	%xmm0, %ymm5
 1302 0d91 C4E37D19 		vextractf128	$0x1, %ymm0, %xmm0
 1302      C001
 1303 0d97 C5FC5AC0 		vcvtps2pd	%xmm0, %ymm0
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1304              		.loc 1 192 52 discriminator 3
 1305 0d9b C5DD58E5 		vaddpd	%ymm5, %ymm4, %ymm4
 1306 0d9f C59D58C0 		vaddpd	%ymm0, %ymm12, %ymm0
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1307              		.loc 1 189 36 discriminator 3
 1308 0da3 C5FDE6E4 		vcvttpd2dqy	%ymm4, %xmm4
 1309 0da7 C5FDE6C0 		vcvttpd2dqy	%ymm0, %xmm0
 1310 0dab C4E35D38 		vinserti128	$0x1, %xmm0, %ymm4, %ymm4
 1310      E001
 1311 0db1 C595DB05 		vpand	.LC34(%rip), %ymm13, %ymm0
 1311      00000000 
 1312 0db9 C55DDB2D 		vpand	.LC34(%rip), %ymm4, %ymm13
 1312      00000000 
 1313 0dc1 C5E5DB1D 		vpand	.LC35(%rip), %ymm3, %ymm3
 1313      00000000 
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1314              		.loc 1 189 33 discriminator 3
 1315 0dc9 C4E27500 		vpshufb	.LC42(%rip), %ymm1, %ymm4
 1315      25000000 
 1315      00
 1316 0dd2 C4E3FD00 		vpermq	$78, %ymm4, %ymm6
 1316      F44E
 1317 0dd8 C5FD6F3D 		vmovdqa	.LC53(%rip), %ymm7
 1317      00000000 
 1318 0de0 C4E27500 		vpshufb	.LC44(%rip), %ymm1, %ymm4
 1318      25000000 
 1318      00
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1319              		.loc 1 189 36 discriminator 3
 1320 0de9 C4C27D2B 		vpackusdw	%ymm13, %ymm0, %ymm0
 1320      C5
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1321              		.loc 1 189 33 discriminator 3
 1322 0dee C5DDEBE6 		vpor	%ymm6, %ymm4, %ymm4
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1323              		.loc 1 189 36 discriminator 3
 1324 0df2 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 1324      C0D8
 1325 0df8 C5FDDB05 		vpand	.LC35(%rip), %ymm0, %ymm0
 1325      00000000 
 1326 0e00 C5E567C0 		vpackuswb	%ymm0, %ymm3, %ymm0
 1327 0e04 C4E3FD00 		vpermq	$216, %ymm0, %ymm3
 1327      D8D8
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1328              		.loc 1 189 33 discriminator 3
 1329 0e0a C4E26D00 		vpshufb	.LC43(%rip), %ymm2, %ymm0
 1329      05000000 
 1329      00
 1330 0e13 C4E3FD00 		vpermq	$78, %ymm0, %ymm5
 1330      E84E
 1331 0e19 C4E26D00 		vpshufb	.LC45(%rip), %ymm2, %ymm0
 1331      05000000 
 1331      00
 1332 0e22 C5FDEBC5 		vpor	%ymm5, %ymm0, %ymm0
 1333 0e26 C5DDEBE0 		vpor	%ymm0, %ymm4, %ymm4
 1334 0e2a C4E26500 		vpshufb	.LC46(%rip), %ymm3, %ymm0
 1334      05000000 
 1334      00
 1335 0e33 C4E25D00 		vpshufb	.LC47(%rip), %ymm4, %ymm4
 1335      25000000 
 1335      00
 1336 0e3c C4E3FD00 		vpermq	$78, %ymm0, %ymm5
 1336      E84E
 1337 0e42 C4E26500 		vpshufb	.LC48(%rip), %ymm3, %ymm0
 1337      05000000 
 1337      00
 1338 0e4b C5FDEBC5 		vpor	%ymm5, %ymm0, %ymm0
 1339 0e4f C4E26D00 		vpshufb	.LC51(%rip), %ymm2, %ymm5
 1339      2D000000 
 1339      00
 1340 0e58 C5DDEBE0 		vpor	%ymm0, %ymm4, %ymm4
 1341 0e5c C4E27500 		vpshufb	.LC49(%rip), %ymm1, %ymm0
 1341      05000000 
 1341      00
 1342 0e65 C5FE7F62 		vmovdqu	%ymm4, -96(%rdx)
 1342      A0
 1343 0e6a C4E3FD00 		vpermq	$78, %ymm0, %ymm4
 1343      E04E
 1344 0e70 C4E27500 		vpshufb	.LC50(%rip), %ymm1, %ymm0
 1344      05000000 
 1344      00
 1345 0e79 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 1346 0e7d C4E26500 		vpshufb	.LC52(%rip), %ymm3, %ymm4
 1346      25000000 
 1346      00
 1347 0e86 C5FDEBC5 		vpor	%ymm5, %ymm0, %ymm0
 1348 0e8a C4E37D4C 		vpblendvb	%ymm7, %ymm4, %ymm0, %ymm0
 1348      C470
 1349 0e90 C4E26D00 		vpshufb	.LC55(%rip), %ymm2, %ymm4
 1349      25000000 
 1349      00
 1350 0e99 C4E26D00 		vpshufb	.LC57(%rip), %ymm2, %ymm2
 1350      15000000 
 1350      00
 1351 0ea2 C5FE7F42 		vmovdqu	%ymm0, -64(%rdx)
 1351      C0
 1352 0ea7 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 1352      E44E
 1353 0ead C4E27500 		vpshufb	.LC54(%rip), %ymm1, %ymm0
 1353      05000000 
 1353      00
 1354 0eb6 C4E3FD00 		vpermq	$78, %ymm0, %ymm5
 1354      E84E
 1355 0ebc C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 1356 0ec0 C4E27500 		vpshufb	.LC56(%rip), %ymm1, %ymm0
 1356      05000000 
 1356      00
 1357 0ec9 C4E26500 		vpshufb	.LC58(%rip), %ymm3, %ymm1
 1357      0D000000 
 1357      00
 1358 0ed2 C5FDEBC5 		vpor	%ymm5, %ymm0, %ymm0
 1359 0ed6 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 1360 0eda C4E3FD00 		vpermq	$78, %ymm1, %ymm2
 1360      D14E
 1361 0ee0 C4E26500 		vpshufb	.LC60(%rip), %ymm3, %ymm1
 1361      0D000000 
 1361      00
 1362 0ee9 C4E27D00 		vpshufb	.LC59(%rip), %ymm0, %ymm0
 1362      05000000 
 1362      00
 1363 0ef2 C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 1364 0ef6 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 1365 0efa C5FE7F42 		vmovdqu	%ymm0, -32(%rdx)
 1365      E0
 174:RGB2YCbCr.c   ****         {
 1366              		.loc 1 174 43 is_stmt 1 discriminator 3
 174:RGB2YCbCr.c   ****         {
 1367              		.loc 1 174 25 discriminator 3
 1368 0eff 4C39E0   		cmpq	%r12, %rax
 1369 0f02 0F85B0F5 		jne	.L26
 1369      FFFF
 1370 0f08 8B8558FE 		movl	-424(%rbp), %eax
 1370      FFFF
 1371 0f0e 4139C5   		cmpl	%eax, %r13d
 1372 0f11 0F84AD01 		je	.L35
 1372      0000
 174:RGB2YCbCr.c   ****         {
 1373              		.loc 1 174 18 is_stmt 0
 1374 0f17 89C6     		movl	%eax, %esi
 1375 0f19 C5F877   		vzeroupper
 1376              	.L25:
 1377 0f1c 488B8568 		movq	-408(%rbp), %rax
 1377      FEFFFF
 1378 0f23 8D1476   		leal	(%rsi,%rsi,2), %edx
 1379 0f26 C57A1015 		vmovss	.LC1(%rip), %xmm10
 1379      00000000 
 1380 0f2e 4863D2   		movslq	%edx, %rdx
 1381 0f31 C57B100D 		vmovsd	.LC61(%rip), %xmm9
 1381      00000000 
 1382 0f39 C57A1005 		vmovss	.LC3(%rip), %xmm8
 1382      00000000 
 1383 0f41 C5FA103D 		vmovss	.LC4(%rip), %xmm7
 1383      00000000 
 1384 0f49 C5FA1035 		vmovss	.LC5(%rip), %xmm6
 1384      00000000 
 1385 0f51 4801D0   		addq	%rdx, %rax
 1386 0f54 C5FB1015 		vmovsd	.LC62(%rip), %xmm2
 1386      00000000 
 1387 0f5c C5FA102D 		vmovss	.LC7(%rip), %xmm5
 1387      00000000 
 1388 0f64 C5FA100D 		vmovss	.LC8(%rip), %xmm1
 1388      00000000 
 1389 0f6c C5FA1025 		vmovss	.LC9(%rip), %xmm4
 1389      00000000 
 1390 0f74 C5FA101D 		vmovss	.LC10(%rip), %xmm3
 1390      00000000 
 1391 0f7c 48039560 		addq	-416(%rbp), %rdx
 1391      FEFFFF
 1392              		.p2align 4,,10
 1393 0f83 0F1F4400 		.p2align 3
 1393      00
 1394              	.L28:
 1395              	.LVL57:
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 1396              		.loc 1 177 13 is_stmt 1
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1397              		.loc 1 179 42 is_stmt 0
 1398 0f88 0FB608   		movzbl	(%rax), %ecx
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1399              		.loc 1 179 32
 1400 0f8b C4410057 		vxorps	%xmm15, %xmm15, %xmm15
 1400      FF
 174:RGB2YCbCr.c   ****         {
 1401              		.loc 1 174 44
 1402 0f90 FFC6     		incl	%esi
 1403              	.LVL58:
 1404 0f92 4883C003 		addq	$3, %rax
 1405 0f96 4883C203 		addq	$3, %rdx
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1406              		.loc 1 179 32
 1407 0f9a C5822AC1 		vcvtsi2ssl	%ecx, %xmm15, %xmm0
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1408              		.loc 1 180 42
 1409 0f9e 0FB648FE 		movzbl	-2(%rax), %ecx
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1410              		.loc 1 180 32
 1411 0fa2 C5022AD9 		vcvtsi2ssl	%ecx, %xmm15, %xmm11
 181:RGB2YCbCr.c   ****             /* G */
 1412              		.loc 1 181 42
 1413 0fa6 0FB648FF 		movzbl	-1(%rax), %ecx
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1414              		.loc 1 179 32
 1415 0faa C4C17A59 		vmulss	%xmm10, %xmm0, %xmm0
 1415      C2
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1416              		.loc 1 180 32
 1417 0faf C4412259 		vmulss	%xmm8, %xmm11, %xmm11
 1417      D8
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1418              		.loc 1 179 32
 1419 0fb4 C5FA5AC0 		vcvtss2sd	%xmm0, %xmm0, %xmm0
 178:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 1420              		.loc 1 178 37
 1421 0fb8 C4C17B58 		vaddsd	%xmm9, %xmm0, %xmm0
 1421      C1
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1422              		.loc 1 180 32
 1423 0fbd C441225A 		vcvtss2sd	%xmm11, %xmm11, %xmm11
 1423      DB
 179:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1424              		.loc 1 179 52
 1425 0fc2 C4C17B58 		vaddsd	%xmm11, %xmm0, %xmm0
 1425      C3
 181:RGB2YCbCr.c   ****             /* G */
 1426              		.loc 1 181 32
 1427 0fc7 C5022AD9 		vcvtsi2ssl	%ecx, %xmm15, %xmm11
 1428 0fcb C52259DF 		vmulss	%xmm7, %xmm11, %xmm11
 1429 0fcf C441225A 		vcvtss2sd	%xmm11, %xmm11, %xmm11
 1429      DB
 180:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1430              		.loc 1 180 52
 1431 0fd4 C4C17B58 		vaddsd	%xmm11, %xmm0, %xmm0
 1431      C3
 177:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 1432              		.loc 1 177 35
 1433 0fd9 C5FB2CC8 		vcvttsd2sil	%xmm0, %ecx
 1434 0fdd 884AFD   		movb	%cl, -3(%rdx)
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1435              		.loc 1 183 13 is_stmt 1
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1436              		.loc 1 185 42 is_stmt 0
 1437 0fe0 0FB648FD 		movzbl	-3(%rax), %ecx
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1438              		.loc 1 185 32
 1439 0fe4 C5822AC1 		vcvtsi2ssl	%ecx, %xmm15, %xmm0
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1440              		.loc 1 186 42
 1441 0fe8 0FB648FE 		movzbl	-2(%rax), %ecx
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1442              		.loc 1 186 32
 1443 0fec C5022AD9 		vcvtsi2ssl	%ecx, %xmm15, %xmm11
 187:RGB2YCbCr.c   ****             /* B */
 1444              		.loc 1 187 42
 1445 0ff0 0FB648FF 		movzbl	-1(%rax), %ecx
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1446              		.loc 1 185 32
 1447 0ff4 C5FA59C6 		vmulss	%xmm6, %xmm0, %xmm0
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1448              		.loc 1 186 32
 1449 0ff8 C52259DD 		vmulss	%xmm5, %xmm11, %xmm11
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1450              		.loc 1 185 32
 1451 0ffc C5FA5AC0 		vcvtss2sd	%xmm0, %xmm0, %xmm0
 184:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1452              		.loc 1 184 37
 1453 1000 C5FB58C2 		vaddsd	%xmm2, %xmm0, %xmm0
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1454              		.loc 1 186 32
 1455 1004 C441225A 		vcvtss2sd	%xmm11, %xmm11, %xmm11
 1455      DB
 185:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1456              		.loc 1 185 52
 1457 1009 C4C17B58 		vaddsd	%xmm11, %xmm0, %xmm0
 1457      C3
 187:RGB2YCbCr.c   ****             /* B */
 1458              		.loc 1 187 32
 1459 100e C5022AD9 		vcvtsi2ssl	%ecx, %xmm15, %xmm11
 1460 1012 C52259D9 		vmulss	%xmm1, %xmm11, %xmm11
 1461 1016 C441225A 		vcvtss2sd	%xmm11, %xmm11, %xmm11
 1461      DB
 186:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1462              		.loc 1 186 52
 1463 101b C4C17B58 		vaddsd	%xmm11, %xmm0, %xmm0
 1463      C3
 183:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1464              		.loc 1 183 35
 1465 1020 C5FB2CC8 		vcvttsd2sil	%xmm0, %ecx
 1466 1024 884AFE   		movb	%cl, -2(%rdx)
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1467              		.loc 1 189 13 is_stmt 1
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1468              		.loc 1 191 42 is_stmt 0
 1469 1027 0FB648FD 		movzbl	-3(%rax), %ecx
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1470              		.loc 1 191 32
 1471 102b C5822AC1 		vcvtsi2ssl	%ecx, %xmm15, %xmm0
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1472              		.loc 1 192 42
 1473 102f 0FB648FE 		movzbl	-2(%rax), %ecx
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1474              		.loc 1 192 32
 1475 1033 C5022AD9 		vcvtsi2ssl	%ecx, %xmm15, %xmm11
 1476              		.loc 1 193 42
 1477 1037 0FB648FF 		movzbl	-1(%rax), %ecx
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1478              		.loc 1 191 32
 1479 103b C5FA59C1 		vmulss	%xmm1, %xmm0, %xmm0
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1480              		.loc 1 192 32
 1481 103f C52259DC 		vmulss	%xmm4, %xmm11, %xmm11
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1482              		.loc 1 191 32
 1483 1043 C5FA5AC0 		vcvtss2sd	%xmm0, %xmm0, %xmm0
 190:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1484              		.loc 1 190 37
 1485 1047 C5FB58C2 		vaddsd	%xmm2, %xmm0, %xmm0
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1486              		.loc 1 192 32
 1487 104b C441225A 		vcvtss2sd	%xmm11, %xmm11, %xmm11
 1487      DB
 191:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1488              		.loc 1 191 52
 1489 1050 C4C17B58 		vaddsd	%xmm11, %xmm0, %xmm0
 1489      C3
 1490              		.loc 1 193 32
 1491 1055 C5022AD9 		vcvtsi2ssl	%ecx, %xmm15, %xmm11
 1492 1059 C52259DB 		vmulss	%xmm3, %xmm11, %xmm11
 1493 105d C441225A 		vcvtss2sd	%xmm11, %xmm11, %xmm11
 1493      DB
 192:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 1494              		.loc 1 192 52
 1495 1062 C4C17B58 		vaddsd	%xmm11, %xmm0, %xmm0
 1495      C3
 189:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1496              		.loc 1 189 36
 1497 1067 C5FB2CC8 		vcvttsd2sil	%xmm0, %ecx
 1498 106b 884AFF   		movb	%cl, -1(%rdx)
 174:RGB2YCbCr.c   ****         {
 1499              		.loc 1 174 43 is_stmt 1
 1500              	.LVL59:
 174:RGB2YCbCr.c   ****         {
 1501              		.loc 1 174 25
 174:RGB2YCbCr.c   ****         {
 1502              		.loc 1 174 9 is_stmt 0
 1503 106e 4139F5   		cmpl	%esi, %r13d
 1504 1071 0F8F11FF 		jg	.L28
 1504      FFFF
 1505              	.LVL60:
 1506              	.L31:
 1507              	.LBE19:
 194:RGB2YCbCr.c   ****         }
 195:RGB2YCbCr.c   ****         dummy(image_in, image_out);
 1508              		.loc 1 195 9 is_stmt 1
 1509 1077 4C89F6   		movq	%r14, %rsi
 1510 107a 4C89FF   		movq	%r15, %rdi
 1511 107d E8000000 		call	dummy
 1511      00
 1512              	.LVL61:
 171:RGB2YCbCr.c   ****     {
 1513              		.loc 1 171 34
 171:RGB2YCbCr.c   ****     {
 1514              		.loc 1 171 22
 171:RGB2YCbCr.c   ****     {
 1515              		.loc 1 171 5 is_stmt 0
 1516 1082 FFCB     		decl	%ebx
 1517 1084 0F8506F4 		jne	.L24
 1517      FFFF
 1518              	.L29:
 1519              	.LBE22:
 196:RGB2YCbCr.c   ****     }
 197:RGB2YCbCr.c   ****     end_t = get_wall_time();
 1520              		.loc 1 197 5 is_stmt 1
 1521              		.loc 1 197 13 is_stmt 0
 1522 108a 31C0     		xorl	%eax, %eax
 1523 108c E8000000 		call	get_wall_time
 1523      00
 1524              	.LVL62:
 198:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast0");
 1525              		.loc 1 198 5 is_stmt 1
 1526 1091 C5FB5C85 		vsubsd	-432(%rbp), %xmm0, %xmm0
 1526      50FEFFFF 
 1527              	.LVL63:
 1528 1099 4489EF   		movl	%r13d, %edi
 199:RGB2YCbCr.c   **** }
 1529              		.loc 1 199 1 is_stmt 0
 1530 109c 4881C488 		addq	$392, %rsp
 1530      010000
 1531 10a3 5B       		popq	%rbx
 1532 10a4 415C     		popq	%r12
 198:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast0");
 1533              		.loc 1 198 5
 1534 10a6 BE000000 		movl	$.LC63, %esi
 1534      00
 1535              		.loc 1 199 1
 1536 10ab 415D     		popq	%r13
 1537              		.cfi_remember_state
 1538              		.cfi_def_cfa 13, 0
 1539 10ad 415E     		popq	%r14
 1540              	.LVL64:
 1541 10af 415F     		popq	%r15
 1542              	.LVL65:
 1543 10b1 5D       		popq	%rbp
 1544              	.LVL66:
 1545 10b2 498D65F0 		leaq	-16(%r13), %rsp
 1546              		.cfi_def_cfa 7, 16
 1547              	.LVL67:
 1548 10b6 415D     		popq	%r13
 1549              		.cfi_def_cfa_offset 8
 198:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast0");
 1550              		.loc 1 198 5
 1551 10b8 E9000000 		jmp	results
 1551      00
 1552              	.LVL68:
 1553              	.L32:
 1554              		.cfi_restore_state
 1555              	.LBB23:
 1556              	.LBB20:
 174:RGB2YCbCr.c   ****         {
 1557              		.loc 1 174 18
 1558 10bd 31F6     		xorl	%esi, %esi
 1559 10bf E958FEFF 		jmp	.L25
 1559      FF
 1560              	.LVL69:
 1561              	.L35:
 1562 10c4 C5F877   		vzeroupper
 1563              	.LBE20:
 195:RGB2YCbCr.c   ****     }
 1564              		.loc 1 195 9 is_stmt 1
 1565 10c7 4C89F6   		movq	%r14, %rsi
 1566 10ca 4C89FF   		movq	%r15, %rdi
 1567 10cd E8000000 		call	dummy
 1567      00
 1568              	.LVL70:
 171:RGB2YCbCr.c   ****     {
 1569              		.loc 1 171 34
 171:RGB2YCbCr.c   ****     {
 1570              		.loc 1 171 22
 171:RGB2YCbCr.c   ****     {
 1571              		.loc 1 171 5 is_stmt 0
 1572 10d2 FFCB     		decl	%ebx
 1573 10d4 0F85B6F3 		jne	.L24
 1573      FFFF
 1574 10da EBAE     		jmp	.L29
 1575              	.LVL71:
 1576              	.L37:
 1577              	.LBE23:
 159:RGB2YCbCr.c   ****         exit(-1);
 1578              		.loc 1 159 9 is_stmt 1
 1579 10dc BF000000 		movl	$.LC0, %edi
 1579      00
 1580              	.LVL72:
 1581 10e1 E8000000 		call	puts
 1581      00
 1582              	.LVL73:
 160:RGB2YCbCr.c   ****     }
 1583              		.loc 1 160 9
 1584 10e6 83CFFF   		orl	$-1, %edi
 1585 10e9 E8000000 		call	exit
 1585      00
 1586              	.LVL74:
 1587              		.cfi_endproc
 1588              	.LFE16:
 1590              		.section	.rodata.str1.1
 1591              	.LC66:
 1592 0033 52474232 		.string	"RGB2Gray_cast1"
 1592      47726179 
 1592      5F636173 
 1592      743100
 1593              		.text
 1594 10ee 6690     		.p2align 4
 1595              		.globl	RGB2YCbCr_cast1
 1597              	RGB2YCbCr_cast1:
 1598              	.LFB17:
 200:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
 201:RGB2YCbCr.c   **** 
 202:RGB2YCbCr.c   **** /* cambios respecto RGB2YCbCr_cast0(): cast de la constante 0.5 a float */
 203:RGB2YCbCr.c   **** void
 204:RGB2YCbCr.c   **** RGB2YCbCr_cast1(image_t * restrict image_in, image_t * restrict image_out)
 205:RGB2YCbCr.c   **** {
 1599              		.loc 1 205 1
 1600              		.cfi_startproc
 1601              	.LVL75:
 206:RGB2YCbCr.c   ****     double start_t, end_t;
 1602              		.loc 1 206 5
 207:RGB2YCbCr.c   ****     const int height = image_in->height;
 1603              		.loc 1 207 5
 205:RGB2YCbCr.c   ****     double start_t, end_t;
 1604              		.loc 1 205 1 is_stmt 0
 1605 10f0 4155     		pushq	%r13
 1606              		.cfi_def_cfa_offset 16
 1607              		.cfi_offset 13, -16
 1608 10f2 4C8D6C24 		leaq	16(%rsp), %r13
 1608      10
 1609              		.cfi_def_cfa 13, 0
 1610 10f7 4883E4E0 		andq	$-32, %rsp
 1611 10fb 41FF75F8 		pushq	-8(%r13)
 1612 10ff 55       		pushq	%rbp
 1613              		.cfi_escape 0x10,0x6,0x2,0x76,0
 1614 1100 4889E5   		movq	%rsp, %rbp
 1615 1103 4157     		pushq	%r15
 1616 1105 4156     		pushq	%r14
 1617 1107 4155     		pushq	%r13
 1618              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 1619              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 1620              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 1621 1109 4154     		pushq	%r12
 1622 110b 53       		pushq	%rbx
 1623 110c 4881EC88 		subq	$136, %rsp
 1623      000000
 1624              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 1625              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
 208:RGB2YCbCr.c   ****     const int width =  image_in->width;
 209:RGB2YCbCr.c   ****     unsigned char * restrict pixels_in  = image_in->pixels;
 1626              		.loc 1 209 30
 1627 1113 488B07   		movq	(%rdi), %rax
 210:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 211:RGB2YCbCr.c   **** 
 212:RGB2YCbCr.c   ****     if (image_in->bytes_per_pixel != 3)
 1628              		.loc 1 212 8
 1629 1116 837F1003 		cmpl	$3, 16(%rdi)
 207:RGB2YCbCr.c   ****     const int width =  image_in->width;
 1630              		.loc 1 207 15
 1631 111a 8B5F0C   		movl	12(%rdi), %ebx
 1632              	.LVL76:
 208:RGB2YCbCr.c   ****     const int width =  image_in->width;
 1633              		.loc 1 208 5 is_stmt 1
 208:RGB2YCbCr.c   ****     const int width =  image_in->width;
 1634              		.loc 1 208 15 is_stmt 0
 1635 111d 448B6F08 		movl	8(%rdi), %r13d
 1636              	.LVL77:
 209:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 1637              		.loc 1 209 5 is_stmt 1
 209:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 1638              		.loc 1 209 30 is_stmt 0
 1639 1121 48898568 		movq	%rax, -152(%rbp)
 1639      FFFFFF
 1640              	.LVL78:
 210:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 1641              		.loc 1 210 5 is_stmt 1
 210:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 1642              		.loc 1 210 30 is_stmt 0
 1643 1128 488B06   		movq	(%rsi), %rax
 1644              	.LVL79:
 1645 112b 48898560 		movq	%rax, -160(%rbp)
 1645      FFFFFF
 1646              	.LVL80:
 1647              		.loc 1 212 5 is_stmt 1
 1648              		.loc 1 212 8 is_stmt 0
 1649 1132 0F853308 		jne	.L52
 1649      0000
 213:RGB2YCbCr.c   ****     {
 214:RGB2YCbCr.c   ****         printf("ERROR: input image has to be RGB\n");
 215:RGB2YCbCr.c   ****         exit(-1);
 216:RGB2YCbCr.c   ****     }
 217:RGB2YCbCr.c   ****     
 218:RGB2YCbCr.c   ****     /* fill struct fields */
 219:RGB2YCbCr.c   ****     image_out->width  = width;
 220:RGB2YCbCr.c   ****     image_out->height = height;
 221:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 1650              		.loc 1 221 32
 1651 1138 48B80300 		movabsq	$12884901891, %rax
 1651      00000300 
 1651      0000
 1652              	.LVL81:
 219:RGB2YCbCr.c   ****     image_out->height = height;
 1653              		.loc 1 219 23
 1654 1142 44896E08 		movl	%r13d, 8(%rsi)
 1655              	.LBB24:
 1656              	.LBB25:
 222:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 223:RGB2YCbCr.c   **** 
 224:RGB2YCbCr.c   ****     start_t = get_wall_time();
 225:RGB2YCbCr.c   **** 
 226:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 227:RGB2YCbCr.c   ****     {
 228:RGB2YCbCr.c   ****         #pragma GCC ivdep
 229:RGB2YCbCr.c   ****         for (int i = 0; i < height*width; i++)
 1657              		.loc 1 229 35
 1658 1146 440FAFEB 		imull	%ebx, %r13d
 1659              	.LVL82:
 1660 114a 4989FF   		movq	%rdi, %r15
 1661              	.LBE25:
 1662              	.LBE24:
 220:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 1663              		.loc 1 220 23
 1664 114d 895E0C   		movl	%ebx, 12(%rsi)
 1665 1150 4989F6   		movq	%rsi, %r14
 219:RGB2YCbCr.c   ****     image_out->height = height;
 1666              		.loc 1 219 5 is_stmt 1
 220:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 1667              		.loc 1 220 5
 221:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 1668              		.loc 1 221 5
 222:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 1669              		.loc 1 222 5
 1670              	.LBB29:
 1671              	.LBB26:
 1672              		.loc 1 229 35 is_stmt 0
 1673 1153 BB0A0000 		movl	$10, %ebx
 1673      00
 1674              	.LVL83:
 1675              	.LBE26:
 1676              	.LBE29:
 221:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 1677              		.loc 1 221 32
 1678 1158 48894610 		movq	%rax, 16(%rsi)
 224:RGB2YCbCr.c   **** 
 1679              		.loc 1 224 5 is_stmt 1
 224:RGB2YCbCr.c   **** 
 1680              		.loc 1 224 15 is_stmt 0
 1681 115c 31C0     		xorl	%eax, %eax
 1682 115e E8000000 		call	get_wall_time
 1682      00
 1683              	.LVL84:
 1684 1163 418D45FF 		leal	-1(%r13), %eax
 1685 1167 C4411857 		vxorps	%xmm12, %xmm12, %xmm12
 1685      E4
 1686 116c C57C282D 		vmovaps	.LC38(%rip), %ymm13
 1686      00000000 
 1687 1174 89855CFF 		movl	%eax, -164(%rbp)
 1687      FFFF
 1688 117a 4489E8   		movl	%r13d, %eax
 1689 117d C1E805   		shrl	$5, %eax
 1690 1180 C5FB1185 		vmovsd	%xmm0, -176(%rbp)
 1690      50FFFFFF 
 1691              	.LVL85:
 226:RGB2YCbCr.c   ****     {
 1692              		.loc 1 226 5 is_stmt 1
 1693              	.LBB30:
 226:RGB2YCbCr.c   ****     {
 1694              		.loc 1 226 10
 226:RGB2YCbCr.c   ****     {
 1695              		.loc 1 226 22
 1696 1188 4C8D0C40 		leaq	(%rax,%rax,2), %r9
 1697 118c 488B8568 		movq	-152(%rbp), %rax
 1697      FFFFFF
 1698 1193 49C1E105 		salq	$5, %r9
 1699 1197 4D8D2401 		leaq	(%r9,%rax), %r12
 1700 119b 4489E8   		movl	%r13d, %eax
 1701 119e 83E0E0   		andl	$-32, %eax
 1702 11a1 898558FF 		movl	%eax, -168(%rbp)
 1702      FFFF
 1703              	.LVL86:
 1704 11a7 660F1F84 		.p2align 4,,10
 1704      00000000 
 1704      00
 1705              		.p2align 3
 1706              	.L40:
 1707              	.LBB27:
 1708              		.loc 1 229 25
 1709              		.loc 1 229 9 is_stmt 0
 1710 11b0 4585ED   		testl	%r13d, %r13d
 1711 11b3 0F8E5207 		jle	.L47
 1711      0000
 1712 11b9 83BD5CFF 		cmpl	$30, -164(%rbp)
 1712      FFFF1E
 1713 11c0 0F869E07 		jbe	.L48
 1713      0000
 1714 11c6 488B9560 		movq	-160(%rbp), %rdx
 1714      FFFFFF
 1715 11cd 488B8568 		movq	-152(%rbp), %rax
 1715      FFFFFF
 1716              	.LVL87:
 1717              		.p2align 4,,10
 1718 11d4 0F1F4000 		.p2align 3
 1719              	.L42:
 230:RGB2YCbCr.c   ****         {
 231:RGB2YCbCr.c   ****             /* el cast float mejora las prestaciones!! */
 232:RGB2YCbCr.c   ****             /* R */
 233:RGB2YCbCr.c   ****             pixels_out[3*i + 0] = (unsigned char) (0.5f + 
 1720              		.loc 1 233 13 is_stmt 1 discriminator 3
 234:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 1721              		.loc 1 235 42 is_stmt 0 discriminator 3
 1722 11d8 C5FE6F00 		vmovdqu	(%rax), %ymm0
 1723 11dc C5FE6F58 		vmovdqu	64(%rax), %ymm3
 1723      40
 1724 11e1 4883C060 		addq	$96, %rax
 1725 11e5 4883C260 		addq	$96, %rdx
 1726 11e9 C5FE6F50 		vmovdqu	-64(%rax), %ymm2
 1726      C0
 1727 11ee C4E27D00 		vpshufb	.LC13(%rip), %ymm0, %ymm1
 1727      0D000000 
 1727      00
 1728 11f7 C4E26D00 		vpshufb	.LC15(%rip), %ymm2, %ymm5
 1728      2D000000 
 1728      00
 1729 1200 C4E3FD00 		vpermq	$78, %ymm1, %ymm4
 1729      E14E
 1730 1206 C4E27D00 		vpshufb	.LC14(%rip), %ymm0, %ymm1
 1730      0D000000 
 1730      00
 1731 120f C4E26D00 		vpshufb	.LC21(%rip), %ymm2, %ymm6
 1731      35000000 
 1731      00
 1732 1218 C5F5EBCC 		vpor	%ymm4, %ymm1, %ymm1
 1733 121c C4E26500 		vpshufb	.LC16(%rip), %ymm3, %ymm4
 1733      25000000 
 1733      00
 1734 1225 C4E26D00 		vpshufb	.LC27(%rip), %ymm2, %ymm2
 1734      15000000 
 1734      00
 1735 122e C5F5EBCD 		vpor	%ymm5, %ymm1, %ymm1
 1736 1232 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 1736      EC4E
 1737 1238 C4E26500 		vpshufb	.LC18(%rip), %ymm3, %ymm4
 1737      25000000 
 1737      00
 1738 1241 C4E27500 		vpshufb	.LC17(%rip), %ymm1, %ymm1
 1738      0D000000 
 1738      00
 1739 124a C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 1740 124e C5F5EBCC 		vpor	%ymm4, %ymm1, %ymm1
 1741 1252 C4E27D00 		vpshufb	.LC19(%rip), %ymm0, %ymm4
 1741      25000000 
 1741      00
 1742 125b C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 1742      EC4E
 1743 1261 C4E27D00 		vpshufb	.LC20(%rip), %ymm0, %ymm4
 1743      25000000 
 1743      00
 1744 126a C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 1745 126e C4E26500 		vpshufb	.LC22(%rip), %ymm3, %ymm5
 1745      2D000000 
 1745      00
 1746 1277 C5DDEBE6 		vpor	%ymm6, %ymm4, %ymm4
 1747 127b C4E3FD00 		vpermq	$78, %ymm5, %ymm6
 1747      F54E
 1748 1281 C4E26500 		vpshufb	.LC24(%rip), %ymm3, %ymm5
 1748      2D000000 
 1748      00
 1749 128a C4E25D00 		vpshufb	.LC23(%rip), %ymm4, %ymm4
 1749      25000000 
 1749      00
 1750 1293 C5D5EBEE 		vpor	%ymm6, %ymm5, %ymm5
 1751 1297 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 1752 129b C4E27D00 		vpshufb	.LC25(%rip), %ymm0, %ymm5
 1752      2D000000 
 1752      00
 1753 12a4 C4E27D00 		vpshufb	.LC26(%rip), %ymm0, %ymm0
 1753      05000000 
 1753      00
 1754 12ad C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 1754      ED4E
 1755 12b3 C5FDEBC5 		vpor	%ymm5, %ymm0, %ymm0
 1756 12b7 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 1757 12bb C4E26500 		vpshufb	.LC28(%rip), %ymm3, %ymm2
 1757      15000000 
 1757      00
 1758 12c4 C4E27D00 		vpshufb	.LC23(%rip), %ymm0, %ymm0
 1758      05000000 
 1758      00
 1759 12cd C4E3FD00 		vpermq	$78, %ymm2, %ymm5
 1759      EA4E
 1760 12d3 C4E26500 		vpshufb	.LC29(%rip), %ymm3, %ymm2
 1760      15000000 
 1760      00
 1761 12dc C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 1762 12e0 C4E27D30 		vpmovzxbw	%xmm1, %ymm3
 1762      D9
 1763 12e5 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 1763      C901
 1764 12eb C5FDEBD2 		vpor	%ymm2, %ymm0, %ymm2
 1765 12ef C4E27D33 		vpmovzxwd	%xmm3, %ymm0
 1765      C3
 1766 12f4 C4E37D39 		vextracti128	$0x1, %ymm3, %xmm3
 1766      DB01
 1767 12fa C4E27D30 		vpmovzxbw	%xmm1, %ymm1
 1767      C9
 1768 12ff C4E27D33 		vpmovzxwd	%xmm3, %ymm3
 1768      DB
 1769              		.loc 1 235 32 discriminator 3
 1770 1304 C5FC5BC0 		vcvtdq2ps	%ymm0, %ymm0
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 237:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1771              		.loc 1 237 42 discriminator 3
 1772 1308 C4E27D30 		vpmovzxbw	%xmm2, %ymm6
 1772      F2
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1773              		.loc 1 235 32 discriminator 3
 1774 130d C5FC5BEB 		vcvtdq2ps	%ymm3, %ymm5
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1775              		.loc 1 235 42 discriminator 3
 1776 1311 C4E27D33 		vpmovzxwd	%xmm1, %ymm3
 1776      D9
 1777 1316 C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 1777      C901
 1778              		.loc 1 237 42 discriminator 3
 1779 131c C4627D33 		vpmovzxwd	%xmm6, %ymm10
 1779      D6
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1780              		.loc 1 235 42 discriminator 3
 1781 1321 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 1781      C9
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1782              		.loc 1 235 32 discriminator 3
 1783 1326 C57C5BF3 		vcvtdq2ps	%ymm3, %ymm14
 1784              		.loc 1 237 32 discriminator 3
 1785 132a C4417C5B 		vcvtdq2ps	%ymm10, %ymm10
 1785      D2
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1786              		.loc 1 235 32 discriminator 3
 1787 132f C57C28FD 		vmovaps	%ymm5, %ymm15
 1788 1333 C5FC5BF9 		vcvtdq2ps	%ymm1, %ymm7
 1789 1337 C5FC590D 		vmulps	.LC30(%rip), %ymm0, %ymm1
 1789      00000000 
 1790 133f C5FC297D 		vmovaps	%ymm7, -80(%rbp)
 1790      B0
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1791              		.loc 1 236 42 discriminator 3
 1792 1344 C4E27D30 		vpmovzxbw	%xmm4, %ymm7
 1792      FC
 1793 1349 C4627D33 		vpmovzxwd	%xmm7, %ymm11
 1793      DF
 1794 134e C4E37D39 		vextracti128	$0x1, %ymm7, %xmm7
 1794      FF01
 1795              		.loc 1 237 42 discriminator 3
 1796 1354 C4E37D39 		vextracti128	$0x1, %ymm6, %xmm6
 1796      F601
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1797              		.loc 1 235 32 discriminator 3
 1798 135a C57C2975 		vmovaps	%ymm14, -112(%rbp)
 1798      90
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1799              		.loc 1 236 32 discriminator 3
 1800 135f C4417C5B 		vcvtdq2ps	%ymm11, %ymm11
 1800      DB
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1801              		.loc 1 236 42 discriminator 3
 1802 1364 C4E27D33 		vpmovzxwd	%xmm7, %ymm7
 1802      FF
 1803              		.loc 1 237 42 discriminator 3
 1804 1369 C4E27D33 		vpmovzxwd	%xmm6, %ymm6
 1804      F6
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1805              		.loc 1 236 42 discriminator 3
 1806 136e C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 1806      E401
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1807              		.loc 1 236 32 discriminator 3
 1808 1374 C5A4591D 		vmulps	.LC31(%rip), %ymm11, %ymm3
 1808      00000000 
 1809 137c C5FC5BFF 		vcvtdq2ps	%ymm7, %ymm7
 1810              		.loc 1 237 32 discriminator 3
 1811 1380 C5FC5BF6 		vcvtdq2ps	%ymm6, %ymm6
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1812              		.loc 1 236 42 discriminator 3
 1813 1384 C4E27D30 		vpmovzxbw	%xmm4, %ymm4
 1813      E4
 1814 1389 C4627D33 		vpmovzxwd	%xmm4, %ymm9
 1814      CC
 1815              		.loc 1 237 42 discriminator 3
 1816 138e C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 1816      D201
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1817              		.loc 1 236 42 discriminator 3
 1818 1394 C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 1818      E401
 234:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 1819              		.loc 1 234 37 discriminator 3
 1820 139a C4C17458 		vaddps	%ymm13, %ymm1, %ymm1
 1820      CD
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1821              		.loc 1 236 32 discriminator 3
 1822 139f C4417C5B 		vcvtdq2ps	%ymm9, %ymm9
 1822      C9
 1823              		.loc 1 237 42 discriminator 3
 1824 13a4 C4E27D30 		vpmovzxbw	%xmm2, %ymm2
 1824      D2
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1825              		.loc 1 236 42 discriminator 3
 1826 13a9 C4E27D33 		vpmovzxwd	%xmm4, %ymm4
 1826      E4
 1827              		.loc 1 237 42 discriminator 3
 1828 13ae C4627D33 		vpmovzxwd	%xmm2, %ymm8
 1828      C2
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1829              		.loc 1 236 32 discriminator 3
 1830 13b3 C5FC5BE4 		vcvtdq2ps	%ymm4, %ymm4
 1831              		.loc 1 237 42 discriminator 3
 1832 13b7 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 1832      D201
 1833              		.loc 1 237 32 discriminator 3
 1834 13bd C4417C5B 		vcvtdq2ps	%ymm8, %ymm8
 1834      C0
 1835              		.loc 1 237 42 discriminator 3
 1836 13c2 C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 1836      D2
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1837              		.loc 1 235 52 discriminator 3
 1838 13c7 C5F458CB 		vaddps	%ymm3, %ymm1, %ymm1
 1839              		.loc 1 237 32 discriminator 3
 1840 13cb C5AC591D 		vmulps	.LC32(%rip), %ymm10, %ymm3
 1840      00000000 
 1841 13d3 C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1842              		.loc 1 236 52 discriminator 3
 1843 13d7 C5F458CB 		vaddps	%ymm3, %ymm1, %ymm1
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1844              		.loc 1 235 32 discriminator 3
 1845 13db C5D4591D 		vmulps	.LC30(%rip), %ymm5, %ymm3
 1845      00000000 
 233:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 1846              		.loc 1 233 35 discriminator 3
 1847 13e3 C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 234:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 1848              		.loc 1 234 37 discriminator 3
 1849 13e7 C4C16458 		vaddps	%ymm13, %ymm3, %ymm5
 1849      ED
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1850              		.loc 1 236 32 discriminator 3
 1851 13ec C5C4591D 		vmulps	.LC31(%rip), %ymm7, %ymm3
 1851      00000000 
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1852              		.loc 1 235 52 discriminator 3
 1853 13f4 C5D458DB 		vaddps	%ymm3, %ymm5, %ymm3
 1854              		.loc 1 237 32 discriminator 3
 1855 13f8 C5CC592D 		vmulps	.LC32(%rip), %ymm6, %ymm5
 1855      00000000 
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1856              		.loc 1 236 52 discriminator 3
 1857 1400 C5E458ED 		vaddps	%ymm5, %ymm3, %ymm5
 233:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 1858              		.loc 1 233 35 discriminator 3
 1859 1404 C5F5DB1D 		vpand	.LC34(%rip), %ymm1, %ymm3
 1859      00000000 
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1860              		.loc 1 235 32 discriminator 3
 1861 140c C58C590D 		vmulps	.LC30(%rip), %ymm14, %ymm1
 1861      00000000 
 233:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 1862              		.loc 1 233 35 discriminator 3
 1863 1414 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 1864 1418 C5D5DB2D 		vpand	.LC34(%rip), %ymm5, %ymm5
 1864      00000000 
 1865 1420 C4E2652B 		vpackusdw	%ymm5, %ymm3, %ymm3
 1865      DD
 234:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 1866              		.loc 1 234 37 discriminator 3
 1867 1425 C4C17458 		vaddps	%ymm13, %ymm1, %ymm5
 1867      ED
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1868              		.loc 1 236 32 discriminator 3
 1869 142a C5B4590D 		vmulps	.LC31(%rip), %ymm9, %ymm1
 1869      00000000 
 233:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 1870              		.loc 1 233 35 discriminator 3
 1871 1432 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 1871      DBD8
 238:RGB2YCbCr.c   ****             /* G */
 239:RGB2YCbCr.c   ****             pixels_out[3*i + 1] = (unsigned char) (0.5f + 
 240:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1872              		.loc 1 241 32 discriminator 3
 1873 1438 C57C29BD 		vmovaps	%ymm15, -144(%rbp)
 1873      70FFFFFF 
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1874              		.loc 1 235 52 discriminator 3
 1875 1440 C5D458C9 		vaddps	%ymm1, %ymm5, %ymm1
 237:RGB2YCbCr.c   ****             /* G */
 1876              		.loc 1 237 32 discriminator 3
 1877 1444 C5BC592D 		vmulps	.LC32(%rip), %ymm8, %ymm5
 1877      00000000 
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1878              		.loc 1 236 52 discriminator 3
 1879 144c C5F458CD 		vaddps	%ymm5, %ymm1, %ymm1
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1880              		.loc 1 235 32 discriminator 3
 1881 1450 C5FC286D 		vmovaps	-80(%rbp), %ymm5
 1881      B0
 1882 1455 C5D4592D 		vmulps	.LC30(%rip), %ymm5, %ymm5
 1882      00000000 
 233:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 1883              		.loc 1 233 35 discriminator 3
 1884 145d C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 1885 1461 C5F5DB0D 		vpand	.LC34(%rip), %ymm1, %ymm1
 1885      00000000 
 234:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 1886              		.loc 1 234 37 discriminator 3
 1887 1469 C4415458 		vaddps	%ymm13, %ymm5, %ymm14
 1887      F5
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1888              		.loc 1 236 32 discriminator 3
 1889 146e C5DC592D 		vmulps	.LC31(%rip), %ymm4, %ymm5
 1889      00000000 
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 1890              		.loc 1 235 52 discriminator 3
 1891 1476 C58C58ED 		vaddps	%ymm5, %ymm14, %ymm5
 237:RGB2YCbCr.c   ****             /* G */
 1892              		.loc 1 237 32 discriminator 3
 1893 147a C56C5935 		vmulps	.LC32(%rip), %ymm2, %ymm14
 1893      00000000 
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 1894              		.loc 1 236 52 discriminator 3
 1895 1482 C4C15458 		vaddps	%ymm14, %ymm5, %ymm5
 1895      EE
 233:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 1896              		.loc 1 233 35 discriminator 3
 1897 1487 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 1898 148b C5D5DB2D 		vpand	.LC34(%rip), %ymm5, %ymm5
 1898      00000000 
 1899 1493 C4E2752B 		vpackusdw	%ymm5, %ymm1, %ymm5
 1899      ED
 1900 1498 C5E5DB0D 		vpand	.LC35(%rip), %ymm3, %ymm1
 1900      00000000 
 1901 14a0 C4E3FD00 		vpermq	$216, %ymm5, %ymm5
 1901      EDD8
 1902 14a6 C5D5DB2D 		vpand	.LC35(%rip), %ymm5, %ymm5
 1902      00000000 
 1903 14ae C5F567CD 		vpackuswb	%ymm5, %ymm1, %ymm1
 1904              		.loc 1 241 32 discriminator 3
 1905 14b2 C5FC592D 		vmulps	.LC36(%rip), %ymm0, %ymm5
 1905      00000000 
 233:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 1906              		.loc 1 233 35 discriminator 3
 1907 14ba C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 1907      C9D8
 239:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1908              		.loc 1 239 13 is_stmt 1 discriminator 3
 240:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1909              		.loc 1 240 37 is_stmt 0 discriminator 3
 1910 14c0 C5D4581D 		vaddps	.LC64(%rip), %ymm5, %ymm3
 1910      00000000 
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1911              		.loc 1 242 32 discriminator 3
 1912 14c8 C5A4592D 		vmulps	.LC37(%rip), %ymm11, %ymm5
 1912      00000000 
 243:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 244:RGB2YCbCr.c   ****             /* B */
 245:RGB2YCbCr.c   ****             pixels_out[3*i + 2] =  (unsigned char) (0.5f + 
 246:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1913              		.loc 1 247 32 discriminator 3
 1914 14d0 C4C17C59 		vmulps	%ymm13, %ymm0, %ymm0
 1914      C5
 246:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1915              		.loc 1 246 37 discriminator 3
 1916 14d5 C5FC5805 		vaddps	.LC64(%rip), %ymm0, %ymm0
 1916      00000000 
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1917              		.loc 1 241 52 discriminator 3
 1918 14dd C5E458ED 		vaddps	%ymm5, %ymm3, %ymm5
 243:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1919              		.loc 1 243 32 discriminator 3
 1920 14e1 C4C12C59 		vmulps	%ymm13, %ymm10, %ymm3
 1920      DD
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1921              		.loc 1 242 52 discriminator 3
 1922 14e6 C5D458EB 		vaddps	%ymm3, %ymm5, %ymm5
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1923              		.loc 1 241 32 discriminator 3
 1924 14ea C584591D 		vmulps	.LC36(%rip), %ymm15, %ymm3
 1924      00000000 
 1925 14f2 C57C287D 		vmovaps	-80(%rbp), %ymm15
 1925      B0
 240:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1926              		.loc 1 240 37 discriminator 3
 1927 14f7 C5645835 		vaddps	.LC64(%rip), %ymm3, %ymm14
 1927      00000000 
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1928              		.loc 1 242 32 discriminator 3
 1929 14ff C5C4591D 		vmulps	.LC37(%rip), %ymm7, %ymm3
 1929      00000000 
 239:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1930              		.loc 1 239 35 discriminator 3
 1931 1507 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 1932 150b C5D5DB2D 		vpand	.LC34(%rip), %ymm5, %ymm5
 1932      00000000 
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1933              		.loc 1 241 52 discriminator 3
 1934 1513 C58C58DB 		vaddps	%ymm3, %ymm14, %ymm3
 243:RGB2YCbCr.c   ****             /* B */
 1935              		.loc 1 243 32 discriminator 3
 1936 1517 C4414C59 		vmulps	%ymm13, %ymm6, %ymm14
 1936      F5
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1937              		.loc 1 242 52 discriminator 3
 1938 151c C4416458 		vaddps	%ymm14, %ymm3, %ymm14
 1938      F6
 239:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1939              		.loc 1 239 35 discriminator 3
 1940 1521 C4417E5B 		vcvttps2dq	%ymm14, %ymm14
 1940      F6
 1941 1526 C50DDB35 		vpand	.LC34(%rip), %ymm14, %ymm14
 1941      00000000 
 1942 152e C4C2552B 		vpackusdw	%ymm14, %ymm5, %ymm5
 1942      EE
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1943              		.loc 1 241 32 discriminator 3
 1944 1533 C57C2875 		vmovaps	-112(%rbp), %ymm14
 1944      90
 239:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1945              		.loc 1 239 35 discriminator 3
 1946 1538 C4E3FD00 		vpermq	$216, %ymm5, %ymm3
 1946      DDD8
 1947 153e C5E5DB1D 		vpand	.LC35(%rip), %ymm3, %ymm3
 1947      00000000 
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1948              		.loc 1 241 32 discriminator 3
 1949 1546 C58C592D 		vmulps	.LC36(%rip), %ymm14, %ymm5
 1949      00000000 
 240:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1950              		.loc 1 240 37 discriminator 3
 1951 154e C5545835 		vaddps	.LC64(%rip), %ymm5, %ymm14
 1951      00000000 
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1952              		.loc 1 242 32 discriminator 3
 1953 1556 C5B4592D 		vmulps	.LC37(%rip), %ymm9, %ymm5
 1953      00000000 
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1954              		.loc 1 241 52 discriminator 3
 1955 155e C58C58ED 		vaddps	%ymm5, %ymm14, %ymm5
 243:RGB2YCbCr.c   ****             /* B */
 1956              		.loc 1 243 32 discriminator 3
 1957 1562 C4413C59 		vmulps	%ymm13, %ymm8, %ymm14
 1957      F5
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1958              		.loc 1 242 52 discriminator 3
 1959 1567 C4C15458 		vaddps	%ymm14, %ymm5, %ymm5
 1959      EE
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1960              		.loc 1 241 32 discriminator 3
 1961 156c C5045935 		vmulps	.LC36(%rip), %ymm15, %ymm14
 1961      00000000 
 240:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 1962              		.loc 1 240 37 discriminator 3
 1963 1574 C50C583D 		vaddps	.LC64(%rip), %ymm14, %ymm15
 1963      00000000 
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1964              		.loc 1 242 32 discriminator 3
 1965 157c C55C5935 		vmulps	.LC37(%rip), %ymm4, %ymm14
 1965      00000000 
 239:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1966              		.loc 1 239 35 discriminator 3
 1967 1584 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 1968 1588 C5D5DB2D 		vpand	.LC34(%rip), %ymm5, %ymm5
 1968      00000000 
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 1969              		.loc 1 241 52 discriminator 3
 1970 1590 C4410458 		vaddps	%ymm14, %ymm15, %ymm14
 1970      F6
 243:RGB2YCbCr.c   ****             /* B */
 1971              		.loc 1 243 32 discriminator 3
 1972 1595 C4416C59 		vmulps	%ymm13, %ymm2, %ymm15
 1972      FD
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 1973              		.loc 1 242 52 discriminator 3
 1974 159a C4410C58 		vaddps	%ymm15, %ymm14, %ymm14
 1974      F7
 239:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1975              		.loc 1 239 35 discriminator 3
 1976 159f C4417E5B 		vcvttps2dq	%ymm14, %ymm14
 1976      F6
 1977 15a4 C50DDB35 		vpand	.LC34(%rip), %ymm14, %ymm14
 1977      00000000 
 1978 15ac C4C2552B 		vpackusdw	%ymm14, %ymm5, %ymm5
 1978      EE
 1979 15b1 C4E3FD00 		vpermq	$216, %ymm5, %ymm5
 1979      EDD8
 1980 15b7 C5D5DB2D 		vpand	.LC35(%rip), %ymm5, %ymm5
 1980      00000000 
 248:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1981              		.loc 1 248 32 discriminator 3
 1982 15bf C524591D 		vmulps	.LC40(%rip), %ymm11, %ymm11
 1982      00000000 
 1983 15c7 C534590D 		vmulps	.LC40(%rip), %ymm9, %ymm9
 1983      00000000 
 239:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1984              		.loc 1 239 35 discriminator 3
 1985 15cf C5E567DD 		vpackuswb	%ymm5, %ymm3, %ymm3
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1986              		.loc 1 247 32 discriminator 3
 1987 15d3 C594596D 		vmulps	-112(%rbp), %ymm13, %ymm5
 1987      90
 239:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 1988              		.loc 1 239 35 discriminator 3
 1989 15d8 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 1989      DBD8
 245:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 1990              		.loc 1 245 13 is_stmt 1 discriminator 3
 246:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 1991              		.loc 1 246 37 is_stmt 0 discriminator 3
 1992 15de C5D4582D 		vaddps	.LC64(%rip), %ymm5, %ymm5
 1992      00000000 
 1993              		.loc 1 248 32 discriminator 3
 1994 15e6 C5C4593D 		vmulps	.LC40(%rip), %ymm7, %ymm7
 1994      00000000 
 1995 15ee C5DC5925 		vmulps	.LC40(%rip), %ymm4, %ymm4
 1995      00000000 
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1996              		.loc 1 247 52 discriminator 3
 1997 15f6 C4417C58 		vaddps	%ymm11, %ymm0, %ymm11
 1997      DB
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 1998              		.loc 1 247 32 discriminator 3
 1999 15fb C5945985 		vmulps	-144(%rbp), %ymm13, %ymm0
 1999      70FFFFFF 
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2000              		.loc 1 247 52 discriminator 3
 2001 1603 C4415458 		vaddps	%ymm9, %ymm5, %ymm9
 2001      C9
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2002              		.loc 1 247 32 discriminator 3
 2003 1608 C594596D 		vmulps	-80(%rbp), %ymm13, %ymm5
 2003      B0
 246:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 2004              		.loc 1 246 37 discriminator 3
 2005 160d C5FC5805 		vaddps	.LC64(%rip), %ymm0, %ymm0
 2005      00000000 
 2006 1615 C5D4582D 		vaddps	.LC64(%rip), %ymm5, %ymm5
 2006      00000000 
 249:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2007              		.loc 1 249 32 discriminator 3
 2008 161d C5EC5915 		vmulps	.LC41(%rip), %ymm2, %ymm2
 2008      00000000 
 2009 1625 C52C5915 		vmulps	.LC41(%rip), %ymm10, %ymm10
 2009      00000000 
 2010 162d C5CC5935 		vmulps	.LC41(%rip), %ymm6, %ymm6
 2010      00000000 
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2011              		.loc 1 247 52 discriminator 3
 2012 1635 C5FC58FF 		vaddps	%ymm7, %ymm0, %ymm7
 2013              		.loc 1 249 32 discriminator 3
 2014 1639 C53C5905 		vmulps	.LC41(%rip), %ymm8, %ymm8
 2014      00000000 
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2015              		.loc 1 247 52 discriminator 3
 2016 1641 C5D458E4 		vaddps	%ymm4, %ymm5, %ymm4
 248:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2017              		.loc 1 248 52 discriminator 3
 2018 1645 C4412458 		vaddps	%ymm10, %ymm11, %ymm10
 2018      D2
 2019 164a C5DC58E2 		vaddps	%ymm2, %ymm4, %ymm4
 2020 164e C5C458F6 		vaddps	%ymm6, %ymm7, %ymm6
 2021 1652 C4413458 		vaddps	%ymm8, %ymm9, %ymm8
 2021      C0
 245:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2022              		.loc 1 245 36 discriminator 3
 2023 1657 C4417E5B 		vcvttps2dq	%ymm10, %ymm10
 2023      D2
 2024 165c C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 2025 1660 C5ADDB05 		vpand	.LC34(%rip), %ymm10, %ymm0
 2025      00000000 
 2026 1668 C5DDDB25 		vpand	.LC34(%rip), %ymm4, %ymm4
 2026      00000000 
 2027 1670 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 2028 1674 C5CDDB35 		vpand	.LC34(%rip), %ymm6, %ymm6
 2028      00000000 
 2029 167c C4417E5B 		vcvttps2dq	%ymm8, %ymm8
 2029      C0
 2030 1681 C5BDDB15 		vpand	.LC34(%rip), %ymm8, %ymm2
 2030      00000000 
 2031 1689 C4E27D2B 		vpackusdw	%ymm6, %ymm0, %ymm0
 2031      C6
 2032 168e C4E26D2B 		vpackusdw	%ymm4, %ymm2, %ymm2
 2032      D4
 2033 1693 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 2033      C0D8
 2034 1699 C5FDDB05 		vpand	.LC35(%rip), %ymm0, %ymm0
 2034      00000000 
 245:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2035              		.loc 1 245 33 discriminator 3
 2036 16a1 C4E26500 		vpshufb	.LC43(%rip), %ymm3, %ymm4
 2036      25000000 
 2036      00
 245:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2037              		.loc 1 245 36 discriminator 3
 2038 16aa C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 2038      D2D8
 2039 16b0 C5EDDB15 		vpand	.LC35(%rip), %ymm2, %ymm2
 2039      00000000 
 245:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2040              		.loc 1 245 33 discriminator 3
 2041 16b8 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 2041      EC4E
 2042 16be C4E26500 		vpshufb	.LC45(%rip), %ymm3, %ymm4
 2042      25000000 
 2042      00
 245:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2043              		.loc 1 245 36 discriminator 3
 2044 16c7 C5FD67D2 		vpackuswb	%ymm2, %ymm0, %ymm2
 245:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2045              		.loc 1 245 33 discriminator 3
 2046 16cb C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 2047 16cf C4E27500 		vpshufb	.LC42(%rip), %ymm1, %ymm0
 2047      05000000 
 2047      00
 2048 16d8 C4E3FD00 		vpermq	$78, %ymm0, %ymm6
 2048      F04E
 245:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2049              		.loc 1 245 36 discriminator 3
 2050 16de C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 2050      D2D8
 245:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2051              		.loc 1 245 33 discriminator 3
 2052 16e4 C4E27500 		vpshufb	.LC44(%rip), %ymm1, %ymm0
 2052      05000000 
 2052      00
 2053 16ed C5FDEBC6 		vpor	%ymm6, %ymm0, %ymm0
 2054 16f1 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 2055 16f5 C4E26D00 		vpshufb	.LC46(%rip), %ymm2, %ymm4
 2055      25000000 
 2055      00
 2056 16fe C4E27D00 		vpshufb	.LC47(%rip), %ymm0, %ymm0
 2056      05000000 
 2056      00
 2057 1707 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 2057      EC4E
 2058 170d C4E26D00 		vpshufb	.LC48(%rip), %ymm2, %ymm4
 2058      25000000 
 2058      00
 2059 1716 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 2060 171a C4E26500 		vpshufb	.LC51(%rip), %ymm3, %ymm5
 2060      2D000000 
 2060      00
 2061 1723 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 2062 1727 C5FE7F42 		vmovdqu	%ymm0, -96(%rdx)
 2062      A0
 2063 172c C4E27500 		vpshufb	.LC49(%rip), %ymm1, %ymm0
 2063      05000000 
 2063      00
 2064 1735 C4E3FD00 		vpermq	$78, %ymm0, %ymm4
 2064      E04E
 2065 173b C4E27500 		vpshufb	.LC50(%rip), %ymm1, %ymm0
 2065      05000000 
 2065      00
 2066 1744 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 2067 1748 C4E26D00 		vpshufb	.LC52(%rip), %ymm2, %ymm4
 2067      25000000 
 2067      00
 2068 1751 C5FD6F3D 		vmovdqa	.LC53(%rip), %ymm7
 2068      00000000 
 2069 1759 C5FDEBC5 		vpor	%ymm5, %ymm0, %ymm0
 2070 175d C4E26500 		vpshufb	.LC55(%rip), %ymm3, %ymm5
 2070      2D000000 
 2070      00
 2071 1766 C4E26500 		vpshufb	.LC57(%rip), %ymm3, %ymm3
 2071      1D000000 
 2071      00
 2072 176f C4E37D4C 		vpblendvb	%ymm7, %ymm4, %ymm0, %ymm0
 2072      C470
 2073 1775 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 2073      ED4E
 2074 177b C5FE7F42 		vmovdqu	%ymm0, -64(%rdx)
 2074      C0
 2075 1780 C5E5EBDD 		vpor	%ymm5, %ymm3, %ymm3
 2076 1784 C4E27500 		vpshufb	.LC54(%rip), %ymm1, %ymm0
 2076      05000000 
 2076      00
 2077 178d C4E3FD00 		vpermq	$78, %ymm0, %ymm4
 2077      E04E
 2078 1793 C4E27500 		vpshufb	.LC56(%rip), %ymm1, %ymm0
 2078      05000000 
 2078      00
 2079 179c C4E26D00 		vpshufb	.LC58(%rip), %ymm2, %ymm1
 2079      0D000000 
 2079      00
 2080 17a5 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 2081 17a9 C4E3FD00 		vpermq	$78, %ymm1, %ymm1
 2081      C94E
 2082 17af C4E26D00 		vpshufb	.LC60(%rip), %ymm2, %ymm2
 2082      15000000 
 2082      00
 2083 17b8 C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 2084 17bc C5EDEBD1 		vpor	%ymm1, %ymm2, %ymm2
 2085 17c0 C4E27D00 		vpshufb	.LC59(%rip), %ymm0, %ymm0
 2085      05000000 
 2085      00
 2086 17c9 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 2087 17cd C5FE7F42 		vmovdqu	%ymm0, -32(%rdx)
 2087      E0
 229:RGB2YCbCr.c   ****         {
 2088              		.loc 1 229 43 is_stmt 1 discriminator 3
 229:RGB2YCbCr.c   ****         {
 2089              		.loc 1 229 25 discriminator 3
 2090 17d2 4C39E0   		cmpq	%r12, %rax
 2091 17d5 0F85FDF9 		jne	.L42
 2091      FFFF
 2092 17db 8B8558FF 		movl	-168(%rbp), %eax
 2092      FFFF
 2093 17e1 4139C5   		cmpl	%eax, %r13d
 2094 17e4 0F842101 		je	.L47
 2094      0000
 229:RGB2YCbCr.c   ****         {
 2095              		.loc 1 229 18 is_stmt 0
 2096 17ea 89C6     		movl	%eax, %esi
 2097              	.L41:
 2098 17ec 488B8568 		movq	-152(%rbp), %rax
 2098      FFFFFF
 2099 17f3 8D1476   		leal	(%rsi,%rsi,2), %edx
 2100 17f6 C57A101D 		vmovss	.LC1(%rip), %xmm11
 2100      00000000 
 2101 17fe 4863D2   		movslq	%edx, %rdx
 2102 1801 C5FA101D 		vmovss	.LC8(%rip), %xmm3
 2102      00000000 
 2103 1809 C57A1015 		vmovss	.LC3(%rip), %xmm10
 2103      00000000 
 2104 1811 C57A100D 		vmovss	.LC4(%rip), %xmm9
 2104      00000000 
 2105 1819 C57A1005 		vmovss	.LC5(%rip), %xmm8
 2105      00000000 
 2106 1821 4801D0   		addq	%rdx, %rax
 2107 1824 C5FA1025 		vmovss	.LC65(%rip), %xmm4
 2107      00000000 
 2108 182c C5FA103D 		vmovss	.LC7(%rip), %xmm7
 2108      00000000 
 2109 1834 C5FA1035 		vmovss	.LC9(%rip), %xmm6
 2109      00000000 
 2110 183c C5FA102D 		vmovss	.LC10(%rip), %xmm5
 2110      00000000 
 2111 1844 48039560 		addq	-160(%rbp), %rdx
 2111      FFFFFF
 2112 184b 0F1F4400 		.p2align 4,,10
 2112      00
 2113              		.p2align 3
 2114              	.L44:
 2115              	.LVL88:
 233:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2116              		.loc 1 233 13 is_stmt 1
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2117              		.loc 1 235 42 is_stmt 0
 2118 1850 0FB608   		movzbl	(%rax), %ecx
 229:RGB2YCbCr.c   ****         {
 2119              		.loc 1 229 44
 2120 1853 FFC6     		incl	%esi
 2121              	.LVL89:
 2122 1855 4883C003 		addq	$3, %rax
 2123 1859 4883C203 		addq	$3, %rdx
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2124              		.loc 1 235 32
 2125 185d C59A2AC9 		vcvtsi2ssl	%ecx, %xmm12, %xmm1
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2126              		.loc 1 236 42
 2127 1861 0FB648FE 		movzbl	-2(%rax), %ecx
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2128              		.loc 1 236 32
 2129 1865 C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 237:RGB2YCbCr.c   ****             /* G */
 2130              		.loc 1 237 42
 2131 1869 0FB648FF 		movzbl	-1(%rax), %ecx
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2132              		.loc 1 235 32
 2133 186d C4C17259 		vmulss	%xmm11, %xmm1, %xmm1
 2133      CB
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2134              		.loc 1 236 32
 2135 1872 C4C17A59 		vmulss	%xmm10, %xmm0, %xmm0
 2135      C2
 234:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 2136              		.loc 1 234 37
 2137 1877 C5F258D3 		vaddss	%xmm3, %xmm1, %xmm2
 235:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2138              		.loc 1 235 52
 2139 187b C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 237:RGB2YCbCr.c   ****             /* G */
 2140              		.loc 1 237 32
 2141 187f C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 2142 1883 C4C17A59 		vmulss	%xmm9, %xmm0, %xmm0
 2142      C1
 236:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2143              		.loc 1 236 52
 2144 1888 C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 233:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2145              		.loc 1 233 35
 2146 188c C5FA2CC8 		vcvttss2sil	%xmm0, %ecx
 2147 1890 884AFD   		movb	%cl, -3(%rdx)
 239:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 2148              		.loc 1 239 13 is_stmt 1
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2149              		.loc 1 241 42 is_stmt 0
 2150 1893 0FB648FD 		movzbl	-3(%rax), %ecx
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2151              		.loc 1 241 32
 2152 1897 C59A2AC9 		vcvtsi2ssl	%ecx, %xmm12, %xmm1
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2153              		.loc 1 242 42
 2154 189b 0FB648FE 		movzbl	-2(%rax), %ecx
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2155              		.loc 1 242 32
 2156 189f C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 243:RGB2YCbCr.c   ****             /* B */
 2157              		.loc 1 243 42
 2158 18a3 0FB648FF 		movzbl	-1(%rax), %ecx
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2159              		.loc 1 241 32
 2160 18a7 C4C17259 		vmulss	%xmm8, %xmm1, %xmm1
 2160      C8
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2161              		.loc 1 242 32
 2162 18ac C5FA59C7 		vmulss	%xmm7, %xmm0, %xmm0
 240:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 2163              		.loc 1 240 37
 2164 18b0 C5F258D4 		vaddss	%xmm4, %xmm1, %xmm2
 241:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2165              		.loc 1 241 52
 2166 18b4 C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 243:RGB2YCbCr.c   ****             /* B */
 2167              		.loc 1 243 32
 2168 18b8 C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 2169 18bc C5FA59C3 		vmulss	%xmm3, %xmm0, %xmm0
 242:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2170              		.loc 1 242 52
 2171 18c0 C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 239:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 2172              		.loc 1 239 35
 2173 18c4 C5FA2CC8 		vcvttss2sil	%xmm0, %ecx
 2174 18c8 884AFE   		movb	%cl, -2(%rdx)
 245:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2175              		.loc 1 245 13 is_stmt 1
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2176              		.loc 1 247 42 is_stmt 0
 2177 18cb 0FB648FD 		movzbl	-3(%rax), %ecx
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2178              		.loc 1 247 32
 2179 18cf C59A2AC9 		vcvtsi2ssl	%ecx, %xmm12, %xmm1
 248:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2180              		.loc 1 248 42
 2181 18d3 0FB648FE 		movzbl	-2(%rax), %ecx
 248:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2182              		.loc 1 248 32
 2183 18d7 C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 2184              		.loc 1 249 42
 2185 18db 0FB648FF 		movzbl	-1(%rax), %ecx
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2186              		.loc 1 247 32
 2187 18df C5F259CB 		vmulss	%xmm3, %xmm1, %xmm1
 248:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2188              		.loc 1 248 32
 2189 18e3 C5FA59C6 		vmulss	%xmm6, %xmm0, %xmm0
 246:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 2190              		.loc 1 246 37
 2191 18e7 C5F258D4 		vaddss	%xmm4, %xmm1, %xmm2
 247:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2192              		.loc 1 247 52
 2193 18eb C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 2194              		.loc 1 249 32
 2195 18ef C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 2196 18f3 C5FA59C5 		vmulss	%xmm5, %xmm0, %xmm0
 248:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2197              		.loc 1 248 52
 2198 18f7 C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 245:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2199              		.loc 1 245 36
 2200 18fb C5FA2CC8 		vcvttss2sil	%xmm0, %ecx
 2201 18ff 884AFF   		movb	%cl, -1(%rdx)
 229:RGB2YCbCr.c   ****         {
 2202              		.loc 1 229 43 is_stmt 1
 2203              	.LVL90:
 229:RGB2YCbCr.c   ****         {
 2204              		.loc 1 229 25
 229:RGB2YCbCr.c   ****         {
 2205              		.loc 1 229 9 is_stmt 0
 2206 1902 4139F5   		cmpl	%esi, %r13d
 2207 1905 0F8F45FF 		jg	.L44
 2207      FFFF
 2208              	.LVL91:
 2209              	.L47:
 2210              	.LBE27:
 250:RGB2YCbCr.c   ****         }
 251:RGB2YCbCr.c   ****         dummy(image_in, image_out);
 2211              		.loc 1 251 9 is_stmt 1
 2212 190b 4C89F6   		movq	%r14, %rsi
 2213 190e 4C89FF   		movq	%r15, %rdi
 2214 1911 C5F877   		vzeroupper
 2215 1914 E8000000 		call	dummy
 2215      00
 2216              	.LVL92:
 226:RGB2YCbCr.c   ****     {
 2217              		.loc 1 226 34
 226:RGB2YCbCr.c   ****     {
 2218              		.loc 1 226 22
 226:RGB2YCbCr.c   ****     {
 2219              		.loc 1 226 5 is_stmt 0
 2220 1919 FFCB     		decl	%ebx
 2221 191b C4411857 		vxorps	%xmm12, %xmm12, %xmm12
 2221      E4
 2222 1920 C57C282D 		vmovaps	.LC38(%rip), %ymm13
 2222      00000000 
 2223 1928 0F8582F8 		jne	.L40
 2223      FFFF
 2224              	.LBE30:
 252:RGB2YCbCr.c   ****     }
 253:RGB2YCbCr.c   ****     end_t = get_wall_time();
 2225              		.loc 1 253 5 is_stmt 1
 2226              		.loc 1 253 13 is_stmt 0
 2227 192e 31C0     		xorl	%eax, %eax
 2228 1930 C5F877   		vzeroupper
 2229 1933 E8000000 		call	get_wall_time
 2229      00
 2230              	.LVL93:
 254:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast1");
 2231              		.loc 1 254 5 is_stmt 1
 2232 1938 4489EF   		movl	%r13d, %edi
 2233 193b C5FB5C85 		vsubsd	-176(%rbp), %xmm0, %xmm0
 2233      50FFFFFF 
 2234              	.LVL94:
 255:RGB2YCbCr.c   **** }
 2235              		.loc 1 255 1 is_stmt 0
 2236 1943 4881C488 		addq	$136, %rsp
 2236      000000
 254:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast1");
 2237              		.loc 1 254 5
 2238 194a BE000000 		movl	$.LC66, %esi
 2238      00
 2239              		.loc 1 255 1
 2240 194f 5B       		popq	%rbx
 2241 1950 415C     		popq	%r12
 2242 1952 415D     		popq	%r13
 2243              		.cfi_remember_state
 2244              		.cfi_def_cfa 13, 0
 2245 1954 415E     		popq	%r14
 2246              	.LVL95:
 2247 1956 415F     		popq	%r15
 2248              	.LVL96:
 2249 1958 5D       		popq	%rbp
 2250              	.LVL97:
 2251 1959 498D65F0 		leaq	-16(%r13), %rsp
 2252              		.cfi_def_cfa 7, 16
 2253              	.LVL98:
 2254 195d 415D     		popq	%r13
 2255              		.cfi_def_cfa_offset 8
 254:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast1");
 2256              		.loc 1 254 5
 2257 195f E9000000 		jmp	results
 2257      00
 2258              	.LVL99:
 2259              	.L48:
 2260              		.cfi_restore_state
 2261              	.LBB31:
 2262              	.LBB28:
 229:RGB2YCbCr.c   ****         {
 2263              		.loc 1 229 18
 2264 1964 31F6     		xorl	%esi, %esi
 2265 1966 E981FEFF 		jmp	.L41
 2265      FF
 2266              	.LVL100:
 2267              	.L52:
 2268              	.LBE28:
 2269              	.LBE31:
 214:RGB2YCbCr.c   ****         exit(-1);
 2270              		.loc 1 214 9 is_stmt 1
 2271 196b BF000000 		movl	$.LC0, %edi
 2271      00
 2272              	.LVL101:
 2273 1970 E8000000 		call	puts
 2273      00
 2274              	.LVL102:
 215:RGB2YCbCr.c   ****     }
 2275              		.loc 1 215 9
 2276 1975 83CFFF   		orl	$-1, %edi
 2277 1978 E8000000 		call	exit
 2277      00
 2278              	.LVL103:
 2279              		.cfi_endproc
 2280              	.LFE17:
 2282              		.section	.rodata.str1.1
 2283              	.LC68:
 2284 0042 52474232 		.string	"RGB2Gray_cast2"
 2284      47726179 
 2284      5F636173 
 2284      743200
 2285              		.text
 2286 197d 0F1F00   		.p2align 4
 2287              		.globl	RGB2YCbCr_cast2
 2289              	RGB2YCbCr_cast2:
 2290              	.LFB18:
 256:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
 257:RGB2YCbCr.c   **** 
 258:RGB2YCbCr.c   **** /* cambios respecto RGB2YCbCr_cast1(): no suma 0.5f a los valores Y,Cb,Cr calculados */
 259:RGB2YCbCr.c   **** void
 260:RGB2YCbCr.c   **** RGB2YCbCr_cast2(image_t * restrict image_in, image_t * restrict image_out)
 261:RGB2YCbCr.c   **** {
 2291              		.loc 1 261 1
 2292              		.cfi_startproc
 2293              	.LVL104:
 262:RGB2YCbCr.c   ****     double start_t, end_t;
 2294              		.loc 1 262 5
 263:RGB2YCbCr.c   ****     const int height = image_in->height;
 2295              		.loc 1 263 5
 261:RGB2YCbCr.c   ****     double start_t, end_t;
 2296              		.loc 1 261 1 is_stmt 0
 2297 1980 4155     		pushq	%r13
 2298              		.cfi_def_cfa_offset 16
 2299              		.cfi_offset 13, -16
 2300 1982 4C8D6C24 		leaq	16(%rsp), %r13
 2300      10
 2301              		.cfi_def_cfa 13, 0
 2302 1987 4883E4E0 		andq	$-32, %rsp
 2303 198b 41FF75F8 		pushq	-8(%r13)
 2304 198f 55       		pushq	%rbp
 2305              		.cfi_escape 0x10,0x6,0x2,0x76,0
 2306 1990 4889E5   		movq	%rsp, %rbp
 2307 1993 4157     		pushq	%r15
 2308 1995 4156     		pushq	%r14
 2309 1997 4155     		pushq	%r13
 2310              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 2311              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 2312              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 2313 1999 4154     		pushq	%r12
 2314 199b 53       		pushq	%rbx
 2315 199c 4881EC88 		subq	$136, %rsp
 2315      000000
 2316              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 2317              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
 264:RGB2YCbCr.c   ****     const int width =  image_in->width;
 265:RGB2YCbCr.c   ****     unsigned char * restrict pixels_in  = image_in->pixels;
 2318              		.loc 1 265 30
 2319 19a3 488B07   		movq	(%rdi), %rax
 266:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 267:RGB2YCbCr.c   **** 
 268:RGB2YCbCr.c   ****     if (image_in->bytes_per_pixel != 3)
 2320              		.loc 1 268 8
 2321 19a6 837F1003 		cmpl	$3, 16(%rdi)
 263:RGB2YCbCr.c   ****     const int width =  image_in->width;
 2322              		.loc 1 263 15
 2323 19aa 8B5F0C   		movl	12(%rdi), %ebx
 2324              	.LVL105:
 264:RGB2YCbCr.c   ****     const int width =  image_in->width;
 2325              		.loc 1 264 5 is_stmt 1
 264:RGB2YCbCr.c   ****     const int width =  image_in->width;
 2326              		.loc 1 264 15 is_stmt 0
 2327 19ad 448B6F08 		movl	8(%rdi), %r13d
 2328              	.LVL106:
 265:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 2329              		.loc 1 265 5 is_stmt 1
 265:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 2330              		.loc 1 265 30 is_stmt 0
 2331 19b1 48898568 		movq	%rax, -152(%rbp)
 2331      FFFFFF
 2332              	.LVL107:
 266:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 2333              		.loc 1 266 5 is_stmt 1
 266:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 2334              		.loc 1 266 30 is_stmt 0
 2335 19b8 488B06   		movq	(%rsi), %rax
 2336              	.LVL108:
 2337 19bb 48898560 		movq	%rax, -160(%rbp)
 2337      FFFFFF
 2338              	.LVL109:
 2339              		.loc 1 268 5 is_stmt 1
 2340              		.loc 1 268 8 is_stmt 0
 2341 19c2 0F853C08 		jne	.L67
 2341      0000
 269:RGB2YCbCr.c   ****     {
 270:RGB2YCbCr.c   ****         printf("ERROR: input image has to be RGB\n");
 271:RGB2YCbCr.c   ****         exit(-1);
 272:RGB2YCbCr.c   ****     }
 273:RGB2YCbCr.c   ****     
 274:RGB2YCbCr.c   ****     /* fill struct fields */
 275:RGB2YCbCr.c   ****     image_out->width  = width;
 276:RGB2YCbCr.c   ****     image_out->height = height;
 277:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 2342              		.loc 1 277 32
 2343 19c8 48B80300 		movabsq	$12884901891, %rax
 2343      00000300 
 2343      0000
 2344              	.LVL110:
 275:RGB2YCbCr.c   ****     image_out->height = height;
 2345              		.loc 1 275 23
 2346 19d2 44896E08 		movl	%r13d, 8(%rsi)
 2347              	.LBB32:
 2348              	.LBB33:
 278:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 279:RGB2YCbCr.c   **** 
 280:RGB2YCbCr.c   ****     start_t = get_wall_time();
 281:RGB2YCbCr.c   **** 
 282:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 283:RGB2YCbCr.c   ****     {
 284:RGB2YCbCr.c   ****         #pragma GCC ivdep
 285:RGB2YCbCr.c   ****         for (int i = 0; i < height*width; i++)
 2349              		.loc 1 285 35
 2350 19d6 440FAFEB 		imull	%ebx, %r13d
 2351              	.LVL111:
 2352 19da 4989FF   		movq	%rdi, %r15
 2353              	.LBE33:
 2354              	.LBE32:
 276:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 2355              		.loc 1 276 23
 2356 19dd 895E0C   		movl	%ebx, 12(%rsi)
 2357 19e0 4989F6   		movq	%rsi, %r14
 275:RGB2YCbCr.c   ****     image_out->height = height;
 2358              		.loc 1 275 5 is_stmt 1
 276:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 2359              		.loc 1 276 5
 277:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 2360              		.loc 1 277 5
 278:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 2361              		.loc 1 278 5
 2362              	.LBB37:
 2363              	.LBB34:
 2364              		.loc 1 285 35 is_stmt 0
 2365 19e3 BB0A0000 		movl	$10, %ebx
 2365      00
 2366              	.LVL112:
 2367              	.LBE34:
 2368              	.LBE37:
 277:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 2369              		.loc 1 277 32
 2370 19e8 48894610 		movq	%rax, 16(%rsi)
 280:RGB2YCbCr.c   **** 
 2371              		.loc 1 280 5 is_stmt 1
 280:RGB2YCbCr.c   **** 
 2372              		.loc 1 280 15 is_stmt 0
 2373 19ec 31C0     		xorl	%eax, %eax
 2374 19ee E8000000 		call	get_wall_time
 2374      00
 2375              	.LVL113:
 2376 19f3 418D45FF 		leal	-1(%r13), %eax
 2377 19f7 C4411857 		vxorps	%xmm12, %xmm12, %xmm12
 2377      E4
 2378 19fc C57D6F35 		vmovdqa	.LC34(%rip), %ymm14
 2378      00000000 
 2379 1a04 89855CFF 		movl	%eax, -164(%rbp)
 2379      FFFF
 2380 1a0a 4489E8   		movl	%r13d, %eax
 2381 1a0d C1E805   		shrl	$5, %eax
 2382 1a10 C5FB1185 		vmovsd	%xmm0, -176(%rbp)
 2382      50FFFFFF 
 2383              	.LVL114:
 282:RGB2YCbCr.c   ****     {
 2384              		.loc 1 282 5 is_stmt 1
 2385              	.LBB38:
 282:RGB2YCbCr.c   ****     {
 2386              		.loc 1 282 10
 282:RGB2YCbCr.c   ****     {
 2387              		.loc 1 282 22
 2388 1a18 4C8D0C40 		leaq	(%rax,%rax,2), %r9
 2389 1a1c 488B8568 		movq	-152(%rbp), %rax
 2389      FFFFFF
 2390 1a23 49C1E105 		salq	$5, %r9
 2391 1a27 4D8D2401 		leaq	(%r9,%rax), %r12
 2392 1a2b 4489E8   		movl	%r13d, %eax
 2393 1a2e 83E0E0   		andl	$-32, %eax
 2394 1a31 898558FF 		movl	%eax, -168(%rbp)
 2394      FFFF
 2395              	.LVL115:
 2396 1a37 660F1F84 		.p2align 4,,10
 2396      00000000 
 2396      00
 2397              		.p2align 3
 2398              	.L55:
 2399              	.LBB35:
 2400              		.loc 1 285 25
 2401              		.loc 1 285 9 is_stmt 0
 2402 1a40 4585ED   		testl	%r13d, %r13d
 2403 1a43 0F8E5B07 		jle	.L62
 2403      0000
 2404 1a49 83BD5CFF 		cmpl	$30, -164(%rbp)
 2404      FFFF1E
 2405 1a50 0F86A707 		jbe	.L63
 2405      0000
 2406 1a56 488B9560 		movq	-160(%rbp), %rdx
 2406      FFFFFF
 2407 1a5d 488B8568 		movq	-152(%rbp), %rax
 2407      FFFFFF
 2408              	.LVL116:
 2409              		.p2align 4,,10
 2410 1a64 0F1F4000 		.p2align 3
 2411              	.L57:
 286:RGB2YCbCr.c   ****         {
 287:RGB2YCbCr.c   ****             /* R */
 288:RGB2YCbCr.c   ****             pixels_out[3*i + 0] = (unsigned char) (
 2412              		.loc 1 288 13 is_stmt 1 discriminator 3
 289:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 2413              		.loc 1 290 42 is_stmt 0 discriminator 3
 2414 1a68 C5FE6F00 		vmovdqu	(%rax), %ymm0
 289:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2415              		.loc 1 289 37 discriminator 3
 2416 1a6c C4410057 		vxorps	%xmm15, %xmm15, %xmm15
 2416      FF
 2417 1a71 4883C060 		addq	$96, %rax
 2418 1a75 4883C260 		addq	$96, %rdx
 2419              		.loc 1 290 42 discriminator 3
 2420 1a79 C5FE6F58 		vmovdqu	-32(%rax), %ymm3
 2420      E0
 2421 1a7e C5FE6F50 		vmovdqu	-64(%rax), %ymm2
 2421      C0
 2422 1a83 C4E27D00 		vpshufb	.LC13(%rip), %ymm0, %ymm1
 2422      0D000000 
 2422      00
 2423 1a8c C4E26D00 		vpshufb	.LC15(%rip), %ymm2, %ymm5
 2423      2D000000 
 2423      00
 2424 1a95 C4E3FD00 		vpermq	$78, %ymm1, %ymm4
 2424      E14E
 2425 1a9b C4E27D00 		vpshufb	.LC14(%rip), %ymm0, %ymm1
 2425      0D000000 
 2425      00
 2426 1aa4 C4E26D00 		vpshufb	.LC21(%rip), %ymm2, %ymm6
 2426      35000000 
 2426      00
 2427 1aad C5F5EBCC 		vpor	%ymm4, %ymm1, %ymm1
 2428 1ab1 C4E26500 		vpshufb	.LC16(%rip), %ymm3, %ymm4
 2428      25000000 
 2428      00
 2429 1aba C4E26D00 		vpshufb	.LC27(%rip), %ymm2, %ymm2
 2429      15000000 
 2429      00
 2430 1ac3 C5F5EBCD 		vpor	%ymm5, %ymm1, %ymm1
 2431 1ac7 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 2431      EC4E
 2432 1acd C4E26500 		vpshufb	.LC18(%rip), %ymm3, %ymm4
 2432      25000000 
 2432      00
 2433 1ad6 C4E27500 		vpshufb	.LC17(%rip), %ymm1, %ymm1
 2433      0D000000 
 2433      00
 2434 1adf C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 2435 1ae3 C5F5EBCC 		vpor	%ymm4, %ymm1, %ymm1
 2436 1ae7 C4E27D00 		vpshufb	.LC19(%rip), %ymm0, %ymm4
 2436      25000000 
 2436      00
 2437 1af0 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 2437      EC4E
 2438 1af6 C4E27D00 		vpshufb	.LC20(%rip), %ymm0, %ymm4
 2438      25000000 
 2438      00
 2439 1aff C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 2440 1b03 C4E26500 		vpshufb	.LC22(%rip), %ymm3, %ymm5
 2440      2D000000 
 2440      00
 2441 1b0c C5DDEBE6 		vpor	%ymm6, %ymm4, %ymm4
 2442 1b10 C4E3FD00 		vpermq	$78, %ymm5, %ymm6
 2442      F54E
 2443 1b16 C4E26500 		vpshufb	.LC24(%rip), %ymm3, %ymm5
 2443      2D000000 
 2443      00
 2444 1b1f C4E25D00 		vpshufb	.LC23(%rip), %ymm4, %ymm4
 2444      25000000 
 2444      00
 2445 1b28 C5D5EBEE 		vpor	%ymm6, %ymm5, %ymm5
 2446 1b2c C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 2447 1b30 C4E27D00 		vpshufb	.LC25(%rip), %ymm0, %ymm5
 2447      2D000000 
 2447      00
 2448 1b39 C4E27D00 		vpshufb	.LC26(%rip), %ymm0, %ymm0
 2448      05000000 
 2448      00
 2449 1b42 C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 2449      ED4E
 2450 1b48 C5FDEBC5 		vpor	%ymm5, %ymm0, %ymm0
 2451 1b4c C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 2452 1b50 C4E26500 		vpshufb	.LC28(%rip), %ymm3, %ymm2
 2452      15000000 
 2452      00
 2453 1b59 C4E27D00 		vpshufb	.LC23(%rip), %ymm0, %ymm0
 2453      05000000 
 2453      00
 2454 1b62 C4E3FD00 		vpermq	$78, %ymm2, %ymm5
 2454      EA4E
 2455 1b68 C4E26500 		vpshufb	.LC29(%rip), %ymm3, %ymm2
 2455      15000000 
 2455      00
 2456 1b71 C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 2457 1b75 C4E27D30 		vpmovzxbw	%xmm1, %ymm3
 2457      D9
 2458 1b7a C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 2458      C901
 2459 1b80 C5FDEBD2 		vpor	%ymm2, %ymm0, %ymm2
 2460 1b84 C4E27D33 		vpmovzxwd	%xmm3, %ymm0
 2460      C3
 2461 1b89 C4E37D39 		vextracti128	$0x1, %ymm3, %xmm3
 2461      DB01
 2462 1b8f C4E27D30 		vpmovzxbw	%xmm1, %ymm1
 2462      C9
 2463 1b94 C4E27D33 		vpmovzxwd	%xmm3, %ymm3
 2463      DB
 2464              		.loc 1 290 32 discriminator 3
 2465 1b99 C5FC5BC0 		vcvtdq2ps	%ymm0, %ymm0
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 292:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2466              		.loc 1 292 42 discriminator 3
 2467 1b9d C4E27D30 		vpmovzxbw	%xmm2, %ymm6
 2467      F2
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2468              		.loc 1 290 32 discriminator 3
 2469 1ba2 C5FC5BEB 		vcvtdq2ps	%ymm3, %ymm5
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2470              		.loc 1 290 42 discriminator 3
 2471 1ba6 C4E27D33 		vpmovzxwd	%xmm1, %ymm3
 2471      D9
 2472 1bab C4E37D39 		vextracti128	$0x1, %ymm1, %xmm1
 2472      C901
 2473              		.loc 1 292 42 discriminator 3
 2474 1bb1 C4627D33 		vpmovzxwd	%xmm6, %ymm10
 2474      D6
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2475              		.loc 1 290 42 discriminator 3
 2476 1bb6 C4E27D33 		vpmovzxwd	%xmm1, %ymm1
 2476      C9
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2477              		.loc 1 290 32 discriminator 3
 2478 1bbb C57C5BEB 		vcvtdq2ps	%ymm3, %ymm13
 2479              		.loc 1 292 32 discriminator 3
 2480 1bbf C4417C5B 		vcvtdq2ps	%ymm10, %ymm10
 2480      D2
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2481              		.loc 1 290 32 discriminator 3
 2482 1bc4 C5FC296D 		vmovaps	%ymm5, -112(%rbp)
 2482      90
 2483 1bc9 C5FC5BF9 		vcvtdq2ps	%ymm1, %ymm7
 2484 1bcd C5FC590D 		vmulps	.LC30(%rip), %ymm0, %ymm1
 2484      00000000 
 2485 1bd5 C5FC297D 		vmovaps	%ymm7, -80(%rbp)
 2485      B0
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2486              		.loc 1 291 42 discriminator 3
 2487 1bda C4E27D30 		vpmovzxbw	%xmm4, %ymm7
 2487      FC
 2488 1bdf C4627D33 		vpmovzxwd	%xmm7, %ymm11
 2488      DF
 2489 1be4 C4E37D39 		vextracti128	$0x1, %ymm7, %xmm7
 2489      FF01
 2490              		.loc 1 292 42 discriminator 3
 2491 1bea C4E37D39 		vextracti128	$0x1, %ymm6, %xmm6
 2491      F601
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2492              		.loc 1 290 32 discriminator 3
 2493 1bf0 C57C29AD 		vmovaps	%ymm13, -144(%rbp)
 2493      70FFFFFF 
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2494              		.loc 1 291 32 discriminator 3
 2495 1bf8 C4417C5B 		vcvtdq2ps	%ymm11, %ymm11
 2495      DB
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2496              		.loc 1 291 42 discriminator 3
 2497 1bfd C4E27D33 		vpmovzxwd	%xmm7, %ymm7
 2497      FF
 2498              		.loc 1 292 42 discriminator 3
 2499 1c02 C4E27D33 		vpmovzxwd	%xmm6, %ymm6
 2499      F6
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2500              		.loc 1 291 42 discriminator 3
 2501 1c07 C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 2501      E401
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2502              		.loc 1 291 32 discriminator 3
 2503 1c0d C5A4591D 		vmulps	.LC31(%rip), %ymm11, %ymm3
 2503      00000000 
 2504 1c15 C5FC5BFF 		vcvtdq2ps	%ymm7, %ymm7
 2505              		.loc 1 292 32 discriminator 3
 2506 1c19 C5FC5BF6 		vcvtdq2ps	%ymm6, %ymm6
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2507              		.loc 1 291 42 discriminator 3
 2508 1c1d C4E27D30 		vpmovzxbw	%xmm4, %ymm4
 2508      E4
 2509 1c22 C4627D33 		vpmovzxwd	%xmm4, %ymm9
 2509      CC
 2510              		.loc 1 292 42 discriminator 3
 2511 1c27 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 2511      D201
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2512              		.loc 1 291 42 discriminator 3
 2513 1c2d C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 2513      E401
 289:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2514              		.loc 1 289 37 discriminator 3
 2515 1c33 C4C17458 		vaddps	%ymm15, %ymm1, %ymm1
 2515      CF
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2516              		.loc 1 291 32 discriminator 3
 2517 1c38 C4417C5B 		vcvtdq2ps	%ymm9, %ymm9
 2517      C9
 2518              		.loc 1 292 42 discriminator 3
 2519 1c3d C4E27D30 		vpmovzxbw	%xmm2, %ymm2
 2519      D2
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2520              		.loc 1 291 42 discriminator 3
 2521 1c42 C4E27D33 		vpmovzxwd	%xmm4, %ymm4
 2521      E4
 2522              		.loc 1 292 42 discriminator 3
 2523 1c47 C4627D33 		vpmovzxwd	%xmm2, %ymm8
 2523      C2
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2524              		.loc 1 291 32 discriminator 3
 2525 1c4c C5FC5BE4 		vcvtdq2ps	%ymm4, %ymm4
 2526              		.loc 1 292 42 discriminator 3
 2527 1c50 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 2527      D201
 2528              		.loc 1 292 32 discriminator 3
 2529 1c56 C4417C5B 		vcvtdq2ps	%ymm8, %ymm8
 2529      C0
 2530              		.loc 1 292 42 discriminator 3
 2531 1c5b C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 2531      D2
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2532              		.loc 1 290 52 discriminator 3
 2533 1c60 C5F458CB 		vaddps	%ymm3, %ymm1, %ymm1
 2534              		.loc 1 292 32 discriminator 3
 2535 1c64 C5AC591D 		vmulps	.LC32(%rip), %ymm10, %ymm3
 2535      00000000 
 2536 1c6c C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2537              		.loc 1 291 52 discriminator 3
 2538 1c70 C5F458CB 		vaddps	%ymm3, %ymm1, %ymm1
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2539              		.loc 1 290 32 discriminator 3
 2540 1c74 C5D4591D 		vmulps	.LC30(%rip), %ymm5, %ymm3
 2540      00000000 
 288:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2541              		.loc 1 288 35 discriminator 3
 2542 1c7c C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 289:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 2543              		.loc 1 289 37 discriminator 3
 2544 1c80 C4C16458 		vaddps	%ymm15, %ymm3, %ymm5
 2544      EF
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2545              		.loc 1 291 32 discriminator 3
 2546 1c85 C5C4591D 		vmulps	.LC31(%rip), %ymm7, %ymm3
 2546      00000000 
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2547              		.loc 1 290 52 discriminator 3
 2548 1c8d C5D458DB 		vaddps	%ymm3, %ymm5, %ymm3
 2549              		.loc 1 292 32 discriminator 3
 2550 1c91 C5CC592D 		vmulps	.LC32(%rip), %ymm6, %ymm5
 2550      00000000 
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2551              		.loc 1 291 52 discriminator 3
 2552 1c99 C5E458ED 		vaddps	%ymm5, %ymm3, %ymm5
 288:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2553              		.loc 1 288 35 discriminator 3
 2554 1c9d C58DDBD9 		vpand	%ymm1, %ymm14, %ymm3
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2555              		.loc 1 290 32 discriminator 3
 2556 1ca1 C594590D 		vmulps	.LC30(%rip), %ymm13, %ymm1
 2556      00000000 
 288:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2557              		.loc 1 288 35 discriminator 3
 2558 1ca9 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 2559 1cad C58DDBED 		vpand	%ymm5, %ymm14, %ymm5
 2560 1cb1 C4E2652B 		vpackusdw	%ymm5, %ymm3, %ymm3
 2560      DD
 2561 1cb6 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 2561      DBD8
 289:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 2562              		.loc 1 289 37 discriminator 3
 2563 1cbc C4C17458 		vaddps	%ymm15, %ymm1, %ymm5
 2563      EF
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2564              		.loc 1 291 32 discriminator 3
 2565 1cc1 C5B4590D 		vmulps	.LC31(%rip), %ymm9, %ymm1
 2565      00000000 
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2566              		.loc 1 290 52 discriminator 3
 2567 1cc9 C5D458C9 		vaddps	%ymm1, %ymm5, %ymm1
 2568              		.loc 1 292 32 discriminator 3
 2569 1ccd C5BC592D 		vmulps	.LC32(%rip), %ymm8, %ymm5
 2569      00000000 
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2570              		.loc 1 291 52 discriminator 3
 2571 1cd5 C5F458CD 		vaddps	%ymm5, %ymm1, %ymm1
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2572              		.loc 1 290 32 discriminator 3
 2573 1cd9 C5FC286D 		vmovaps	-80(%rbp), %ymm5
 2573      B0
 2574 1cde C5D4592D 		vmulps	.LC30(%rip), %ymm5, %ymm5
 2574      00000000 
 288:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2575              		.loc 1 288 35 discriminator 3
 2576 1ce6 C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 2577 1cea C58DDBC9 		vpand	%ymm1, %ymm14, %ymm1
 289:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 2578              		.loc 1 289 37 discriminator 3
 2579 1cee C4415458 		vaddps	%ymm15, %ymm5, %ymm13
 2579      EF
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2580              		.loc 1 291 32 discriminator 3
 2581 1cf3 C5DC592D 		vmulps	.LC31(%rip), %ymm4, %ymm5
 2581      00000000 
 293:RGB2YCbCr.c   ****             /* G */
 294:RGB2YCbCr.c   ****             pixels_out[3*i + 1] = (unsigned char) (
 295:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 2582              		.loc 1 296 32 discriminator 3
 2583 1cfb C57C287D 		vmovaps	-80(%rbp), %ymm15
 2583      B0
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2584              		.loc 1 290 52 discriminator 3
 2585 1d00 C59458ED 		vaddps	%ymm5, %ymm13, %ymm5
 292:RGB2YCbCr.c   ****             /* G */
 2586              		.loc 1 292 32 discriminator 3
 2587 1d04 C56C592D 		vmulps	.LC32(%rip), %ymm2, %ymm13
 2587      00000000 
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2588              		.loc 1 291 52 discriminator 3
 2589 1d0c C4C15458 		vaddps	%ymm13, %ymm5, %ymm5
 2589      ED
 288:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2590              		.loc 1 288 35 discriminator 3
 2591 1d11 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 2592 1d15 C58DDBED 		vpand	%ymm5, %ymm14, %ymm5
 2593 1d19 C4E2752B 		vpackusdw	%ymm5, %ymm1, %ymm5
 2593      ED
 2594 1d1e C5E5DB0D 		vpand	.LC35(%rip), %ymm3, %ymm1
 2594      00000000 
 2595 1d26 C4E3FD00 		vpermq	$216, %ymm5, %ymm5
 2595      EDD8
 2596 1d2c C5D5DB2D 		vpand	.LC35(%rip), %ymm5, %ymm5
 2596      00000000 
 2597 1d34 C5F567CD 		vpackuswb	%ymm5, %ymm1, %ymm1
 2598              		.loc 1 296 32 discriminator 3
 2599 1d38 C5FC592D 		vmulps	.LC36(%rip), %ymm0, %ymm5
 2599      00000000 
 288:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2600              		.loc 1 288 35 discriminator 3
 2601 1d40 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 2601      C9D8
 294:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 2602              		.loc 1 294 13 is_stmt 1 discriminator 3
 295:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 2603              		.loc 1 295 37 is_stmt 0 discriminator 3
 2604 1d46 C5D4581D 		vaddps	.LC67(%rip), %ymm5, %ymm3
 2604      00000000 
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2605              		.loc 1 297 32 discriminator 3
 2606 1d4e C5A4592D 		vmulps	.LC37(%rip), %ymm11, %ymm5
 2606      00000000 
 298:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 299:RGB2YCbCr.c   ****             /* B */
 300:RGB2YCbCr.c   ****             pixels_out[3*i + 2] =  (unsigned char) (
 301:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 303:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2607              		.loc 1 303 32 discriminator 3
 2608 1d56 C524591D 		vmulps	.LC40(%rip), %ymm11, %ymm11
 2608      00000000 
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2609              		.loc 1 302 32 discriminator 3
 2610 1d5e C5FC5905 		vmulps	.LC38(%rip), %ymm0, %ymm0
 2610      00000000 
 301:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 2611              		.loc 1 301 37 discriminator 3
 2612 1d66 C5FC5805 		vaddps	.LC67(%rip), %ymm0, %ymm0
 2612      00000000 
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2613              		.loc 1 296 52 discriminator 3
 2614 1d6e C5E458ED 		vaddps	%ymm5, %ymm3, %ymm5
 298:RGB2YCbCr.c   ****             /* B */
 2615              		.loc 1 298 32 discriminator 3
 2616 1d72 C5AC591D 		vmulps	.LC38(%rip), %ymm10, %ymm3
 2616      00000000 
 304:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2617              		.loc 1 304 32 discriminator 3
 2618 1d7a C52C5915 		vmulps	.LC41(%rip), %ymm10, %ymm10
 2618      00000000 
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2619              		.loc 1 302 52 discriminator 3
 2620 1d82 C4417C58 		vaddps	%ymm11, %ymm0, %ymm11
 2620      DB
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2621              		.loc 1 297 52 discriminator 3
 2622 1d87 C5D458EB 		vaddps	%ymm3, %ymm5, %ymm5
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2623              		.loc 1 296 32 discriminator 3
 2624 1d8b C5FC285D 		vmovaps	-112(%rbp), %ymm3
 2624      90
 2625 1d90 C5E4591D 		vmulps	.LC36(%rip), %ymm3, %ymm3
 2625      00000000 
 295:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 2626              		.loc 1 295 37 discriminator 3
 2627 1d98 C564582D 		vaddps	.LC67(%rip), %ymm3, %ymm13
 2627      00000000 
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2628              		.loc 1 297 32 discriminator 3
 2629 1da0 C5C4591D 		vmulps	.LC37(%rip), %ymm7, %ymm3
 2629      00000000 
 303:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2630              		.loc 1 303 52 discriminator 3
 2631 1da8 C4412458 		vaddps	%ymm10, %ymm11, %ymm10
 2631      D2
 294:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 2632              		.loc 1 294 35 discriminator 3
 2633 1dad C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 2634 1db1 C58DDBED 		vpand	%ymm5, %ymm14, %ymm5
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2635              		.loc 1 300 36 discriminator 3
 2636 1db5 C4417E5B 		vcvttps2dq	%ymm10, %ymm10
 2636      D2
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2637              		.loc 1 296 52 discriminator 3
 2638 1dba C59458DB 		vaddps	%ymm3, %ymm13, %ymm3
 298:RGB2YCbCr.c   ****             /* B */
 2639              		.loc 1 298 32 discriminator 3
 2640 1dbe C54C592D 		vmulps	.LC38(%rip), %ymm6, %ymm13
 2640      00000000 
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2641              		.loc 1 297 52 discriminator 3
 2642 1dc6 C4416458 		vaddps	%ymm13, %ymm3, %ymm13
 2642      ED
 294:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 2643              		.loc 1 294 35 discriminator 3
 2644 1dcb C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 2644      ED
 2645 1dd0 C4410DDB 		vpand	%ymm13, %ymm14, %ymm13
 2645      ED
 2646 1dd5 C4C2552B 		vpackusdw	%ymm13, %ymm5, %ymm5
 2646      ED
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2647              		.loc 1 296 32 discriminator 3
 2648 1dda C57C28AD 		vmovaps	-144(%rbp), %ymm13
 2648      70FFFFFF 
 294:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 2649              		.loc 1 294 35 discriminator 3
 2650 1de2 C4E3FD00 		vpermq	$216, %ymm5, %ymm3
 2650      DDD8
 2651 1de8 C5E5DB1D 		vpand	.LC35(%rip), %ymm3, %ymm3
 2651      00000000 
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2652              		.loc 1 296 32 discriminator 3
 2653 1df0 C594592D 		vmulps	.LC36(%rip), %ymm13, %ymm5
 2653      00000000 
 295:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 2654              		.loc 1 295 37 discriminator 3
 2655 1df8 C554582D 		vaddps	.LC67(%rip), %ymm5, %ymm13
 2655      00000000 
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2656              		.loc 1 297 32 discriminator 3
 2657 1e00 C5B4592D 		vmulps	.LC37(%rip), %ymm9, %ymm5
 2657      00000000 
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2658              		.loc 1 296 52 discriminator 3
 2659 1e08 C59458ED 		vaddps	%ymm5, %ymm13, %ymm5
 298:RGB2YCbCr.c   ****             /* B */
 2660              		.loc 1 298 32 discriminator 3
 2661 1e0c C53C592D 		vmulps	.LC38(%rip), %ymm8, %ymm13
 2661      00000000 
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2662              		.loc 1 297 52 discriminator 3
 2663 1e14 C4C15458 		vaddps	%ymm13, %ymm5, %ymm5
 2663      ED
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2664              		.loc 1 296 32 discriminator 3
 2665 1e19 C504592D 		vmulps	.LC36(%rip), %ymm15, %ymm13
 2665      00000000 
 295:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 2666              		.loc 1 295 37 discriminator 3
 2667 1e21 C514583D 		vaddps	.LC67(%rip), %ymm13, %ymm15
 2667      00000000 
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2668              		.loc 1 297 32 discriminator 3
 2669 1e29 C55C592D 		vmulps	.LC37(%rip), %ymm4, %ymm13
 2669      00000000 
 294:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 2670              		.loc 1 294 35 discriminator 3
 2671 1e31 C5FE5BED 		vcvttps2dq	%ymm5, %ymm5
 2672 1e35 C58DDBED 		vpand	%ymm5, %ymm14, %ymm5
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2673              		.loc 1 296 52 discriminator 3
 2674 1e39 C4410458 		vaddps	%ymm13, %ymm15, %ymm13
 2674      ED
 298:RGB2YCbCr.c   ****             /* B */
 2675              		.loc 1 298 32 discriminator 3
 2676 1e3e C56C593D 		vmulps	.LC38(%rip), %ymm2, %ymm15
 2676      00000000 
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2677              		.loc 1 297 52 discriminator 3
 2678 1e46 C4411458 		vaddps	%ymm15, %ymm13, %ymm13
 2678      EF
 294:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 2679              		.loc 1 294 35 discriminator 3
 2680 1e4b C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 2680      ED
 2681 1e50 C4410DDB 		vpand	%ymm13, %ymm14, %ymm13
 2681      ED
 2682 1e55 C4C2552B 		vpackusdw	%ymm13, %ymm5, %ymm5
 2682      ED
 2683 1e5a C4E3FD00 		vpermq	$216, %ymm5, %ymm5
 2683      EDD8
 2684 1e60 C5D5DB2D 		vpand	.LC35(%rip), %ymm5, %ymm5
 2684      00000000 
 2685 1e68 C5E567DD 		vpackuswb	%ymm5, %ymm3, %ymm3
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2686              		.loc 1 302 32 discriminator 3
 2687 1e6c C5FC286D 		vmovaps	-112(%rbp), %ymm5
 2687      90
 2688 1e71 C57C287D 		vmovaps	-80(%rbp), %ymm15
 2688      B0
 303:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2689              		.loc 1 303 32 discriminator 3
 2690 1e76 C534590D 		vmulps	.LC40(%rip), %ymm9, %ymm9
 2690      00000000 
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2691              		.loc 1 302 32 discriminator 3
 2692 1e7e C57C28AD 		vmovaps	-144(%rbp), %ymm13
 2692      70FFFFFF 
 294:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 2693              		.loc 1 294 35 discriminator 3
 2694 1e86 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 2694      DBD8
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2695              		.loc 1 300 13 is_stmt 1 discriminator 3
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2696              		.loc 1 302 32 is_stmt 0 discriminator 3
 2697 1e8c C5D45905 		vmulps	.LC38(%rip), %ymm5, %ymm0
 2697      00000000 
 2698 1e94 C594592D 		vmulps	.LC38(%rip), %ymm13, %ymm5
 2698      00000000 
 301:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 2699              		.loc 1 301 37 discriminator 3
 2700 1e9c C5FC5805 		vaddps	.LC67(%rip), %ymm0, %ymm0
 2700      00000000 
 2701 1ea4 C5D4582D 		vaddps	.LC67(%rip), %ymm5, %ymm5
 2701      00000000 
 303:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2702              		.loc 1 303 32 discriminator 3
 2703 1eac C5C4593D 		vmulps	.LC40(%rip), %ymm7, %ymm7
 2703      00000000 
 2704 1eb4 C5DC5925 		vmulps	.LC40(%rip), %ymm4, %ymm4
 2704      00000000 
 2705              		.loc 1 304 32 discriminator 3
 2706 1ebc C5EC5915 		vmulps	.LC41(%rip), %ymm2, %ymm2
 2706      00000000 
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2707              		.loc 1 302 52 discriminator 3
 2708 1ec4 C4415458 		vaddps	%ymm9, %ymm5, %ymm9
 2708      C9
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2709              		.loc 1 302 32 discriminator 3
 2710 1ec9 C584592D 		vmulps	.LC38(%rip), %ymm15, %ymm5
 2710      00000000 
 301:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 2711              		.loc 1 301 37 discriminator 3
 2712 1ed1 C5D4582D 		vaddps	.LC67(%rip), %ymm5, %ymm5
 2712      00000000 
 2713              		.loc 1 304 32 discriminator 3
 2714 1ed9 C5CC5935 		vmulps	.LC41(%rip), %ymm6, %ymm6
 2714      00000000 
 2715 1ee1 C53C5905 		vmulps	.LC41(%rip), %ymm8, %ymm8
 2715      00000000 
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2716              		.loc 1 302 52 discriminator 3
 2717 1ee9 C5FC58FF 		vaddps	%ymm7, %ymm0, %ymm7
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2718              		.loc 1 300 36 discriminator 3
 2719 1eed C4C10DDB 		vpand	%ymm10, %ymm14, %ymm0
 2719      C2
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2720              		.loc 1 302 52 discriminator 3
 2721 1ef2 C5D458E4 		vaddps	%ymm4, %ymm5, %ymm4
 303:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2722              		.loc 1 303 52 discriminator 3
 2723 1ef6 C5C458F6 		vaddps	%ymm6, %ymm7, %ymm6
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2724              		.loc 1 300 33 discriminator 3
 2725 1efa C5FD6F3D 		vmovdqa	.LC53(%rip), %ymm7
 2725      00000000 
 303:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2726              		.loc 1 303 52 discriminator 3
 2727 1f02 C5DC58E2 		vaddps	%ymm2, %ymm4, %ymm4
 2728 1f06 C4413458 		vaddps	%ymm8, %ymm9, %ymm8
 2728      C0
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2729              		.loc 1 300 36 discriminator 3
 2730 1f0b C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 2731 1f0f C58DDBF6 		vpand	%ymm6, %ymm14, %ymm6
 2732 1f13 C4417E5B 		vcvttps2dq	%ymm8, %ymm8
 2732      C0
 2733 1f18 C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 2734 1f1c C4C10DDB 		vpand	%ymm8, %ymm14, %ymm2
 2734      D0
 2735 1f21 C58DDBE4 		vpand	%ymm4, %ymm14, %ymm4
 2736 1f25 C4E27D2B 		vpackusdw	%ymm6, %ymm0, %ymm0
 2736      C6
 2737 1f2a C4E26D2B 		vpackusdw	%ymm4, %ymm2, %ymm2
 2737      D4
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2738              		.loc 1 300 33 discriminator 3
 2739 1f2f C4E26500 		vpshufb	.LC43(%rip), %ymm3, %ymm4
 2739      25000000 
 2739      00
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2740              		.loc 1 300 36 discriminator 3
 2741 1f38 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 2741      C0D8
 2742 1f3e C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 2742      D2D8
 2743 1f44 C5FDDB05 		vpand	.LC35(%rip), %ymm0, %ymm0
 2743      00000000 
 2744 1f4c C5EDDB15 		vpand	.LC35(%rip), %ymm2, %ymm2
 2744      00000000 
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2745              		.loc 1 300 33 discriminator 3
 2746 1f54 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 2746      EC4E
 2747 1f5a C4E26500 		vpshufb	.LC45(%rip), %ymm3, %ymm4
 2747      25000000 
 2747      00
 2748 1f63 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2749              		.loc 1 300 36 discriminator 3
 2750 1f67 C5FD67D2 		vpackuswb	%ymm2, %ymm0, %ymm2
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2751              		.loc 1 300 33 discriminator 3
 2752 1f6b C4E27500 		vpshufb	.LC42(%rip), %ymm1, %ymm0
 2752      05000000 
 2752      00
 2753 1f74 C4E3FD00 		vpermq	$78, %ymm0, %ymm6
 2753      F04E
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2754              		.loc 1 300 36 discriminator 3
 2755 1f7a C4E3FD00 		vpermq	$216, %ymm2, %ymm2
 2755      D2D8
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2756              		.loc 1 300 33 discriminator 3
 2757 1f80 C4E27500 		vpshufb	.LC44(%rip), %ymm1, %ymm0
 2757      05000000 
 2757      00
 2758 1f89 C5FDEBC6 		vpor	%ymm6, %ymm0, %ymm0
 2759 1f8d C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 2760 1f91 C4E26D00 		vpshufb	.LC46(%rip), %ymm2, %ymm4
 2760      25000000 
 2760      00
 2761 1f9a C4E27D00 		vpshufb	.LC47(%rip), %ymm0, %ymm0
 2761      05000000 
 2761      00
 2762 1fa3 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 2762      EC4E
 2763 1fa9 C4E26D00 		vpshufb	.LC48(%rip), %ymm2, %ymm4
 2763      25000000 
 2763      00
 2764 1fb2 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 2765 1fb6 C4E26500 		vpshufb	.LC51(%rip), %ymm3, %ymm5
 2765      2D000000 
 2765      00
 2766 1fbf C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 2767 1fc3 C5FE7F42 		vmovdqu	%ymm0, -96(%rdx)
 2767      A0
 2768 1fc8 C4E27500 		vpshufb	.LC49(%rip), %ymm1, %ymm0
 2768      05000000 
 2768      00
 2769 1fd1 C4E3FD00 		vpermq	$78, %ymm0, %ymm4
 2769      E04E
 2770 1fd7 C4E27500 		vpshufb	.LC50(%rip), %ymm1, %ymm0
 2770      05000000 
 2770      00
 2771 1fe0 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 2772 1fe4 C4E26D00 		vpshufb	.LC52(%rip), %ymm2, %ymm4
 2772      25000000 
 2772      00
 2773 1fed C5FDEBC5 		vpor	%ymm5, %ymm0, %ymm0
 2774 1ff1 C4E37D4C 		vpblendvb	%ymm7, %ymm4, %ymm0, %ymm0
 2774      C470
 2775 1ff7 C5FE7F42 		vmovdqu	%ymm0, -64(%rdx)
 2775      C0
 2776 1ffc C4E27500 		vpshufb	.LC54(%rip), %ymm1, %ymm0
 2776      05000000 
 2776      00
 2777 2005 C4E26500 		vpshufb	.LC55(%rip), %ymm3, %ymm5
 2777      2D000000 
 2777      00
 2778 200e C4E26500 		vpshufb	.LC57(%rip), %ymm3, %ymm3
 2778      1D000000 
 2778      00
 2779 2017 C4E3FD00 		vpermq	$78, %ymm0, %ymm4
 2779      E04E
 2780 201d C4E3FD00 		vpermq	$78, %ymm5, %ymm5
 2780      ED4E
 2781 2023 C4E27500 		vpshufb	.LC56(%rip), %ymm1, %ymm0
 2781      05000000 
 2781      00
 2782 202c C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 2783 2030 C5E5EBDD 		vpor	%ymm5, %ymm3, %ymm3
 2784 2034 C4E26D00 		vpshufb	.LC58(%rip), %ymm2, %ymm1
 2784      0D000000 
 2784      00
 2785 203d C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 2786 2041 C4E3FD00 		vpermq	$78, %ymm1, %ymm1
 2786      C94E
 2787 2047 C4E26D00 		vpshufb	.LC60(%rip), %ymm2, %ymm2
 2787      15000000 
 2787      00
 2788 2050 C4E27D00 		vpshufb	.LC59(%rip), %ymm0, %ymm0
 2788      05000000 
 2788      00
 2789 2059 C5EDEBD1 		vpor	%ymm1, %ymm2, %ymm2
 2790 205d C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 2791 2061 C5FE7F42 		vmovdqu	%ymm0, -32(%rdx)
 2791      E0
 285:RGB2YCbCr.c   ****         {
 2792              		.loc 1 285 43 is_stmt 1 discriminator 3
 285:RGB2YCbCr.c   ****         {
 2793              		.loc 1 285 25 discriminator 3
 2794 2066 4C39E0   		cmpq	%r12, %rax
 2795 2069 0F85F9F9 		jne	.L57
 2795      FFFF
 2796 206f 8B8558FF 		movl	-168(%rbp), %eax
 2796      FFFF
 2797 2075 4139C5   		cmpl	%eax, %r13d
 2798 2078 0F842601 		je	.L62
 2798      0000
 285:RGB2YCbCr.c   ****         {
 2799              		.loc 1 285 18 is_stmt 0
 2800 207e 89C6     		movl	%eax, %esi
 2801              	.L56:
 2802 2080 488B8568 		movq	-152(%rbp), %rax
 2802      FFFFFF
 2803 2087 8D1476   		leal	(%rsi,%rsi,2), %edx
 2804 208a C57A102D 		vmovss	.LC1(%rip), %xmm13
 2804      00000000 
 2805 2092 C4412057 		vxorps	%xmm11, %xmm11, %xmm11
 2805      DB
 2806 2097 4863D2   		movslq	%edx, %rdx
 2807 209a C57A1015 		vmovss	.LC3(%rip), %xmm10
 2807      00000000 
 2808 20a2 C57A100D 		vmovss	.LC4(%rip), %xmm9
 2808      00000000 
 2809 20aa C57A1005 		vmovss	.LC5(%rip), %xmm8
 2809      00000000 
 2810 20b2 C5FA1025 		vmovss	.LC6(%rip), %xmm4
 2810      00000000 
 2811 20ba 4801D0   		addq	%rdx, %rax
 2812 20bd C5FA103D 		vmovss	.LC7(%rip), %xmm7
 2812      00000000 
 2813 20c5 C5FA101D 		vmovss	.LC8(%rip), %xmm3
 2813      00000000 
 2814 20cd C5FA1035 		vmovss	.LC9(%rip), %xmm6
 2814      00000000 
 2815 20d5 C5FA102D 		vmovss	.LC10(%rip), %xmm5
 2815      00000000 
 2816 20dd 48039560 		addq	-160(%rbp), %rdx
 2816      FFFFFF
 2817              		.p2align 4,,10
 2818 20e4 0F1F4000 		.p2align 3
 2819              	.L59:
 2820              	.LVL117:
 288:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2821              		.loc 1 288 13 is_stmt 1
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2822              		.loc 1 290 42 is_stmt 0
 2823 20e8 0FB608   		movzbl	(%rax), %ecx
 285:RGB2YCbCr.c   ****         {
 2824              		.loc 1 285 44
 2825 20eb FFC6     		incl	%esi
 2826              	.LVL118:
 2827 20ed 4883C003 		addq	$3, %rax
 2828 20f1 4883C203 		addq	$3, %rdx
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2829              		.loc 1 290 32
 2830 20f5 C59A2AC9 		vcvtsi2ssl	%ecx, %xmm12, %xmm1
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2831              		.loc 1 291 42
 2832 20f9 0FB648FE 		movzbl	-2(%rax), %ecx
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2833              		.loc 1 291 32
 2834 20fd C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 292:RGB2YCbCr.c   ****             /* G */
 2835              		.loc 1 292 42
 2836 2101 0FB648FF 		movzbl	-1(%rax), %ecx
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2837              		.loc 1 290 32
 2838 2105 C4C17259 		vmulss	%xmm13, %xmm1, %xmm1
 2838      CD
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2839              		.loc 1 291 32
 2840 210a C4C17A59 		vmulss	%xmm10, %xmm0, %xmm0
 2840      C2
 289:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 2841              		.loc 1 289 37
 2842 210f C4C17258 		vaddss	%xmm11, %xmm1, %xmm2
 2842      D3
 290:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 2843              		.loc 1 290 52
 2844 2114 C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 292:RGB2YCbCr.c   ****             /* G */
 2845              		.loc 1 292 32
 2846 2118 C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 2847 211c C4C17A59 		vmulss	%xmm9, %xmm0, %xmm0
 2847      C1
 291:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 2848              		.loc 1 291 52
 2849 2121 C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 288:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 2850              		.loc 1 288 35
 2851 2125 C5FA2CC8 		vcvttss2sil	%xmm0, %ecx
 2852 2129 884AFD   		movb	%cl, -3(%rdx)
 294:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 2853              		.loc 1 294 13 is_stmt 1
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2854              		.loc 1 296 42 is_stmt 0
 2855 212c 0FB648FD 		movzbl	-3(%rax), %ecx
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2856              		.loc 1 296 32
 2857 2130 C59A2AC9 		vcvtsi2ssl	%ecx, %xmm12, %xmm1
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2858              		.loc 1 297 42
 2859 2134 0FB648FE 		movzbl	-2(%rax), %ecx
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2860              		.loc 1 297 32
 2861 2138 C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 298:RGB2YCbCr.c   ****             /* B */
 2862              		.loc 1 298 42
 2863 213c 0FB648FF 		movzbl	-1(%rax), %ecx
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2864              		.loc 1 296 32
 2865 2140 C4C17259 		vmulss	%xmm8, %xmm1, %xmm1
 2865      C8
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2866              		.loc 1 297 32
 2867 2145 C5FA59C7 		vmulss	%xmm7, %xmm0, %xmm0
 295:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 2868              		.loc 1 295 37
 2869 2149 C5F258D4 		vaddss	%xmm4, %xmm1, %xmm2
 296:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 2870              		.loc 1 296 52
 2871 214d C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 298:RGB2YCbCr.c   ****             /* B */
 2872              		.loc 1 298 32
 2873 2151 C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 2874 2155 C5FA59C3 		vmulss	%xmm3, %xmm0, %xmm0
 297:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 2875              		.loc 1 297 52
 2876 2159 C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 294:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 2877              		.loc 1 294 35
 2878 215d C5FA2CC8 		vcvttss2sil	%xmm0, %ecx
 2879 2161 884AFE   		movb	%cl, -2(%rdx)
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2880              		.loc 1 300 13 is_stmt 1
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2881              		.loc 1 302 42 is_stmt 0
 2882 2164 0FB648FD 		movzbl	-3(%rax), %ecx
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2883              		.loc 1 302 32
 2884 2168 C59A2AC9 		vcvtsi2ssl	%ecx, %xmm12, %xmm1
 303:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2885              		.loc 1 303 42
 2886 216c 0FB648FE 		movzbl	-2(%rax), %ecx
 303:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2887              		.loc 1 303 32
 2888 2170 C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 2889              		.loc 1 304 42
 2890 2174 0FB648FF 		movzbl	-1(%rax), %ecx
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2891              		.loc 1 302 32
 2892 2178 C5F259CB 		vmulss	%xmm3, %xmm1, %xmm1
 303:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2893              		.loc 1 303 32
 2894 217c C5FA59C6 		vmulss	%xmm6, %xmm0, %xmm0
 301:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 2895              		.loc 1 301 37
 2896 2180 C5F258D4 		vaddss	%xmm4, %xmm1, %xmm2
 302:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 2897              		.loc 1 302 52
 2898 2184 C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 2899              		.loc 1 304 32
 2900 2188 C59A2AC1 		vcvtsi2ssl	%ecx, %xmm12, %xmm0
 2901 218c C5FA59C5 		vmulss	%xmm5, %xmm0, %xmm0
 303:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 2902              		.loc 1 303 52
 2903 2190 C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 300:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 2904              		.loc 1 300 36
 2905 2194 C5FA2CC8 		vcvttss2sil	%xmm0, %ecx
 2906 2198 884AFF   		movb	%cl, -1(%rdx)
 285:RGB2YCbCr.c   ****         {
 2907              		.loc 1 285 43 is_stmt 1
 2908              	.LVL119:
 285:RGB2YCbCr.c   ****         {
 2909              		.loc 1 285 25
 285:RGB2YCbCr.c   ****         {
 2910              		.loc 1 285 9 is_stmt 0
 2911 219b 4139F5   		cmpl	%esi, %r13d
 2912 219e 0F8F44FF 		jg	.L59
 2912      FFFF
 2913              	.LVL120:
 2914              	.L62:
 2915              	.LBE35:
 305:RGB2YCbCr.c   ****         }
 306:RGB2YCbCr.c   ****         dummy(image_in, image_out);
 2916              		.loc 1 306 9 is_stmt 1
 2917 21a4 4C89F6   		movq	%r14, %rsi
 2918 21a7 4C89FF   		movq	%r15, %rdi
 2919 21aa C5F877   		vzeroupper
 2920 21ad E8000000 		call	dummy
 2920      00
 2921              	.LVL121:
 282:RGB2YCbCr.c   ****     {
 2922              		.loc 1 282 34
 282:RGB2YCbCr.c   ****     {
 2923              		.loc 1 282 22
 282:RGB2YCbCr.c   ****     {
 2924              		.loc 1 282 5 is_stmt 0
 2925 21b2 FFCB     		decl	%ebx
 2926 21b4 C4411857 		vxorps	%xmm12, %xmm12, %xmm12
 2926      E4
 2927 21b9 C57D6F35 		vmovdqa	.LC34(%rip), %ymm14
 2927      00000000 
 2928 21c1 0F8579F8 		jne	.L55
 2928      FFFF
 2929              	.LBE38:
 307:RGB2YCbCr.c   ****     }
 308:RGB2YCbCr.c   ****     end_t = get_wall_time();
 2930              		.loc 1 308 5 is_stmt 1
 2931              		.loc 1 308 13 is_stmt 0
 2932 21c7 31C0     		xorl	%eax, %eax
 2933 21c9 C5F877   		vzeroupper
 2934 21cc E8000000 		call	get_wall_time
 2934      00
 2935              	.LVL122:
 309:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast2");
 2936              		.loc 1 309 5 is_stmt 1
 2937 21d1 4489EF   		movl	%r13d, %edi
 2938 21d4 C5FB5C85 		vsubsd	-176(%rbp), %xmm0, %xmm0
 2938      50FFFFFF 
 2939              	.LVL123:
 310:RGB2YCbCr.c   **** }
 2940              		.loc 1 310 1 is_stmt 0
 2941 21dc 4881C488 		addq	$136, %rsp
 2941      000000
 309:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast2");
 2942              		.loc 1 309 5
 2943 21e3 BE000000 		movl	$.LC68, %esi
 2943      00
 2944              		.loc 1 310 1
 2945 21e8 5B       		popq	%rbx
 2946 21e9 415C     		popq	%r12
 2947 21eb 415D     		popq	%r13
 2948              		.cfi_remember_state
 2949              		.cfi_def_cfa 13, 0
 2950 21ed 415E     		popq	%r14
 2951              	.LVL124:
 2952 21ef 415F     		popq	%r15
 2953              	.LVL125:
 2954 21f1 5D       		popq	%rbp
 2955              	.LVL126:
 2956 21f2 498D65F0 		leaq	-16(%r13), %rsp
 2957              		.cfi_def_cfa 7, 16
 2958              	.LVL127:
 2959 21f6 415D     		popq	%r13
 2960              		.cfi_def_cfa_offset 8
 309:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast2");
 2961              		.loc 1 309 5
 2962 21f8 E9000000 		jmp	results
 2962      00
 2963              	.LVL128:
 2964              	.L63:
 2965              		.cfi_restore_state
 2966              	.LBB39:
 2967              	.LBB36:
 285:RGB2YCbCr.c   ****         {
 2968              		.loc 1 285 18
 2969 21fd 31F6     		xorl	%esi, %esi
 2970 21ff E97CFEFF 		jmp	.L56
 2970      FF
 2971              	.LVL129:
 2972              	.L67:
 2973              	.LBE36:
 2974              	.LBE39:
 270:RGB2YCbCr.c   ****         exit(-1);
 2975              		.loc 1 270 9 is_stmt 1
 2976 2204 BF000000 		movl	$.LC0, %edi
 2976      00
 2977              	.LVL130:
 2978 2209 E8000000 		call	puts
 2978      00
 2979              	.LVL131:
 271:RGB2YCbCr.c   ****     }
 2980              		.loc 1 271 9
 2981 220e 83CFFF   		orl	$-1, %edi
 2982 2211 E8000000 		call	exit
 2982      00
 2983              	.LVL132:
 2984              		.cfi_endproc
 2985              	.LFE18:
 2987              		.section	.rodata.str1.1
 2988              	.LC69:
 2989 0051 52474232 		.string	"RGB2Gray_cast_esc"
 2989      47726179 
 2989      5F636173 
 2989      745F6573 
 2989      6300
 2990              		.text
 2991 2216 662E0F1F 		.p2align 4
 2991      84000000 
 2991      0000
 2992              		.globl	RGB2YCbCr_cast_esc
 2994              	RGB2YCbCr_cast_esc:
 2995              	.LFB19:
 311:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
 312:RGB2YCbCr.c   **** 
 313:RGB2YCbCr.c   **** /* cambios respecto RGB2YCbCr_cast1(): atributo para no vectorizar */
 314:RGB2YCbCr.c   **** __attribute__((optimize("no-tree-vectorize")))
 315:RGB2YCbCr.c   **** void
 316:RGB2YCbCr.c   **** RGB2YCbCr_cast_esc(image_t * restrict image_in, image_t * restrict image_out)
 317:RGB2YCbCr.c   **** {
 2996              		.loc 1 317 1
 2997              		.cfi_startproc
 2998              	.LVL133:
 318:RGB2YCbCr.c   ****     double start_t, end_t;
 2999              		.loc 1 318 5
 319:RGB2YCbCr.c   ****     const int height = image_in->height;
 3000              		.loc 1 319 5
 317:RGB2YCbCr.c   ****     double start_t, end_t;
 3001              		.loc 1 317 1 is_stmt 0
 3002 2220 4157     		pushq	%r15
 3003              		.cfi_def_cfa_offset 16
 3004              		.cfi_offset 15, -16
 3005 2222 4156     		pushq	%r14
 3006              		.cfi_def_cfa_offset 24
 3007              		.cfi_offset 14, -24
 3008 2224 4155     		pushq	%r13
 3009              		.cfi_def_cfa_offset 32
 3010              		.cfi_offset 13, -32
 3011 2226 4154     		pushq	%r12
 3012              		.cfi_def_cfa_offset 40
 3013              		.cfi_offset 12, -40
 3014 2228 55       		pushq	%rbp
 3015              		.cfi_def_cfa_offset 48
 3016              		.cfi_offset 6, -48
 3017 2229 53       		pushq	%rbx
 3018              		.cfi_def_cfa_offset 56
 3019              		.cfi_offset 3, -56
 3020 222a 4883EC18 		subq	$24, %rsp
 3021              		.cfi_def_cfa_offset 80
 320:RGB2YCbCr.c   ****     const int width =  image_in->width;
 321:RGB2YCbCr.c   ****     unsigned char * restrict pixels_in  = image_in->pixels;
 322:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 3022              		.loc 1 322 30
 3023 222e 488B06   		movq	(%rsi), %rax
 323:RGB2YCbCr.c   **** 
 324:RGB2YCbCr.c   ****     if (image_in->bytes_per_pixel != 3)
 3024              		.loc 1 324 8
 3025 2231 837F1003 		cmpl	$3, 16(%rdi)
 319:RGB2YCbCr.c   ****     const int width =  image_in->width;
 3026              		.loc 1 319 15
 3027 2235 448B6F0C 		movl	12(%rdi), %r13d
 3028              	.LVL134:
 320:RGB2YCbCr.c   ****     const int width =  image_in->width;
 3029              		.loc 1 320 5 is_stmt 1
 320:RGB2YCbCr.c   ****     const int width =  image_in->width;
 3030              		.loc 1 320 15 is_stmt 0
 3031 2239 8B5F08   		movl	8(%rdi), %ebx
 3032              	.LVL135:
 321:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 3033              		.loc 1 321 5 is_stmt 1
 322:RGB2YCbCr.c   **** 
 3034              		.loc 1 322 30 is_stmt 0
 3035 223c 48890424 		movq	%rax, (%rsp)
 321:RGB2YCbCr.c   ****     unsigned char * restrict pixels_out = image_out->pixels;
 3036              		.loc 1 321 30
 3037 2240 4C8B37   		movq	(%rdi), %r14
 3038              	.LVL136:
 322:RGB2YCbCr.c   **** 
 3039              		.loc 1 322 5 is_stmt 1
 3040              		.loc 1 324 5
 3041              		.loc 1 324 8 is_stmt 0
 3042 2243 0F85A801 		jne	.L77
 3042      0000
 325:RGB2YCbCr.c   ****     {
 326:RGB2YCbCr.c   ****         printf("ERROR: input image has to be RGB\n");
 327:RGB2YCbCr.c   ****         exit(-1);
 328:RGB2YCbCr.c   ****     }
 329:RGB2YCbCr.c   ****     
 330:RGB2YCbCr.c   ****     /* fill struct fields */
 331:RGB2YCbCr.c   ****     image_out->width  = width;
 332:RGB2YCbCr.c   ****     image_out->height = height;
 333:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 3043              		.loc 1 333 32
 3044 2249 48B80300 		movabsq	$12884901891, %rax
 3044      00000300 
 3044      0000
 3045              	.LVL137:
 331:RGB2YCbCr.c   ****     image_out->height = height;
 3046              		.loc 1 331 23
 3047 2253 895E08   		movl	%ebx, 8(%rsi)
 3048 2256 4989FC   		movq	%rdi, %r12
 3049 2259 4889F5   		movq	%rsi, %rbp
 331:RGB2YCbCr.c   ****     image_out->height = height;
 3050              		.loc 1 331 5 is_stmt 1
 332:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 3051              		.loc 1 332 5
 332:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 3052              		.loc 1 332 23 is_stmt 0
 3053 225c 44896E0C 		movl	%r13d, 12(%rsi)
 3054              		.loc 1 333 5 is_stmt 1
 334:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 3055              		.loc 1 334 5
 3056              	.LBB40:
 3057              	.LBB41:
 335:RGB2YCbCr.c   **** 
 336:RGB2YCbCr.c   ****     start_t = get_wall_time();
 337:RGB2YCbCr.c   **** 
 338:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 339:RGB2YCbCr.c   ****     {
 340:RGB2YCbCr.c   ****         for (int i = 0; i < height*width; i++)
 3058              		.loc 1 340 35 is_stmt 0
 3059 2260 440FAFEB 		imull	%ebx, %r13d
 3060              	.LVL138:
 3061 2264 BB0A0000 		movl	$10, %ebx
 3061      00
 3062              	.LVL139:
 3063              	.LBE41:
 3064              	.LBE40:
 333:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 3065              		.loc 1 333 32
 3066 2269 48894610 		movq	%rax, 16(%rsi)
 336:RGB2YCbCr.c   **** 
 3067              		.loc 1 336 5 is_stmt 1
 336:RGB2YCbCr.c   **** 
 3068              		.loc 1 336 15 is_stmt 0
 3069 226d 31C0     		xorl	%eax, %eax
 3070 226f E8000000 		call	get_wall_time
 3070      00
 3071              	.LVL140:
 3072 2274 418D45FF 		leal	-1(%r13), %eax
 3073 2278 C5E057DB 		vxorps	%xmm3, %xmm3, %xmm3
 3074 227c C57A1025 		vmovss	.LC1(%rip), %xmm12
 3074      00000000 
 3075 2284 488D0440 		leaq	(%rax,%rax,2), %rax
 3076 2288 C5FB1144 		vmovsd	%xmm0, 8(%rsp)
 3076      2408
 3077              	.LVL141:
 338:RGB2YCbCr.c   ****     {
 3078              		.loc 1 338 5 is_stmt 1
 3079              	.LBB43:
 338:RGB2YCbCr.c   ****     {
 3080              		.loc 1 338 10
 338:RGB2YCbCr.c   ****     {
 3081              		.loc 1 338 22
 3082 228e 4D8D7C06 		leaq	3(%r14,%rax), %r15
 3082      03
 3083              	.LVL142:
 3084              		.p2align 4,,10
 3085 2293 0F1F4400 		.p2align 3
 3085      00
 3086              	.L70:
 3087              	.LBB42:
 3088              		.loc 1 340 25
 3089              		.loc 1 340 9 is_stmt 0
 3090 2298 4585ED   		testl	%r13d, %r13d
 3091 229b 0F8E0901 		jle	.L74
 3091      0000
 3092 22a1 488B3424 		movq	(%rsp), %rsi
 3093 22a5 C5FA1025 		vmovss	.LC8(%rip), %xmm4
 3093      00000000 
 3094 22ad 4C89F1   		movq	%r14, %rcx
 3095 22b0 C57A101D 		vmovss	.LC3(%rip), %xmm11
 3095      00000000 
 3096 22b8 C57A1015 		vmovss	.LC4(%rip), %xmm10
 3096      00000000 
 3097 22c0 C57A100D 		vmovss	.LC5(%rip), %xmm9
 3097      00000000 
 3098 22c8 C5FA102D 		vmovss	.LC65(%rip), %xmm5
 3098      00000000 
 3099 22d0 C57A1005 		vmovss	.LC7(%rip), %xmm8
 3099      00000000 
 3100 22d8 C5FA103D 		vmovss	.LC9(%rip), %xmm7
 3100      00000000 
 3101 22e0 C5FA1035 		vmovss	.LC10(%rip), %xmm6
 3101      00000000 
 3102              	.LVL143:
 3103 22e8 0F1F8400 		.p2align 4,,10
 3103      00000000 
 3104              		.p2align 3
 3105              	.L71:
 341:RGB2YCbCr.c   ****         {
 342:RGB2YCbCr.c   ****             /* el cast float mejora las prestaciones!! */
 343:RGB2YCbCr.c   ****             /* R */
 344:RGB2YCbCr.c   ****             pixels_out[3*i + 0] = (unsigned char) (0.5f + 
 3106              		.loc 1 344 13 is_stmt 1 discriminator 3
 345:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 346:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 3107              		.loc 1 346 42 is_stmt 0 discriminator 3
 3108 22f0 0FB601   		movzbl	(%rcx), %eax
 3109 22f3 4883C103 		addq	$3, %rcx
 3110 22f7 4883C603 		addq	$3, %rsi
 3111              		.loc 1 346 32 discriminator 3
 3112 22fb C5E22AC8 		vcvtsi2ssl	%eax, %xmm3, %xmm1
 347:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 3113              		.loc 1 347 42 discriminator 3
 3114 22ff 0FB641FE 		movzbl	-2(%rcx), %eax
 3115              		.loc 1 347 32 discriminator 3
 3116 2303 C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 348:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 3117              		.loc 1 348 42 discriminator 3
 3118 2307 0FB641FF 		movzbl	-1(%rcx), %eax
 346:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 3119              		.loc 1 346 32 discriminator 3
 3120 230b C4C17259 		vmulss	%xmm12, %xmm1, %xmm1
 3120      CC
 347:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 3121              		.loc 1 347 32 discriminator 3
 3122 2310 C4C17A59 		vmulss	%xmm11, %xmm0, %xmm0
 3122      C3
 345:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*pixels_in[3*i + 0] + 
 3123              		.loc 1 345 37 discriminator 3
 3124 2315 C5F258D4 		vaddss	%xmm4, %xmm1, %xmm2
 346:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*pixels_in[3*i + 1] + 
 3125              		.loc 1 346 52 discriminator 3
 3126 2319 C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 3127              		.loc 1 348 32 discriminator 3
 3128 231d C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 3129 2321 C4C17A59 		vmulss	%xmm10, %xmm0, %xmm0
 3129      C2
 347:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*pixels_in[3*i + 2]);
 3130              		.loc 1 347 52 discriminator 3
 3131 2326 C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 344:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3132              		.loc 1 344 35 discriminator 3
 3133 232a C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 3134 232e 8846FD   		movb	%al, -3(%rsi)
 349:RGB2YCbCr.c   ****             /* G */
 350:RGB2YCbCr.c   ****             pixels_out[3*i + 1] = (unsigned char) (0.5f + 
 3135              		.loc 1 350 13 is_stmt 1 discriminator 3
 351:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 352:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 3136              		.loc 1 352 42 is_stmt 0 discriminator 3
 3137 2331 0FB641FD 		movzbl	-3(%rcx), %eax
 3138              		.loc 1 352 32 discriminator 3
 3139 2335 C5E22AC8 		vcvtsi2ssl	%eax, %xmm3, %xmm1
 353:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 3140              		.loc 1 353 42 discriminator 3
 3141 2339 0FB641FE 		movzbl	-2(%rcx), %eax
 3142              		.loc 1 353 32 discriminator 3
 3143 233d C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 354:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 3144              		.loc 1 354 42 discriminator 3
 3145 2341 0FB641FF 		movzbl	-1(%rcx), %eax
 352:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 3146              		.loc 1 352 32 discriminator 3
 3147 2345 C4C17259 		vmulss	%xmm9, %xmm1, %xmm1
 3147      C9
 353:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 3148              		.loc 1 353 32 discriminator 3
 3149 234a C4C17A59 		vmulss	%xmm8, %xmm0, %xmm0
 3149      C0
 351:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*pixels_in[3*i + 0] + 
 3150              		.loc 1 351 37 discriminator 3
 3151 234f C5F258D5 		vaddss	%xmm5, %xmm1, %xmm2
 352:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*pixels_in[3*i + 1] + 
 3152              		.loc 1 352 52 discriminator 3
 3153 2353 C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 3154              		.loc 1 354 32 discriminator 3
 3155 2357 C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 3156 235b C5FA59C4 		vmulss	%xmm4, %xmm0, %xmm0
 353:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*pixels_in[3*i + 2]);
 3157              		.loc 1 353 52 discriminator 3
 3158 235f C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 350:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3159              		.loc 1 350 35 discriminator 3
 3160 2363 C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 3161 2367 8846FE   		movb	%al, -2(%rsi)
 355:RGB2YCbCr.c   ****             /* B */
 356:RGB2YCbCr.c   ****             pixels_out[3*i + 2] =  (unsigned char) (0.5f + 
 3162              		.loc 1 356 13 is_stmt 1 discriminator 3
 357:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 358:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 3163              		.loc 1 358 42 is_stmt 0 discriminator 3
 3164 236a 0FB641FD 		movzbl	-3(%rcx), %eax
 3165              		.loc 1 358 32 discriminator 3
 3166 236e C5E22AC8 		vcvtsi2ssl	%eax, %xmm3, %xmm1
 359:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 3167              		.loc 1 359 42 discriminator 3
 3168 2372 0FB641FE 		movzbl	-2(%rcx), %eax
 3169              		.loc 1 359 32 discriminator 3
 3170 2376 C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 360:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 3171              		.loc 1 360 42 discriminator 3
 3172 237a 0FB641FF 		movzbl	-1(%rcx), %eax
 358:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 3173              		.loc 1 358 32 discriminator 3
 3174 237e C5F259CC 		vmulss	%xmm4, %xmm1, %xmm1
 359:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 3175              		.loc 1 359 32 discriminator 3
 3176 2382 C5FA59C7 		vmulss	%xmm7, %xmm0, %xmm0
 357:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*pixels_in[3*i + 0] + 
 3177              		.loc 1 357 37 discriminator 3
 3178 2386 C5F258D5 		vaddss	%xmm5, %xmm1, %xmm2
 358:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*pixels_in[3*i + 1] + 
 3179              		.loc 1 358 52 discriminator 3
 3180 238a C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 3181              		.loc 1 360 32 discriminator 3
 3182 238e C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 3183 2392 C5FA59C6 		vmulss	%xmm6, %xmm0, %xmm0
 359:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*pixels_in[3*i + 2]);
 3184              		.loc 1 359 52 discriminator 3
 3185 2396 C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 356:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 3186              		.loc 1 356 36 discriminator 3
 3187 239a C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 3188 239e 8846FF   		movb	%al, -1(%rsi)
 340:RGB2YCbCr.c   ****         {
 3189              		.loc 1 340 43 is_stmt 1 discriminator 3
 340:RGB2YCbCr.c   ****         {
 3190              		.loc 1 340 25 discriminator 3
 340:RGB2YCbCr.c   ****         {
 3191              		.loc 1 340 9 is_stmt 0 discriminator 3
 3192 23a1 4939CF   		cmpq	%rcx, %r15
 3193 23a4 0F8546FF 		jne	.L71
 3193      FFFF
 3194              	.L74:
 3195              	.LBE42:
 361:RGB2YCbCr.c   ****         }
 362:RGB2YCbCr.c   ****         dummy(image_in, image_out);
 3196              		.loc 1 362 9 is_stmt 1
 3197 23aa 4889EE   		movq	%rbp, %rsi
 3198 23ad 4C89E7   		movq	%r12, %rdi
 3199 23b0 E8000000 		call	dummy
 3199      00
 3200              	.LVL144:
 338:RGB2YCbCr.c   ****     {
 3201              		.loc 1 338 34
 338:RGB2YCbCr.c   ****     {
 3202              		.loc 1 338 22
 338:RGB2YCbCr.c   ****     {
 3203              		.loc 1 338 5 is_stmt 0
 3204 23b5 FFCB     		decl	%ebx
 3205              	.LVL145:
 3206 23b7 C5E057DB 		vxorps	%xmm3, %xmm3, %xmm3
 3207 23bb C57A1025 		vmovss	.LC1(%rip), %xmm12
 3207      00000000 
 3208 23c3 0F85CFFE 		jne	.L70
 3208      FFFF
 3209              	.LBE43:
 363:RGB2YCbCr.c   ****     }
 364:RGB2YCbCr.c   ****     end_t = get_wall_time();
 3210              		.loc 1 364 5 is_stmt 1
 3211              		.loc 1 364 13 is_stmt 0
 3212 23c9 31C0     		xorl	%eax, %eax
 3213 23cb E8000000 		call	get_wall_time
 3213      00
 3214              	.LVL146:
 365:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast_esc");
 3215              		.loc 1 365 5 is_stmt 1
 3216 23d0 C5FB5C44 		vsubsd	8(%rsp), %xmm0, %xmm0
 3216      2408
 3217              	.LVL147:
 366:RGB2YCbCr.c   **** }
 3218              		.loc 1 366 1 is_stmt 0
 3219 23d6 4883C418 		addq	$24, %rsp
 3220              		.cfi_remember_state
 3221              		.cfi_def_cfa_offset 56
 3222              	.LVL148:
 365:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast_esc");
 3223              		.loc 1 365 5
 3224 23da 4489EF   		movl	%r13d, %edi
 3225              		.loc 1 366 1
 3226 23dd 5B       		popq	%rbx
 3227              		.cfi_def_cfa_offset 48
 3228              	.LVL149:
 365:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast_esc");
 3229              		.loc 1 365 5
 3230 23de BE000000 		movl	$.LC69, %esi
 3230      00
 3231              		.loc 1 366 1
 3232 23e3 5D       		popq	%rbp
 3233              		.cfi_def_cfa_offset 40
 3234              	.LVL150:
 3235 23e4 415C     		popq	%r12
 3236              		.cfi_def_cfa_offset 32
 3237              	.LVL151:
 3238 23e6 415D     		popq	%r13
 3239              		.cfi_def_cfa_offset 24
 3240 23e8 415E     		popq	%r14
 3241              		.cfi_def_cfa_offset 16
 3242              	.LVL152:
 3243 23ea 415F     		popq	%r15
 3244              		.cfi_def_cfa_offset 8
 365:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2Gray_cast_esc");
 3245              		.loc 1 365 5
 3246 23ec E9000000 		jmp	results
 3246      00
 3247              	.LVL153:
 3248              	.L77:
 3249              		.cfi_restore_state
 326:RGB2YCbCr.c   ****         exit(-1);
 3250              		.loc 1 326 9 is_stmt 1
 3251 23f1 BF000000 		movl	$.LC0, %edi
 3251      00
 3252              	.LVL154:
 3253 23f6 E8000000 		call	puts
 3253      00
 3254              	.LVL155:
 327:RGB2YCbCr.c   ****     }
 3255              		.loc 1 327 9
 3256 23fb 83CFFF   		orl	$-1, %edi
 3257 23fe E8000000 		call	exit
 3257      00
 3258              	.LVL156:
 3259              		.cfi_endproc
 3260              	.LFE19:
 3262              		.section	.rodata.str1.1
 3263              	.LC70:
 3264 0063 52474232 		.string	"RGB2YCbCrSOA0"
 3264      59436243 
 3264      72534F41 
 3264      3000
 3265              		.text
 3266 2403 0F1F0066 		.p2align 4
 3266      2E0F1F84 
 3266      00000000 
 3266      00
 3267              		.globl	RGB2YCbCr_SOA0
 3269              	RGB2YCbCr_SOA0:
 3270              	.LFB20:
 367:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
 368:RGB2YCbCr.c   **** 
 369:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
 370:RGB2YCbCr.c   **** 
 371:RGB2YCbCr.c   **** /* transformaci贸n de datos de entrada y salida de formato vector de estructuras (Array of Structs,
 372:RGB2YCbCr.c   ****  * (R0 G0 B0 R1 G1 B1 ... Rn-1 Gn-1 Bn-1)
 373:RGB2YCbCr.c   ****  * a estructura de vectores (Struct of Arrays, SoA)
 374:RGB2YCbCr.c   ****  * (R0 R1 ... Rn-1 G0 G1 ... Gn-1 B0 B1 ... Bn-1) */
 375:RGB2YCbCr.c   **** void
 376:RGB2YCbCr.c   **** RGB2YCbCr_SOA0(image_t * restrict image_in, image_t * restrict image_out)
 377:RGB2YCbCr.c   **** {
 3271              		.loc 1 377 1
 3272              		.cfi_startproc
 3273              	.LVL157:
 378:RGB2YCbCr.c   ****     double start_t, end_t;
 3274              		.loc 1 378 5
 379:RGB2YCbCr.c   ****     const int height = image_in->height;
 3275              		.loc 1 379 5
 377:RGB2YCbCr.c   ****     double start_t, end_t;
 3276              		.loc 1 377 1 is_stmt 0
 3277 2410 4155     		pushq	%r13
 3278              		.cfi_def_cfa_offset 16
 3279              		.cfi_offset 13, -16
 3280 2412 4C8D6C24 		leaq	16(%rsp), %r13
 3280      10
 3281              		.cfi_def_cfa 13, 0
 3282 2417 4883E4E0 		andq	$-32, %rsp
 3283 241b 41FF75F8 		pushq	-8(%r13)
 3284 241f 55       		pushq	%rbp
 3285              		.cfi_escape 0x10,0x6,0x2,0x76,0
 3286 2420 4889E5   		movq	%rsp, %rbp
 3287 2423 4157     		pushq	%r15
 3288 2425 4156     		pushq	%r14
 3289 2427 4155     		pushq	%r13
 3290              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 3291              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 3292              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 3293 2429 4154     		pushq	%r12
 3294 242b 53       		pushq	%rbx
 3295 242c 4881EC88 		subq	$136, %rsp
 3295      000000
 3296              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 3297              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
 380:RGB2YCbCr.c   ****     const int width =  image_in->width;
 381:RGB2YCbCr.c   ****     unsigned char *Rpixels, *Gpixels, *Bpixels, *Ypixels, *Cbpixels, *Crpixels;
 382:RGB2YCbCr.c   **** 
 383:RGB2YCbCr.c   ****     if (image_in->bytes_per_pixel != 3)
 3298              		.loc 1 383 8
 3299 2433 837F1003 		cmpl	$3, 16(%rdi)
 377:RGB2YCbCr.c   ****     double start_t, end_t;
 3300              		.loc 1 377 1
 3301 2437 48897D80 		movq	%rdi, -128(%rbp)
 379:RGB2YCbCr.c   ****     const int width =  image_in->width;
 3302              		.loc 1 379 15
 3303 243b 448B7F0C 		movl	12(%rdi), %r15d
 3304              	.LVL158:
 380:RGB2YCbCr.c   ****     const int width =  image_in->width;
 3305              		.loc 1 380 5 is_stmt 1
 380:RGB2YCbCr.c   ****     const int width =  image_in->width;
 3306              		.loc 1 380 15 is_stmt 0
 3307 243f 8B4708   		movl	8(%rdi), %eax
 3308              	.LVL159:
 381:RGB2YCbCr.c   **** 
 3309              		.loc 1 381 5 is_stmt 1
 3310              		.loc 1 383 5
 3311              		.loc 1 383 8 is_stmt 0
 3312 2442 0F85E008 		jne	.L106
 3312      0000
 384:RGB2YCbCr.c   ****     {
 385:RGB2YCbCr.c   ****         printf("ERROR: input image has to be RGB\n");
 386:RGB2YCbCr.c   ****         exit(-1);
 387:RGB2YCbCr.c   ****     }
 388:RGB2YCbCr.c   ****     
 389:RGB2YCbCr.c   ****     /* fill struct fields */
 390:RGB2YCbCr.c   ****     image_out->width  = width;
 3313              		.loc 1 390 5 is_stmt 1
 391:RGB2YCbCr.c   ****     image_out->height = height;
 392:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 3314              		.loc 1 392 32 is_stmt 0
 3315 2448 48BF0300 		movabsq	$12884901891, %rdi
 3315      00000300 
 3315      0000
 3316              	.LVL160:
 391:RGB2YCbCr.c   ****     image_out->height = height;
 3317              		.loc 1 391 23
 3318 2452 44897E0C 		movl	%r15d, 12(%rsi)
 393:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 394:RGB2YCbCr.c   **** 
 395:RGB2YCbCr.c   ****     /* transform data layout */
 396:RGB2YCbCr.c   ****     Rpixels = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
 3319              		.loc 1 396 66
 3320 2456 440FAFF8 		imull	%eax, %r15d
 3321              	.LVL161:
 392:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 3322              		.loc 1 392 32
 3323 245a 48897E10 		movq	%rdi, 16(%rsi)
 3324              		.loc 1 396 33
 3325 245e BF200000 		movl	$32, %edi
 3325      00
 390:RGB2YCbCr.c   ****     image_out->height = height;
 3326              		.loc 1 390 23
 3327 2463 894608   		movl	%eax, 8(%rsi)
 391:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 3328              		.loc 1 391 5 is_stmt 1
 392:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 3329              		.loc 1 392 5
 393:RGB2YCbCr.c   **** 
 3330              		.loc 1 393 5
 3331              		.loc 1 396 66 is_stmt 0
 3332 2466 438D1C3F 		leal	(%r15,%r15), %ebx
 392:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 3333              		.loc 1 392 32
 3334 246a 48897598 		movq	%rsi, -104(%rbp)
 3335              		.loc 1 396 5 is_stmt 1
 3336              		.loc 1 396 66 is_stmt 0
 3337 246e 468D2C3B 		leal	(%rbx,%r15), %r13d
 3338              		.loc 1 396 33
 3339 2472 4D63ED   		movslq	%r13d, %r13
 3340 2475 4C89EE   		movq	%r13, %rsi
 3341              	.LVL162:
 3342 2478 E8000000 		call	aligned_alloc
 3342      00
 3343              	.LVL163:
 397:RGB2YCbCr.c   ****     Gpixels = Rpixels + 1*width*height;
 398:RGB2YCbCr.c   ****     Bpixels = Rpixels + 2*width*height;
 3344              		.loc 1 398 32
 3345 247d 4863D3   		movslq	%ebx, %rdx
 397:RGB2YCbCr.c   ****     Gpixels = Rpixels + 1*width*height;
 3346              		.loc 1 397 32
 3347 2480 4D63C7   		movslq	%r15d, %r8
 399:RGB2YCbCr.c   **** 
 400:RGB2YCbCr.c   ****     Ypixels = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
 3348              		.loc 1 400 33
 3349 2483 4C89EE   		movq	%r13, %rsi
 398:RGB2YCbCr.c   **** 
 3350              		.loc 1 398 13
 3351 2486 488D0C10 		leaq	(%rax,%rdx), %rcx
 3352              		.loc 1 400 33
 3353 248a BF200000 		movl	$32, %edi
 3353      00
 397:RGB2YCbCr.c   ****     Gpixels = Rpixels + 1*width*height;
 3354              		.loc 1 397 13
 3355 248f 4C8945A0 		movq	%r8, -96(%rbp)
 396:RGB2YCbCr.c   ****     Gpixels = Rpixels + 1*width*height;
 3356              		.loc 1 396 33
 3357 2493 4989C4   		movq	%rax, %r12
 3358              	.LVL164:
 397:RGB2YCbCr.c   ****     Bpixels = Rpixels + 2*width*height;
 3359              		.loc 1 397 5 is_stmt 1
 398:RGB2YCbCr.c   **** 
 3360              		.loc 1 398 13 is_stmt 0
 3361 2496 488955A8 		movq	%rdx, -88(%rbp)
 397:RGB2YCbCr.c   ****     Bpixels = Rpixels + 2*width*height;
 3362              		.loc 1 397 13
 3363 249a 4E8D3400 		leaq	(%rax,%r8), %r14
 3364              	.LVL165:
 398:RGB2YCbCr.c   **** 
 3365              		.loc 1 398 5 is_stmt 1
 398:RGB2YCbCr.c   **** 
 3366              		.loc 1 398 13 is_stmt 0
 3367 249e 48894DB0 		movq	%rcx, -80(%rbp)
 3368              	.LVL166:
 3369              		.loc 1 400 5 is_stmt 1
 3370              		.loc 1 400 33 is_stmt 0
 3371 24a2 E8000000 		call	aligned_alloc
 3371      00
 3372              	.LVL167:
 401:RGB2YCbCr.c   ****     Cbpixels = Ypixels + 1*width*height;
 402:RGB2YCbCr.c   ****     Crpixels = Ypixels + 2*width*height;
 3373              		.loc 1 402 14
 3374 24a7 488B55A8 		movq	-88(%rbp), %rdx
 401:RGB2YCbCr.c   ****     Cbpixels = Ypixels + 1*width*height;
 3375              		.loc 1 401 14
 3376 24ab 4C8B45A0 		movq	-96(%rbp), %r8
 3377              	.LBB44:
 403:RGB2YCbCr.c   **** 
 404:RGB2YCbCr.c   ****     /* transformaci贸n AoS -> SoA */
 405:RGB2YCbCr.c   ****     /* COMPLETAR ... */
 406:RGB2YCbCr.c   ****     #pragma GCC ivdep
 407:RGB2YCbCr.c   ****     for (int i = 0; i < height*width; i++)
 3378              		.loc 1 407 5
 3379 24af 488B4DB0 		movq	-80(%rbp), %rcx
 3380 24b3 4C8B5D98 		movq	-104(%rbp), %r11
 3381              	.LBE44:
 400:RGB2YCbCr.c   ****     Cbpixels = Ypixels + 1*width*height;
 3382              		.loc 1 400 33
 3383 24b7 4989C5   		movq	%rax, %r13
 3384              	.LVL168:
 401:RGB2YCbCr.c   ****     Cbpixels = Ypixels + 1*width*height;
 3385              		.loc 1 401 5 is_stmt 1
 402:RGB2YCbCr.c   **** 
 3386              		.loc 1 402 14 is_stmt 0
 3387 24ba 4801C2   		addq	%rax, %rdx
 3388              	.LBB45:
 3389              		.loc 1 407 5
 3390 24bd 4585FF   		testl	%r15d, %r15d
 3391              	.LBE45:
 401:RGB2YCbCr.c   ****     Crpixels = Ypixels + 2*width*height;
 3392              		.loc 1 401 14
 3393 24c0 4A8D1C00 		leaq	(%rax,%r8), %rbx
 3394              	.LVL169:
 402:RGB2YCbCr.c   **** 
 3395              		.loc 1 402 5 is_stmt 1
 3396              	.LBB46:
 3397              		.loc 1 407 10
 3398              		.loc 1 407 21
 3399              		.loc 1 407 5 is_stmt 0
 3400 24c4 0F8E4008 		jle	.L107
 3400      0000
 408:RGB2YCbCr.c   ****     {
 409:RGB2YCbCr.c   ****         Rpixels[i] = image_in->pixels[3*i + 0];
 3401              		.loc 1 409 9
 3402 24ca 488B4580 		movq	-128(%rbp), %rax
 3403              	.LVL170:
 3404 24ce 4C8B10   		movq	(%rax), %r10
 3405 24d1 418D47FF 		leal	-1(%r15), %eax
 3406 24d5 898578FF 		movl	%eax, -136(%rbp)
 3406      FFFF
 3407 24db 83F81E   		cmpl	$30, %eax
 3408 24de 0F863508 		jbe	.L95
 3408      0000
 3409 24e4 4589F9   		movl	%r15d, %r9d
 3410 24e7 C57D6F2D 		vmovdqa	.LC13(%rip), %ymm13
 3410      00000000 
 3411 24ef C57D6F25 		vmovdqa	.LC14(%rip), %ymm12
 3411      00000000 
 3412 24f7 4C89D0   		movq	%r10, %rax
 3413 24fa 41C1E905 		shrl	$5, %r9d
 3414 24fe C57D6F1D 		vmovdqa	.LC15(%rip), %ymm11
 3414      00000000 
 3415 2506 C57D6F15 		vmovdqa	.LC16(%rip), %ymm10
 3415      00000000 
 3416 250e 4C89E6   		movq	%r12, %rsi
 3417 2511 49C1E105 		salq	$5, %r9
 3418 2515 C57D6F0D 		vmovdqa	.LC17(%rip), %ymm9
 3418      00000000 
 3419 251d C57D6F05 		vmovdqa	.LC18(%rip), %ymm8
 3419      00000000 
 3420 2525 4D89F0   		movq	%r14, %r8
 3421 2528 C5FD6F3D 		vmovdqa	.LC19(%rip), %ymm7
 3421      00000000 
 3422 2530 4889CF   		movq	%rcx, %rdi
 3423 2533 4D01E1   		addq	%r12, %r9
 3424 2536 C5FD6F35 		vmovdqa	.LC20(%rip), %ymm6
 3424      00000000 
 3425 253e C5FD6F2D 		vmovdqa	.LC21(%rip), %ymm5
 3425      00000000 
 3426 2546 C5FD6F25 		vmovdqa	.LC23(%rip), %ymm4
 3426      00000000 
 3427              	.LVL171:
 3428 254e 6690     		.p2align 4,,10
 3429              		.p2align 3
 3430              	.L82:
 3431              		.loc 1 409 9 is_stmt 1 discriminator 3
 3432              		.loc 1 409 38 is_stmt 0 discriminator 3
 3433 2550 C5FE6F00 		vmovdqu	(%rax), %ymm0
 3434 2554 4883C620 		addq	$32, %rsi
 3435 2558 4883C060 		addq	$96, %rax
 3436 255c 4983C020 		addq	$32, %r8
 3437 2560 C5FE6F50 		vmovdqu	-64(%rax), %ymm2
 3437      C0
 3438 2565 C5FE6F48 		vmovdqu	-32(%rax), %ymm1
 3438      E0
 3439 256a 4883C720 		addq	$32, %rdi
 3440 256e C4C27D00 		vpshufb	%ymm13, %ymm0, %ymm3
 3440      DD
 3441 2573 C463FD00 		vpermq	$78, %ymm3, %ymm15
 3441      FB4E
 3442 2579 C4C27D00 		vpshufb	%ymm12, %ymm0, %ymm3
 3442      DC
 3443 257e C4426D00 		vpshufb	%ymm11, %ymm2, %ymm14
 3443      F3
 3444 2583 C4C165EB 		vpor	%ymm15, %ymm3, %ymm3
 3444      DF
 3445 2588 C4427500 		vpshufb	%ymm8, %ymm1, %ymm15
 3445      F8
 3446 258d C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 3446      DE
 3447 2592 C4427500 		vpshufb	%ymm10, %ymm1, %ymm14
 3447      F2
 3448 2597 C443FD00 		vpermq	$78, %ymm14, %ymm14
 3448      F64E
 3449 259d C4C26500 		vpshufb	%ymm9, %ymm3, %ymm3
 3449      D9
 3450 25a2 C44105EB 		vpor	%ymm14, %ymm15, %ymm14
 3450      F6
 3451 25a7 C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 3451      DE
 3452 25ac C4626D00 		vpshufb	%ymm5, %ymm2, %ymm14
 3452      F5
 3453 25b1 C4E26D00 		vpshufb	.LC27(%rip), %ymm2, %ymm2
 3453      15000000 
 3453      00
 3454              		.loc 1 409 20 discriminator 3
 3455 25ba C5FD7F5E 		vmovdqa	%ymm3, -32(%rsi)
 3455      E0
 410:RGB2YCbCr.c   ****         Gpixels[i] = image_in->pixels[3*i + 1];
 3456              		.loc 1 410 9 is_stmt 1 discriminator 3
 409:RGB2YCbCr.c   ****         Gpixels[i] = image_in->pixels[3*i + 1];
 3457              		.loc 1 409 38 is_stmt 0 discriminator 3
 3458 25bf C4E27D00 		vpshufb	%ymm7, %ymm0, %ymm3
 3458      DF
 3459 25c4 C463FD00 		vpermq	$78, %ymm3, %ymm15
 3459      FB4E
 3460 25ca C4E27D00 		vpshufb	%ymm6, %ymm0, %ymm3
 3460      DE
 3461 25cf C4C165EB 		vpor	%ymm15, %ymm3, %ymm3
 3461      DF
 3462 25d4 C4627500 		vpshufb	.LC24(%rip), %ymm1, %ymm15
 3462      3D000000 
 3462      00
 3463 25dd C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 3463      DE
 3464 25e2 C4627500 		vpshufb	.LC22(%rip), %ymm1, %ymm14
 3464      35000000 
 3464      00
 3465 25eb C443FD00 		vpermq	$78, %ymm14, %ymm14
 3465      F64E
 3466 25f1 C4E26500 		vpshufb	%ymm4, %ymm3, %ymm3
 3466      DC
 3467 25f6 C44105EB 		vpor	%ymm14, %ymm15, %ymm14
 3467      F6
 3468 25fb C4C165EB 		vpor	%ymm14, %ymm3, %ymm3
 3468      DE
 3469              		.loc 1 410 20 discriminator 3
 3470 2600 C4C17E7F 		vmovdqu	%ymm3, -32(%r8)
 3470      58E0
 411:RGB2YCbCr.c   ****         Bpixels[i] = image_in->pixels[3*i + 2];
 3471              		.loc 1 411 9 is_stmt 1 discriminator 3
 409:RGB2YCbCr.c   ****         Gpixels[i] = image_in->pixels[3*i + 1];
 3472              		.loc 1 409 38 is_stmt 0 discriminator 3
 3473 2606 C4E27D00 		vpshufb	.LC25(%rip), %ymm0, %ymm3
 3473      1D000000 
 3473      00
 3474 260f C4E27D00 		vpshufb	.LC26(%rip), %ymm0, %ymm0
 3474      05000000 
 3474      00
 3475 2618 C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 3475      DB4E
 3476 261e C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 3477 2622 C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 3478 2626 C4E27500 		vpshufb	.LC28(%rip), %ymm1, %ymm2
 3478      15000000 
 3478      00
 3479 262f C4E27500 		vpshufb	.LC29(%rip), %ymm1, %ymm1
 3479      0D000000 
 3479      00
 3480 2638 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 3480      D24E
 3481 263e C4E27D00 		vpshufb	%ymm4, %ymm0, %ymm0
 3481      C4
 3482 2643 C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 3483 2647 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 3484              		.loc 1 411 20 discriminator 3
 3485 264b C5FE7F47 		vmovdqu	%ymm0, -32(%rdi)
 3485      E0
 407:RGB2YCbCr.c   ****     {
 3486              		.loc 1 407 39 is_stmt 1 discriminator 3
 407:RGB2YCbCr.c   ****     {
 3487              		.loc 1 407 21 discriminator 3
 3488 2650 4C39CE   		cmpq	%r9, %rsi
 3489 2653 0F85F7FE 		jne	.L82
 3489      FFFF
 3490 2659 4489FE   		movl	%r15d, %esi
 3491 265c 83E6E0   		andl	$-32, %esi
 3492 265f 41F6C71F 		testb	$31, %r15b
 3493 2663 0F84B706 		je	.L108
 3493      0000
 3494 2669 C5F877   		vzeroupper
 3495              	.L81:
 3496 266c 4863C6   		movslq	%esi, %rax
 3497 266f 8D3476   		leal	(%rsi,%rsi,2), %esi
 3498 2672 4863F6   		movslq	%esi, %rsi
 3499 2675 4901F2   		addq	%rsi, %r10
 3500 2678 0F1F8400 		.p2align 4,,10
 3500      00000000 
 3501              		.p2align 3
 3502              	.L84:
 3503              	.LVL172:
 409:RGB2YCbCr.c   ****         Gpixels[i] = image_in->pixels[3*i + 1];
 3504              		.loc 1 409 9
 409:RGB2YCbCr.c   ****         Gpixels[i] = image_in->pixels[3*i + 1];
 3505              		.loc 1 409 20 is_stmt 0
 3506 2680 410FB632 		movzbl	(%r10), %esi
 3507 2684 4983C203 		addq	$3, %r10
 3508 2688 41883404 		movb	%sil, (%r12,%rax)
 410:RGB2YCbCr.c   ****         Bpixels[i] = image_in->pixels[3*i + 2];
 3509              		.loc 1 410 9 is_stmt 1
 410:RGB2YCbCr.c   ****         Bpixels[i] = image_in->pixels[3*i + 2];
 3510              		.loc 1 410 20 is_stmt 0
 3511 268c 410FB672 		movzbl	-2(%r10), %esi
 3511      FE
 3512 2691 41883406 		movb	%sil, (%r14,%rax)
 3513              		.loc 1 411 9 is_stmt 1
 3514              		.loc 1 411 20 is_stmt 0
 3515 2695 410FB672 		movzbl	-1(%r10), %esi
 3515      FF
 3516 269a 40883401 		movb	%sil, (%rcx,%rax)
 407:RGB2YCbCr.c   ****     {
 3517              		.loc 1 407 39 is_stmt 1
 3518              	.LVL173:
 407:RGB2YCbCr.c   ****     {
 3519              		.loc 1 407 21
 3520 269e 48FFC0   		incq	%rax
 3521              	.LVL174:
 407:RGB2YCbCr.c   ****     {
 3522              		.loc 1 407 5 is_stmt 0
 3523 26a1 4139C7   		cmpl	%eax, %r15d
 3524 26a4 7FDA     		jg	.L84
 3525              	.L80:
 3526              	.LBE46:
 412:RGB2YCbCr.c   ****     }
 413:RGB2YCbCr.c   **** 
 414:RGB2YCbCr.c   ****     start_t = get_wall_time();
 3527              		.loc 1 414 15
 3528 26a6 31C0     		xorl	%eax, %eax
 3529 26a8 4C895DA0 		movq	%r11, -96(%rbp)
 3530 26ac 488955A8 		movq	%rdx, -88(%rbp)
 3531 26b0 48894DB0 		movq	%rcx, -80(%rbp)
 3532              	.LVL175:
 3533              		.loc 1 414 5 is_stmt 1
 3534              		.loc 1 414 15 is_stmt 0
 3535 26b4 E8000000 		call	get_wall_time
 3535      00
 3536              	.LVL176:
 3537 26b9 4C8B5DA0 		movq	-96(%rbp), %r11
 3538 26bd 4489F8   		movl	%r15d, %eax
 3539 26c0 478D043F 		leal	(%r15,%r15), %r8d
 3540 26c4 83E0E0   		andl	$-32, %eax
 3541 26c7 4589F9   		movl	%r15d, %r9d
 3542 26ca 4D63C0   		movslq	%r8d, %r8
 3543 26cd 488B4DB0 		movq	-80(%rbp), %rcx
 3544 26d1 4C895D88 		movq	%r11, -120(%rbp)
 3545 26d5 41C1E905 		shrl	$5, %r9d
 3546 26d9 488B55A8 		movq	-88(%rbp), %rdx
 3547 26dd 4F8D1404 		leaq	(%r12,%r8), %r10
 3548 26e1 898574FF 		movl	%eax, -140(%rbp)
 3548      FFFF
 3549 26e7 4D01E8   		addq	%r13, %r8
 3550 26ea 49C1E105 		salq	$5, %r9
 3551 26ee C57D6F3D 		vmovdqa	.LC34(%rip), %ymm15
 3551      00000000 
 3552 26f6 C7857CFF 		movl	$10, -132(%rbp)
 3552      FFFF0A00 
 3552      0000
 3553 2700 C5FB1185 		vmovsd	%xmm0, -152(%rbp)
 3553      68FFFFFF 
 3554              	.LVL177:
 415:RGB2YCbCr.c   ****     for (int it=0; it < NITER; it++)
 3555              		.loc 1 415 5 is_stmt 1
 3556              	.LBB47:
 3557              		.loc 1 415 10
 3558              		.loc 1 415 20
 3559 2708 0F1F8400 		.p2align 4,,10
 3559      00000000 
 3560              		.p2align 3
 3561              	.L85:
 3562              	.LBB48:
 416:RGB2YCbCr.c   ****     {
 417:RGB2YCbCr.c   ****         /* COMPLETAR ... */
 418:RGB2YCbCr.c   ****         #pragma GCC ivdep
 419:RGB2YCbCr.c   ****         for (int i = 0; i < height*width; i++)
 3563              		.loc 1 419 25
 3564              		.loc 1 419 9 is_stmt 0
 3565 2710 4585FF   		testl	%r15d, %r15d
 3566 2713 0F8EFA04 		jle	.L92
 3566      0000
 3567 2719 83BD78FF 		cmpl	$30, -136(%rbp)
 3567      FFFF1E
 3568 2720 0F86DD05 		jbe	.L96
 3568      0000
 3569 2726 31C0     		xorl	%eax, %eax
 3570              	.LVL178:
 3571 2728 0F1F8400 		.p2align 4,,10
 3571      00000000 
 3572              		.p2align 3
 3573              	.L87:
 420:RGB2YCbCr.c   ****         {
 421:RGB2YCbCr.c   ****             Ypixels[i] = (unsigned char) (0.5f + 
 3574              		.loc 1 421 13 is_stmt 1 discriminator 3
 422:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 3575              		.loc 1 423 40 is_stmt 0 discriminator 3
 3576 2730 C4C17D6F 		vmovdqa	(%r12,%rax), %ymm5
 3576      2C04
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3577              		.loc 1 424 40 discriminator 3
 3578 2736 C4427D30 		vpmovzxbw	(%r14,%rax), %ymm8
 3578      0406
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3579              		.loc 1 423 40 discriminator 3
 3580 273c C4C27D30 		vpmovzxbw	(%r12,%rax), %ymm2
 3580      1404
 425:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3581              		.loc 1 425 40 discriminator 3
 3582 2742 C4C27D30 		vpmovzxbw	(%r10,%rax), %ymm7
 3582      3C02
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3583              		.loc 1 423 40 discriminator 3
 3584 2748 C4E37D39 		vextracti128	$0x1, %ymm5, %xmm3
 3584      EB01
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3585              		.loc 1 424 40 discriminator 3
 3586 274e C4427D33 		vpmovzxwd	%xmm8, %ymm12
 3586      E0
 3587 2753 C4437D39 		vextracti128	$0x1, %ymm8, %xmm8
 3587      C001
 3588 2759 C4C17E6F 		vmovdqu	(%r14,%rax), %ymm5
 3588      2C06
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3589              		.loc 1 423 40 discriminator 3
 3590 275f C4E27D30 		vpmovzxbw	%xmm3, %ymm3
 3590      DB
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3591              		.loc 1 424 32 discriminator 3
 3592 2764 C4417C5B 		vcvtdq2ps	%ymm12, %ymm12
 3592      E4
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3593              		.loc 1 423 40 discriminator 3
 3594 2769 C4E27D33 		vpmovzxwd	%xmm2, %ymm0
 3594      C2
 3595              		.loc 1 425 40 discriminator 3
 3596 276e C4627D33 		vpmovzxwd	%xmm7, %ymm11
 3596      DF
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3597              		.loc 1 423 40 discriminator 3
 3598 2773 C4E27D33 		vpmovzxwd	%xmm3, %ymm1
 3598      CB
 3599 2778 C4E37D39 		vextracti128	$0x1, %ymm3, %xmm3
 3599      DB01
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3600              		.loc 1 423 32 discriminator 3
 3601 277e C5FC5BC0 		vcvtdq2ps	%ymm0, %ymm0
 3602              		.loc 1 425 32 discriminator 3
 3603 2782 C4417C5B 		vcvtdq2ps	%ymm11, %ymm11
 3603      DB
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3604              		.loc 1 423 40 discriminator 3
 3605 2787 C4E27D33 		vpmovzxwd	%xmm3, %ymm3
 3605      DB
 3606 278c C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 3606      D201
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3607              		.loc 1 424 40 discriminator 3
 3608 2792 C4427D33 		vpmovzxwd	%xmm8, %ymm8
 3608      C0
 3609              		.loc 1 425 40 discriminator 3
 3610 2797 C4C17E6F 		vmovdqu	(%r10,%rax), %ymm4
 3610      2402
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3611              		.loc 1 423 32 discriminator 3
 3612 279d C57C5BF3 		vcvtdq2ps	%ymm3, %ymm14
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3613              		.loc 1 424 32 discriminator 3
 3614 27a1 C4417C5B 		vcvtdq2ps	%ymm8, %ymm8
 3614      C0
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3615              		.loc 1 423 40 discriminator 3
 3616 27a6 C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 3616      D2
 3617              		.loc 1 425 40 discriminator 3
 3618 27ab C4E37D39 		vextracti128	$0x1, %ymm7, %xmm7
 3618      FF01
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3619              		.loc 1 424 32 discriminator 3
 3620 27b1 C59C591D 		vmulps	.LC31(%rip), %ymm12, %ymm3
 3620      00000000 
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3621              		.loc 1 423 32 discriminator 3
 3622 27b9 C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 3623              		.loc 1 425 40 discriminator 3
 3624 27bd C4E27D33 		vpmovzxwd	%xmm7, %ymm7
 3624      FF
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3625              		.loc 1 424 40 discriminator 3
 3626 27c2 C4E37D39 		vextracti128	$0x1, %ymm5, %xmm5
 3626      ED01
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3627              		.loc 1 423 32 discriminator 3
 3628 27c8 C5FC5935 		vmulps	.LC30(%rip), %ymm0, %ymm6
 3628      00000000 
 3629              		.loc 1 425 32 discriminator 3
 3630 27d0 C5FC5BFF 		vcvtdq2ps	%ymm7, %ymm7
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3631              		.loc 1 424 40 discriminator 3
 3632 27d4 C4E27D30 		vpmovzxbw	%xmm5, %ymm5
 3632      ED
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3633              		.loc 1 423 32 discriminator 3
 3634 27d9 C5FC5BC9 		vcvtdq2ps	%ymm1, %ymm1
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3635              		.loc 1 424 40 discriminator 3
 3636 27dd C4627D33 		vpmovzxwd	%xmm5, %ymm10
 3636      D5
 422:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 3637              		.loc 1 422 37 discriminator 3
 3638 27e2 C5CC5835 		vaddps	.LC38(%rip), %ymm6, %ymm6
 3638      00000000 
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3639              		.loc 1 423 32 discriminator 3
 3640 27ea C57C2975 		vmovaps	%ymm14, -80(%rbp)
 3640      B0
 3641              		.loc 1 425 40 discriminator 3
 3642 27ef C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 3642      E401
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3643              		.loc 1 424 32 discriminator 3
 3644 27f5 C4417C5B 		vcvtdq2ps	%ymm10, %ymm10
 3644      D2
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3645              		.loc 1 423 32 discriminator 3
 3646 27fa C56C592D 		vmulps	.LC30(%rip), %ymm2, %ymm13
 3646      00000000 
 3647              		.loc 1 425 40 discriminator 3
 3648 2802 C4E27D30 		vpmovzxbw	%xmm4, %ymm4
 3648      E4
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3649              		.loc 1 424 40 discriminator 3
 3650 2807 C4E37D39 		vextracti128	$0x1, %ymm5, %xmm5
 3650      ED01
 422:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 3651              		.loc 1 422 37 discriminator 3
 3652 280d C514582D 		vaddps	.LC38(%rip), %ymm13, %ymm13
 3652      00000000 
 3653              		.loc 1 425 40 discriminator 3
 3654 2815 C4627D33 		vpmovzxwd	%xmm4, %ymm9
 3654      CC
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3655              		.loc 1 424 40 discriminator 3
 3656 281a C4E27D33 		vpmovzxwd	%xmm5, %ymm5
 3656      ED
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3657              		.loc 1 423 44 discriminator 3
 3658 281f C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 3659              		.loc 1 425 32 discriminator 3
 3660 2823 C4417C5B 		vcvtdq2ps	%ymm9, %ymm9
 3660      C9
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3661              		.loc 1 424 32 discriminator 3
 3662 2828 C5FC5BED 		vcvtdq2ps	%ymm5, %ymm5
 3663              		.loc 1 425 32 discriminator 3
 3664 282c C5A4591D 		vmulps	.LC32(%rip), %ymm11, %ymm3
 3664      00000000 
 3665              		.loc 1 425 40 discriminator 3
 3666 2834 C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 3666      E401
 3667 283a C4E27D33 		vpmovzxwd	%xmm4, %ymm4
 3667      E4
 3668              		.loc 1 425 32 discriminator 3
 3669 283f C5FC5BE4 		vcvtdq2ps	%ymm4, %ymm4
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3670              		.loc 1 424 44 discriminator 3
 3671 2843 C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3672              		.loc 1 424 32 discriminator 3
 3673 2847 C5BC591D 		vmulps	.LC31(%rip), %ymm8, %ymm3
 3673      00000000 
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3674              		.loc 1 421 26 discriminator 3
 3675 284f C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3676              		.loc 1 423 44 discriminator 3
 3677 2853 C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 3678              		.loc 1 425 32 discriminator 3
 3679 2857 C5C4591D 		vmulps	.LC32(%rip), %ymm7, %ymm3
 3679      00000000 
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3680              		.loc 1 424 44 discriminator 3
 3681 285f C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3682              		.loc 1 421 26 discriminator 3
 3683 2863 C585DBDE 		vpand	%ymm6, %ymm15, %ymm3
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3684              		.loc 1 423 32 discriminator 3
 3685 2867 C5F45935 		vmulps	.LC30(%rip), %ymm1, %ymm6
 3685      00000000 
 422:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 3686              		.loc 1 422 37 discriminator 3
 3687 286f C5CC5835 		vaddps	.LC38(%rip), %ymm6, %ymm6
 3687      00000000 
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3688              		.loc 1 421 26 discriminator 3
 3689 2877 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 3689      ED
 3690 287c C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 3690      ED
 3691 2881 C4C2652B 		vpackusdw	%ymm13, %ymm3, %ymm3
 3691      DD
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3692              		.loc 1 424 32 discriminator 3
 3693 2886 C52C592D 		vmulps	.LC31(%rip), %ymm10, %ymm13
 3693      00000000 
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3694              		.loc 1 421 26 discriminator 3
 3695 288e C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 3695      DBD8
 3696 2894 C5E5DB1D 		vpand	.LC35(%rip), %ymm3, %ymm3
 3696      00000000 
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3697              		.loc 1 423 44 discriminator 3
 3698 289c C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 3698      F5
 3699              		.loc 1 425 32 discriminator 3
 3700 28a1 C534592D 		vmulps	.LC32(%rip), %ymm9, %ymm13
 3700      00000000 
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3701              		.loc 1 424 44 discriminator 3
 3702 28a9 C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 3702      F5
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3703              		.loc 1 423 32 discriminator 3
 3704 28ae C50C592D 		vmulps	.LC30(%rip), %ymm14, %ymm13
 3704      00000000 
 422:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 3705              		.loc 1 422 37 discriminator 3
 3706 28b6 C5145835 		vaddps	.LC38(%rip), %ymm13, %ymm14
 3706      00000000 
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3707              		.loc 1 424 32 discriminator 3
 3708 28be C554592D 		vmulps	.LC31(%rip), %ymm5, %ymm13
 3708      00000000 
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3709              		.loc 1 421 26 discriminator 3
 3710 28c6 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 3711 28ca C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3712              		.loc 1 423 44 discriminator 3
 3713 28ce C4410C58 		vaddps	%ymm13, %ymm14, %ymm13
 3713      ED
 3714              		.loc 1 425 32 discriminator 3
 3715 28d3 C55C5935 		vmulps	.LC32(%rip), %ymm4, %ymm14
 3715      00000000 
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3716              		.loc 1 424 44 discriminator 3
 3717 28db C4411458 		vaddps	%ymm14, %ymm13, %ymm13
 3717      EE
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3718              		.loc 1 421 26 discriminator 3
 3719 28e0 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 3719      ED
 3720 28e5 C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 3720      ED
 3721 28ea C4C24D2B 		vpackusdw	%ymm13, %ymm6, %ymm6
 3721      F5
 426:RGB2YCbCr.c   ****             Cbpixels[i] = (unsigned char) (0.5f + 
 427:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 428:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 3722              		.loc 1 428 32 discriminator 3
 3723 28ef C56C592D 		vmulps	.LC36(%rip), %ymm2, %ymm13
 3723      00000000 
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3724              		.loc 1 421 26 discriminator 3
 3725 28f7 C4E3FD00 		vpermq	$216, %ymm6, %ymm6
 3725      F6D8
 3726 28fd C5CDDB35 		vpand	.LC35(%rip), %ymm6, %ymm6
 3726      00000000 
 427:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 3727              		.loc 1 427 37 discriminator 3
 3728 2905 C514582D 		vaddps	.LC64(%rip), %ymm13, %ymm13
 3728      00000000 
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3729              		.loc 1 421 26 discriminator 3
 3730 290d C5E567DE 		vpackuswb	%ymm6, %ymm3, %ymm3
 3731              		.loc 1 428 32 discriminator 3
 3732 2911 C5FC5935 		vmulps	.LC36(%rip), %ymm0, %ymm6
 3732      00000000 
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3733              		.loc 1 421 26 discriminator 3
 3734 2919 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 3734      DBD8
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3735              		.loc 1 421 24 discriminator 3
 3736 291f C4C17D7F 		vmovdqa	%ymm3, 0(%r13,%rax)
 3736      5C0500
 426:RGB2YCbCr.c   ****             Cbpixels[i] = (unsigned char) (0.5f + 
 3737              		.loc 1 426 13 is_stmt 1 discriminator 3
 429:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3738              		.loc 1 429 32 is_stmt 0 discriminator 3
 3739 2926 C59C591D 		vmulps	.LC37(%rip), %ymm12, %ymm3
 3739      00000000 
 427:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 3740              		.loc 1 427 37 discriminator 3
 3741 292e C5CC5835 		vaddps	.LC64(%rip), %ymm6, %ymm6
 3741      00000000 
 428:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3742              		.loc 1 428 44 discriminator 3
 3743 2936 C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 430:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 3744              		.loc 1 430 32 discriminator 3
 3745 293a C5A4591D 		vmulps	.LC38(%rip), %ymm11, %ymm3
 3745      00000000 
 429:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3746              		.loc 1 429 44 discriminator 3
 3747 2942 C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 429:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3748              		.loc 1 429 32 discriminator 3
 3749 2946 C5BC591D 		vmulps	.LC37(%rip), %ymm8, %ymm3
 3749      00000000 
 428:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3750              		.loc 1 428 32 discriminator 3
 3751 294e C57C2875 		vmovaps	-80(%rbp), %ymm14
 3751      B0
 431:RGB2YCbCr.c   ****             Crpixels[i] = (unsigned char) (0.5f + 
 432:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 433:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 434:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 3752              		.loc 1 434 32 discriminator 3
 3753 2953 C53C5905 		vmulps	.LC40(%rip), %ymm8, %ymm8
 3753      00000000 
 433:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 3754              		.loc 1 433 32 discriminator 3
 3755 295b C5EC5915 		vmulps	.LC38(%rip), %ymm2, %ymm2
 3755      00000000 
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3756              		.loc 1 426 27 discriminator 3
 3757 2963 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 432:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 3758              		.loc 1 432 37 discriminator 3
 3759 2967 C5EC5815 		vaddps	.LC64(%rip), %ymm2, %ymm2
 3759      00000000 
 3760              		.loc 1 434 32 discriminator 3
 3761 296f C51C5925 		vmulps	.LC40(%rip), %ymm12, %ymm12
 3761      00000000 
 433:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 3762              		.loc 1 433 32 discriminator 3
 3763 2977 C5FC5905 		vmulps	.LC38(%rip), %ymm0, %ymm0
 3763      00000000 
 428:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3764              		.loc 1 428 44 discriminator 3
 3765 297f C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 430:RGB2YCbCr.c   ****             Crpixels[i] = (unsigned char) (0.5f + 
 3766              		.loc 1 430 32 discriminator 3
 3767 2983 C5C4591D 		vmulps	.LC38(%rip), %ymm7, %ymm3
 3767      00000000 
 432:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 3768              		.loc 1 432 37 discriminator 3
 3769 298b C5FC5805 		vaddps	.LC64(%rip), %ymm0, %ymm0
 3769      00000000 
 433:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 3770              		.loc 1 433 44 discriminator 3
 3771 2993 C4416C58 		vaddps	%ymm8, %ymm2, %ymm8
 3771      C0
 435:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 3772              		.loc 1 435 32 discriminator 3
 3773 2998 C524591D 		vmulps	.LC41(%rip), %ymm11, %ymm11
 3773      00000000 
 3774 29a0 C5C4593D 		vmulps	.LC41(%rip), %ymm7, %ymm7
 3774      00000000 
 433:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 3775              		.loc 1 433 44 discriminator 3
 3776 29a8 C4417C58 		vaddps	%ymm12, %ymm0, %ymm12
 3776      E4
 429:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 3777              		.loc 1 429 44 discriminator 3
 3778 29ad C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3779              		.loc 1 426 27 discriminator 3
 3780 29b1 C585DBDE 		vpand	%ymm6, %ymm15, %ymm3
 428:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3781              		.loc 1 428 32 discriminator 3
 3782 29b5 C5F45935 		vmulps	.LC36(%rip), %ymm1, %ymm6
 3782      00000000 
 434:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 3783              		.loc 1 434 44 discriminator 3
 3784 29bd C4411C58 		vaddps	%ymm11, %ymm12, %ymm11
 3784      DB
 427:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 3785              		.loc 1 427 37 discriminator 3
 3786 29c2 C5CC5835 		vaddps	.LC64(%rip), %ymm6, %ymm6
 3786      00000000 
 433:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 3787              		.loc 1 433 32 discriminator 3
 3788 29ca C5F4590D 		vmulps	.LC38(%rip), %ymm1, %ymm1
 3788      00000000 
 434:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 3789              		.loc 1 434 44 discriminator 3
 3790 29d2 C5BC58FF 		vaddps	%ymm7, %ymm8, %ymm7
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3791              		.loc 1 426 27 discriminator 3
 3792 29d6 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 3792      ED
 3793 29db C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 3793      ED
 432:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 3794              		.loc 1 432 37 discriminator 3
 3795 29e0 C5F4580D 		vaddps	.LC64(%rip), %ymm1, %ymm1
 3795      00000000 
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3796              		.loc 1 426 27 discriminator 3
 3797 29e8 C4C2652B 		vpackusdw	%ymm13, %ymm3, %ymm3
 3797      DD
 431:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 3798              		.loc 1 431 27 discriminator 3
 3799 29ed C4C17E5B 		vcvttps2dq	%ymm11, %ymm0
 3799      C3
 3800 29f2 C585DBC0 		vpand	%ymm0, %ymm15, %ymm0
 429:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 3801              		.loc 1 429 32 discriminator 3
 3802 29f6 C52C592D 		vmulps	.LC37(%rip), %ymm10, %ymm13
 3802      00000000 
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3803              		.loc 1 426 27 discriminator 3
 3804 29fe C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 3804      DBD8
 431:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 3805              		.loc 1 431 27 discriminator 3
 3806 2a04 C5FE5BFF 		vcvttps2dq	%ymm7, %ymm7
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3807              		.loc 1 426 27 discriminator 3
 3808 2a08 C5E5DB1D 		vpand	.LC35(%rip), %ymm3, %ymm3
 3808      00000000 
 434:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 3809              		.loc 1 434 32 discriminator 3
 3810 2a10 C52C5915 		vmulps	.LC40(%rip), %ymm10, %ymm10
 3810      00000000 
 431:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 3811              		.loc 1 431 27 discriminator 3
 3812 2a18 C585DBFF 		vpand	%ymm7, %ymm15, %ymm7
 3813 2a1c C4E27D2B 		vpackusdw	%ymm7, %ymm0, %ymm0
 3813      C7
 3814 2a21 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 3814      C0D8
 3815 2a27 C5FDDB05 		vpand	.LC35(%rip), %ymm0, %ymm0
 3815      00000000 
 428:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3816              		.loc 1 428 44 discriminator 3
 3817 2a2f C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 3817      F5
 430:RGB2YCbCr.c   ****             Crpixels[i] = (unsigned char) (0.5f + 
 3818              		.loc 1 430 32 discriminator 3
 3819 2a34 C534592D 		vmulps	.LC38(%rip), %ymm9, %ymm13
 3819      00000000 
 3820              		.loc 1 435 32 discriminator 3
 3821 2a3c C534590D 		vmulps	.LC41(%rip), %ymm9, %ymm9
 3821      00000000 
 433:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 3822              		.loc 1 433 44 discriminator 3
 3823 2a44 C4C17458 		vaddps	%ymm10, %ymm1, %ymm1
 3823      CA
 429:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 3824              		.loc 1 429 44 discriminator 3
 3825 2a49 C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 3825      F5
 428:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3826              		.loc 1 428 32 discriminator 3
 3827 2a4e C50C592D 		vmulps	.LC36(%rip), %ymm14, %ymm13
 3827      00000000 
 427:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 3828              		.loc 1 427 37 discriminator 3
 3829 2a56 C5145835 		vaddps	.LC64(%rip), %ymm13, %ymm14
 3829      00000000 
 429:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 3830              		.loc 1 429 32 discriminator 3
 3831 2a5e C554592D 		vmulps	.LC37(%rip), %ymm5, %ymm13
 3831      00000000 
 434:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 3832              		.loc 1 434 44 discriminator 3
 3833 2a66 C4C17458 		vaddps	%ymm9, %ymm1, %ymm1
 3833      C9
 434:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 3834              		.loc 1 434 32 discriminator 3
 3835 2a6b C5D4592D 		vmulps	.LC40(%rip), %ymm5, %ymm5
 3835      00000000 
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3836              		.loc 1 426 27 discriminator 3
 3837 2a73 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 3838 2a77 C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 431:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 3839              		.loc 1 431 27 discriminator 3
 3840 2a7b C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 3841 2a7f C585DBC9 		vpand	%ymm1, %ymm15, %ymm1
 428:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3842              		.loc 1 428 44 discriminator 3
 3843 2a83 C4410C58 		vaddps	%ymm13, %ymm14, %ymm13
 3843      ED
 430:RGB2YCbCr.c   ****             Crpixels[i] = (unsigned char) (0.5f + 
 3844              		.loc 1 430 32 discriminator 3
 3845 2a88 C55C5935 		vmulps	.LC38(%rip), %ymm4, %ymm14
 3845      00000000 
 3846              		.loc 1 435 32 discriminator 3
 3847 2a90 C5DC5925 		vmulps	.LC41(%rip), %ymm4, %ymm4
 3847      00000000 
 429:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 3848              		.loc 1 429 44 discriminator 3
 3849 2a98 C4411458 		vaddps	%ymm14, %ymm13, %ymm13
 3849      EE
 433:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 3850              		.loc 1 433 32 discriminator 3
 3851 2a9d C57C2875 		vmovaps	-80(%rbp), %ymm14
 3851      B0
 3852 2aa2 C58C5915 		vmulps	.LC38(%rip), %ymm14, %ymm2
 3852      00000000 
 432:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 3853              		.loc 1 432 37 discriminator 3
 3854 2aaa C5EC5815 		vaddps	.LC64(%rip), %ymm2, %ymm2
 3854      00000000 
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3855              		.loc 1 426 27 discriminator 3
 3856 2ab2 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 3856      ED
 3857 2ab7 C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 3857      ED
 433:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 3858              		.loc 1 433 44 discriminator 3
 3859 2abc C5EC58ED 		vaddps	%ymm5, %ymm2, %ymm5
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3860              		.loc 1 426 27 discriminator 3
 3861 2ac0 C4C24D2B 		vpackusdw	%ymm13, %ymm6, %ymm6
 3861      F5
 3862 2ac5 C4E3FD00 		vpermq	$216, %ymm6, %ymm6
 3862      F6D8
 3863 2acb C5CDDB35 		vpand	.LC35(%rip), %ymm6, %ymm6
 3863      00000000 
 434:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 3864              		.loc 1 434 44 discriminator 3
 3865 2ad3 C5D458E4 		vaddps	%ymm4, %ymm5, %ymm4
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3866              		.loc 1 426 27 discriminator 3
 3867 2ad7 C5E567DE 		vpackuswb	%ymm6, %ymm3, %ymm3
 3868 2adb C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 3868      DBD8
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3869              		.loc 1 426 25 discriminator 3
 3870 2ae1 C5FE7F1C 		vmovdqu	%ymm3, (%rbx,%rax)
 3870      03
 431:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 3871              		.loc 1 431 13 is_stmt 1 discriminator 3
 431:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 3872              		.loc 1 431 27 is_stmt 0 discriminator 3
 3873 2ae6 C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 3874 2aea C585DBE4 		vpand	%ymm4, %ymm15, %ymm4
 3875 2aee C4E2752B 		vpackusdw	%ymm4, %ymm1, %ymm1
 3875      CC
 3876 2af3 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 3876      C9D8
 3877 2af9 C5F5DB0D 		vpand	.LC35(%rip), %ymm1, %ymm1
 3877      00000000 
 3878 2b01 C5FD67C9 		vpackuswb	%ymm1, %ymm0, %ymm1
 3879 2b05 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 3879      C9D8
 431:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 3880              		.loc 1 431 25 discriminator 3
 3881 2b0b C4C17E7F 		vmovdqu	%ymm1, (%r8,%rax)
 3881      0C00
 419:RGB2YCbCr.c   ****         {
 3882              		.loc 1 419 43 is_stmt 1 discriminator 3
 419:RGB2YCbCr.c   ****         {
 3883              		.loc 1 419 25 discriminator 3
 3884 2b11 4883C020 		addq	$32, %rax
 3885 2b15 4C39C8   		cmpq	%r9, %rax
 3886 2b18 0F8512FC 		jne	.L87
 3886      FFFF
 3887 2b1e 8B8574FF 		movl	-140(%rbp), %eax
 3887      FFFF
 3888 2b24 4439F8   		cmpl	%r15d, %eax
 3889 2b27 0F84E600 		je	.L92
 3889      0000
 419:RGB2YCbCr.c   ****         {
 3890              		.loc 1 419 18 is_stmt 0
 3891 2b2d 4863F0   		movslq	%eax, %rsi
 3892              	.L86:
 3893 2b30 C57A1015 		vmovss	.LC1(%rip), %xmm10
 3893      00000000 
 3894 2b38 C5FA1015 		vmovss	.LC8(%rip), %xmm2
 3894      00000000 
 3895 2b40 C57A100D 		vmovss	.LC3(%rip), %xmm9
 3895      00000000 
 3896 2b48 C57A1005 		vmovss	.LC4(%rip), %xmm8
 3896      00000000 
 3897 2b50 C5FA103D 		vmovss	.LC5(%rip), %xmm7
 3897      00000000 
 3898 2b58 C5FA101D 		vmovss	.LC65(%rip), %xmm3
 3898      00000000 
 3899 2b60 C5FA1035 		vmovss	.LC7(%rip), %xmm6
 3899      00000000 
 3900 2b68 C5FA102D 		vmovss	.LC9(%rip), %xmm5
 3900      00000000 
 3901 2b70 C5FA1025 		vmovss	.LC10(%rip), %xmm4
 3901      00000000 
 3902 2b78 0F1F8400 		.p2align 4,,10
 3902      00000000 
 3903              		.p2align 3
 3904              	.L89:
 3905              	.LVL179:
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3906              		.loc 1 421 13 is_stmt 1
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3907              		.loc 1 423 40 is_stmt 0
 3908 2b80 410FB604 		movzbl	(%r12,%rsi), %eax
 3908      34
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3909              		.loc 1 423 32
 3910 2b85 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 3911 2b89 C5F22AC0 		vcvtsi2ssl	%eax, %xmm1, %xmm0
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3912              		.loc 1 424 40
 3913 2b8d 410FB604 		movzbl	(%r14,%rsi), %eax
 3913      36
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3914              		.loc 1 424 32
 3915 2b92 C5722AD8 		vcvtsi2ssl	%eax, %xmm1, %xmm11
 425:RGB2YCbCr.c   ****             Cbpixels[i] = (unsigned char) (0.5f + 
 3916              		.loc 1 425 40
 3917 2b96 0FB60431 		movzbl	(%rcx,%rsi), %eax
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3918              		.loc 1 423 32
 3919 2b9a C4417A59 		vmulss	%xmm10, %xmm0, %xmm12
 3919      E2
 425:RGB2YCbCr.c   ****             Cbpixels[i] = (unsigned char) (0.5f + 
 3920              		.loc 1 425 32
 3921 2b9f C5F22AC8 		vcvtsi2ssl	%eax, %xmm1, %xmm1
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3922              		.loc 1 424 32
 3923 2ba3 C4412259 		vmulss	%xmm9, %xmm11, %xmm13
 3923      E9
 422:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 3924              		.loc 1 422 37
 3925 2ba8 C51A58E2 		vaddss	%xmm2, %xmm12, %xmm12
 423:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 3926              		.loc 1 423 44
 3927 2bac C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 3927      E5
 425:RGB2YCbCr.c   ****             Cbpixels[i] = (unsigned char) (0.5f + 
 3928              		.loc 1 425 32
 3929 2bb1 C4417259 		vmulss	%xmm8, %xmm1, %xmm13
 3929      E8
 424:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 3930              		.loc 1 424 44
 3931 2bb6 C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 3931      E5
 429:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 3932              		.loc 1 429 32
 3933 2bbb C52259EE 		vmulss	%xmm6, %xmm11, %xmm13
 434:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 3934              		.loc 1 434 32
 3935 2bbf C52259DD 		vmulss	%xmm5, %xmm11, %xmm11
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3936              		.loc 1 421 26
 3937 2bc3 C4C17A2C 		vcvttss2sil	%xmm12, %eax
 3937      C4
 428:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3938              		.loc 1 428 32
 3939 2bc8 C57A59E7 		vmulss	%xmm7, %xmm0, %xmm12
 433:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 3940              		.loc 1 433 32
 3941 2bcc C5FA59C2 		vmulss	%xmm2, %xmm0, %xmm0
 421:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 3942              		.loc 1 421 26
 3943 2bd0 41884435 		movb	%al, 0(%r13,%rsi)
 3943      00
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3944              		.loc 1 426 13 is_stmt 1
 427:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 3945              		.loc 1 427 37 is_stmt 0
 3946 2bd5 C51A58E3 		vaddss	%xmm3, %xmm12, %xmm12
 432:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 3947              		.loc 1 432 37
 3948 2bd9 C5FA58C3 		vaddss	%xmm3, %xmm0, %xmm0
 428:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 3949              		.loc 1 428 44
 3950 2bdd C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 3950      E5
 430:RGB2YCbCr.c   ****             Crpixels[i] = (unsigned char) (0.5f + 
 3951              		.loc 1 430 32
 3952 2be2 C57259EA 		vmulss	%xmm2, %xmm1, %xmm13
 3953              		.loc 1 435 32
 3954 2be6 C5F259CC 		vmulss	%xmm4, %xmm1, %xmm1
 433:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 3955              		.loc 1 433 44
 3956 2bea C4C17A58 		vaddss	%xmm11, %xmm0, %xmm0
 3956      C3
 429:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 3957              		.loc 1 429 44
 3958 2bef C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 3958      E5
 434:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 3959              		.loc 1 434 44
 3960 2bf4 C5FA58C1 		vaddss	%xmm1, %xmm0, %xmm0
 426:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 3961              		.loc 1 426 27
 3962 2bf8 C4C17A2C 		vcvttss2sil	%xmm12, %eax
 3962      C4
 3963 2bfd 880433   		movb	%al, (%rbx,%rsi)
 431:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 3964              		.loc 1 431 13 is_stmt 1
 431:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 3965              		.loc 1 431 27 is_stmt 0
 3966 2c00 C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 3967 2c04 880432   		movb	%al, (%rdx,%rsi)
 419:RGB2YCbCr.c   ****         {
 3968              		.loc 1 419 43 is_stmt 1
 3969              	.LVL180:
 419:RGB2YCbCr.c   ****         {
 3970              		.loc 1 419 25
 3971 2c07 48FFC6   		incq	%rsi
 3972              	.LVL181:
 419:RGB2YCbCr.c   ****         {
 3973              		.loc 1 419 9 is_stmt 0
 3974 2c0a 4139F7   		cmpl	%esi, %r15d
 3975 2c0d 0F8F6DFF 		jg	.L89
 3975      FFFF
 3976              	.L92:
 3977              	.LBE48:
 436:RGB2YCbCr.c   ****         }
 437:RGB2YCbCr.c   ****         dummy(image_in, image_out);
 3978              		.loc 1 437 9 is_stmt 1
 3979 2c13 488B7588 		movq	-120(%rbp), %rsi
 3980 2c17 488B7D80 		movq	-128(%rbp), %rdi
 3981 2c1b 4C894590 		movq	%r8, -112(%rbp)
 3982 2c1f 4C895598 		movq	%r10, -104(%rbp)
 3983 2c23 488955A0 		movq	%rdx, -96(%rbp)
 3984 2c27 48894DA8 		movq	%rcx, -88(%rbp)
 3985 2c2b 4C894DB0 		movq	%r9, -80(%rbp)
 3986 2c2f C5F877   		vzeroupper
 3987 2c32 E8000000 		call	dummy
 3987      00
 3988              	.LVL182:
 415:RGB2YCbCr.c   ****     {
 3989              		.loc 1 415 32
 415:RGB2YCbCr.c   ****     {
 3990              		.loc 1 415 20
 415:RGB2YCbCr.c   ****     {
 3991              		.loc 1 415 5 is_stmt 0
 3992 2c37 FF8D7CFF 		decl	-132(%rbp)
 3992      FFFF
 3993 2c3d 4C8B4DB0 		movq	-80(%rbp), %r9
 3994 2c41 C57D6F3D 		vmovdqa	.LC34(%rip), %ymm15
 3994      00000000 
 3995 2c49 488B4DA8 		movq	-88(%rbp), %rcx
 3996 2c4d 488B55A0 		movq	-96(%rbp), %rdx
 3997 2c51 4C8B5598 		movq	-104(%rbp), %r10
 3998 2c55 4C8B4590 		movq	-112(%rbp), %r8
 3999 2c59 0F85B1FA 		jne	.L85
 3999      FFFF
 4000 2c5f 4C8B5D88 		movq	-120(%rbp), %r11
 4001              	.LBE47:
 438:RGB2YCbCr.c   ****     }
 439:RGB2YCbCr.c   ****     end_t = get_wall_time();
 4002              		.loc 1 439 13
 4003 2c63 31C0     		xorl	%eax, %eax
 4004 2c65 488955A8 		movq	%rdx, -88(%rbp)
 4005 2c69 4C895DB0 		movq	%r11, -80(%rbp)
 4006              		.loc 1 439 5 is_stmt 1
 4007              		.loc 1 439 13 is_stmt 0
 4008 2c6d C5F877   		vzeroupper
 4009 2c70 E8000000 		call	get_wall_time
 4009      00
 4010              	.LVL183:
 440:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2YCbCrSOA0");
 4011              		.loc 1 440 5 is_stmt 1
 4012 2c75 C5FB5C85 		vsubsd	-152(%rbp), %xmm0, %xmm0
 4012      68FFFFFF 
 4013              	.LVL184:
 4014 2c7d BE000000 		movl	$.LC70, %esi
 4014      00
 4015 2c82 4489FF   		movl	%r15d, %edi
 4016 2c85 E8000000 		call	results
 4016      00
 4017              	.LVL185:
 4018              	.LBB50:
 441:RGB2YCbCr.c   **** 
 442:RGB2YCbCr.c   ****     /* transformaci贸n SoA -> AoS */
 443:RGB2YCbCr.c   ****     /* COMPLETAR ... */
 444:RGB2YCbCr.c   ****     #pragma GCC ivdep
 445:RGB2YCbCr.c   ****     for (int i=0; i < height*width; i++)
 4019              		.loc 1 445 10
 4020              		.loc 1 445 19
 4021              		.loc 1 445 5 is_stmt 0
 4022 2c8a 4585FF   		testl	%r15d, %r15d
 4023 2c8d 7E4D     		jle	.L93
 4024 2c8f 448B8578 		movl	-136(%rbp), %r8d
 4024      FFFFFF
 4025 2c96 488B55A8 		movq	-88(%rbp), %rdx
 4026 2c9a 31C9     		xorl	%ecx, %ecx
 4027 2c9c 31C0     		xorl	%eax, %eax
 4028 2c9e 4C8B5DB0 		movq	-80(%rbp), %r11
 4029              	.LVL186:
 4030              		.p2align 4,,10
 4031 2ca2 660F1F44 		.p2align 3
 4031      0000
 4032              	.L94:
 446:RGB2YCbCr.c   ****     {
 447:RGB2YCbCr.c   ****         image_out->pixels[3*i + 0] = Ypixels[i];
 4033              		.loc 1 447 9 is_stmt 1 discriminator 3
 4034              		.loc 1 447 36 is_stmt 0 discriminator 3
 4035 2ca8 498B33   		movq	(%r11), %rsi
 4036 2cab 410FB67C 		movzbl	0(%r13,%rax), %edi
 4036      0500
 4037 2cb1 40883C0E 		movb	%dil, (%rsi,%rcx)
 448:RGB2YCbCr.c   ****         image_out->pixels[3*i + 1] = Cbpixels[i];
 4038              		.loc 1 448 9 is_stmt 1 discriminator 3
 4039              		.loc 1 448 36 is_stmt 0 discriminator 3
 4040 2cb5 0FB63C03 		movzbl	(%rbx,%rax), %edi
 4041 2cb9 498B33   		movq	(%r11), %rsi
 4042 2cbc 40887C0E 		movb	%dil, 1(%rsi,%rcx)
 4042      01
 449:RGB2YCbCr.c   ****         image_out->pixels[3*i + 2] = Crpixels[i];
 4043              		.loc 1 449 9 is_stmt 1 discriminator 3
 4044              		.loc 1 449 36 is_stmt 0 discriminator 3
 4045 2cc1 0FB63C02 		movzbl	(%rdx,%rax), %edi
 4046 2cc5 498B33   		movq	(%r11), %rsi
 4047 2cc8 40887C0E 		movb	%dil, 2(%rsi,%rcx)
 4047      02
 445:RGB2YCbCr.c   ****     {
 4048              		.loc 1 445 37 is_stmt 1 discriminator 3
 4049              	.LVL187:
 445:RGB2YCbCr.c   ****     {
 4050              		.loc 1 445 19 discriminator 3
 4051 2ccd 4889C6   		movq	%rax, %rsi
 4052 2cd0 4883C103 		addq	$3, %rcx
 4053 2cd4 48FFC0   		incq	%rax
 4054              	.LVL188:
 445:RGB2YCbCr.c   ****     {
 4055              		.loc 1 445 5 is_stmt 0 discriminator 3
 4056 2cd7 4939F0   		cmpq	%rsi, %r8
 4057 2cda 75CC     		jne	.L94
 4058              	.L93:
 4059              	.LBE50:
 450:RGB2YCbCr.c   ****     }
 451:RGB2YCbCr.c   **** 
 452:RGB2YCbCr.c   ****     free(Rpixels); free(Ypixels);
 4060              		.loc 1 452 5 is_stmt 1
 4061 2cdc 4C89E7   		movq	%r12, %rdi
 4062 2cdf E8000000 		call	free
 4062      00
 4063              	.LVL189:
 4064              		.loc 1 452 20
 453:RGB2YCbCr.c   **** }
 4065              		.loc 1 453 1 is_stmt 0
 4066 2ce4 4881C488 		addq	$136, %rsp
 4066      000000
 452:RGB2YCbCr.c   **** }
 4067              		.loc 1 452 20
 4068 2ceb 4C89EF   		movq	%r13, %rdi
 4069              		.loc 1 453 1
 4070 2cee 5B       		popq	%rbx
 4071              	.LVL190:
 4072 2cef 415C     		popq	%r12
 4073              	.LVL191:
 4074 2cf1 415D     		popq	%r13
 4075              		.cfi_remember_state
 4076              		.cfi_def_cfa 13, 0
 4077              	.LVL192:
 4078 2cf3 415E     		popq	%r14
 4079              	.LVL193:
 4080 2cf5 415F     		popq	%r15
 4081 2cf7 5D       		popq	%rbp
 4082              	.LVL194:
 4083 2cf8 498D65F0 		leaq	-16(%r13), %rsp
 4084              		.cfi_def_cfa 7, 16
 4085              	.LVL195:
 4086 2cfc 415D     		popq	%r13
 4087              		.cfi_def_cfa_offset 8
 452:RGB2YCbCr.c   **** }
 4088              		.loc 1 452 20
 4089 2cfe E9000000 		jmp	free
 4089      00
 4090              	.LVL196:
 4091              	.L96:
 4092              		.cfi_restore_state
 4093              	.LBB51:
 4094              	.LBB49:
 419:RGB2YCbCr.c   ****         {
 4095              		.loc 1 419 18
 4096 2d03 31F6     		xorl	%esi, %esi
 4097 2d05 E926FEFF 		jmp	.L86
 4097      FF
 4098              	.LVL197:
 4099              	.L107:
 4100 2d0a 418D47FF 		leal	-1(%r15), %eax
 4101              	.LVL198:
 4102 2d0e 898578FF 		movl	%eax, -136(%rbp)
 4102      FFFF
 4103 2d14 E98DF9FF 		jmp	.L80
 4103      FF
 4104              	.L95:
 4105              	.LBE49:
 4106              	.LBE51:
 4107              	.LBB52:
 407:RGB2YCbCr.c   ****     {
 4108              		.loc 1 407 14
 4109 2d19 31F6     		xorl	%esi, %esi
 4110 2d1b E94CF9FF 		jmp	.L81
 4110      FF
 4111              	.LVL199:
 4112              	.L108:
 4113 2d20 C5F877   		vzeroupper
 4114 2d23 E97EF9FF 		jmp	.L80
 4114      FF
 4115              	.LVL200:
 4116              	.L106:
 4117              	.LBE52:
 385:RGB2YCbCr.c   ****         exit(-1);
 4118              		.loc 1 385 9 is_stmt 1
 4119 2d28 BF000000 		movl	$.LC0, %edi
 4119      00
 4120              	.LVL201:
 4121 2d2d E8000000 		call	puts
 4121      00
 4122              	.LVL202:
 386:RGB2YCbCr.c   ****     }
 4123              		.loc 1 386 9
 4124 2d32 83CFFF   		orl	$-1, %edi
 4125 2d35 E8000000 		call	exit
 4125      00
 4126              	.LVL203:
 4127              		.cfi_endproc
 4128              	.LFE20:
 4130              		.section	.rodata.str1.1
 4131              	.LC71:
 4132 0071 52474232 		.string	"RGB2YCbCrSOA1"
 4132      59436243 
 4132      72534F41 
 4132      3100
 4133              		.text
 4134 2d3a 660F1F44 		.p2align 4
 4134      0000
 4135              		.globl	RGB2YCbCr_SOA1
 4137              	RGB2YCbCr_SOA1:
 4138              	.LFB21:
 454:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
 455:RGB2YCbCr.c   **** 
 456:RGB2YCbCr.c   **** /* como SOA0 pero contando el tiempo de la transformacion de datos */
 457:RGB2YCbCr.c   **** void
 458:RGB2YCbCr.c   **** RGB2YCbCr_SOA1(image_t * restrict image_in, image_t * restrict image_out)
 459:RGB2YCbCr.c   **** {
 4139              		.loc 1 459 1
 4140              		.cfi_startproc
 4141              	.LVL204:
 460:RGB2YCbCr.c   ****     double start_t, end_t;
 4142              		.loc 1 460 5
 461:RGB2YCbCr.c   ****     const int height = image_in->height;
 4143              		.loc 1 461 5
 459:RGB2YCbCr.c   ****     double start_t, end_t;
 4144              		.loc 1 459 1 is_stmt 0
 4145 2d40 4155     		pushq	%r13
 4146              		.cfi_def_cfa_offset 16
 4147              		.cfi_offset 13, -16
 4148 2d42 4C8D6C24 		leaq	16(%rsp), %r13
 4148      10
 4149              		.cfi_def_cfa 13, 0
 4150 2d47 4883E4E0 		andq	$-32, %rsp
 4151 2d4b 41FF75F8 		pushq	-8(%r13)
 4152 2d4f 55       		pushq	%rbp
 4153              		.cfi_escape 0x10,0x6,0x2,0x76,0
 4154 2d50 4889E5   		movq	%rsp, %rbp
 4155 2d53 4157     		pushq	%r15
 4156 2d55 4156     		pushq	%r14
 4157 2d57 4155     		pushq	%r13
 4158              		.cfi_escape 0xf,0x3,0x76,0x68,0x6
 4159              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 4160              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 4161 2d59 4154     		pushq	%r12
 4162 2d5b 53       		pushq	%rbx
 4163 2d5c 4883EC68 		subq	$104, %rsp
 4164              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 4165              		.cfi_escape 0x10,0x3,0x2,0x76,0x58
 462:RGB2YCbCr.c   ****     const int width =  image_in->width;
 463:RGB2YCbCr.c   ****     unsigned char *Rpixels, *Gpixels, *Bpixels, *Ypixels, *Cbpixels, *Crpixels;
 464:RGB2YCbCr.c   **** 
 465:RGB2YCbCr.c   ****     if (image_in->bytes_per_pixel != 3)
 4166              		.loc 1 465 8
 4167 2d60 837F1003 		cmpl	$3, 16(%rdi)
 461:RGB2YCbCr.c   ****     const int width =  image_in->width;
 4168              		.loc 1 461 15
 4169 2d64 448B4F0C 		movl	12(%rdi), %r9d
 4170              	.LVL205:
 462:RGB2YCbCr.c   ****     const int width =  image_in->width;
 4171              		.loc 1 462 5 is_stmt 1
 459:RGB2YCbCr.c   ****     double start_t, end_t;
 4172              		.loc 1 459 1 is_stmt 0
 4173 2d68 48897D80 		movq	%rdi, -128(%rbp)
 462:RGB2YCbCr.c   ****     const int width =  image_in->width;
 4174              		.loc 1 462 15
 4175 2d6c 8B4708   		movl	8(%rdi), %eax
 4176              	.LVL206:
 463:RGB2YCbCr.c   **** 
 4177              		.loc 1 463 5 is_stmt 1
 4178              		.loc 1 465 5
 4179              		.loc 1 465 8 is_stmt 0
 4180 2d6f 0F854508 		jne	.L132
 4180      0000
 466:RGB2YCbCr.c   ****     {
 467:RGB2YCbCr.c   ****         printf("ERROR: input image has to be RGB\n");
 468:RGB2YCbCr.c   ****         exit(-1);
 469:RGB2YCbCr.c   ****     }
 470:RGB2YCbCr.c   ****     
 471:RGB2YCbCr.c   ****     /* fill struct fields */
 472:RGB2YCbCr.c   ****     image_out->width  = width;
 473:RGB2YCbCr.c   ****     image_out->height = height;
 474:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 4181              		.loc 1 474 32
 4182 2d75 48BF0300 		movabsq	$12884901891, %rdi
 4182      00000300 
 4182      0000
 4183              	.LVL207:
 473:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 4184              		.loc 1 473 23
 4185 2d7f 44894E0C 		movl	%r9d, 12(%rsi)
 475:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 476:RGB2YCbCr.c   **** 
 477:RGB2YCbCr.c   ****     /* transform data layout */
 478:RGB2YCbCr.c   ****     Rpixels = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
 4186              		.loc 1 478 66
 4187 2d83 440FAFC8 		imull	%eax, %r9d
 4188              	.LVL208:
 4189 2d87 4889F3   		movq	%rsi, %rbx
 472:RGB2YCbCr.c   ****     image_out->height = height;
 4190              		.loc 1 472 5 is_stmt 1
 474:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 4191              		.loc 1 474 32 is_stmt 0
 4192 2d8a 48897E10 		movq	%rdi, 16(%rsi)
 4193              		.loc 1 478 33
 4194 2d8e BF200000 		movl	$32, %edi
 4194      00
 472:RGB2YCbCr.c   ****     image_out->height = height;
 4195              		.loc 1 472 23
 4196 2d93 894608   		movl	%eax, 8(%rsi)
 473:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 4197              		.loc 1 473 5 is_stmt 1
 474:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 4198              		.loc 1 474 5
 475:RGB2YCbCr.c   **** 
 4199              		.loc 1 475 5
 4200              		.loc 1 478 5
 4201              		.loc 1 478 66 is_stmt 0
 4202 2d96 478D2C09 		leal	(%r9,%r9), %r13d
 4203 2d9a 44894DB0 		movl	%r9d, -80(%rbp)
 4204 2d9e 438D740D 		leal	0(%r13,%r9), %esi
 4204      00
 4205              	.LVL209:
 479:RGB2YCbCr.c   ****     Gpixels = Rpixels + 1*width*height;
 480:RGB2YCbCr.c   ****     Bpixels = Rpixels + 2*width*height;
 4206              		.loc 1 480 32
 4207 2da3 4D63ED   		movslq	%r13d, %r13
 478:RGB2YCbCr.c   ****     Gpixels = Rpixels + 1*width*height;
 4208              		.loc 1 478 33
 4209 2da6 4863F6   		movslq	%esi, %rsi
 4210 2da9 488975A0 		movq	%rsi, -96(%rbp)
 4211 2dad E8000000 		call	aligned_alloc
 4211      00
 4212              	.LVL210:
 479:RGB2YCbCr.c   ****     Gpixels = Rpixels + 1*width*height;
 4213              		.loc 1 479 32
 4214 2db2 486355B0 		movslq	-80(%rbp), %rdx
 481:RGB2YCbCr.c   **** 
 482:RGB2YCbCr.c   ****     Ypixels = (unsigned char *) aligned_alloc(SIMD_ALIGN, 3*width*height);
 4215              		.loc 1 482 33
 4216 2db6 488B75A0 		movq	-96(%rbp), %rsi
 4217 2dba BF200000 		movl	$32, %edi
 4217      00
 478:RGB2YCbCr.c   ****     Gpixels = Rpixels + 1*width*height;
 4218              		.loc 1 478 33
 4219 2dbf 4989C4   		movq	%rax, %r12
 4220              	.LVL211:
 479:RGB2YCbCr.c   ****     Bpixels = Rpixels + 2*width*height;
 4221              		.loc 1 479 5 is_stmt 1
 480:RGB2YCbCr.c   **** 
 4222              		.loc 1 480 13 is_stmt 0
 4223 2dc2 4E8D3428 		leaq	(%rax,%r13), %r14
 479:RGB2YCbCr.c   ****     Bpixels = Rpixels + 2*width*height;
 4224              		.loc 1 479 32
 4225 2dc6 8955A8   		movl	%edx, -88(%rbp)
 479:RGB2YCbCr.c   ****     Bpixels = Rpixels + 2*width*height;
 4226              		.loc 1 479 13
 4227 2dc9 4C8D3C10 		leaq	(%rax,%rdx), %r15
 4228 2dcd 488955B0 		movq	%rdx, -80(%rbp)
 4229              	.LVL212:
 480:RGB2YCbCr.c   **** 
 4230              		.loc 1 480 5 is_stmt 1
 4231              		.loc 1 482 5
 4232              		.loc 1 482 33 is_stmt 0
 4233 2dd1 E8000000 		call	aligned_alloc
 4233      00
 4234              	.LVL213:
 483:RGB2YCbCr.c   ****     Cbpixels = Ypixels + 1*width*height;
 4235              		.loc 1 483 5 is_stmt 1
 4236              		.loc 1 483 14 is_stmt 0
 4237 2dd6 488B55B0 		movq	-80(%rbp), %rdx
 484:RGB2YCbCr.c   ****     Crpixels = Ypixels + 2*width*height;
 4238              		.loc 1 484 14
 4239 2dda 4901C5   		addq	%rax, %r13
 4240 2ddd 488945B0 		movq	%rax, -80(%rbp)
 483:RGB2YCbCr.c   ****     Cbpixels = Ypixels + 1*width*height;
 4241              		.loc 1 483 14
 4242 2de1 4801C2   		addq	%rax, %rdx
 485:RGB2YCbCr.c   **** 
 486:RGB2YCbCr.c   ****     start_t = get_wall_time();
 4243              		.loc 1 486 15
 4244 2de4 31C0     		xorl	%eax, %eax
 4245              	.LVL214:
 483:RGB2YCbCr.c   ****     Crpixels = Ypixels + 2*width*height;
 4246              		.loc 1 483 14
 4247 2de6 48895598 		movq	%rdx, -104(%rbp)
 4248              	.LVL215:
 484:RGB2YCbCr.c   ****     Crpixels = Ypixels + 2*width*height;
 4249              		.loc 1 484 5 is_stmt 1
 4250              		.loc 1 486 5
 4251              		.loc 1 486 15 is_stmt 0
 4252 2dea E8000000 		call	get_wall_time
 4252      00
 4253              	.LVL216:
 4254 2def 448B4DA8 		movl	-88(%rbp), %r9d
 4255 2df3 4C8B45B0 		movq	-80(%rbp), %r8
 4256 2df7 C78578FF 		movl	$10, -136(%rbp)
 4256      FFFF0A00 
 4256      0000
 4257 2e01 C57D6F3D 		vmovdqa	.LC34(%rip), %ymm15
 4257      00000000 
 4258 2e09 488B5598 		movq	-104(%rbp), %rdx
 4259 2e0d C5FB1185 		vmovsd	%xmm0, -144(%rbp)
 4259      70FFFFFF 
 4260              	.LVL217:
 487:RGB2YCbCr.c   ****     for (int it=0; it < NITER; it++)
 4261              		.loc 1 487 5 is_stmt 1
 4262              	.LBB53:
 4263              		.loc 1 487 10
 4264              		.loc 1 487 20
 4265 2e15 4589CA   		movl	%r9d, %r10d
 4266 2e18 418D41FF 		leal	-1(%r9), %eax
 4267 2e1c 41C1EA05 		shrl	$5, %r10d
 4268 2e20 8945A0   		movl	%eax, -96(%rbp)
 4269 2e23 49C1E205 		salq	$5, %r10
 4270 2e27 4B8D0422 		leaq	(%r10,%r12), %rax
 4271 2e2b 488945A8 		movq	%rax, -88(%rbp)
 4272 2e2f 4489C8   		movl	%r9d, %eax
 4273 2e32 83E0E0   		andl	$-32, %eax
 4274 2e35 89857CFF 		movl	%eax, -132(%rbp)
 4274      FFFF
 4275 2e3b 4C89E8   		movq	%r13, %rax
 4276 2e3e 4D89C5   		movq	%r8, %r13
 4277              	.LVL218:
 4278 2e41 4989C0   		movq	%rax, %r8
 4279              	.LVL219:
 4280              		.p2align 4,,10
 4281 2e44 0F1F4000 		.p2align 3
 4282              	.L111:
 4283              	.LBB54:
 488:RGB2YCbCr.c   ****     {
 489:RGB2YCbCr.c   ****         /* transformaci贸n AoS -> SoA */
 490:RGB2YCbCr.c   ****         /* COMPLETAR ... */
 491:RGB2YCbCr.c   ****         #pragma GCC ivdep
 492:RGB2YCbCr.c   ****         for (int i = 0; i < height*width; i++)
 4284              		.loc 1 492 25
 4285              		.loc 1 492 9 is_stmt 0
 4286 2e48 4585C9   		testl	%r9d, %r9d
 4287 2e4b 0F8EC506 		jle	.L123
 4287      0000
 493:RGB2YCbCr.c   ****         {
 494:RGB2YCbCr.c   ****             Rpixels[i] = image_in->pixels[3*i + 0];
 4288              		.loc 1 494 13
 4289 2e51 488B4580 		movq	-128(%rbp), %rax
 4290 2e55 837DA01E 		cmpl	$30, -96(%rbp)
 4291 2e59 488B00   		movq	(%rax), %rax
 4292 2e5c 0F865107 		jbe	.L124
 4292      0000
 4293 2e62 4889C1   		movq	%rax, %rcx
 4294 2e65 4D89FB   		movq	%r15, %r11
 4295 2e68 4C89F7   		movq	%r14, %rdi
 4296 2e6b 4C89E6   		movq	%r12, %rsi
 4297              	.LVL220:
 4298 2e6e 6690     		.p2align 4,,10
 4299              		.p2align 3
 4300              	.L113:
 4301              		.loc 1 494 13 is_stmt 1 discriminator 3
 4302              		.loc 1 494 42 is_stmt 0 discriminator 3
 4303 2e70 C5FE6F01 		vmovdqu	(%rcx), %ymm0
 4304 2e74 4883C620 		addq	$32, %rsi
 4305 2e78 4883C160 		addq	$96, %rcx
 4306 2e7c 4983C320 		addq	$32, %r11
 4307 2e80 C5FE6F49 		vmovdqu	-32(%rcx), %ymm1
 4307      E0
 4308 2e85 C5FE6F59 		vmovdqu	-64(%rcx), %ymm3
 4308      C0
 4309 2e8a 4883C720 		addq	$32, %rdi
 4310 2e8e C4E27D00 		vpshufb	.LC13(%rip), %ymm0, %ymm2
 4310      15000000 
 4310      00
 4311 2e97 C4E26500 		vpshufb	.LC15(%rip), %ymm3, %ymm5
 4311      2D000000 
 4311      00
 4312 2ea0 C4E3FD00 		vpermq	$78, %ymm2, %ymm4
 4312      E24E
 4313 2ea6 C4E27D00 		vpshufb	.LC14(%rip), %ymm0, %ymm2
 4313      15000000 
 4313      00
 4314 2eaf C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 4315 2eb3 C4E27500 		vpshufb	.LC16(%rip), %ymm1, %ymm4
 4315      25000000 
 4315      00
 4316 2ebc C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 4317 2ec0 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 4317      EC4E
 4318 2ec6 C4E27500 		vpshufb	.LC18(%rip), %ymm1, %ymm4
 4318      25000000 
 4318      00
 4319 2ecf C4E26D00 		vpshufb	.LC17(%rip), %ymm2, %ymm2
 4319      15000000 
 4319      00
 4320 2ed8 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 4321 2edc C4E26500 		vpshufb	.LC21(%rip), %ymm3, %ymm5
 4321      2D000000 
 4321      00
 4322 2ee5 C4E26500 		vpshufb	.LC27(%rip), %ymm3, %ymm3
 4322      1D000000 
 4322      00
 4323 2eee C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 4324              		.loc 1 494 24 discriminator 3
 4325 2ef2 C5FD7F56 		vmovdqa	%ymm2, -32(%rsi)
 4325      E0
 495:RGB2YCbCr.c   **** 			Gpixels[i] = image_in->pixels[3*i + 1];
 4326              		.loc 1 495 4 is_stmt 1 discriminator 3
 494:RGB2YCbCr.c   **** 			Gpixels[i] = image_in->pixels[3*i + 1];
 4327              		.loc 1 494 42 is_stmt 0 discriminator 3
 4328 2ef7 C4E27D00 		vpshufb	.LC19(%rip), %ymm0, %ymm2
 4328      15000000 
 4328      00
 4329 2f00 C4E3FD00 		vpermq	$78, %ymm2, %ymm4
 4329      E24E
 4330 2f06 C4E27D00 		vpshufb	.LC20(%rip), %ymm0, %ymm2
 4330      15000000 
 4330      00
 4331 2f0f C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 4332 2f13 C4E27500 		vpshufb	.LC22(%rip), %ymm1, %ymm4
 4332      25000000 
 4332      00
 4333 2f1c C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 4334 2f20 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 4334      EC4E
 4335 2f26 C4E27500 		vpshufb	.LC24(%rip), %ymm1, %ymm4
 4335      25000000 
 4335      00
 4336 2f2f C4E26D00 		vpshufb	.LC23(%rip), %ymm2, %ymm2
 4336      15000000 
 4336      00
 4337 2f38 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 4338 2f3c C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 4339              		.loc 1 495 15 discriminator 3
 4340 2f40 C4C17E7F 		vmovdqu	%ymm2, -32(%r11)
 4340      53E0
 496:RGB2YCbCr.c   **** 			Bpixels[i] = image_in->pixels[3*i + 2];
 4341              		.loc 1 496 4 is_stmt 1 discriminator 3
 494:RGB2YCbCr.c   **** 			Gpixels[i] = image_in->pixels[3*i + 1];
 4342              		.loc 1 494 42 is_stmt 0 discriminator 3
 4343 2f46 C4E27D00 		vpshufb	.LC25(%rip), %ymm0, %ymm2
 4343      15000000 
 4343      00
 4344 2f4f C4E27D00 		vpshufb	.LC26(%rip), %ymm0, %ymm0
 4344      05000000 
 4344      00
 4345 2f58 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 4345      D24E
 4346 2f5e C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 4347 2f62 C4E27500 		vpshufb	.LC28(%rip), %ymm1, %ymm2
 4347      15000000 
 4347      00
 4348 2f6b C4E27500 		vpshufb	.LC29(%rip), %ymm1, %ymm1
 4348      0D000000 
 4348      00
 4349 2f74 C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 4350 2f78 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 4350      D24E
 4351 2f7e C4E27D00 		vpshufb	.LC23(%rip), %ymm0, %ymm0
 4351      05000000 
 4351      00
 4352 2f87 C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 4353 2f8b C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 4354              		.loc 1 496 15 discriminator 3
 4355 2f8f C5FE7F47 		vmovdqu	%ymm0, -32(%rdi)
 4355      E0
 492:RGB2YCbCr.c   ****         {
 4356              		.loc 1 492 43 is_stmt 1 discriminator 3
 492:RGB2YCbCr.c   ****         {
 4357              		.loc 1 492 25 discriminator 3
 4358 2f94 483B75A8 		cmpq	-88(%rbp), %rsi
 4359 2f98 0F85D2FE 		jne	.L113
 4359      FFFF
 4360 2f9e 8BB57CFF 		movl	-132(%rbp), %esi
 4360      FFFF
 4361 2fa4 4139F1   		cmpl	%esi, %r9d
 4362 2fa7 743C     		je	.L114
 4363              	.L112:
 4364 2fa9 4863CE   		movslq	%esi, %rcx
 4365 2fac 8D3476   		leal	(%rsi,%rsi,2), %esi
 4366 2faf 4863F6   		movslq	%esi, %rsi
 4367 2fb2 4801F0   		addq	%rsi, %rax
 4368              		.p2align 4,,10
 4369 2fb5 0F1F00   		.p2align 3
 4370              	.L115:
 4371              	.LVL221:
 494:RGB2YCbCr.c   **** 			Gpixels[i] = image_in->pixels[3*i + 1];
 4372              		.loc 1 494 13
 494:RGB2YCbCr.c   **** 			Gpixels[i] = image_in->pixels[3*i + 1];
 4373              		.loc 1 494 24 is_stmt 0
 4374 2fb8 0FB630   		movzbl	(%rax), %esi
 4375 2fbb 4883C003 		addq	$3, %rax
 4376 2fbf 4188340C 		movb	%sil, (%r12,%rcx)
 495:RGB2YCbCr.c   **** 			Bpixels[i] = image_in->pixels[3*i + 2];
 4377              		.loc 1 495 4 is_stmt 1
 495:RGB2YCbCr.c   **** 			Bpixels[i] = image_in->pixels[3*i + 2];
 4378              		.loc 1 495 15 is_stmt 0
 4379 2fc3 0FB670FE 		movzbl	-2(%rax), %esi
 4380 2fc7 4188340F 		movb	%sil, (%r15,%rcx)
 4381              		.loc 1 496 4 is_stmt 1
 4382              		.loc 1 496 15 is_stmt 0
 4383 2fcb 0FB670FF 		movzbl	-1(%rax), %esi
 4384 2fcf 4188340E 		movb	%sil, (%r14,%rcx)
 492:RGB2YCbCr.c   ****         {
 4385              		.loc 1 492 43 is_stmt 1
 4386              	.LVL222:
 492:RGB2YCbCr.c   ****         {
 4387              		.loc 1 492 25
 4388 2fd3 48FFC1   		incq	%rcx
 4389              	.LVL223:
 492:RGB2YCbCr.c   ****         {
 4390              		.loc 1 492 9 is_stmt 0
 4391 2fd6 4139C9   		cmpl	%ecx, %r9d
 4392 2fd9 7FDD     		jg	.L115
 4393 2fdb 837DA01E 		cmpl	$30, -96(%rbp)
 4394 2fdf 0F86C705 		jbe	.L125
 4394      0000
 4395              	.L114:
 492:RGB2YCbCr.c   ****         {
 4396              		.loc 1 492 18
 4397 2fe5 31C0     		xorl	%eax, %eax
 4398 2fe7 660F1F84 		.p2align 4,,10
 4398      00000000 
 4398      00
 4399              		.p2align 3
 4400              	.L117:
 4401              	.LBE54:
 4402              	.LBB55:
 497:RGB2YCbCr.c   ****         }
 498:RGB2YCbCr.c   **** 
 499:RGB2YCbCr.c   ****         /* COMPLETAR ... */
 500:RGB2YCbCr.c   ****         #pragma GCC ivdep
 501:RGB2YCbCr.c   ****         for (int i = 0; i < height*width; i++)
 502:RGB2YCbCr.c   ****         {
 503:RGB2YCbCr.c   ****             Ypixels[i] = (unsigned char) (0.5f + 
 4403              		.loc 1 503 13 is_stmt 1 discriminator 3
 504:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 4404              		.loc 1 505 40 is_stmt 0 discriminator 3
 4405 2ff0 C4C17D6F 		vmovdqa	(%r12,%rax), %ymm7
 4405      3C04
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4406              		.loc 1 506 40 discriminator 3
 4407 2ff6 C4427D30 		vpmovzxbw	(%r15,%rax), %ymm8
 4407      0407
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4408              		.loc 1 505 40 discriminator 3
 4409 2ffc C4C27D30 		vpmovzxbw	(%r12,%rax), %ymm2
 4409      1404
 507:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4410              		.loc 1 507 40 discriminator 3
 4411 3002 C4C17E6F 		vmovdqu	(%r14,%rax), %ymm4
 4411      2406
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4412              		.loc 1 505 40 discriminator 3
 4413 3008 C4E37D39 		vextracti128	$0x1, %ymm7, %xmm3
 4413      FB01
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4414              		.loc 1 506 40 discriminator 3
 4415 300e C4427D33 		vpmovzxwd	%xmm8, %ymm12
 4415      E0
 4416 3013 C4C17E6F 		vmovdqu	(%r15,%rax), %ymm7
 4416      3C07
 4417 3019 C4437D39 		vextracti128	$0x1, %ymm8, %xmm8
 4417      C001
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4418              		.loc 1 505 40 discriminator 3
 4419 301f C4E27D30 		vpmovzxbw	%xmm3, %ymm3
 4419      DB
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4420              		.loc 1 506 32 discriminator 3
 4421 3024 C4417C5B 		vcvtdq2ps	%ymm12, %ymm12
 4421      E4
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4422              		.loc 1 505 40 discriminator 3
 4423 3029 C4E27D33 		vpmovzxwd	%xmm2, %ymm0
 4423      C2
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4424              		.loc 1 506 40 discriminator 3
 4425 302e C4427D33 		vpmovzxwd	%xmm8, %ymm8
 4425      C0
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4426              		.loc 1 505 40 discriminator 3
 4427 3033 C4E27D33 		vpmovzxwd	%xmm3, %ymm1
 4427      CB
 4428 3038 C4E37D39 		vextracti128	$0x1, %ymm3, %xmm3
 4428      DB01
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4429              		.loc 1 505 32 discriminator 3
 4430 303e C5FC5BC0 		vcvtdq2ps	%ymm0, %ymm0
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4431              		.loc 1 506 40 discriminator 3
 4432 3042 C4E37D39 		vextracti128	$0x1, %ymm7, %xmm5
 4432      FD01
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4433              		.loc 1 505 40 discriminator 3
 4434 3048 C4E27D33 		vpmovzxwd	%xmm3, %ymm3
 4434      DB
 4435              		.loc 1 507 40 discriminator 3
 4436 304d C4C27D30 		vpmovzxbw	(%r14,%rax), %ymm7
 4436      3C06
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4437              		.loc 1 506 32 discriminator 3
 4438 3053 C4417C5B 		vcvtdq2ps	%ymm8, %ymm8
 4438      C0
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4439              		.loc 1 505 40 discriminator 3
 4440 3058 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 4440      D201
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4441              		.loc 1 505 32 discriminator 3
 4442 305e C57C5BF3 		vcvtdq2ps	%ymm3, %ymm14
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4443              		.loc 1 505 40 discriminator 3
 4444 3062 C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 4444      D2
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4445              		.loc 1 506 40 discriminator 3
 4446 3067 C4E27D30 		vpmovzxbw	%xmm5, %ymm5
 4446      ED
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4447              		.loc 1 505 32 discriminator 3
 4448 306c C5FC5BC9 		vcvtdq2ps	%ymm1, %ymm1
 4449              		.loc 1 507 40 discriminator 3
 4450 3070 C4627D33 		vpmovzxwd	%xmm7, %ymm11
 4450      DF
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4451              		.loc 1 505 32 discriminator 3
 4452 3075 C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 4453              		.loc 1 507 40 discriminator 3
 4454 3079 C4E37D39 		vextracti128	$0x1, %ymm7, %xmm7
 4454      FF01
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4455              		.loc 1 506 40 discriminator 3
 4456 307f C4627D33 		vpmovzxwd	%xmm5, %ymm10
 4456      D5
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4457              		.loc 1 506 32 discriminator 3
 4458 3084 C59C591D 		vmulps	.LC31(%rip), %ymm12, %ymm3
 4458      00000000 
 4459              		.loc 1 507 32 discriminator 3
 4460 308c C4417C5B 		vcvtdq2ps	%ymm11, %ymm11
 4460      DB
 4461              		.loc 1 507 40 discriminator 3
 4462 3091 C4E27D33 		vpmovzxwd	%xmm7, %ymm7
 4462      FF
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4463              		.loc 1 506 32 discriminator 3
 4464 3096 C4417C5B 		vcvtdq2ps	%ymm10, %ymm10
 4464      D2
 4465              		.loc 1 507 32 discriminator 3
 4466 309b C5FC5BFF 		vcvtdq2ps	%ymm7, %ymm7
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4467              		.loc 1 505 32 discriminator 3
 4468 309f C5FC5935 		vmulps	.LC30(%rip), %ymm0, %ymm6
 4468      00000000 
 4469              		.loc 1 507 40 discriminator 3
 4470 30a7 C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 4470      E401
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4471              		.loc 1 506 40 discriminator 3
 4472 30ad C4E37D39 		vextracti128	$0x1, %ymm5, %xmm5
 4472      ED01
 4473              		.loc 1 507 40 discriminator 3
 4474 30b3 C4E27D30 		vpmovzxbw	%xmm4, %ymm4
 4474      E4
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4475              		.loc 1 506 40 discriminator 3
 4476 30b8 C4E27D33 		vpmovzxwd	%xmm5, %ymm5
 4476      ED
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4477              		.loc 1 505 32 discriminator 3
 4478 30bd C57C2975 		vmovaps	%ymm14, -80(%rbp)
 4478      B0
 504:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 4479              		.loc 1 504 37 discriminator 3
 4480 30c2 C5CC5835 		vaddps	.LC38(%rip), %ymm6, %ymm6
 4480      00000000 
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4481              		.loc 1 505 32 discriminator 3
 4482 30ca C56C592D 		vmulps	.LC30(%rip), %ymm2, %ymm13
 4482      00000000 
 4483              		.loc 1 507 40 discriminator 3
 4484 30d2 C4627D33 		vpmovzxwd	%xmm4, %ymm9
 4484      CC
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4485              		.loc 1 506 32 discriminator 3
 4486 30d7 C5FC5BED 		vcvtdq2ps	%ymm5, %ymm5
 4487              		.loc 1 507 40 discriminator 3
 4488 30db C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 4488      E401
 504:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 4489              		.loc 1 504 37 discriminator 3
 4490 30e1 C514582D 		vaddps	.LC38(%rip), %ymm13, %ymm13
 4490      00000000 
 4491              		.loc 1 507 32 discriminator 3
 4492 30e9 C4417C5B 		vcvtdq2ps	%ymm9, %ymm9
 4492      C9
 4493              		.loc 1 507 40 discriminator 3
 4494 30ee C4E27D33 		vpmovzxwd	%xmm4, %ymm4
 4494      E4
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4495              		.loc 1 505 44 discriminator 3
 4496 30f3 C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 4497              		.loc 1 507 32 discriminator 3
 4498 30f7 C5A4591D 		vmulps	.LC32(%rip), %ymm11, %ymm3
 4498      00000000 
 4499 30ff C5FC5BE4 		vcvtdq2ps	%ymm4, %ymm4
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4500              		.loc 1 506 44 discriminator 3
 4501 3103 C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4502              		.loc 1 506 32 discriminator 3
 4503 3107 C5BC591D 		vmulps	.LC31(%rip), %ymm8, %ymm3
 4503      00000000 
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4504              		.loc 1 503 26 discriminator 3
 4505 310f C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4506              		.loc 1 505 44 discriminator 3
 4507 3113 C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 4508              		.loc 1 507 32 discriminator 3
 4509 3117 C5C4591D 		vmulps	.LC32(%rip), %ymm7, %ymm3
 4509      00000000 
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4510              		.loc 1 506 44 discriminator 3
 4511 311f C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4512              		.loc 1 503 26 discriminator 3
 4513 3123 C585DBDE 		vpand	%ymm6, %ymm15, %ymm3
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4514              		.loc 1 505 32 discriminator 3
 4515 3127 C5F45935 		vmulps	.LC30(%rip), %ymm1, %ymm6
 4515      00000000 
 504:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 4516              		.loc 1 504 37 discriminator 3
 4517 312f C5CC5835 		vaddps	.LC38(%rip), %ymm6, %ymm6
 4517      00000000 
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4518              		.loc 1 503 26 discriminator 3
 4519 3137 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 4519      ED
 4520 313c C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 4520      ED
 4521 3141 C4C2652B 		vpackusdw	%ymm13, %ymm3, %ymm3
 4521      DD
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4522              		.loc 1 506 32 discriminator 3
 4523 3146 C52C592D 		vmulps	.LC31(%rip), %ymm10, %ymm13
 4523      00000000 
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4524              		.loc 1 503 26 discriminator 3
 4525 314e C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 4525      DBD8
 4526 3154 C5E5DB1D 		vpand	.LC35(%rip), %ymm3, %ymm3
 4526      00000000 
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4527              		.loc 1 505 44 discriminator 3
 4528 315c C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 4528      F5
 4529              		.loc 1 507 32 discriminator 3
 4530 3161 C534592D 		vmulps	.LC32(%rip), %ymm9, %ymm13
 4530      00000000 
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4531              		.loc 1 506 44 discriminator 3
 4532 3169 C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 4532      F5
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4533              		.loc 1 505 32 discriminator 3
 4534 316e C50C592D 		vmulps	.LC30(%rip), %ymm14, %ymm13
 4534      00000000 
 504:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 4535              		.loc 1 504 37 discriminator 3
 4536 3176 C5145835 		vaddps	.LC38(%rip), %ymm13, %ymm14
 4536      00000000 
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4537              		.loc 1 506 32 discriminator 3
 4538 317e C554592D 		vmulps	.LC31(%rip), %ymm5, %ymm13
 4538      00000000 
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4539              		.loc 1 503 26 discriminator 3
 4540 3186 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 4541 318a C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4542              		.loc 1 505 44 discriminator 3
 4543 318e C4410C58 		vaddps	%ymm13, %ymm14, %ymm13
 4543      ED
 4544              		.loc 1 507 32 discriminator 3
 4545 3193 C55C5935 		vmulps	.LC32(%rip), %ymm4, %ymm14
 4545      00000000 
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4546              		.loc 1 506 44 discriminator 3
 4547 319b C4411458 		vaddps	%ymm14, %ymm13, %ymm13
 4547      EE
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4548              		.loc 1 503 26 discriminator 3
 4549 31a0 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 4549      ED
 4550 31a5 C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 4550      ED
 4551 31aa C4C24D2B 		vpackusdw	%ymm13, %ymm6, %ymm6
 4551      F5
 508:RGB2YCbCr.c   ****             Cbpixels[i] = (unsigned char) (0.5f + 
 509:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 510:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 4552              		.loc 1 510 32 discriminator 3
 4553 31af C56C592D 		vmulps	.LC36(%rip), %ymm2, %ymm13
 4553      00000000 
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4554              		.loc 1 503 26 discriminator 3
 4555 31b7 C4E3FD00 		vpermq	$216, %ymm6, %ymm6
 4555      F6D8
 4556 31bd C5CDDB35 		vpand	.LC35(%rip), %ymm6, %ymm6
 4556      00000000 
 509:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 4557              		.loc 1 509 37 discriminator 3
 4558 31c5 C514582D 		vaddps	.LC64(%rip), %ymm13, %ymm13
 4558      00000000 
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4559              		.loc 1 503 26 discriminator 3
 4560 31cd C5E567DE 		vpackuswb	%ymm6, %ymm3, %ymm3
 4561              		.loc 1 510 32 discriminator 3
 4562 31d1 C5FC5935 		vmulps	.LC36(%rip), %ymm0, %ymm6
 4562      00000000 
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4563              		.loc 1 503 26 discriminator 3
 4564 31d9 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 4564      DBD8
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4565              		.loc 1 503 24 discriminator 3
 4566 31df C4C17D7F 		vmovdqa	%ymm3, 0(%r13,%rax)
 4566      5C0500
 508:RGB2YCbCr.c   ****             Cbpixels[i] = (unsigned char) (0.5f + 
 4567              		.loc 1 508 13 is_stmt 1 discriminator 3
 511:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4568              		.loc 1 511 32 is_stmt 0 discriminator 3
 4569 31e6 C59C591D 		vmulps	.LC37(%rip), %ymm12, %ymm3
 4569      00000000 
 509:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 4570              		.loc 1 509 37 discriminator 3
 4571 31ee C5CC5835 		vaddps	.LC64(%rip), %ymm6, %ymm6
 4571      00000000 
 510:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4572              		.loc 1 510 44 discriminator 3
 4573 31f6 C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 512:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 4574              		.loc 1 512 32 discriminator 3
 4575 31fa C5A4591D 		vmulps	.LC38(%rip), %ymm11, %ymm3
 4575      00000000 
 511:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4576              		.loc 1 511 44 discriminator 3
 4577 3202 C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 511:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4578              		.loc 1 511 32 discriminator 3
 4579 3206 C5BC591D 		vmulps	.LC37(%rip), %ymm8, %ymm3
 4579      00000000 
 510:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4580              		.loc 1 510 32 discriminator 3
 4581 320e C57C2875 		vmovaps	-80(%rbp), %ymm14
 4581      B0
 513:RGB2YCbCr.c   ****             Crpixels[i] = (unsigned char) (0.5f + 
 514:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 515:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 516:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 4582              		.loc 1 516 32 discriminator 3
 4583 3213 C53C5905 		vmulps	.LC40(%rip), %ymm8, %ymm8
 4583      00000000 
 515:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 4584              		.loc 1 515 32 discriminator 3
 4585 321b C5EC5915 		vmulps	.LC38(%rip), %ymm2, %ymm2
 4585      00000000 
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4586              		.loc 1 508 27 discriminator 3
 4587 3223 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 514:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 4588              		.loc 1 514 37 discriminator 3
 4589 3227 C5EC5815 		vaddps	.LC64(%rip), %ymm2, %ymm2
 4589      00000000 
 4590              		.loc 1 516 32 discriminator 3
 4591 322f C51C5925 		vmulps	.LC40(%rip), %ymm12, %ymm12
 4591      00000000 
 515:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 4592              		.loc 1 515 32 discriminator 3
 4593 3237 C5FC5905 		vmulps	.LC38(%rip), %ymm0, %ymm0
 4593      00000000 
 510:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4594              		.loc 1 510 44 discriminator 3
 4595 323f C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 512:RGB2YCbCr.c   ****             Crpixels[i] = (unsigned char) (0.5f + 
 4596              		.loc 1 512 32 discriminator 3
 4597 3243 C5C4591D 		vmulps	.LC38(%rip), %ymm7, %ymm3
 4597      00000000 
 514:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 4598              		.loc 1 514 37 discriminator 3
 4599 324b C5FC5805 		vaddps	.LC64(%rip), %ymm0, %ymm0
 4599      00000000 
 515:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 4600              		.loc 1 515 44 discriminator 3
 4601 3253 C4416C58 		vaddps	%ymm8, %ymm2, %ymm8
 4601      C0
 517:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 4602              		.loc 1 517 32 discriminator 3
 4603 3258 C524591D 		vmulps	.LC41(%rip), %ymm11, %ymm11
 4603      00000000 
 4604 3260 C5C4593D 		vmulps	.LC41(%rip), %ymm7, %ymm7
 4604      00000000 
 515:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 4605              		.loc 1 515 44 discriminator 3
 4606 3268 C4417C58 		vaddps	%ymm12, %ymm0, %ymm12
 4606      E4
 511:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 4607              		.loc 1 511 44 discriminator 3
 4608 326d C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4609              		.loc 1 508 27 discriminator 3
 4610 3271 C585DBDE 		vpand	%ymm6, %ymm15, %ymm3
 510:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4611              		.loc 1 510 32 discriminator 3
 4612 3275 C5F45935 		vmulps	.LC36(%rip), %ymm1, %ymm6
 4612      00000000 
 516:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 4613              		.loc 1 516 44 discriminator 3
 4614 327d C4411C58 		vaddps	%ymm11, %ymm12, %ymm11
 4614      DB
 509:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 4615              		.loc 1 509 37 discriminator 3
 4616 3282 C5CC5835 		vaddps	.LC64(%rip), %ymm6, %ymm6
 4616      00000000 
 515:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 4617              		.loc 1 515 32 discriminator 3
 4618 328a C5F4590D 		vmulps	.LC38(%rip), %ymm1, %ymm1
 4618      00000000 
 516:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 4619              		.loc 1 516 44 discriminator 3
 4620 3292 C5BC58FF 		vaddps	%ymm7, %ymm8, %ymm7
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4621              		.loc 1 508 27 discriminator 3
 4622 3296 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 4622      ED
 4623 329b C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 4623      ED
 514:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 4624              		.loc 1 514 37 discriminator 3
 4625 32a0 C5F4580D 		vaddps	.LC64(%rip), %ymm1, %ymm1
 4625      00000000 
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4626              		.loc 1 508 27 discriminator 3
 4627 32a8 C4C2652B 		vpackusdw	%ymm13, %ymm3, %ymm3
 4627      DD
 513:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 4628              		.loc 1 513 27 discriminator 3
 4629 32ad C4C17E5B 		vcvttps2dq	%ymm11, %ymm0
 4629      C3
 4630 32b2 C585DBC0 		vpand	%ymm0, %ymm15, %ymm0
 511:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 4631              		.loc 1 511 32 discriminator 3
 4632 32b6 C52C592D 		vmulps	.LC37(%rip), %ymm10, %ymm13
 4632      00000000 
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4633              		.loc 1 508 27 discriminator 3
 4634 32be C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 4634      DBD8
 513:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 4635              		.loc 1 513 27 discriminator 3
 4636 32c4 C5FE5BFF 		vcvttps2dq	%ymm7, %ymm7
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4637              		.loc 1 508 27 discriminator 3
 4638 32c8 C5E5DB1D 		vpand	.LC35(%rip), %ymm3, %ymm3
 4638      00000000 
 516:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 4639              		.loc 1 516 32 discriminator 3
 4640 32d0 C52C5915 		vmulps	.LC40(%rip), %ymm10, %ymm10
 4640      00000000 
 513:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 4641              		.loc 1 513 27 discriminator 3
 4642 32d8 C585DBFF 		vpand	%ymm7, %ymm15, %ymm7
 4643 32dc C4E27D2B 		vpackusdw	%ymm7, %ymm0, %ymm0
 4643      C7
 4644 32e1 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 4644      C0D8
 4645 32e7 C5FDDB05 		vpand	.LC35(%rip), %ymm0, %ymm0
 4645      00000000 
 510:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4646              		.loc 1 510 44 discriminator 3
 4647 32ef C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 4647      F5
 512:RGB2YCbCr.c   ****             Crpixels[i] = (unsigned char) (0.5f + 
 4648              		.loc 1 512 32 discriminator 3
 4649 32f4 C534592D 		vmulps	.LC38(%rip), %ymm9, %ymm13
 4649      00000000 
 4650              		.loc 1 517 32 discriminator 3
 4651 32fc C534590D 		vmulps	.LC41(%rip), %ymm9, %ymm9
 4651      00000000 
 515:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 4652              		.loc 1 515 44 discriminator 3
 4653 3304 C4C17458 		vaddps	%ymm10, %ymm1, %ymm1
 4653      CA
 511:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 4654              		.loc 1 511 44 discriminator 3
 4655 3309 C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 4655      F5
 510:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4656              		.loc 1 510 32 discriminator 3
 4657 330e C50C592D 		vmulps	.LC36(%rip), %ymm14, %ymm13
 4657      00000000 
 509:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 4658              		.loc 1 509 37 discriminator 3
 4659 3316 C5145835 		vaddps	.LC64(%rip), %ymm13, %ymm14
 4659      00000000 
 511:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 4660              		.loc 1 511 32 discriminator 3
 4661 331e C554592D 		vmulps	.LC37(%rip), %ymm5, %ymm13
 4661      00000000 
 516:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 4662              		.loc 1 516 44 discriminator 3
 4663 3326 C4C17458 		vaddps	%ymm9, %ymm1, %ymm1
 4663      C9
 516:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 4664              		.loc 1 516 32 discriminator 3
 4665 332b C5D4592D 		vmulps	.LC40(%rip), %ymm5, %ymm5
 4665      00000000 
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4666              		.loc 1 508 27 discriminator 3
 4667 3333 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 4668 3337 C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 513:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 4669              		.loc 1 513 27 discriminator 3
 4670 333b C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 4671 333f C585DBC9 		vpand	%ymm1, %ymm15, %ymm1
 510:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4672              		.loc 1 510 44 discriminator 3
 4673 3343 C4410C58 		vaddps	%ymm13, %ymm14, %ymm13
 4673      ED
 512:RGB2YCbCr.c   ****             Crpixels[i] = (unsigned char) (0.5f + 
 4674              		.loc 1 512 32 discriminator 3
 4675 3348 C55C5935 		vmulps	.LC38(%rip), %ymm4, %ymm14
 4675      00000000 
 4676              		.loc 1 517 32 discriminator 3
 4677 3350 C5DC5925 		vmulps	.LC41(%rip), %ymm4, %ymm4
 4677      00000000 
 511:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 4678              		.loc 1 511 44 discriminator 3
 4679 3358 C4411458 		vaddps	%ymm14, %ymm13, %ymm13
 4679      EE
 515:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 4680              		.loc 1 515 32 discriminator 3
 4681 335d C57C2875 		vmovaps	-80(%rbp), %ymm14
 4681      B0
 4682 3362 C58C5915 		vmulps	.LC38(%rip), %ymm14, %ymm2
 4682      00000000 
 514:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 4683              		.loc 1 514 37 discriminator 3
 4684 336a C5EC5815 		vaddps	.LC64(%rip), %ymm2, %ymm2
 4684      00000000 
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4685              		.loc 1 508 27 discriminator 3
 4686 3372 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 4686      ED
 4687 3377 C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 4687      ED
 515:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 4688              		.loc 1 515 44 discriminator 3
 4689 337c C5EC58ED 		vaddps	%ymm5, %ymm2, %ymm5
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4690              		.loc 1 508 27 discriminator 3
 4691 3380 C4C24D2B 		vpackusdw	%ymm13, %ymm6, %ymm6
 4691      F5
 4692 3385 C4E3FD00 		vpermq	$216, %ymm6, %ymm6
 4692      F6D8
 4693 338b C5CDDB35 		vpand	.LC35(%rip), %ymm6, %ymm6
 4693      00000000 
 516:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 4694              		.loc 1 516 44 discriminator 3
 4695 3393 C5D458E4 		vaddps	%ymm4, %ymm5, %ymm4
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4696              		.loc 1 508 27 discriminator 3
 4697 3397 C5E567DE 		vpackuswb	%ymm6, %ymm3, %ymm3
 4698 339b C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 4698      DBD8
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4699              		.loc 1 508 25 discriminator 3
 4700 33a1 C5FE7F1C 		vmovdqu	%ymm3, (%rdx,%rax)
 4700      02
 513:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 4701              		.loc 1 513 13 is_stmt 1 discriminator 3
 513:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 4702              		.loc 1 513 27 is_stmt 0 discriminator 3
 4703 33a6 C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 4704 33aa C585DBE4 		vpand	%ymm4, %ymm15, %ymm4
 4705 33ae C4E2752B 		vpackusdw	%ymm4, %ymm1, %ymm1
 4705      CC
 4706 33b3 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 4706      C9D8
 4707 33b9 C5F5DB0D 		vpand	.LC35(%rip), %ymm1, %ymm1
 4707      00000000 
 4708 33c1 C5FD67C9 		vpackuswb	%ymm1, %ymm0, %ymm1
 4709 33c5 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 4709      C9D8
 513:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 4710              		.loc 1 513 25 discriminator 3
 4711 33cb C4C17E7F 		vmovdqu	%ymm1, (%r8,%rax)
 4711      0C00
 501:RGB2YCbCr.c   ****         {
 4712              		.loc 1 501 43 is_stmt 1 discriminator 3
 501:RGB2YCbCr.c   ****         {
 4713              		.loc 1 501 25 discriminator 3
 4714 33d1 4883C020 		addq	$32, %rax
 4715 33d5 4C39D0   		cmpq	%r10, %rax
 4716 33d8 0F8512FC 		jne	.L117
 4716      FFFF
 4717 33de 48638D7C 		movslq	-132(%rbp), %rcx
 4717      FFFFFF
 4718 33e5 4139C9   		cmpl	%ecx, %r9d
 4719 33e8 0F84E700 		je	.L118
 4719      0000
 4720              	.L116:
 4721 33ee C57A1015 		vmovss	.LC1(%rip), %xmm10
 4721      00000000 
 4722 33f6 C5FA1015 		vmovss	.LC8(%rip), %xmm2
 4722      00000000 
 4723 33fe C57A100D 		vmovss	.LC3(%rip), %xmm9
 4723      00000000 
 4724 3406 C57A1005 		vmovss	.LC4(%rip), %xmm8
 4724      00000000 
 4725 340e C5FA103D 		vmovss	.LC5(%rip), %xmm7
 4725      00000000 
 4726 3416 C5FA101D 		vmovss	.LC65(%rip), %xmm3
 4726      00000000 
 4727 341e C5FA1035 		vmovss	.LC7(%rip), %xmm6
 4727      00000000 
 4728 3426 C5FA102D 		vmovss	.LC9(%rip), %xmm5
 4728      00000000 
 4729 342e C5FA1025 		vmovss	.LC10(%rip), %xmm4
 4729      00000000 
 4730 3436 662E0F1F 		.p2align 4,,10
 4730      84000000 
 4730      0000
 4731              		.p2align 3
 4732              	.L119:
 4733              	.LVL224:
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4734              		.loc 1 503 13
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4735              		.loc 1 505 40 is_stmt 0
 4736 3440 410FB604 		movzbl	(%r12,%rcx), %eax
 4736      0C
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4737              		.loc 1 505 32
 4738 3445 C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 4739 3449 C5F22AC0 		vcvtsi2ssl	%eax, %xmm1, %xmm0
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4740              		.loc 1 506 40
 4741 344d 410FB604 		movzbl	(%r15,%rcx), %eax
 4741      0F
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4742              		.loc 1 506 32
 4743 3452 C5722AD8 		vcvtsi2ssl	%eax, %xmm1, %xmm11
 507:RGB2YCbCr.c   ****             Cbpixels[i] = (unsigned char) (0.5f + 
 4744              		.loc 1 507 40
 4745 3456 410FB604 		movzbl	(%r14,%rcx), %eax
 4745      0E
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4746              		.loc 1 505 32
 4747 345b C4417A59 		vmulss	%xmm10, %xmm0, %xmm12
 4747      E2
 507:RGB2YCbCr.c   ****             Cbpixels[i] = (unsigned char) (0.5f + 
 4748              		.loc 1 507 32
 4749 3460 C5F22AC8 		vcvtsi2ssl	%eax, %xmm1, %xmm1
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4750              		.loc 1 506 32
 4751 3464 C4412259 		vmulss	%xmm9, %xmm11, %xmm13
 4751      E9
 504:RGB2YCbCr.c   ****                 RGB2YCbCr[0][0]*Rpixels[i] + 
 4752              		.loc 1 504 37
 4753 3469 C51A58E2 		vaddss	%xmm2, %xmm12, %xmm12
 505:RGB2YCbCr.c   ****                 RGB2YCbCr[0][1]*Gpixels[i] + 
 4754              		.loc 1 505 44
 4755 346d C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 4755      E5
 507:RGB2YCbCr.c   ****             Cbpixels[i] = (unsigned char) (0.5f + 
 4756              		.loc 1 507 32
 4757 3472 C4417259 		vmulss	%xmm8, %xmm1, %xmm13
 4757      E8
 506:RGB2YCbCr.c   ****                 RGB2YCbCr[0][2]*Bpixels[i]);
 4758              		.loc 1 506 44
 4759 3477 C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 4759      E5
 511:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 4760              		.loc 1 511 32
 4761 347c C52259EE 		vmulss	%xmm6, %xmm11, %xmm13
 516:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 4762              		.loc 1 516 32
 4763 3480 C52259DD 		vmulss	%xmm5, %xmm11, %xmm11
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4764              		.loc 1 503 26
 4765 3484 C4C17A2C 		vcvttss2sil	%xmm12, %eax
 4765      C4
 510:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4766              		.loc 1 510 32
 4767 3489 C57A59E7 		vmulss	%xmm7, %xmm0, %xmm12
 515:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 4768              		.loc 1 515 32
 4769 348d C5FA59C2 		vmulss	%xmm2, %xmm0, %xmm0
 503:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[0] +
 4770              		.loc 1 503 26
 4771 3491 4188440D 		movb	%al, 0(%r13,%rcx)
 4771      00
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4772              		.loc 1 508 13 is_stmt 1
 509:RGB2YCbCr.c   ****                 RGB2YCbCr[1][0]*Rpixels[i] + 
 4773              		.loc 1 509 37 is_stmt 0
 4774 3496 C51A58E3 		vaddss	%xmm3, %xmm12, %xmm12
 514:RGB2YCbCr.c   ****                 RGB2YCbCr[2][0]*Rpixels[i] + 
 4775              		.loc 1 514 37
 4776 349a C5FA58C3 		vaddss	%xmm3, %xmm0, %xmm0
 510:RGB2YCbCr.c   ****                 RGB2YCbCr[1][1]*Gpixels[i] + 
 4777              		.loc 1 510 44
 4778 349e C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 4778      E5
 512:RGB2YCbCr.c   ****             Crpixels[i] = (unsigned char) (0.5f + 
 4779              		.loc 1 512 32
 4780 34a3 C57259EA 		vmulss	%xmm2, %xmm1, %xmm13
 4781              		.loc 1 517 32
 4782 34a7 C5F259CC 		vmulss	%xmm4, %xmm1, %xmm1
 515:RGB2YCbCr.c   ****                 RGB2YCbCr[2][1]*Gpixels[i] + 
 4783              		.loc 1 515 44
 4784 34ab C4C17A58 		vaddss	%xmm11, %xmm0, %xmm0
 4784      C3
 511:RGB2YCbCr.c   ****                 RGB2YCbCr[1][2]*Bpixels[i]);
 4785              		.loc 1 511 44
 4786 34b0 C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 4786      E5
 516:RGB2YCbCr.c   ****                 RGB2YCbCr[2][2]*Bpixels[i]);
 4787              		.loc 1 516 44
 4788 34b5 C5FA58C1 		vaddss	%xmm1, %xmm0, %xmm0
 508:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[1] +
 4789              		.loc 1 508 27
 4790 34b9 C4C17A2C 		vcvttss2sil	%xmm12, %eax
 4790      C4
 4791 34be 88040A   		movb	%al, (%rdx,%rcx)
 513:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 4792              		.loc 1 513 13 is_stmt 1
 513:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 4793              		.loc 1 513 27 is_stmt 0
 4794 34c1 C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 4795 34c5 41880408 		movb	%al, (%r8,%rcx)
 501:RGB2YCbCr.c   ****         {
 4796              		.loc 1 501 43 is_stmt 1
 4797              	.LVL225:
 501:RGB2YCbCr.c   ****         {
 4798              		.loc 1 501 25
 4799 34c9 48FFC1   		incq	%rcx
 4800              	.LVL226:
 501:RGB2YCbCr.c   ****         {
 4801              		.loc 1 501 9 is_stmt 0
 4802 34cc 4139C9   		cmpl	%ecx, %r9d
 4803 34cf 0F8F6BFF 		jg	.L119
 4803      FFFF
 4804              	.L118:
 4805 34d5 8B7DA0   		movl	-96(%rbp), %edi
 513:RGB2YCbCr.c   ****                 RGB2YCbCr_offset[2] +
 4806              		.loc 1 513 25
 4807 34d8 31C9     		xorl	%ecx, %ecx
 4808 34da 31C0     		xorl	%eax, %eax
 4809 34dc 0F1F4000 		.p2align 4,,10
 4810              		.p2align 3
 4811              	.L120:
 4812              	.LVL227:
 4813              	.LBE55:
 4814              	.LBB56:
 518:RGB2YCbCr.c   ****         }
 519:RGB2YCbCr.c   **** 
 520:RGB2YCbCr.c   ****         /* transformaci贸n SoA -> AoS */
 521:RGB2YCbCr.c   ****         /* COMPLETAR ... */
 522:RGB2YCbCr.c   ****         #pragma GCC ivdep
 523:RGB2YCbCr.c   ****         for (int i = 0; i < height*width; i++)
 524:RGB2YCbCr.c   ****         {
 525:RGB2YCbCr.c   ****             image_out->pixels[3*i + 0] = Ypixels[i];
 4815              		.loc 1 525 13 is_stmt 1 discriminator 3
 4816              		.loc 1 525 40 is_stmt 0 discriminator 3
 4817 34e0 488B33   		movq	(%rbx), %rsi
 4818 34e3 450FB65C 		movzbl	0(%r13,%rax), %r11d
 4818      0500
 4819 34e9 44881C0E 		movb	%r11b, (%rsi,%rcx)
 526:RGB2YCbCr.c   **** 			image_out->pixels[3*i + 1] = Cbpixels[i];
 4820              		.loc 1 526 4 is_stmt 1 discriminator 3
 4821              		.loc 1 526 31 is_stmt 0 discriminator 3
 4822 34ed 440FB61C 		movzbl	(%rdx,%rax), %r11d
 4822      02
 4823 34f2 488B33   		movq	(%rbx), %rsi
 4824 34f5 44885C0E 		movb	%r11b, 1(%rsi,%rcx)
 4824      01
 527:RGB2YCbCr.c   **** 			image_out->pixels[3*i + 2] = Crpixels[i];
 4825              		.loc 1 527 4 is_stmt 1 discriminator 3
 4826              		.loc 1 527 31 is_stmt 0 discriminator 3
 4827 34fa 450FB61C 		movzbl	(%r8,%rax), %r11d
 4827      00
 4828 34ff 488B33   		movq	(%rbx), %rsi
 4829 3502 44885C0E 		movb	%r11b, 2(%rsi,%rcx)
 4829      02
 523:RGB2YCbCr.c   ****         {
 4830              		.loc 1 523 43 is_stmt 1 discriminator 3
 4831              	.LVL228:
 523:RGB2YCbCr.c   ****         {
 4832              		.loc 1 523 25 discriminator 3
 4833 3507 4889C6   		movq	%rax, %rsi
 4834 350a 4883C103 		addq	$3, %rcx
 4835 350e 48FFC0   		incq	%rax
 4836              	.LVL229:
 523:RGB2YCbCr.c   ****         {
 4837              		.loc 1 523 9 is_stmt 0 discriminator 3
 4838 3511 4839F7   		cmpq	%rsi, %rdi
 4839 3514 75CA     		jne	.L120
 4840              	.L123:
 4841              	.LBE56:
 528:RGB2YCbCr.c   ****         }
 529:RGB2YCbCr.c   **** 
 530:RGB2YCbCr.c   ****         dummy(image_in, image_out);
 4842              		.loc 1 530 9 is_stmt 1
 4843 3516 488B7D80 		movq	-128(%rbp), %rdi
 4844 351a 4889DE   		movq	%rbx, %rsi
 4845 351d 4C894588 		movq	%r8, -120(%rbp)
 4846 3521 48895590 		movq	%rdx, -112(%rbp)
 4847 3525 4C895598 		movq	%r10, -104(%rbp)
 4848 3529 44894DB0 		movl	%r9d, -80(%rbp)
 4849 352d C5F877   		vzeroupper
 4850 3530 E8000000 		call	dummy
 4850      00
 4851              	.LVL230:
 487:RGB2YCbCr.c   ****     {
 4852              		.loc 1 487 32
 487:RGB2YCbCr.c   ****     {
 4853              		.loc 1 487 20
 487:RGB2YCbCr.c   ****     {
 4854              		.loc 1 487 5 is_stmt 0
 4855 3535 FF8D78FF 		decl	-136(%rbp)
 4855      FFFF
 4856 353b 448B4DB0 		movl	-80(%rbp), %r9d
 4857 353f C57D6F3D 		vmovdqa	.LC34(%rip), %ymm15
 4857      00000000 
 4858 3547 4C8B5598 		movq	-104(%rbp), %r10
 4859 354b 488B5590 		movq	-112(%rbp), %rdx
 4860 354f 4C8B4588 		movq	-120(%rbp), %r8
 4861 3553 0F85EFF8 		jne	.L111
 4861      FFFF
 4862              	.LBE53:
 531:RGB2YCbCr.c   ****     }
 532:RGB2YCbCr.c   **** 
 533:RGB2YCbCr.c   ****     end_t = get_wall_time();
 4863              		.loc 1 533 13
 4864 3559 31C0     		xorl	%eax, %eax
 4865 355b 44894DA8 		movl	%r9d, -88(%rbp)
 4866 355f 4C896DB0 		movq	%r13, -80(%rbp)
 4867              		.loc 1 533 5 is_stmt 1
 4868              		.loc 1 533 13 is_stmt 0
 4869 3563 C5F877   		vzeroupper
 4870 3566 E8000000 		call	get_wall_time
 4870      00
 4871              	.LVL231:
 534:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2YCbCrSOA1");
 4872              		.loc 1 534 5 is_stmt 1
 4873 356b 448B4DA8 		movl	-88(%rbp), %r9d
 4874 356f BE000000 		movl	$.LC71, %esi
 4874      00
 4875 3574 C5FB5C85 		vsubsd	-144(%rbp), %xmm0, %xmm0
 4875      70FFFFFF 
 4876              	.LVL232:
 4877 357c 4489CF   		movl	%r9d, %edi
 4878 357f E8000000 		call	results
 4878      00
 4879              	.LVL233:
 535:RGB2YCbCr.c   **** 
 536:RGB2YCbCr.c   ****     free(Rpixels); free(Ypixels);
 4880              		.loc 1 536 5
 4881 3584 4C89E7   		movq	%r12, %rdi
 4882 3587 E8000000 		call	free
 4882      00
 4883              	.LVL234:
 4884              		.loc 1 536 20
 4885 358c 4C8B45B0 		movq	-80(%rbp), %r8
 537:RGB2YCbCr.c   **** }
 4886              		.loc 1 537 1 is_stmt 0
 4887 3590 4883C468 		addq	$104, %rsp
 4888 3594 5B       		popq	%rbx
 4889              	.LVL235:
 4890 3595 415C     		popq	%r12
 4891              	.LVL236:
 4892 3597 415D     		popq	%r13
 4893              		.cfi_remember_state
 4894              		.cfi_def_cfa 13, 0
 4895 3599 415E     		popq	%r14
 4896              	.LVL237:
 536:RGB2YCbCr.c   **** }
 4897              		.loc 1 536 20
 4898 359b 4C89C7   		movq	%r8, %rdi
 4899              		.loc 1 537 1
 4900 359e 415F     		popq	%r15
 4901              	.LVL238:
 4902 35a0 5D       		popq	%rbp
 4903              	.LVL239:
 4904 35a1 498D65F0 		leaq	-16(%r13), %rsp
 4905              		.cfi_def_cfa 7, 16
 4906              	.LVL240:
 4907 35a5 415D     		popq	%r13
 4908              		.cfi_def_cfa_offset 8
 536:RGB2YCbCr.c   **** }
 4909              		.loc 1 536 20
 4910 35a7 E9000000 		jmp	free
 4910      00
 4911              	.LVL241:
 4912              	.L125:
 4913              		.cfi_restore_state
 4914              	.LBB58:
 4915              	.LBB57:
 492:RGB2YCbCr.c   ****         {
 4916              		.loc 1 492 9
 4917 35ac 31C9     		xorl	%ecx, %ecx
 4918 35ae E93BFEFF 		jmp	.L116
 4918      FF
 4919              	.LVL242:
 4920              	.L124:
 492:RGB2YCbCr.c   ****         {
 4921              		.loc 1 492 18
 4922 35b3 31F6     		xorl	%esi, %esi
 4923 35b5 E9EFF9FF 		jmp	.L112
 4923      FF
 4924              	.LVL243:
 4925              	.L132:
 4926              	.LBE57:
 4927              	.LBE58:
 467:RGB2YCbCr.c   ****         exit(-1);
 4928              		.loc 1 467 9 is_stmt 1
 4929 35ba BF000000 		movl	$.LC0, %edi
 4929      00
 4930              	.LVL244:
 4931 35bf E8000000 		call	puts
 4931      00
 4932              	.LVL245:
 468:RGB2YCbCr.c   ****     }
 4933              		.loc 1 468 9
 4934 35c4 83CFFF   		orl	$-1, %edi
 4935 35c7 E8000000 		call	exit
 4935      00
 4936              	.LVL246:
 4937              		.cfi_endproc
 4938              	.LFE21:
 4940              		.section	.rodata.str1.1
 4941              	.LC72:
 4942 007f 52474232 		.string	"RGB2YCbCr_block"
 4942      59436243 
 4942      725F626C 
 4942      6F636B00 
 4943              		.text
 4944 35cc 0F1F4000 		.p2align 4
 4945              		.globl	RGB2YCbCr_block
 4947              	RGB2YCbCr_block:
 4948              	.LFB22:
 538:RGB2YCbCr.c   **** 
 539:RGB2YCbCr.c   **** //#define BLOCK 64
 540:RGB2YCbCr.c   **** 
 541:RGB2YCbCr.c   ****  /* funci贸n que entrelaza la transformaci贸n de los datos con los c谩lculos a realizar.
 542:RGB2YCbCr.c   ****     De esta forma, en lugar de necesitar nuevas variables
 543:RGB2YCbCr.c   ****     con **todos** los valores RGB de la imagen en formato SOA,
 544:RGB2YCbCr.c   ****     solamente son necesarias variables que almacenen **parte** de los valores RGB */
 545:RGB2YCbCr.c   **** void
 546:RGB2YCbCr.c   **** RGB2YCbCr_block(image_t * restrict image_in, image_t * restrict image_out, int BLOCK)
 547:RGB2YCbCr.c   **** {
 4949              		.loc 1 547 1
 4950              		.cfi_startproc
 4951              	.LVL247:
 548:RGB2YCbCr.c   **** 	/* Indicamos que no compruebe solapamiento en los campos pixels del struct */
 549:RGB2YCbCr.c   **** 	unsigned char * restrict pin;
 4952              		.loc 1 549 2
 550:RGB2YCbCr.c   **** 	unsigned char * restrict pout;
 4953              		.loc 1 550 2
 551:RGB2YCbCr.c   **** 	
 552:RGB2YCbCr.c   ****     double start_t, end_t;
 4954              		.loc 1 552 5
 553:RGB2YCbCr.c   ****     const int height = image_in->height;
 4955              		.loc 1 553 5
 547:RGB2YCbCr.c   **** 	/* Indicamos que no compruebe solapamiento en los campos pixels del struct */
 4956              		.loc 1 547 1 is_stmt 0
 4957 35d0 4C8D5424 		leaq	8(%rsp), %r10
 4957      08
 4958              		.cfi_def_cfa 10, 0
 4959 35d5 4883E4E0 		andq	$-32, %rsp
 4960 35d9 4863C2   		movslq	%edx, %rax
 4961 35dc 41FF72F8 		pushq	-8(%r10)
 4962 35e0 4989C3   		movq	%rax, %r11
 554:RGB2YCbCr.c   ****     const int width =  image_in->width;
 555:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Rpixels[BLOCK];
 4963              		.loc 1 555 56
 4964 35e3 4883C027 		addq	$39, %rax
 547:RGB2YCbCr.c   **** 	/* Indicamos que no compruebe solapamiento en los campos pixels del struct */
 4965              		.loc 1 547 1
 4966 35e7 55       		pushq	%rbp
 4967              		.loc 1 555 56
 4968 35e8 48C1E804 		shrq	$4, %rax
 4969 35ec 48C1E004 		salq	$4, %rax
 4970              		.cfi_escape 0x10,0x6,0x2,0x76,0
 547:RGB2YCbCr.c   **** 	/* Indicamos que no compruebe solapamiento en los campos pixels del struct */
 4971              		.loc 1 547 1
 4972 35f0 4889E5   		movq	%rsp, %rbp
 4973 35f3 4157     		pushq	%r15
 4974 35f5 4156     		pushq	%r14
 4975 35f7 4155     		pushq	%r13
 4976 35f9 4154     		pushq	%r12
 4977 35fb 4152     		pushq	%r10
 4978              		.cfi_escape 0xf,0x3,0x76,0x58,0x6
 4979              		.cfi_escape 0x10,0xf,0x2,0x76,0x78
 4980              		.cfi_escape 0x10,0xe,0x2,0x76,0x70
 4981              		.cfi_escape 0x10,0xd,0x2,0x76,0x68
 4982              		.cfi_escape 0x10,0xc,0x2,0x76,0x60
 4983 35fd 53       		pushq	%rbx
 4984 35fe 4883C480 		addq	$-128, %rsp
 4985              		.cfi_escape 0x10,0x3,0x2,0x76,0x50
 553:RGB2YCbCr.c   ****     const int width =  image_in->width;
 4986              		.loc 1 553 15
 4987 3602 8B570C   		movl	12(%rdi), %edx
 4988              	.LVL248:
 554:RGB2YCbCr.c   ****     const int width =  image_in->width;
 4989              		.loc 1 554 5 is_stmt 1
 554:RGB2YCbCr.c   ****     const int width =  image_in->width;
 4990              		.loc 1 554 15 is_stmt 0
 4991 3605 8B4F08   		movl	8(%rdi), %ecx
 4992              	.LVL249:
 4993              		.loc 1 555 5 is_stmt 1
 547:RGB2YCbCr.c   **** 	/* Indicamos que no compruebe solapamiento en los campos pixels del struct */
 4994              		.loc 1 547 1 is_stmt 0
 4995 3608 48897580 		movq	%rsi, -128(%rbp)
 4996              		.loc 1 555 56
 4997 360c 4829C4   		subq	%rax, %rsp
 547:RGB2YCbCr.c   **** 	/* Indicamos que no compruebe solapamiento en los campos pixels del struct */
 4998              		.loc 1 547 1
 4999 360f 4889BD78 		movq	%rdi, -136(%rbp)
 4999      FFFFFF
 5000              		.loc 1 555 56
 5001 3616 4C8D7424 		leaq	31(%rsp), %r14
 5001      1F
 556:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Gpixels[BLOCK];
 5002              		.loc 1 556 56
 5003 361b 4829C4   		subq	%rax, %rsp
 5004 361e 4C8D7C24 		leaq	31(%rsp), %r15
 5004      1F
 557:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Bpixels[BLOCK];
 5005              		.loc 1 557 56
 5006 3623 4829C4   		subq	%rax, %rsp
 555:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Gpixels[BLOCK];
 5007              		.loc 1 555 56
 5008 3626 4983E6E0 		andq	$-32, %r14
 5009              	.LVL250:
 556:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Gpixels[BLOCK];
 5010              		.loc 1 556 5 is_stmt 1
 5011              		.loc 1 557 56 is_stmt 0
 5012 362a 4C8D4424 		leaq	31(%rsp), %r8
 5012      1F
 558:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Ypixels[BLOCK];
 5013              		.loc 1 558 56
 5014 362f 4829C4   		subq	%rax, %rsp
 556:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Bpixels[BLOCK];
 5015              		.loc 1 556 56
 5016 3632 4983E7E0 		andq	$-32, %r15
 5017              	.LVL251:
 557:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Ypixels[BLOCK];
 5018              		.loc 1 557 5 is_stmt 1
 5019              		.loc 1 558 56 is_stmt 0
 5020 3636 488D5C24 		leaq	31(%rsp), %rbx
 5020      1F
 559:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Cbpixels[BLOCK];
 5021              		.loc 1 559 56
 5022 363b 4829C4   		subq	%rax, %rsp
 557:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Ypixels[BLOCK];
 5023              		.loc 1 557 56
 5024 363e 4983E0E0 		andq	$-32, %r8
 5025              	.LVL252:
 558:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Cbpixels[BLOCK];
 5026              		.loc 1 558 5 is_stmt 1
 5027              		.loc 1 559 56 is_stmt 0
 5028 3642 4C8D6424 		leaq	31(%rsp), %r12
 5028      1F
 560:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Crpixels[BLOCK];
 5029              		.loc 1 560 56
 5030 3647 4829C4   		subq	%rax, %rsp
 558:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Cbpixels[BLOCK];
 5031              		.loc 1 558 56
 5032 364a 4883E3E0 		andq	$-32, %rbx
 5033              	.LVL253:
 559:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Cbpixels[BLOCK];
 5034              		.loc 1 559 5 is_stmt 1
 5035              		.loc 1 560 56 is_stmt 0
 5036 364e 4C8D6C24 		leaq	31(%rsp), %r13
 5036      1F
 559:RGB2YCbCr.c   ****     unsigned char __attribute__((aligned(SIMD_ALIGN))) Cbpixels[BLOCK];
 5037              		.loc 1 559 56
 5038 3653 4983E4E0 		andq	$-32, %r12
 5039              	.LVL254:
 5040              		.loc 1 560 5 is_stmt 1
 5041              		.loc 1 560 56 is_stmt 0
 5042 3657 4983E5E0 		andq	$-32, %r13
 5043              	.LVL255:
 561:RGB2YCbCr.c   **** 
 562:RGB2YCbCr.c   ****     if (image_in->bytes_per_pixel != 3)
 5044              		.loc 1 562 5 is_stmt 1
 5045              		.loc 1 562 8 is_stmt 0
 5046 365b 837F1003 		cmpl	$3, 16(%rdi)
 5047 365f 0F859409 		jne	.L166
 5047      0000
 563:RGB2YCbCr.c   ****     {
 564:RGB2YCbCr.c   ****         printf("ERROR: input image has to be RGB\n");
 565:RGB2YCbCr.c   ****         exit(-1);
 566:RGB2YCbCr.c   ****     }
 567:RGB2YCbCr.c   ****     
 568:RGB2YCbCr.c   ****     /* fill struct fields */
 569:RGB2YCbCr.c   ****     image_out->width  = width;
 5048              		.loc 1 569 23
 5049 3665 488B4580 		movq	-128(%rbp), %rax
 5050 3669 4C894598 		movq	%r8, -104(%rbp)
 570:RGB2YCbCr.c   ****     image_out->height = height;
 571:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 5051              		.loc 1 571 32
 5052 366d 48BE0300 		movabsq	$12884901891, %rsi
 5052      00000300 
 5052      0000
 5053              	.LVL256:
 5054 3677 44895DA0 		movl	%r11d, -96(%rbp)
 569:RGB2YCbCr.c   ****     image_out->height = height;
 5055              		.loc 1 569 5 is_stmt 1
 569:RGB2YCbCr.c   ****     image_out->height = height;
 5056              		.loc 1 569 23 is_stmt 0
 5057 367b 894808   		movl	%ecx, 8(%rax)
 570:RGB2YCbCr.c   ****     image_out->height = height;
 5058              		.loc 1 570 23
 5059 367e 89500C   		movl	%edx, 12(%rax)
 5060              		.loc 1 571 32
 5061 3681 48897010 		movq	%rsi, 16(%rax)
 572:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 573:RGB2YCbCr.c   **** 
 574:RGB2YCbCr.c   ****     start_t = get_wall_time();
 5062              		.loc 1 574 15
 5063 3685 31C0     		xorl	%eax, %eax
 5064              	.LVL257:
 569:RGB2YCbCr.c   ****     image_out->height = height;
 5065              		.loc 1 569 23
 5066 3687 894DA8   		movl	%ecx, -88(%rbp)
 570:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 5067              		.loc 1 570 5 is_stmt 1
 570:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 5068              		.loc 1 570 23 is_stmt 0
 5069 368a 8955B0   		movl	%edx, -80(%rbp)
 571:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 5070              		.loc 1 571 5 is_stmt 1
 572:RGB2YCbCr.c   ****     image_out->color_space = JCS_YCbCr;
 5071              		.loc 1 572 5
 5072              		.loc 1 574 5
 5073              		.loc 1 574 15 is_stmt 0
 5074 368d E8000000 		call	get_wall_time
 5074      00
 5075              	.LVL258:
 5076 3692 448B5DA0 		movl	-96(%rbp), %r11d
 5077              	.LBB59:
 5078              	.LBB60:
 575:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 576:RGB2YCbCr.c   ****     {
 577:RGB2YCbCr.c   ****         for (int i = 0; i < height*width; i+= BLOCK)
 5079              		.loc 1 577 35
 5080 3696 8B4DA8   		movl	-88(%rbp), %ecx
 5081 3699 C745880A 		movl	$10, -120(%rbp)
 5081      000000
 5082 36a0 8B55B0   		movl	-80(%rbp), %edx
 5083 36a3 C57D6F3D 		vmovdqa	.LC34(%rip), %ymm15
 5083      00000000 
 5084 36ab 4C89BD68 		movq	%r15, -152(%rbp)
 5084      FFFFFF
 5085 36b2 4D89F7   		movq	%r14, %r15
 5086              	.LVL259:
 5087 36b5 438D045B 		leal	(%r11,%r11,2), %eax
 5088 36b9 4C8B4598 		movq	-104(%rbp), %r8
 5089              	.LBE60:
 5090              	.LBE59:
 574:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 5091              		.loc 1 574 15
 5092 36bd C5FB1185 		vmovsd	%xmm0, -160(%rbp)
 5092      60FFFFFF 
 5093              	.LVL260:
 575:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 5094              		.loc 1 575 5 is_stmt 1
 5095              	.LBB69:
 575:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 5096              		.loc 1 575 10
 575:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 5097              		.loc 1 575 22
 5098 36c5 4898     		cltq
 5099              	.LBB67:
 5100              		.loc 1 577 35 is_stmt 0
 5101 36c7 0FAFCA   		imull	%edx, %ecx
 5102 36ca 48898570 		movq	%rax, -144(%rbp)
 5102      FFFFFF
 5103 36d1 418D43FF 		leal	-1(%r11), %eax
 5104 36d5 894594   		movl	%eax, -108(%rbp)
 5105 36d8 4489D8   		movl	%r11d, %eax
 5106 36db C1E805   		shrl	$5, %eax
 5107 36de 894D8C   		movl	%ecx, -116(%rbp)
 5108 36e1 48C1E005 		salq	$5, %rax
 5109 36e5 4989C2   		movq	%rax, %r10
 5110 36e8 498D0406 		leaq	(%r14,%rax), %rax
 5111 36ec 4D89EE   		movq	%r13, %r14
 5112              	.LVL261:
 5113 36ef 4D89E5   		movq	%r12, %r13
 5114              	.LVL262:
 5115 36f2 488945A8 		movq	%rax, -88(%rbp)
 5116              	.LVL263:
 5117 36f6 4489D8   		movl	%r11d, %eax
 5118 36f9 4989DC   		movq	%rbx, %r12
 5119              	.LVL264:
 5120 36fc 4489DB   		movl	%r11d, %ebx
 5121              	.LVL265:
 5122 36ff 83E0E0   		andl	$-32, %eax
 5123 3702 894590   		movl	%eax, -112(%rbp)
 5124              	.LVL266:
 5125              		.p2align 4,,10
 5126 3705 0F1F00   		.p2align 3
 5127              	.L135:
 5128              		.loc 1 577 25 is_stmt 1
 5129              		.loc 1 577 9 is_stmt 0
 5130 3708 8B458C   		movl	-116(%rbp), %eax
 5131              		.loc 1 577 18
 5132 370b 31F6     		xorl	%esi, %esi
 5133              		.loc 1 577 9
 5134 370d 48C745A0 		movq	$0, -96(%rbp)
 5134      00000000 
 5135 3715 4C8B8D68 		movq	-152(%rbp), %r9
 5135      FFFFFF
 5136 371c 4189F3   		movl	%esi, %r11d
 5137 371f 85C0     		testl	%eax, %eax
 5138 3721 0F8E5508 		jle	.L151
 5138      0000
 5139              	.LVL267:
 5140 3727 660F1F84 		.p2align 4,,10
 5140      00000000 
 5140      00
 5141              		.p2align 3
 5142              	.L149:
 578:RGB2YCbCr.c   ****         {
 579:RGB2YCbCr.c   **** 			pin=&image_in->pixels[3*i];
 5143              		.loc 1 579 4 is_stmt 1
 580:RGB2YCbCr.c   **** 			pout=&image_out->pixels[3*i];
 5144              		.loc 1 580 19 is_stmt 0
 5145 3730 488B7D80 		movq	-128(%rbp), %rdi
 579:RGB2YCbCr.c   **** 			pout=&image_out->pixels[3*i];
 5146              		.loc 1 579 17
 5147 3734 488B8578 		movq	-136(%rbp), %rax
 5147      FFFFFF
 5148              		.loc 1 580 19
 5149 373b 488B3F   		movq	(%rdi), %rdi
 579:RGB2YCbCr.c   **** 			pout=&image_out->pixels[3*i];
 5150              		.loc 1 579 17
 5151 373e 488B00   		movq	(%rax), %rax
 5152              	.LVL268:
 5153              		.loc 1 580 4 is_stmt 1
 5154              		.loc 1 580 19 is_stmt 0
 5155 3741 48897D98 		movq	%rdi, -104(%rbp)
 5156              	.LVL269:
 5157              	.LBB61:
 581:RGB2YCbCr.c   **** 			
 582:RGB2YCbCr.c   ****             /* transformaci贸n AoS -> SoA */
 583:RGB2YCbCr.c   ****             #pragma GCC ivdep
 584:RGB2YCbCr.c   ****             for (int j = 0; j < BLOCK; j++)
 5158              		.loc 1 584 18 is_stmt 1
 5159              		.loc 1 584 29
 5160              		.loc 1 584 13 is_stmt 0
 5161 3745 85DB     		testl	%ebx, %ebx
 5162 3747 0F8E1708 		jle	.L136
 5162      0000
 5163 374d 837D941E 		cmpl	$30, -108(%rbp)
 5164 3751 0F869B08 		jbe	.L152
 5164      0000
 5165 3757 438D145B 		leal	(%r11,%r11,2), %edx
 5166 375b 4C89CF   		movq	%r9, %rdi
 5167              	.LVL270:
 5168 375e 4C89C6   		movq	%r8, %rsi
 5169 3761 4C89F9   		movq	%r15, %rcx
 5170 3764 4863D2   		movslq	%edx, %rdx
 5171 3767 4801C2   		addq	%rax, %rdx
 5172              	.LVL271:
 5173 376a 660F1F44 		.p2align 4,,10
 5173      0000
 5174              		.p2align 3
 5175              	.L138:
 585:RGB2YCbCr.c   ****             {
 586:RGB2YCbCr.c   ****                 Rpixels[j] = pin[3*j + 0];
 5176              		.loc 1 586 17 is_stmt 1 discriminator 3
 5177              		.loc 1 586 33 is_stmt 0 discriminator 3
 5178 3770 C5FE6F02 		vmovdqu	(%rdx), %ymm0
 5179 3774 4883C120 		addq	$32, %rcx
 5180 3778 4883C260 		addq	$96, %rdx
 5181 377c 4883C720 		addq	$32, %rdi
 5182 3780 C5FE6F4A 		vmovdqu	-32(%rdx), %ymm1
 5182      E0
 5183 3785 C5FE6F5A 		vmovdqu	-64(%rdx), %ymm3
 5183      C0
 5184 378a 4883C620 		addq	$32, %rsi
 5185 378e C4E27D00 		vpshufb	.LC13(%rip), %ymm0, %ymm2
 5185      15000000 
 5185      00
 5186 3797 C4E26500 		vpshufb	.LC15(%rip), %ymm3, %ymm5
 5186      2D000000 
 5186      00
 5187 37a0 C4E3FD00 		vpermq	$78, %ymm2, %ymm4
 5187      E24E
 5188 37a6 C4E27D00 		vpshufb	.LC14(%rip), %ymm0, %ymm2
 5188      15000000 
 5188      00
 5189 37af C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 5190 37b3 C4E27500 		vpshufb	.LC16(%rip), %ymm1, %ymm4
 5190      25000000 
 5190      00
 5191 37bc C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 5192 37c0 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 5192      EC4E
 5193 37c6 C4E27500 		vpshufb	.LC18(%rip), %ymm1, %ymm4
 5193      25000000 
 5193      00
 5194 37cf C4E26D00 		vpshufb	.LC17(%rip), %ymm2, %ymm2
 5194      15000000 
 5194      00
 5195 37d8 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 5196 37dc C4E26500 		vpshufb	.LC21(%rip), %ymm3, %ymm5
 5196      2D000000 
 5196      00
 5197 37e5 C4E26500 		vpshufb	.LC27(%rip), %ymm3, %ymm3
 5197      1D000000 
 5197      00
 5198 37ee C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 5199              		.loc 1 586 28 discriminator 3
 5200 37f2 C5FD7F51 		vmovdqa	%ymm2, -32(%rcx)
 5200      E0
 587:RGB2YCbCr.c   **** 				Gpixels[j] = pin[3*j + 1];
 5201              		.loc 1 587 5 is_stmt 1 discriminator 3
 586:RGB2YCbCr.c   **** 				Gpixels[j] = pin[3*j + 1];
 5202              		.loc 1 586 33 is_stmt 0 discriminator 3
 5203 37f7 C4E27D00 		vpshufb	.LC19(%rip), %ymm0, %ymm2
 5203      15000000 
 5203      00
 5204 3800 C4E3FD00 		vpermq	$78, %ymm2, %ymm4
 5204      E24E
 5205 3806 C4E27D00 		vpshufb	.LC20(%rip), %ymm0, %ymm2
 5205      15000000 
 5205      00
 5206 380f C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 5207 3813 C4E27500 		vpshufb	.LC22(%rip), %ymm1, %ymm4
 5207      25000000 
 5207      00
 5208 381c C5EDEBD5 		vpor	%ymm5, %ymm2, %ymm2
 5209 3820 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 5209      EC4E
 5210 3826 C4E27500 		vpshufb	.LC24(%rip), %ymm1, %ymm4
 5210      25000000 
 5210      00
 5211 382f C4E26D00 		vpshufb	.LC23(%rip), %ymm2, %ymm2
 5211      15000000 
 5211      00
 5212 3838 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 5213 383c C5EDEBD4 		vpor	%ymm4, %ymm2, %ymm2
 5214              		.loc 1 587 16 discriminator 3
 5215 3840 C5FD7F57 		vmovdqa	%ymm2, -32(%rdi)
 5215      E0
 588:RGB2YCbCr.c   **** 				Bpixels[j] = pin[3*j + 2];
 5216              		.loc 1 588 5 is_stmt 1 discriminator 3
 586:RGB2YCbCr.c   **** 				Gpixels[j] = pin[3*j + 1];
 5217              		.loc 1 586 33 is_stmt 0 discriminator 3
 5218 3845 C4E27D00 		vpshufb	.LC25(%rip), %ymm0, %ymm2
 5218      15000000 
 5218      00
 5219 384e C4E27D00 		vpshufb	.LC26(%rip), %ymm0, %ymm0
 5219      05000000 
 5219      00
 5220 3857 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 5220      D24E
 5221 385d C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 5222 3861 C4E27500 		vpshufb	.LC28(%rip), %ymm1, %ymm2
 5222      15000000 
 5222      00
 5223 386a C4E27500 		vpshufb	.LC29(%rip), %ymm1, %ymm1
 5223      0D000000 
 5223      00
 5224 3873 C5FDEBC3 		vpor	%ymm3, %ymm0, %ymm0
 5225 3877 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 5225      D24E
 5226 387d C4E27D00 		vpshufb	.LC23(%rip), %ymm0, %ymm0
 5226      05000000 
 5226      00
 5227 3886 C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 5228 388a C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 5229              		.loc 1 588 16 discriminator 3
 5230 388e C5FD7F46 		vmovdqa	%ymm0, -32(%rsi)
 5230      E0
 584:RGB2YCbCr.c   ****             {
 5231              		.loc 1 584 40 is_stmt 1 discriminator 3
 584:RGB2YCbCr.c   ****             {
 5232              		.loc 1 584 29 discriminator 3
 5233 3893 48394DA8 		cmpq	%rcx, -88(%rbp)
 5234 3897 0F85D3FE 		jne	.L138
 5234      FFFF
 5235 389d 8B7590   		movl	-112(%rbp), %esi
 5236 38a0 39F3     		cmpl	%esi, %ebx
 5237 38a2 7448     		je	.L139
 584:RGB2YCbCr.c   ****             {
 5238              		.loc 1 584 22 is_stmt 0
 5239 38a4 89F1     		movl	%esi, %ecx
 5240              	.L137:
 5241 38a6 4863D1   		movslq	%ecx, %rdx
 5242 38a9 8D0C49   		leal	(%rcx,%rcx,2), %ecx
 5243 38ac 4863C9   		movslq	%ecx, %rcx
 5244 38af 48034DA0 		addq	-96(%rbp), %rcx
 5245 38b3 4801C8   		addq	%rcx, %rax
 5246              	.LVL272:
 5247 38b6 662E0F1F 		.p2align 4,,10
 5247      84000000 
 5247      0000
 5248              		.p2align 3
 5249              	.L140:
 586:RGB2YCbCr.c   **** 				Gpixels[j] = pin[3*j + 1];
 5250              		.loc 1 586 17 is_stmt 1
 586:RGB2YCbCr.c   **** 				Gpixels[j] = pin[3*j + 1];
 5251              		.loc 1 586 28 is_stmt 0
 5252 38c0 0FB608   		movzbl	(%rax), %ecx
 5253 38c3 4883C003 		addq	$3, %rax
 5254 38c7 41880C17 		movb	%cl, (%r15,%rdx)
 587:RGB2YCbCr.c   **** 				Bpixels[j] = pin[3*j + 2];
 5255              		.loc 1 587 5 is_stmt 1
 587:RGB2YCbCr.c   **** 				Bpixels[j] = pin[3*j + 2];
 5256              		.loc 1 587 16 is_stmt 0
 5257 38cb 0FB648FE 		movzbl	-2(%rax), %ecx
 5258 38cf 41880C11 		movb	%cl, (%r9,%rdx)
 5259              		.loc 1 588 5 is_stmt 1
 5260              		.loc 1 588 16 is_stmt 0
 5261 38d3 0FB648FF 		movzbl	-1(%rax), %ecx
 5262 38d7 41880C10 		movb	%cl, (%r8,%rdx)
 584:RGB2YCbCr.c   ****             {
 5263              		.loc 1 584 40 is_stmt 1
 5264              	.LVL273:
 584:RGB2YCbCr.c   ****             {
 5265              		.loc 1 584 29
 5266 38db 48FFC2   		incq	%rdx
 5267              	.LVL274:
 584:RGB2YCbCr.c   ****             {
 5268              		.loc 1 584 13 is_stmt 0
 5269 38de 39D3     		cmpl	%edx, %ebx
 5270 38e0 7FDE     		jg	.L140
 5271 38e2 837D941E 		cmpl	$30, -108(%rbp)
 5272 38e6 0F86F806 		jbe	.L153
 5272      0000
 5273              	.L139:
 584:RGB2YCbCr.c   ****             {
 5274              		.loc 1 584 22
 5275 38ec 31C0     		xorl	%eax, %eax
 5276 38ee 6690     		.p2align 4,,10
 5277              		.p2align 3
 5278              	.L142:
 5279              	.LBE61:
 5280              	.LBB62:
 589:RGB2YCbCr.c   ****             }
 590:RGB2YCbCr.c   ****             /* conversi贸n RGB -> YbCrCb */
 591:RGB2YCbCr.c   ****             #pragma GCC ivdep
 592:RGB2YCbCr.c   ****             for (int j = 0; j < BLOCK; j++)
 593:RGB2YCbCr.c   ****             {
 594:RGB2YCbCr.c   ****                 Ypixels[j] = (unsigned char) (0.5f + 
 5281              		.loc 1 594 17 is_stmt 1 discriminator 3
 595:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][0]*Rpixels[j] + 
 5282              		.loc 1 596 29 is_stmt 0 discriminator 3
 5283 38f0 C4C17D6F 		vmovdqa	(%r15,%rax), %ymm7
 5283      3C07
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5284              		.loc 1 597 29 discriminator 3
 5285 38f6 C4427D30 		vpmovzxbw	(%r9,%rax), %ymm8
 5285      0401
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5286              		.loc 1 596 29 discriminator 3
 5287 38fc C4C27D30 		vpmovzxbw	(%r15,%rax), %ymm2
 5287      1407
 598:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5288              		.loc 1 598 29 discriminator 3
 5289 3902 C4C17D6F 		vmovdqa	(%r8,%rax), %ymm4
 5289      2400
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5290              		.loc 1 596 29 discriminator 3
 5291 3908 C4E37D39 		vextracti128	$0x1, %ymm7, %xmm3
 5291      FB01
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5292              		.loc 1 597 29 discriminator 3
 5293 390e C4427D33 		vpmovzxwd	%xmm8, %ymm12
 5293      E0
 5294 3913 C4C17D6F 		vmovdqa	(%r9,%rax), %ymm7
 5294      3C01
 5295 3919 C4437D39 		vextracti128	$0x1, %ymm8, %xmm8
 5295      C001
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5296              		.loc 1 596 29 discriminator 3
 5297 391f C4E27D30 		vpmovzxbw	%xmm3, %ymm3
 5297      DB
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5298              		.loc 1 597 21 discriminator 3
 5299 3924 C4417C5B 		vcvtdq2ps	%ymm12, %ymm12
 5299      E4
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5300              		.loc 1 596 29 discriminator 3
 5301 3929 C4E27D33 		vpmovzxwd	%xmm2, %ymm0
 5301      C2
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5302              		.loc 1 597 29 discriminator 3
 5303 392e C4427D33 		vpmovzxwd	%xmm8, %ymm8
 5303      C0
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5304              		.loc 1 596 29 discriminator 3
 5305 3933 C4E27D33 		vpmovzxwd	%xmm3, %ymm1
 5305      CB
 5306 3938 C4E37D39 		vextracti128	$0x1, %ymm3, %xmm3
 5306      DB01
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5307              		.loc 1 596 21 discriminator 3
 5308 393e C5FC5BC0 		vcvtdq2ps	%ymm0, %ymm0
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5309              		.loc 1 597 29 discriminator 3
 5310 3942 C4E37D39 		vextracti128	$0x1, %ymm7, %xmm5
 5310      FD01
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5311              		.loc 1 596 29 discriminator 3
 5312 3948 C4E27D33 		vpmovzxwd	%xmm3, %ymm3
 5312      DB
 5313              		.loc 1 598 29 discriminator 3
 5314 394d C4C27D30 		vpmovzxbw	(%r8,%rax), %ymm7
 5314      3C00
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5315              		.loc 1 597 21 discriminator 3
 5316 3953 C4417C5B 		vcvtdq2ps	%ymm8, %ymm8
 5316      C0
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5317              		.loc 1 596 29 discriminator 3
 5318 3958 C4E37D39 		vextracti128	$0x1, %ymm2, %xmm2
 5318      D201
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5319              		.loc 1 596 21 discriminator 3
 5320 395e C57C5BF3 		vcvtdq2ps	%ymm3, %ymm14
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5321              		.loc 1 596 29 discriminator 3
 5322 3962 C4E27D33 		vpmovzxwd	%xmm2, %ymm2
 5322      D2
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5323              		.loc 1 597 29 discriminator 3
 5324 3967 C4E27D30 		vpmovzxbw	%xmm5, %ymm5
 5324      ED
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5325              		.loc 1 596 21 discriminator 3
 5326 396c C5FC5BC9 		vcvtdq2ps	%ymm1, %ymm1
 5327              		.loc 1 598 29 discriminator 3
 5328 3970 C4627D33 		vpmovzxwd	%xmm7, %ymm11
 5328      DF
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5329              		.loc 1 596 21 discriminator 3
 5330 3975 C5FC5BD2 		vcvtdq2ps	%ymm2, %ymm2
 5331              		.loc 1 598 29 discriminator 3
 5332 3979 C4E37D39 		vextracti128	$0x1, %ymm7, %xmm7
 5332      FF01
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5333              		.loc 1 597 29 discriminator 3
 5334 397f C4627D33 		vpmovzxwd	%xmm5, %ymm10
 5334      D5
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5335              		.loc 1 597 21 discriminator 3
 5336 3984 C59C591D 		vmulps	.LC31(%rip), %ymm12, %ymm3
 5336      00000000 
 5337              		.loc 1 598 21 discriminator 3
 5338 398c C4417C5B 		vcvtdq2ps	%ymm11, %ymm11
 5338      DB
 5339              		.loc 1 598 29 discriminator 3
 5340 3991 C4E27D33 		vpmovzxwd	%xmm7, %ymm7
 5340      FF
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5341              		.loc 1 597 21 discriminator 3
 5342 3996 C4417C5B 		vcvtdq2ps	%ymm10, %ymm10
 5342      D2
 5343              		.loc 1 598 21 discriminator 3
 5344 399b C5FC5BFF 		vcvtdq2ps	%ymm7, %ymm7
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5345              		.loc 1 596 21 discriminator 3
 5346 399f C5FC5935 		vmulps	.LC30(%rip), %ymm0, %ymm6
 5346      00000000 
 5347              		.loc 1 598 29 discriminator 3
 5348 39a7 C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 5348      E401
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5349              		.loc 1 597 29 discriminator 3
 5350 39ad C4E37D39 		vextracti128	$0x1, %ymm5, %xmm5
 5350      ED01
 5351              		.loc 1 598 29 discriminator 3
 5352 39b3 C4E27D30 		vpmovzxbw	%xmm4, %ymm4
 5352      E4
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5353              		.loc 1 597 29 discriminator 3
 5354 39b8 C4E27D33 		vpmovzxwd	%xmm5, %ymm5
 5354      ED
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5355              		.loc 1 596 21 discriminator 3
 5356 39bd C57C2975 		vmovaps	%ymm14, -80(%rbp)
 5356      B0
 595:RGB2YCbCr.c   **** 					RGB2YCbCr[0][0]*Rpixels[j] + 
 5357              		.loc 1 595 26 discriminator 3
 5358 39c2 C5CC5835 		vaddps	.LC38(%rip), %ymm6, %ymm6
 5358      00000000 
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5359              		.loc 1 596 21 discriminator 3
 5360 39ca C56C592D 		vmulps	.LC30(%rip), %ymm2, %ymm13
 5360      00000000 
 5361              		.loc 1 598 29 discriminator 3
 5362 39d2 C4627D33 		vpmovzxwd	%xmm4, %ymm9
 5362      CC
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5363              		.loc 1 597 21 discriminator 3
 5364 39d7 C5FC5BED 		vcvtdq2ps	%ymm5, %ymm5
 5365              		.loc 1 598 29 discriminator 3
 5366 39db C4E37D39 		vextracti128	$0x1, %ymm4, %xmm4
 5366      E401
 595:RGB2YCbCr.c   **** 					RGB2YCbCr[0][0]*Rpixels[j] + 
 5367              		.loc 1 595 26 discriminator 3
 5368 39e1 C514582D 		vaddps	.LC38(%rip), %ymm13, %ymm13
 5368      00000000 
 5369              		.loc 1 598 21 discriminator 3
 5370 39e9 C4417C5B 		vcvtdq2ps	%ymm9, %ymm9
 5370      C9
 5371              		.loc 1 598 29 discriminator 3
 5372 39ee C4E27D33 		vpmovzxwd	%xmm4, %ymm4
 5372      E4
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5373              		.loc 1 596 33 discriminator 3
 5374 39f3 C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 5375              		.loc 1 598 21 discriminator 3
 5376 39f7 C5A4591D 		vmulps	.LC32(%rip), %ymm11, %ymm3
 5376      00000000 
 5377 39ff C5FC5BE4 		vcvtdq2ps	%ymm4, %ymm4
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5378              		.loc 1 597 33 discriminator 3
 5379 3a03 C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5380              		.loc 1 597 21 discriminator 3
 5381 3a07 C5BC591D 		vmulps	.LC31(%rip), %ymm8, %ymm3
 5381      00000000 
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5382              		.loc 1 594 30 discriminator 3
 5383 3a0f C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5384              		.loc 1 596 33 discriminator 3
 5385 3a13 C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 5386              		.loc 1 598 21 discriminator 3
 5387 3a17 C5C4591D 		vmulps	.LC32(%rip), %ymm7, %ymm3
 5387      00000000 
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5388              		.loc 1 597 33 discriminator 3
 5389 3a1f C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5390              		.loc 1 594 30 discriminator 3
 5391 3a23 C585DBDE 		vpand	%ymm6, %ymm15, %ymm3
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5392              		.loc 1 596 21 discriminator 3
 5393 3a27 C5F45935 		vmulps	.LC30(%rip), %ymm1, %ymm6
 5393      00000000 
 595:RGB2YCbCr.c   **** 					RGB2YCbCr[0][0]*Rpixels[j] + 
 5394              		.loc 1 595 26 discriminator 3
 5395 3a2f C5CC5835 		vaddps	.LC38(%rip), %ymm6, %ymm6
 5395      00000000 
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5396              		.loc 1 594 30 discriminator 3
 5397 3a37 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 5397      ED
 5398 3a3c C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 5398      ED
 5399 3a41 C4C2652B 		vpackusdw	%ymm13, %ymm3, %ymm3
 5399      DD
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5400              		.loc 1 597 21 discriminator 3
 5401 3a46 C52C592D 		vmulps	.LC31(%rip), %ymm10, %ymm13
 5401      00000000 
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5402              		.loc 1 594 30 discriminator 3
 5403 3a4e C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 5403      DBD8
 5404 3a54 C5E5DB1D 		vpand	.LC35(%rip), %ymm3, %ymm3
 5404      00000000 
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5405              		.loc 1 596 33 discriminator 3
 5406 3a5c C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 5406      F5
 5407              		.loc 1 598 21 discriminator 3
 5408 3a61 C534592D 		vmulps	.LC32(%rip), %ymm9, %ymm13
 5408      00000000 
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5409              		.loc 1 597 33 discriminator 3
 5410 3a69 C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 5410      F5
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5411              		.loc 1 596 21 discriminator 3
 5412 3a6e C50C592D 		vmulps	.LC30(%rip), %ymm14, %ymm13
 5412      00000000 
 595:RGB2YCbCr.c   **** 					RGB2YCbCr[0][0]*Rpixels[j] + 
 5413              		.loc 1 595 26 discriminator 3
 5414 3a76 C5145835 		vaddps	.LC38(%rip), %ymm13, %ymm14
 5414      00000000 
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5415              		.loc 1 597 21 discriminator 3
 5416 3a7e C554592D 		vmulps	.LC31(%rip), %ymm5, %ymm13
 5416      00000000 
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5417              		.loc 1 594 30 discriminator 3
 5418 3a86 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 5419 3a8a C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5420              		.loc 1 596 33 discriminator 3
 5421 3a8e C4410C58 		vaddps	%ymm13, %ymm14, %ymm13
 5421      ED
 5422              		.loc 1 598 21 discriminator 3
 5423 3a93 C55C5935 		vmulps	.LC32(%rip), %ymm4, %ymm14
 5423      00000000 
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5424              		.loc 1 597 33 discriminator 3
 5425 3a9b C4411458 		vaddps	%ymm14, %ymm13, %ymm13
 5425      EE
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5426              		.loc 1 594 30 discriminator 3
 5427 3aa0 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 5427      ED
 5428 3aa5 C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 5428      ED
 5429 3aaa C4C24D2B 		vpackusdw	%ymm13, %ymm6, %ymm6
 5429      F5
 599:RGB2YCbCr.c   **** 				Cbpixels[j] = (unsigned char) (0.5f +
 600:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 601:RGB2YCbCr.c   **** 					RGB2YCbCr[1][0]*Rpixels[j] +
 5430              		.loc 1 601 21 discriminator 3
 5431 3aaf C56C592D 		vmulps	.LC36(%rip), %ymm2, %ymm13
 5431      00000000 
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5432              		.loc 1 594 30 discriminator 3
 5433 3ab7 C4E3FD00 		vpermq	$216, %ymm6, %ymm6
 5433      F6D8
 5434 3abd C5CDDB35 		vpand	.LC35(%rip), %ymm6, %ymm6
 5434      00000000 
 600:RGB2YCbCr.c   **** 					RGB2YCbCr[1][0]*Rpixels[j] +
 5435              		.loc 1 600 26 discriminator 3
 5436 3ac5 C514582D 		vaddps	.LC64(%rip), %ymm13, %ymm13
 5436      00000000 
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5437              		.loc 1 594 30 discriminator 3
 5438 3acd C5E567DE 		vpackuswb	%ymm6, %ymm3, %ymm3
 5439              		.loc 1 601 21 discriminator 3
 5440 3ad1 C5FC5935 		vmulps	.LC36(%rip), %ymm0, %ymm6
 5440      00000000 
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5441              		.loc 1 594 30 discriminator 3
 5442 3ad9 C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 5442      DBD8
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5443              		.loc 1 594 28 discriminator 3
 5444 3adf C4C17D7F 		vmovdqa	%ymm3, (%r12,%rax)
 5444      1C04
 599:RGB2YCbCr.c   **** 				Cbpixels[j] = (unsigned char) (0.5f +
 5445              		.loc 1 599 5 is_stmt 1 discriminator 3
 602:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5446              		.loc 1 602 21 is_stmt 0 discriminator 3
 5447 3ae5 C59C591D 		vmulps	.LC37(%rip), %ymm12, %ymm3
 5447      00000000 
 600:RGB2YCbCr.c   **** 					RGB2YCbCr[1][0]*Rpixels[j] +
 5448              		.loc 1 600 26 discriminator 3
 5449 3aed C5CC5835 		vaddps	.LC64(%rip), %ymm6, %ymm6
 5449      00000000 
 601:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5450              		.loc 1 601 33 discriminator 3
 5451 3af5 C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 603:RGB2YCbCr.c   **** 					RGB2YCbCr[1][2]*Bpixels[j]);
 5452              		.loc 1 603 21 discriminator 3
 5453 3af9 C5A4591D 		vmulps	.LC38(%rip), %ymm11, %ymm3
 5453      00000000 
 602:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5454              		.loc 1 602 33 discriminator 3
 5455 3b01 C5CC58F3 		vaddps	%ymm3, %ymm6, %ymm6
 602:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5456              		.loc 1 602 21 discriminator 3
 5457 3b05 C5BC591D 		vmulps	.LC37(%rip), %ymm8, %ymm3
 5457      00000000 
 601:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5458              		.loc 1 601 21 discriminator 3
 5459 3b0d C57C2875 		vmovaps	-80(%rbp), %ymm14
 5459      B0
 604:RGB2YCbCr.c   **** 				Crpixels[j] = (unsigned char) (0.5f +
 605:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 606:RGB2YCbCr.c   **** 					RGB2YCbCr[2][0]*Rpixels[j] +
 607:RGB2YCbCr.c   **** 					RGB2YCbCr[2][1]*Gpixels[j] +
 5460              		.loc 1 607 21 discriminator 3
 5461 3b12 C53C5905 		vmulps	.LC40(%rip), %ymm8, %ymm8
 5461      00000000 
 606:RGB2YCbCr.c   **** 					RGB2YCbCr[2][1]*Gpixels[j] +
 5462              		.loc 1 606 21 discriminator 3
 5463 3b1a C5EC5915 		vmulps	.LC38(%rip), %ymm2, %ymm2
 5463      00000000 
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5464              		.loc 1 599 19 discriminator 3
 5465 3b22 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 605:RGB2YCbCr.c   **** 					RGB2YCbCr[2][0]*Rpixels[j] +
 5466              		.loc 1 605 26 discriminator 3
 5467 3b26 C5EC5815 		vaddps	.LC64(%rip), %ymm2, %ymm2
 5467      00000000 
 5468              		.loc 1 607 21 discriminator 3
 5469 3b2e C51C5925 		vmulps	.LC40(%rip), %ymm12, %ymm12
 5469      00000000 
 606:RGB2YCbCr.c   **** 					RGB2YCbCr[2][1]*Gpixels[j] +
 5470              		.loc 1 606 21 discriminator 3
 5471 3b36 C5FC5905 		vmulps	.LC38(%rip), %ymm0, %ymm0
 5471      00000000 
 601:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5472              		.loc 1 601 33 discriminator 3
 5473 3b3e C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 603:RGB2YCbCr.c   **** 				Crpixels[j] = (unsigned char) (0.5f +
 5474              		.loc 1 603 21 discriminator 3
 5475 3b42 C5C4591D 		vmulps	.LC38(%rip), %ymm7, %ymm3
 5475      00000000 
 605:RGB2YCbCr.c   **** 					RGB2YCbCr[2][0]*Rpixels[j] +
 5476              		.loc 1 605 26 discriminator 3
 5477 3b4a C5FC5805 		vaddps	.LC64(%rip), %ymm0, %ymm0
 5477      00000000 
 606:RGB2YCbCr.c   **** 					RGB2YCbCr[2][1]*Gpixels[j] +
 5478              		.loc 1 606 33 discriminator 3
 5479 3b52 C4416C58 		vaddps	%ymm8, %ymm2, %ymm8
 5479      C0
 608:RGB2YCbCr.c   **** 					RGB2YCbCr[2][2]*Bpixels[j]);
 5480              		.loc 1 608 21 discriminator 3
 5481 3b57 C524591D 		vmulps	.LC41(%rip), %ymm11, %ymm11
 5481      00000000 
 5482 3b5f C5C4593D 		vmulps	.LC41(%rip), %ymm7, %ymm7
 5482      00000000 
 606:RGB2YCbCr.c   **** 					RGB2YCbCr[2][1]*Gpixels[j] +
 5483              		.loc 1 606 33 discriminator 3
 5484 3b67 C4417C58 		vaddps	%ymm12, %ymm0, %ymm12
 5484      E4
 602:RGB2YCbCr.c   **** 					RGB2YCbCr[1][2]*Bpixels[j]);
 5485              		.loc 1 602 33 discriminator 3
 5486 3b6c C51458EB 		vaddps	%ymm3, %ymm13, %ymm13
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5487              		.loc 1 599 19 discriminator 3
 5488 3b70 C585DBDE 		vpand	%ymm6, %ymm15, %ymm3
 601:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5489              		.loc 1 601 21 discriminator 3
 5490 3b74 C5F45935 		vmulps	.LC36(%rip), %ymm1, %ymm6
 5490      00000000 
 607:RGB2YCbCr.c   **** 					RGB2YCbCr[2][2]*Bpixels[j]);
 5491              		.loc 1 607 33 discriminator 3
 5492 3b7c C4411C58 		vaddps	%ymm11, %ymm12, %ymm11
 5492      DB
 600:RGB2YCbCr.c   **** 					RGB2YCbCr[1][0]*Rpixels[j] +
 5493              		.loc 1 600 26 discriminator 3
 5494 3b81 C5CC5835 		vaddps	.LC64(%rip), %ymm6, %ymm6
 5494      00000000 
 606:RGB2YCbCr.c   **** 					RGB2YCbCr[2][1]*Gpixels[j] +
 5495              		.loc 1 606 21 discriminator 3
 5496 3b89 C5F4590D 		vmulps	.LC38(%rip), %ymm1, %ymm1
 5496      00000000 
 607:RGB2YCbCr.c   **** 					RGB2YCbCr[2][2]*Bpixels[j]);
 5497              		.loc 1 607 33 discriminator 3
 5498 3b91 C5BC58FF 		vaddps	%ymm7, %ymm8, %ymm7
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5499              		.loc 1 599 19 discriminator 3
 5500 3b95 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 5500      ED
 5501 3b9a C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 5501      ED
 605:RGB2YCbCr.c   **** 					RGB2YCbCr[2][0]*Rpixels[j] +
 5502              		.loc 1 605 26 discriminator 3
 5503 3b9f C5F4580D 		vaddps	.LC64(%rip), %ymm1, %ymm1
 5503      00000000 
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5504              		.loc 1 599 19 discriminator 3
 5505 3ba7 C4C2652B 		vpackusdw	%ymm13, %ymm3, %ymm3
 5505      DD
 604:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 5506              		.loc 1 604 19 discriminator 3
 5507 3bac C4C17E5B 		vcvttps2dq	%ymm11, %ymm0
 5507      C3
 5508 3bb1 C585DBC0 		vpand	%ymm0, %ymm15, %ymm0
 602:RGB2YCbCr.c   **** 					RGB2YCbCr[1][2]*Bpixels[j]);
 5509              		.loc 1 602 21 discriminator 3
 5510 3bb5 C52C592D 		vmulps	.LC37(%rip), %ymm10, %ymm13
 5510      00000000 
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5511              		.loc 1 599 19 discriminator 3
 5512 3bbd C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 5512      DBD8
 604:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 5513              		.loc 1 604 19 discriminator 3
 5514 3bc3 C5FE5BFF 		vcvttps2dq	%ymm7, %ymm7
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5515              		.loc 1 599 19 discriminator 3
 5516 3bc7 C5E5DB1D 		vpand	.LC35(%rip), %ymm3, %ymm3
 5516      00000000 
 607:RGB2YCbCr.c   **** 					RGB2YCbCr[2][2]*Bpixels[j]);
 5517              		.loc 1 607 21 discriminator 3
 5518 3bcf C52C5915 		vmulps	.LC40(%rip), %ymm10, %ymm10
 5518      00000000 
 604:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 5519              		.loc 1 604 19 discriminator 3
 5520 3bd7 C585DBFF 		vpand	%ymm7, %ymm15, %ymm7
 5521 3bdb C4E27D2B 		vpackusdw	%ymm7, %ymm0, %ymm0
 5521      C7
 5522 3be0 C4E3FD00 		vpermq	$216, %ymm0, %ymm0
 5522      C0D8
 5523 3be6 C5FDDB05 		vpand	.LC35(%rip), %ymm0, %ymm0
 5523      00000000 
 601:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5524              		.loc 1 601 33 discriminator 3
 5525 3bee C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 5525      F5
 603:RGB2YCbCr.c   **** 				Crpixels[j] = (unsigned char) (0.5f +
 5526              		.loc 1 603 21 discriminator 3
 5527 3bf3 C534592D 		vmulps	.LC38(%rip), %ymm9, %ymm13
 5527      00000000 
 5528              		.loc 1 608 21 discriminator 3
 5529 3bfb C534590D 		vmulps	.LC41(%rip), %ymm9, %ymm9
 5529      00000000 
 606:RGB2YCbCr.c   **** 					RGB2YCbCr[2][1]*Gpixels[j] +
 5530              		.loc 1 606 33 discriminator 3
 5531 3c03 C4C17458 		vaddps	%ymm10, %ymm1, %ymm1
 5531      CA
 602:RGB2YCbCr.c   **** 					RGB2YCbCr[1][2]*Bpixels[j]);
 5532              		.loc 1 602 33 discriminator 3
 5533 3c08 C4C14C58 		vaddps	%ymm13, %ymm6, %ymm6
 5533      F5
 601:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5534              		.loc 1 601 21 discriminator 3
 5535 3c0d C50C592D 		vmulps	.LC36(%rip), %ymm14, %ymm13
 5535      00000000 
 600:RGB2YCbCr.c   **** 					RGB2YCbCr[1][0]*Rpixels[j] +
 5536              		.loc 1 600 26 discriminator 3
 5537 3c15 C5145835 		vaddps	.LC64(%rip), %ymm13, %ymm14
 5537      00000000 
 602:RGB2YCbCr.c   **** 					RGB2YCbCr[1][2]*Bpixels[j]);
 5538              		.loc 1 602 21 discriminator 3
 5539 3c1d C554592D 		vmulps	.LC37(%rip), %ymm5, %ymm13
 5539      00000000 
 607:RGB2YCbCr.c   **** 					RGB2YCbCr[2][2]*Bpixels[j]);
 5540              		.loc 1 607 33 discriminator 3
 5541 3c25 C4C17458 		vaddps	%ymm9, %ymm1, %ymm1
 5541      C9
 607:RGB2YCbCr.c   **** 					RGB2YCbCr[2][2]*Bpixels[j]);
 5542              		.loc 1 607 21 discriminator 3
 5543 3c2a C5D4592D 		vmulps	.LC40(%rip), %ymm5, %ymm5
 5543      00000000 
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5544              		.loc 1 599 19 discriminator 3
 5545 3c32 C5FE5BF6 		vcvttps2dq	%ymm6, %ymm6
 5546 3c36 C585DBF6 		vpand	%ymm6, %ymm15, %ymm6
 604:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 5547              		.loc 1 604 19 discriminator 3
 5548 3c3a C5FE5BC9 		vcvttps2dq	%ymm1, %ymm1
 5549 3c3e C585DBC9 		vpand	%ymm1, %ymm15, %ymm1
 601:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5550              		.loc 1 601 33 discriminator 3
 5551 3c42 C4410C58 		vaddps	%ymm13, %ymm14, %ymm13
 5551      ED
 603:RGB2YCbCr.c   **** 				Crpixels[j] = (unsigned char) (0.5f +
 5552              		.loc 1 603 21 discriminator 3
 5553 3c47 C55C5935 		vmulps	.LC38(%rip), %ymm4, %ymm14
 5553      00000000 
 5554              		.loc 1 608 21 discriminator 3
 5555 3c4f C5DC5925 		vmulps	.LC41(%rip), %ymm4, %ymm4
 5555      00000000 
 602:RGB2YCbCr.c   **** 					RGB2YCbCr[1][2]*Bpixels[j]);
 5556              		.loc 1 602 33 discriminator 3
 5557 3c57 C4411458 		vaddps	%ymm14, %ymm13, %ymm13
 5557      EE
 606:RGB2YCbCr.c   **** 					RGB2YCbCr[2][1]*Gpixels[j] +
 5558              		.loc 1 606 21 discriminator 3
 5559 3c5c C57C2875 		vmovaps	-80(%rbp), %ymm14
 5559      B0
 5560 3c61 C58C5915 		vmulps	.LC38(%rip), %ymm14, %ymm2
 5560      00000000 
 605:RGB2YCbCr.c   **** 					RGB2YCbCr[2][0]*Rpixels[j] +
 5561              		.loc 1 605 26 discriminator 3
 5562 3c69 C5EC5815 		vaddps	.LC64(%rip), %ymm2, %ymm2
 5562      00000000 
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5563              		.loc 1 599 19 discriminator 3
 5564 3c71 C4417E5B 		vcvttps2dq	%ymm13, %ymm13
 5564      ED
 5565 3c76 C44105DB 		vpand	%ymm13, %ymm15, %ymm13
 5565      ED
 606:RGB2YCbCr.c   **** 					RGB2YCbCr[2][1]*Gpixels[j] +
 5566              		.loc 1 606 33 discriminator 3
 5567 3c7b C5EC58ED 		vaddps	%ymm5, %ymm2, %ymm5
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5568              		.loc 1 599 19 discriminator 3
 5569 3c7f C4C24D2B 		vpackusdw	%ymm13, %ymm6, %ymm6
 5569      F5
 5570 3c84 C4E3FD00 		vpermq	$216, %ymm6, %ymm6
 5570      F6D8
 5571 3c8a C5CDDB35 		vpand	.LC35(%rip), %ymm6, %ymm6
 5571      00000000 
 607:RGB2YCbCr.c   **** 					RGB2YCbCr[2][2]*Bpixels[j]);
 5572              		.loc 1 607 33 discriminator 3
 5573 3c92 C5D458E4 		vaddps	%ymm4, %ymm5, %ymm4
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5574              		.loc 1 599 19 discriminator 3
 5575 3c96 C5E567DE 		vpackuswb	%ymm6, %ymm3, %ymm3
 5576 3c9a C4E3FD00 		vpermq	$216, %ymm3, %ymm3
 5576      DBD8
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5577              		.loc 1 599 17 discriminator 3
 5578 3ca0 C4C17D7F 		vmovdqa	%ymm3, 0(%r13,%rax)
 5578      5C0500
 604:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 5579              		.loc 1 604 5 is_stmt 1 discriminator 3
 604:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 5580              		.loc 1 604 19 is_stmt 0 discriminator 3
 5581 3ca7 C5FE5BE4 		vcvttps2dq	%ymm4, %ymm4
 5582 3cab C585DBE4 		vpand	%ymm4, %ymm15, %ymm4
 5583 3caf C4E2752B 		vpackusdw	%ymm4, %ymm1, %ymm1
 5583      CC
 5584 3cb4 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 5584      C9D8
 5585 3cba C5F5DB0D 		vpand	.LC35(%rip), %ymm1, %ymm1
 5585      00000000 
 5586 3cc2 C5FD67C9 		vpackuswb	%ymm1, %ymm0, %ymm1
 5587 3cc6 C4E3FD00 		vpermq	$216, %ymm1, %ymm1
 5587      C9D8
 604:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 5588              		.loc 1 604 17 discriminator 3
 5589 3ccc C4C17D7F 		vmovdqa	%ymm1, (%r14,%rax)
 5589      0C06
 592:RGB2YCbCr.c   ****             {
 5590              		.loc 1 592 40 is_stmt 1 discriminator 3
 592:RGB2YCbCr.c   ****             {
 5591              		.loc 1 592 29 discriminator 3
 5592 3cd2 4883C020 		addq	$32, %rax
 5593 3cd6 4C39D0   		cmpq	%r10, %rax
 5594 3cd9 0F8511FC 		jne	.L142
 5594      FFFF
 5595 3cdf 8B4590   		movl	-112(%rbp), %eax
 5596 3ce2 39C3     		cmpl	%eax, %ebx
 5597 3ce4 0F84ED00 		je	.L143
 5597      0000
 604:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 5598              		.loc 1 604 17 is_stmt 0
 5599 3cea 4863D0   		movslq	%eax, %rdx
 5600              	.L141:
 5601 3ced C57A1015 		vmovss	.LC1(%rip), %xmm10
 5601      00000000 
 5602 3cf5 C5FA1015 		vmovss	.LC8(%rip), %xmm2
 5602      00000000 
 5603 3cfd C57A100D 		vmovss	.LC3(%rip), %xmm9
 5603      00000000 
 5604 3d05 C57A1005 		vmovss	.LC4(%rip), %xmm8
 5604      00000000 
 5605 3d0d C5FA103D 		vmovss	.LC5(%rip), %xmm7
 5605      00000000 
 5606 3d15 C5FA101D 		vmovss	.LC65(%rip), %xmm3
 5606      00000000 
 5607 3d1d C5FA1035 		vmovss	.LC7(%rip), %xmm6
 5607      00000000 
 5608 3d25 C5FA102D 		vmovss	.LC9(%rip), %xmm5
 5608      00000000 
 5609 3d2d C5FA1025 		vmovss	.LC10(%rip), %xmm4
 5609      00000000 
 5610              		.p2align 4,,10
 5611 3d35 0F1F00   		.p2align 3
 5612              	.L144:
 5613              	.LVL275:
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5614              		.loc 1 594 17 is_stmt 1
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5615              		.loc 1 596 29 is_stmt 0
 5616 3d38 410FB604 		movzbl	(%r15,%rdx), %eax
 5616      17
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5617              		.loc 1 596 21
 5618 3d3d C5F057C9 		vxorps	%xmm1, %xmm1, %xmm1
 5619 3d41 C5F22AC0 		vcvtsi2ssl	%eax, %xmm1, %xmm0
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5620              		.loc 1 597 29
 5621 3d45 410FB604 		movzbl	(%r9,%rdx), %eax
 5621      11
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5622              		.loc 1 597 21
 5623 3d4a C5722AD8 		vcvtsi2ssl	%eax, %xmm1, %xmm11
 598:RGB2YCbCr.c   **** 				Cbpixels[j] = (unsigned char) (0.5f +
 5624              		.loc 1 598 29
 5625 3d4e 410FB604 		movzbl	(%r8,%rdx), %eax
 5625      10
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5626              		.loc 1 596 21
 5627 3d53 C4417A59 		vmulss	%xmm10, %xmm0, %xmm12
 5627      E2
 598:RGB2YCbCr.c   **** 				Cbpixels[j] = (unsigned char) (0.5f +
 5628              		.loc 1 598 21
 5629 3d58 C5F22AC8 		vcvtsi2ssl	%eax, %xmm1, %xmm1
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5630              		.loc 1 597 21
 5631 3d5c C4412259 		vmulss	%xmm9, %xmm11, %xmm13
 5631      E9
 595:RGB2YCbCr.c   **** 					RGB2YCbCr[0][0]*Rpixels[j] + 
 5632              		.loc 1 595 26
 5633 3d61 C51A58E2 		vaddss	%xmm2, %xmm12, %xmm12
 596:RGB2YCbCr.c   **** 					RGB2YCbCr[0][1]*Gpixels[j] + 
 5634              		.loc 1 596 33
 5635 3d65 C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 5635      E5
 598:RGB2YCbCr.c   **** 				Cbpixels[j] = (unsigned char) (0.5f +
 5636              		.loc 1 598 21
 5637 3d6a C4417259 		vmulss	%xmm8, %xmm1, %xmm13
 5637      E8
 597:RGB2YCbCr.c   **** 					RGB2YCbCr[0][2]*Bpixels[j]);
 5638              		.loc 1 597 33
 5639 3d6f C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 5639      E5
 602:RGB2YCbCr.c   **** 					RGB2YCbCr[1][2]*Bpixels[j]);
 5640              		.loc 1 602 21
 5641 3d74 C52259EE 		vmulss	%xmm6, %xmm11, %xmm13
 607:RGB2YCbCr.c   **** 					RGB2YCbCr[2][2]*Bpixels[j]);
 5642              		.loc 1 607 21
 5643 3d78 C52259DD 		vmulss	%xmm5, %xmm11, %xmm11
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5644              		.loc 1 594 30
 5645 3d7c C4C17A2C 		vcvttss2sil	%xmm12, %eax
 5645      C4
 601:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5646              		.loc 1 601 21
 5647 3d81 C57A59E7 		vmulss	%xmm7, %xmm0, %xmm12
 606:RGB2YCbCr.c   **** 					RGB2YCbCr[2][1]*Gpixels[j] +
 5648              		.loc 1 606 21
 5649 3d85 C5FA59C2 		vmulss	%xmm2, %xmm0, %xmm0
 594:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[0] + 
 5650              		.loc 1 594 30
 5651 3d89 41880414 		movb	%al, (%r12,%rdx)
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5652              		.loc 1 599 5 is_stmt 1
 600:RGB2YCbCr.c   **** 					RGB2YCbCr[1][0]*Rpixels[j] +
 5653              		.loc 1 600 26 is_stmt 0
 5654 3d8d C51A58E3 		vaddss	%xmm3, %xmm12, %xmm12
 605:RGB2YCbCr.c   **** 					RGB2YCbCr[2][0]*Rpixels[j] +
 5655              		.loc 1 605 26
 5656 3d91 C5FA58C3 		vaddss	%xmm3, %xmm0, %xmm0
 601:RGB2YCbCr.c   **** 					RGB2YCbCr[1][1]*Gpixels[j] +
 5657              		.loc 1 601 33
 5658 3d95 C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 5658      E5
 603:RGB2YCbCr.c   **** 				Crpixels[j] = (unsigned char) (0.5f +
 5659              		.loc 1 603 21
 5660 3d9a C57259EA 		vmulss	%xmm2, %xmm1, %xmm13
 5661              		.loc 1 608 21
 5662 3d9e C5F259CC 		vmulss	%xmm4, %xmm1, %xmm1
 606:RGB2YCbCr.c   **** 					RGB2YCbCr[2][1]*Gpixels[j] +
 5663              		.loc 1 606 33
 5664 3da2 C4C17A58 		vaddss	%xmm11, %xmm0, %xmm0
 5664      C3
 602:RGB2YCbCr.c   **** 					RGB2YCbCr[1][2]*Bpixels[j]);
 5665              		.loc 1 602 33
 5666 3da7 C4411A58 		vaddss	%xmm13, %xmm12, %xmm12
 5666      E5
 607:RGB2YCbCr.c   **** 					RGB2YCbCr[2][2]*Bpixels[j]);
 5667              		.loc 1 607 33
 5668 3dac C5FA58C1 		vaddss	%xmm1, %xmm0, %xmm0
 599:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[1] +
 5669              		.loc 1 599 19
 5670 3db0 C4C17A2C 		vcvttss2sil	%xmm12, %eax
 5670      C4
 5671 3db5 41884415 		movb	%al, 0(%r13,%rdx)
 5671      00
 604:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 5672              		.loc 1 604 5 is_stmt 1
 604:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 5673              		.loc 1 604 19 is_stmt 0
 5674 3dba C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 5675 3dbe 41880416 		movb	%al, (%r14,%rdx)
 592:RGB2YCbCr.c   ****             {
 5676              		.loc 1 592 40 is_stmt 1
 5677              	.LVL276:
 592:RGB2YCbCr.c   ****             {
 5678              		.loc 1 592 29
 5679 3dc2 48FFC2   		incq	%rdx
 5680              	.LVL277:
 592:RGB2YCbCr.c   ****             {
 5681              		.loc 1 592 13 is_stmt 0
 5682 3dc5 39D3     		cmpl	%edx, %ebx
 5683 3dc7 0F8F6BFF 		jg	.L144
 5683      FFFF
 5684 3dcd 837D941E 		cmpl	$30, -108(%rbp)
 5685 3dd1 0F861402 		jbe	.L154
 5685      0000
 5686              	.L143:
 5687 3dd7 438D145B 		leal	(%r11,%r11,2), %edx
 604:RGB2YCbCr.c   **** 					RGB2YCbCr_offset[2] +
 5688              		.loc 1 604 17
 5689 3ddb 31C0     		xorl	%eax, %eax
 5690 3ddd 4863D2   		movslq	%edx, %rdx
 5691 3de0 48035598 		addq	-104(%rbp), %rdx
 5692              	.LVL278:
 5693              		.p2align 4,,10
 5694 3de4 0F1F4000 		.p2align 3
 5695              	.L146:
 5696              	.LBE62:
 5697              	.LBB63:
 609:RGB2YCbCr.c   ****             }
 610:RGB2YCbCr.c   ****             /* transformaci贸n SoA -> AoS */
 611:RGB2YCbCr.c   ****             #pragma GCC ivdep
 612:RGB2YCbCr.c   ****             for (int j = 0; j < BLOCK; j++)
 613:RGB2YCbCr.c   ****             {
 614:RGB2YCbCr.c   ****                 pout[3*j + 0] = Ypixels[j];
 5698              		.loc 1 614 17 is_stmt 1 discriminator 3
 5699              		.loc 1 614 40 is_stmt 0 discriminator 3
 5700 3de8 C4C17D6F 		vmovdqa	(%r12,%rax), %ymm0
 5700      0404
 615:RGB2YCbCr.c   **** 				pout[3*j + 1] = Cbpixels[j];
 5701              		.loc 1 615 5 is_stmt 1 discriminator 3
 5702              		.loc 1 615 29 is_stmt 0 discriminator 3
 5703 3dee C4C17D6F 		vmovdqa	0(%r13,%rax), %ymm2
 5703      540500
 616:RGB2YCbCr.c   **** 				pout[3*j + 2] = Crpixels[j];
 5704              		.loc 1 616 5 is_stmt 1 discriminator 3
 5705 3df5 4883C260 		addq	$96, %rdx
 5706              		.loc 1 616 29 is_stmt 0 discriminator 3
 5707 3df9 C4C17D6F 		vmovdqa	(%r14,%rax), %ymm1
 5707      0C06
 5708              		.loc 1 616 19 discriminator 3
 5709 3dff C5FD6F3D 		vmovdqa	.LC53(%rip), %ymm7
 5709      00000000 
 5710 3e07 4883C020 		addq	$32, %rax
 5711 3e0b C4E27D00 		vpshufb	.LC42(%rip), %ymm0, %ymm3
 5711      1D000000 
 5711      00
 5712 3e14 C4E26D00 		vpshufb	.LC43(%rip), %ymm2, %ymm4
 5712      25000000 
 5712      00
 5713 3e1d C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 5713      EC4E
 5714 3e23 C4E3FD00 		vpermq	$78, %ymm3, %ymm6
 5714      F34E
 5715 3e29 C4E26D00 		vpshufb	.LC45(%rip), %ymm2, %ymm4
 5715      25000000 
 5715      00
 5716 3e32 C4E27D00 		vpshufb	.LC44(%rip), %ymm0, %ymm3
 5716      1D000000 
 5716      00
 5717 3e3b C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 5718 3e3f C5E5EBDE 		vpor	%ymm6, %ymm3, %ymm3
 5719 3e43 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 5720 3e47 C4E27500 		vpshufb	.LC46(%rip), %ymm1, %ymm4
 5720      25000000 
 5720      00
 5721 3e50 C4E26500 		vpshufb	.LC47(%rip), %ymm3, %ymm3
 5721      1D000000 
 5721      00
 5722 3e59 C4E3FD00 		vpermq	$78, %ymm4, %ymm5
 5722      EC4E
 5723 3e5f C4E27500 		vpshufb	.LC48(%rip), %ymm1, %ymm4
 5723      25000000 
 5723      00
 5724 3e68 C5DDEBE5 		vpor	%ymm5, %ymm4, %ymm4
 5725 3e6c C4E26D00 		vpshufb	.LC51(%rip), %ymm2, %ymm5
 5725      2D000000 
 5725      00
 5726 3e75 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 5727 3e79 C5FE7F5A 		vmovdqu	%ymm3, -96(%rdx)
 5727      A0
 5728 3e7e C4E27D00 		vpshufb	.LC49(%rip), %ymm0, %ymm3
 5728      1D000000 
 5728      00
 5729 3e87 C4E3FD00 		vpermq	$78, %ymm3, %ymm4
 5729      E34E
 5730 3e8d C4E27D00 		vpshufb	.LC50(%rip), %ymm0, %ymm3
 5730      1D000000 
 5730      00
 5731 3e96 C5E5EBDC 		vpor	%ymm4, %ymm3, %ymm3
 5732 3e9a C4E27500 		vpshufb	.LC52(%rip), %ymm1, %ymm4
 5732      25000000 
 5732      00
 5733 3ea3 C5E5EBDD 		vpor	%ymm5, %ymm3, %ymm3
 5734 3ea7 C4E3654C 		vpblendvb	%ymm7, %ymm4, %ymm3, %ymm3
 5734      DC70
 5735 3ead C4E27D00 		vpshufb	.LC54(%rip), %ymm0, %ymm4
 5735      25000000 
 5735      00
 5736 3eb6 C4E27D00 		vpshufb	.LC56(%rip), %ymm0, %ymm0
 5736      05000000 
 5736      00
 5737 3ebf C5FE7F5A 		vmovdqu	%ymm3, -64(%rdx)
 5737      C0
 5738 3ec4 C4E3FD00 		vpermq	$78, %ymm4, %ymm4
 5738      E44E
 5739 3eca C4E26D00 		vpshufb	.LC55(%rip), %ymm2, %ymm3
 5739      1D000000 
 5739      00
 5740 3ed3 C4E26D00 		vpshufb	.LC57(%rip), %ymm2, %ymm2
 5740      15000000 
 5740      00
 5741 3edc C4E3FD00 		vpermq	$78, %ymm3, %ymm3
 5741      DB4E
 5742 3ee2 C5FDEBC4 		vpor	%ymm4, %ymm0, %ymm0
 5743 3ee6 C5EDEBD3 		vpor	%ymm3, %ymm2, %ymm2
 5744 3eea C5FDEBC2 		vpor	%ymm2, %ymm0, %ymm0
 5745 3eee C4E27500 		vpshufb	.LC58(%rip), %ymm1, %ymm2
 5745      15000000 
 5745      00
 5746 3ef7 C4E27500 		vpshufb	.LC60(%rip), %ymm1, %ymm1
 5746      0D000000 
 5746      00
 5747 3f00 C4E27D00 		vpshufb	.LC59(%rip), %ymm0, %ymm0
 5747      05000000 
 5747      00
 5748 3f09 C4E3FD00 		vpermq	$78, %ymm2, %ymm2
 5748      D24E
 5749 3f0f C5F5EBCA 		vpor	%ymm2, %ymm1, %ymm1
 5750 3f13 C5FDEBC1 		vpor	%ymm1, %ymm0, %ymm0
 5751 3f17 C5FE7F42 		vmovdqu	%ymm0, -32(%rdx)
 5751      E0
 612:RGB2YCbCr.c   ****             {
 5752              		.loc 1 612 40 is_stmt 1 discriminator 3
 612:RGB2YCbCr.c   ****             {
 5753              		.loc 1 612 29 discriminator 3
 5754 3f1c 4C39D0   		cmpq	%r10, %rax
 5755 3f1f 0F85C3FE 		jne	.L146
 5755      FFFF
 5756 3f25 8B4590   		movl	-112(%rbp), %eax
 5757 3f28 39C3     		cmpl	%eax, %ebx
 5758 3f2a 7438     		je	.L136
 5759              		.loc 1 616 19 is_stmt 0
 5760 3f2c 89C2     		movl	%eax, %edx
 5761              	.L145:
 5762 3f2e 4863C2   		movslq	%edx, %rax
 5763 3f31 8D1452   		leal	(%rdx,%rdx,2), %edx
 5764 3f34 4863D2   		movslq	%edx, %rdx
 5765 3f37 480355A0 		addq	-96(%rbp), %rdx
 5766 3f3b 48035598 		addq	-104(%rbp), %rdx
 5767 3f3f 90       		.p2align 4,,10
 5768              		.p2align 3
 5769              	.L148:
 5770              	.LVL279:
 614:RGB2YCbCr.c   **** 				pout[3*j + 1] = Cbpixels[j];
 5771              		.loc 1 614 17 is_stmt 1
 614:RGB2YCbCr.c   **** 				pout[3*j + 1] = Cbpixels[j];
 5772              		.loc 1 614 31 is_stmt 0
 5773 3f40 410FB60C 		movzbl	(%r12,%rax), %ecx
 5773      04
 5774 3f45 4883C203 		addq	$3, %rdx
 5775 3f49 884AFD   		movb	%cl, -3(%rdx)
 615:RGB2YCbCr.c   **** 				pout[3*j + 2] = Crpixels[j];
 5776              		.loc 1 615 5 is_stmt 1
 615:RGB2YCbCr.c   **** 				pout[3*j + 2] = Crpixels[j];
 5777              		.loc 1 615 19 is_stmt 0
 5778 3f4c 410FB64C 		movzbl	0(%r13,%rax), %ecx
 5778      0500
 5779 3f52 884AFE   		movb	%cl, -2(%rdx)
 5780              		.loc 1 616 5 is_stmt 1
 5781              		.loc 1 616 19 is_stmt 0
 5782 3f55 410FB60C 		movzbl	(%r14,%rax), %ecx
 5782      06
 5783 3f5a 48FFC0   		incq	%rax
 5784              	.LVL280:
 5785 3f5d 884AFF   		movb	%cl, -1(%rdx)
 612:RGB2YCbCr.c   ****             {
 5786              		.loc 1 612 40 is_stmt 1
 612:RGB2YCbCr.c   ****             {
 5787              		.loc 1 612 29
 612:RGB2YCbCr.c   ****             {
 5788              		.loc 1 612 13 is_stmt 0
 5789 3f60 39C3     		cmpl	%eax, %ebx
 5790 3f62 7FDC     		jg	.L148
 5791              	.L136:
 5792              	.LBE63:
 577:RGB2YCbCr.c   ****         {
 5793              		.loc 1 577 43 is_stmt 1
 5794 3f64 488BB570 		movq	-144(%rbp), %rsi
 5794      FFFFFF
 577:RGB2YCbCr.c   ****         {
 5795              		.loc 1 577 44 is_stmt 0
 5796 3f6b 4101DB   		addl	%ebx, %r11d
 5797              	.LVL281:
 577:RGB2YCbCr.c   ****         {
 5798              		.loc 1 577 25 is_stmt 1
 5799 3f6e 480175A0 		addq	%rsi, -96(%rbp)
 5800              	.LVL282:
 577:RGB2YCbCr.c   ****         {
 5801              		.loc 1 577 9 is_stmt 0
 5802 3f72 443B5D8C 		cmpl	-116(%rbp), %r11d
 5803 3f76 0F8CB4F7 		jl	.L149
 5803      FFFF
 5804              	.LVL283:
 5805              	.L151:
 5806              	.LBE67:
 617:RGB2YCbCr.c   ****             }
 618:RGB2YCbCr.c   ****         }
 619:RGB2YCbCr.c   ****         dummy(image_in, image_out);
 5807              		.loc 1 619 9 is_stmt 1
 5808 3f7c 488B7580 		movq	-128(%rbp), %rsi
 5809 3f80 488BBD78 		movq	-136(%rbp), %rdi
 5809      FFFFFF
 5810 3f87 4C8945A0 		movq	%r8, -96(%rbp)
 5811 3f8b 4C8955B0 		movq	%r10, -80(%rbp)
 5812 3f8f C5F877   		vzeroupper
 5813 3f92 E8000000 		call	dummy
 5813      00
 5814              	.LVL284:
 575:RGB2YCbCr.c   ****     {
 5815              		.loc 1 575 34
 575:RGB2YCbCr.c   ****     {
 5816              		.loc 1 575 22
 575:RGB2YCbCr.c   ****     {
 5817              		.loc 1 575 5 is_stmt 0
 5818 3f97 FF4D88   		decl	-120(%rbp)
 5819 3f9a 4C8B55B0 		movq	-80(%rbp), %r10
 5820 3f9e C57D6F3D 		vmovdqa	.LC34(%rip), %ymm15
 5820      00000000 
 5821 3fa6 4C8B45A0 		movq	-96(%rbp), %r8
 5822 3faa 0F8558F7 		jne	.L135
 5822      FFFF
 5823              	.LBE69:
 620:RGB2YCbCr.c   ****     }
 621:RGB2YCbCr.c   ****     end_t = get_wall_time();
 5824              		.loc 1 621 5 is_stmt 1
 5825              		.loc 1 621 13 is_stmt 0
 5826 3fb0 31C0     		xorl	%eax, %eax
 5827 3fb2 C5F877   		vzeroupper
 5828 3fb5 E8000000 		call	get_wall_time
 5828      00
 5829              	.LVL285:
 622:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "RGB2YCbCr_block");
 5830              		.loc 1 622 5 is_stmt 1
 5831 3fba 8B7D8C   		movl	-116(%rbp), %edi
 5832 3fbd C5FB5C85 		vsubsd	-160(%rbp), %xmm0, %xmm0
 5832      60FFFFFF 
 5833              	.LVL286:
 5834 3fc5 BE000000 		movl	$.LC72, %esi
 5834      00
 5835 3fca E8000000 		call	results
 5835      00
 5836              	.LVL287:
 623:RGB2YCbCr.c   **** }
 5837              		.loc 1 623 1 is_stmt 0
 5838 3fcf 488D65D0 		leaq	-48(%rbp), %rsp
 5839 3fd3 5B       		popq	%rbx
 5840 3fd4 415A     		popq	%r10
 5841              		.cfi_remember_state
 5842              		.cfi_def_cfa 10, 0
 5843 3fd6 415C     		popq	%r12
 5844              	.LVL288:
 5845 3fd8 415D     		popq	%r13
 5846              	.LVL289:
 5847 3fda 415E     		popq	%r14
 5848              	.LVL290:
 5849 3fdc 415F     		popq	%r15
 5850              	.LVL291:
 5851 3fde 5D       		popq	%rbp
 5852              	.LVL292:
 5853 3fdf 498D62F8 		leaq	-8(%r10), %rsp
 5854              		.cfi_def_cfa 7, 8
 5855              	.LVL293:
 5856 3fe3 C3       		ret
 5857              	.LVL294:
 5858              	.L153:
 5859              		.cfi_restore_state
 5860              	.LBB70:
 5861              	.LBB68:
 5862              	.LBB64:
 584:RGB2YCbCr.c   ****             {
 5863              		.loc 1 584 13
 5864 3fe4 31D2     		xorl	%edx, %edx
 5865 3fe6 E902FDFF 		jmp	.L141
 5865      FF
 5866              	.L154:
 5867              	.LBE64:
 5868              	.LBB65:
 592:RGB2YCbCr.c   ****             {
 5869              		.loc 1 592 13
 5870 3feb 31D2     		xorl	%edx, %edx
 5871 3fed E93CFFFF 		jmp	.L145
 5871      FF
 5872              	.LVL295:
 5873              	.L152:
 5874              	.LBE65:
 5875              	.LBB66:
 584:RGB2YCbCr.c   ****             {
 5876              		.loc 1 584 22
 5877 3ff2 31C9     		xorl	%ecx, %ecx
 5878 3ff4 E9ADF8FF 		jmp	.L137
 5878      FF
 5879              	.LVL296:
 5880              	.L166:
 5881              	.LBE66:
 5882              	.LBE68:
 5883              	.LBE70:
 564:RGB2YCbCr.c   ****         exit(-1);
 5884              		.loc 1 564 9 is_stmt 1
 5885 3ff9 BF000000 		movl	$.LC0, %edi
 5885      00
 5886              	.LVL297:
 5887 3ffe E8000000 		call	puts
 5887      00
 5888              	.LVL298:
 565:RGB2YCbCr.c   ****     }
 5889              		.loc 1 565 9
 5890 4003 83CFFF   		orl	$-1, %edi
 5891 4006 E8000000 		call	exit
 5891      00
 5892              	.LVL299:
 5893              		.cfi_endproc
 5894              	.LFE22:
 5896              		.section	.rodata.str1.8
 5897 0021 00000000 		.align 8
 5897      000000
 5898              	.LC73:
 5899 0028 4552524F 		.string	"ERROR: input image has to be YCbCr"
 5899      523A2069 
 5899      6E707574 
 5899      20696D61 
 5899      67652068 
 5900              		.section	.rodata.str1.1
 5901              	.LC78:
 5902 008f 59436243 		.string	"YCbCr2RGB()"
 5902      72325247 
 5902      42282900 
 5903              		.text
 5904 400b 0F1F4400 		.p2align 4
 5904      00
 5905              		.globl	YCbCr2RGB_conversion
 5907              	YCbCr2RGB_conversion:
 5908              	.LFB23:
 624:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
 625:RGB2YCbCr.c   **** 
 626:RGB2YCbCr.c   **** static const float
 627:RGB2YCbCr.c   **** YCbCr2RGB[3][3] = {
 628:RGB2YCbCr.c   ****    { 1.0,  0.0,     1.4075 },
 629:RGB2YCbCr.c   ****    { 1.0, -0.3455, -0.7169 },
 630:RGB2YCbCr.c   ****    { 1.0,  1.7790,  0.0    }
 631:RGB2YCbCr.c   **** };
 632:RGB2YCbCr.c   **** 
 633:RGB2YCbCr.c   **** static const int
 634:RGB2YCbCr.c   **** YCbCr2RGB_offset[3][3]  = {
 635:RGB2YCbCr.c   ****    { 0,    0,  128 },
 636:RGB2YCbCr.c   ****    { 0,  128,  128 },
 637:RGB2YCbCr.c   ****    { 0,  128,    0 }
 638:RGB2YCbCr.c   **** };
 639:RGB2YCbCr.c   **** 
 640:RGB2YCbCr.c   **** //----------------------------------------------------------------------------
 641:RGB2YCbCr.c   **** 
 642:RGB2YCbCr.c   **** void
 643:RGB2YCbCr.c   **** YCbCr2RGB_conversion(image_t * image_in, image_t * image_out)
 644:RGB2YCbCr.c   **** {
 5909              		.loc 1 644 1
 5910              		.cfi_startproc
 5911              	.LVL300:
 645:RGB2YCbCr.c   ****     double start_t, end_t;
 5912              		.loc 1 645 5
 646:RGB2YCbCr.c   ****     const int height = image_in->height;
 5913              		.loc 1 646 5
 644:RGB2YCbCr.c   ****     double start_t, end_t;
 5914              		.loc 1 644 1 is_stmt 0
 5915 4010 4156     		pushq	%r14
 5916              		.cfi_def_cfa_offset 16
 5917              		.cfi_offset 14, -16
 5918 4012 4155     		pushq	%r13
 5919              		.cfi_def_cfa_offset 24
 5920              		.cfi_offset 13, -24
 5921 4014 4154     		pushq	%r12
 5922              		.cfi_def_cfa_offset 32
 5923              		.cfi_offset 12, -32
 5924 4016 55       		pushq	%rbp
 5925              		.cfi_def_cfa_offset 40
 5926              		.cfi_offset 6, -40
 5927 4017 53       		pushq	%rbx
 5928              		.cfi_def_cfa_offset 48
 5929              		.cfi_offset 3, -48
 5930 4018 4883EC10 		subq	$16, %rsp
 5931              		.cfi_def_cfa_offset 64
 647:RGB2YCbCr.c   ****     const int width =  image_in->width;
 648:RGB2YCbCr.c   **** 
 649:RGB2YCbCr.c   ****     if (image_in->bytes_per_pixel != 3)
 5932              		.loc 1 649 8
 5933 401c 837F1003 		cmpl	$3, 16(%rdi)
 646:RGB2YCbCr.c   ****     const int width =  image_in->width;
 5934              		.loc 1 646 15
 5935 4020 8B6F0C   		movl	12(%rdi), %ebp
 5936              	.LVL301:
 647:RGB2YCbCr.c   ****     const int width =  image_in->width;
 5937              		.loc 1 647 5 is_stmt 1
 647:RGB2YCbCr.c   ****     const int width =  image_in->width;
 5938              		.loc 1 647 15 is_stmt 0
 5939 4023 8B5F08   		movl	8(%rdi), %ebx
 5940              	.LVL302:
 5941              		.loc 1 649 5 is_stmt 1
 5942              		.loc 1 649 8 is_stmt 0
 5943 4026 0F857801 		jne	.L176
 5943      0000
 650:RGB2YCbCr.c   ****     {
 651:RGB2YCbCr.c   ****         printf("ERROR: input image has to be YCbCr\n");
 652:RGB2YCbCr.c   ****         exit(-1);
 653:RGB2YCbCr.c   ****     }
 654:RGB2YCbCr.c   ****     
 655:RGB2YCbCr.c   ****     /* fill struct fields */
 656:RGB2YCbCr.c   ****     image_out->width  = width;
 657:RGB2YCbCr.c   ****     image_out->height = height;
 658:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 5944              		.loc 1 658 32
 5945 402c 48B80300 		movabsq	$8589934595, %rax
 5945      00000200 
 5945      0000
 656:RGB2YCbCr.c   ****     image_out->height = height;
 5946              		.loc 1 656 23
 5947 4036 895E08   		movl	%ebx, 8(%rsi)
 5948 4039 4989FE   		movq	%rdi, %r14
 5949 403c 4989F4   		movq	%rsi, %r12
 656:RGB2YCbCr.c   ****     image_out->height = height;
 5950              		.loc 1 656 5 is_stmt 1
 657:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 5951              		.loc 1 657 5
 657:RGB2YCbCr.c   ****     image_out->bytes_per_pixel = 3;
 5952              		.loc 1 657 23 is_stmt 0
 5953 403f 896E0C   		movl	%ebp, 12(%rsi)
 5954              		.loc 1 658 5 is_stmt 1
 659:RGB2YCbCr.c   ****     image_out->color_space = JCS_RGB;
 5955              		.loc 1 659 5
 5956              	.LBB71:
 5957              	.LBB72:
 660:RGB2YCbCr.c   **** 
 661:RGB2YCbCr.c   ****     start_t = get_wall_time();
 662:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 663:RGB2YCbCr.c   ****     {
 664:RGB2YCbCr.c   ****         #pragma GCC ivdep
 665:RGB2YCbCr.c   ****         for (int i=0; i<height*width; i++)
 5958              		.loc 1 665 31 is_stmt 0
 5959 4042 0FAFEB   		imull	%ebx, %ebp
 5960              	.LVL303:
 5961 4045 BB0A0000 		movl	$10, %ebx
 5961      00
 5962              	.LVL304:
 5963              	.LBE72:
 5964              	.LBE71:
 658:RGB2YCbCr.c   ****     image_out->color_space = JCS_RGB;
 5965              		.loc 1 658 32
 5966 404a 48894610 		movq	%rax, 16(%rsi)
 661:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 5967              		.loc 1 661 5 is_stmt 1
 661:RGB2YCbCr.c   ****     for (int it = 0; it < NITER; it++)
 5968              		.loc 1 661 15 is_stmt 0
 5969 404e 31C0     		xorl	%eax, %eax
 5970 4050 E8000000 		call	get_wall_time
 5970      00
 5971              	.LVL305:
 5972 4055 8D45FF   		leal	-1(%rbp), %eax
 5973 4058 C5D857E4 		vxorps	%xmm4, %xmm4, %xmm4
 5974 405c C5E057DB 		vxorps	%xmm3, %xmm3, %xmm3
 5975 4060 C5FB1144 		vmovsd	%xmm0, 8(%rsp)
 5975      2408
 5976              	.LVL306:
 662:RGB2YCbCr.c   ****     {
 5977              		.loc 1 662 5 is_stmt 1
 5978              	.LBB74:
 662:RGB2YCbCr.c   ****     {
 5979              		.loc 1 662 10
 662:RGB2YCbCr.c   ****     {
 5980              		.loc 1 662 22
 5981 4066 4C8D6C40 		leaq	3(%rax,%rax,2), %r13
 5981      03
 5982              	.LVL307:
 5983 406b 0F1F4400 		.p2align 4,,10
 5983      00
 5984              		.p2align 3
 5985              	.L169:
 5986              	.LBB73:
 5987              		.loc 1 665 23
 5988              		.loc 1 665 9 is_stmt 0
 5989 4070 85ED     		testl	%ebp, %ebp
 5990 4072 0F8EEC00 		jle	.L172
 5990      0000
 5991 4078 C57A1005 		vmovss	.LC74(%rip), %xmm8
 5991      00000000 
 5992 4080 C5FA103D 		vmovss	.LC75(%rip), %xmm7
 5992      00000000 
 5993 4088 31D2     		xorl	%edx, %edx
 5994 408a C5FA1035 		vmovss	.LC76(%rip), %xmm6
 5994      00000000 
 5995 4092 C5FA102D 		vmovss	.LC77(%rip), %xmm5
 5995      00000000 
 5996              	.LVL308:
 5997 409a 660F1F44 		.p2align 4,,10
 5997      0000
 5998              		.p2align 3
 5999              	.L170:
 666:RGB2YCbCr.c   ****         {
 667:RGB2YCbCr.c   ****             image_out->pixels[3*i + 0] = (unsigned char)
 6000              		.loc 1 667 13 is_stmt 1 discriminator 3
 668:RGB2YCbCr.c   ****                (YCbCr2RGB[0][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[0][0]) + 
 6001              		.loc 1 668 16 is_stmt 0 discriminator 3
 6002 40a0 498B0E   		movq	(%r14), %rcx
 667:RGB2YCbCr.c   ****                (YCbCr2RGB[0][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[0][0]) + 
 6003              		.loc 1 667 40 discriminator 3
 6004 40a3 498B3424 		movq	(%r12), %rsi
 669:RGB2YCbCr.c   ****                 YCbCr2RGB[0][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[0][1]) + 
 6005              		.loc 1 669 50 discriminator 3
 6006 40a7 0FB64411 		movzbl	1(%rcx,%rdx), %eax
 6006      01
 6007              		.loc 1 669 32 discriminator 3
 6008 40ac C5E22AC8 		vcvtsi2ssl	%eax, %xmm3, %xmm1
 668:RGB2YCbCr.c   ****                (YCbCr2RGB[0][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[0][0]) + 
 6009              		.loc 1 668 50 discriminator 3
 6010 40b0 0FB60411 		movzbl	(%rcx,%rdx), %eax
 668:RGB2YCbCr.c   ****                (YCbCr2RGB[0][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[0][0]) + 
 6011              		.loc 1 668 32 discriminator 3
 6012 40b4 C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 670:RGB2YCbCr.c   ****                 YCbCr2RGB[0][2]*(image_in->pixels[3*i + 2] - YCbCr2RGB_offset[0][2]));
 6013              		.loc 1 670 50 discriminator 3
 6014 40b8 0FB64411 		movzbl	2(%rcx,%rdx), %eax
 6014      02
 669:RGB2YCbCr.c   ****                 YCbCr2RGB[0][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[0][1]) + 
 6015              		.loc 1 669 32 discriminator 3
 6016 40bd C5F259D4 		vmulss	%xmm4, %xmm1, %xmm2
 6017              		.loc 1 670 60 discriminator 3
 6018 40c1 83C080   		addl	$-128, %eax
 668:RGB2YCbCr.c   ****                 YCbCr2RGB[0][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[0][1]) + 
 6019              		.loc 1 668 86 discriminator 3
 6020 40c4 C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 6021              		.loc 1 670 32 discriminator 3
 6022 40c8 C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 6023 40cc C4C17A59 		vmulss	%xmm8, %xmm0, %xmm0
 6023      C0
 669:RGB2YCbCr.c   ****                 YCbCr2RGB[0][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[0][1]) + 
 6024              		.loc 1 669 86 discriminator 3
 6025 40d1 C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 667:RGB2YCbCr.c   ****                (YCbCr2RGB[0][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[0][0]) + 
 6026              		.loc 1 667 42 discriminator 3
 6027 40d5 C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 6028 40d9 880416   		movb	%al, (%rsi,%rdx)
 671:RGB2YCbCr.c   ****             image_out->pixels[3*i + 1] = (unsigned char)
 6029              		.loc 1 671 13 is_stmt 1 discriminator 3
 672:RGB2YCbCr.c   ****                (YCbCr2RGB[1][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[1][0]) + 
 6030              		.loc 1 672 16 is_stmt 0 discriminator 3
 6031 40dc 498B0E   		movq	(%r14), %rcx
 671:RGB2YCbCr.c   ****             image_out->pixels[3*i + 1] = (unsigned char)
 6032              		.loc 1 671 40 discriminator 3
 6033 40df 498B3424 		movq	(%r12), %rsi
 673:RGB2YCbCr.c   ****                 YCbCr2RGB[1][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[1][1]) + 
 6034              		.loc 1 673 50 discriminator 3
 6035 40e3 0FB64411 		movzbl	1(%rcx,%rdx), %eax
 6035      01
 6036              		.loc 1 673 60 discriminator 3
 6037 40e8 83C080   		addl	$-128, %eax
 6038              		.loc 1 673 32 discriminator 3
 6039 40eb C5E22AC8 		vcvtsi2ssl	%eax, %xmm3, %xmm1
 672:RGB2YCbCr.c   ****                (YCbCr2RGB[1][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[1][0]) + 
 6040              		.loc 1 672 50 discriminator 3
 6041 40ef 0FB60411 		movzbl	(%rcx,%rdx), %eax
 672:RGB2YCbCr.c   ****                (YCbCr2RGB[1][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[1][0]) + 
 6042              		.loc 1 672 32 discriminator 3
 6043 40f3 C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 674:RGB2YCbCr.c   ****                 YCbCr2RGB[1][2]*(image_in->pixels[3*i + 2] - YCbCr2RGB_offset[1][2]));
 6044              		.loc 1 674 50 discriminator 3
 6045 40f7 0FB64411 		movzbl	2(%rcx,%rdx), %eax
 6045      02
 673:RGB2YCbCr.c   ****                 YCbCr2RGB[1][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[1][1]) + 
 6046              		.loc 1 673 32 discriminator 3
 6047 40fc C5F259D7 		vmulss	%xmm7, %xmm1, %xmm2
 6048              		.loc 1 674 60 discriminator 3
 6049 4100 83C080   		addl	$-128, %eax
 672:RGB2YCbCr.c   ****                (YCbCr2RGB[1][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[1][0]) + 
 6050              		.loc 1 672 86 discriminator 3
 6051 4103 C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 6052              		.loc 1 674 32 discriminator 3
 6053 4107 C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 6054 410b C5FA59C6 		vmulss	%xmm6, %xmm0, %xmm0
 673:RGB2YCbCr.c   ****                 YCbCr2RGB[1][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[1][1]) + 
 6055              		.loc 1 673 86 discriminator 3
 6056 410f C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 671:RGB2YCbCr.c   ****                (YCbCr2RGB[1][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[1][0]) + 
 6057              		.loc 1 671 42 discriminator 3
 6058 4113 C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 6059 4117 88441601 		movb	%al, 1(%rsi,%rdx)
 675:RGB2YCbCr.c   ****             image_out->pixels[3*i + 2] = (unsigned char)
 6060              		.loc 1 675 13 is_stmt 1 discriminator 3
 676:RGB2YCbCr.c   ****                (YCbCr2RGB[2][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[2][0]) + 
 6061              		.loc 1 676 16 is_stmt 0 discriminator 3
 6062 411b 498B0E   		movq	(%r14), %rcx
 675:RGB2YCbCr.c   ****             image_out->pixels[3*i + 2] = (unsigned char)
 6063              		.loc 1 675 40 discriminator 3
 6064 411e 498B3424 		movq	(%r12), %rsi
 677:RGB2YCbCr.c   ****                 YCbCr2RGB[2][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[2][1]) + 
 6065              		.loc 1 677 50 discriminator 3
 6066 4122 0FB64411 		movzbl	1(%rcx,%rdx), %eax
 6066      01
 6067              		.loc 1 677 60 discriminator 3
 6068 4127 83C080   		addl	$-128, %eax
 6069              		.loc 1 677 32 discriminator 3
 6070 412a C5E22AC8 		vcvtsi2ssl	%eax, %xmm3, %xmm1
 676:RGB2YCbCr.c   ****                (YCbCr2RGB[2][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[2][0]) + 
 6071              		.loc 1 676 50 discriminator 3
 6072 412e 0FB60411 		movzbl	(%rcx,%rdx), %eax
 676:RGB2YCbCr.c   ****                (YCbCr2RGB[2][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[2][0]) + 
 6073              		.loc 1 676 32 discriminator 3
 6074 4132 C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 678:RGB2YCbCr.c   ****                 YCbCr2RGB[2][2]*(image_in->pixels[3*i + 2] - YCbCr2RGB_offset[2][2]));
 6075              		.loc 1 678 50 discriminator 3
 6076 4136 0FB64411 		movzbl	2(%rcx,%rdx), %eax
 6076      02
 677:RGB2YCbCr.c   ****                 YCbCr2RGB[2][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[2][1]) + 
 6077              		.loc 1 677 32 discriminator 3
 6078 413b C5F259D5 		vmulss	%xmm5, %xmm1, %xmm2
 676:RGB2YCbCr.c   ****                (YCbCr2RGB[2][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[2][0]) + 
 6079              		.loc 1 676 86 discriminator 3
 6080 413f C5EA58C8 		vaddss	%xmm0, %xmm2, %xmm1
 6081              		.loc 1 678 32 discriminator 3
 6082 4143 C5E22AC0 		vcvtsi2ssl	%eax, %xmm3, %xmm0
 6083 4147 C5FA59C4 		vmulss	%xmm4, %xmm0, %xmm0
 677:RGB2YCbCr.c   ****                 YCbCr2RGB[2][1]*(image_in->pixels[3*i + 1] - YCbCr2RGB_offset[2][1]) + 
 6084              		.loc 1 677 86 discriminator 3
 6085 414b C5F258C0 		vaddss	%xmm0, %xmm1, %xmm0
 675:RGB2YCbCr.c   ****                (YCbCr2RGB[2][0]*(image_in->pixels[3*i + 0] - YCbCr2RGB_offset[2][0]) + 
 6086              		.loc 1 675 42 discriminator 3
 6087 414f C5FA2CC0 		vcvttss2sil	%xmm0, %eax
 6088 4153 88441602 		movb	%al, 2(%rsi,%rdx)
 665:RGB2YCbCr.c   ****         {
 6089              		.loc 1 665 39 is_stmt 1 discriminator 3
 665:RGB2YCbCr.c   ****         {
 6090              		.loc 1 665 23 discriminator 3
 6091 4157 4883C203 		addq	$3, %rdx
 665:RGB2YCbCr.c   ****         {
 6092              		.loc 1 665 9 is_stmt 0 discriminator 3
 6093 415b 4C39EA   		cmpq	%r13, %rdx
 6094 415e 0F853CFF 		jne	.L170
 6094      FFFF
 6095              	.L172:
 6096              	.LBE73:
 679:RGB2YCbCr.c   ****         }
 680:RGB2YCbCr.c   ****         dummy(image_in, image_out);
 6097              		.loc 1 680 9 is_stmt 1
 6098 4164 4C89E6   		movq	%r12, %rsi
 6099 4167 4C89F7   		movq	%r14, %rdi
 6100 416a E8000000 		call	dummy
 6100      00
 6101              	.LVL309:
 662:RGB2YCbCr.c   ****     {
 6102              		.loc 1 662 34
 662:RGB2YCbCr.c   ****     {
 6103              		.loc 1 662 22
 662:RGB2YCbCr.c   ****     {
 6104              		.loc 1 662 5 is_stmt 0
 6105 416f FFCB     		decl	%ebx
 6106 4171 C5D857E4 		vxorps	%xmm4, %xmm4, %xmm4
 6107 4175 C5E057DB 		vxorps	%xmm3, %xmm3, %xmm3
 6108 4179 0F85F1FE 		jne	.L169
 6108      FFFF
 6109              	.LBE74:
 681:RGB2YCbCr.c   ****     }
 682:RGB2YCbCr.c   ****     end_t = get_wall_time();
 6110              		.loc 1 682 5 is_stmt 1
 6111              		.loc 1 682 13 is_stmt 0
 6112 417f 31C0     		xorl	%eax, %eax
 6113 4181 E8000000 		call	get_wall_time
 6113      00
 6114              	.LVL310:
 683:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "YCbCr2RGB()");
 6115              		.loc 1 683 5 is_stmt 1
 6116 4186 C5FB5C44 		vsubsd	8(%rsp), %xmm0, %xmm0
 6116      2408
 6117              	.LVL311:
 684:RGB2YCbCr.c   **** }
 6118              		.loc 1 684 1 is_stmt 0
 6119 418c 4883C410 		addq	$16, %rsp
 6120              		.cfi_remember_state
 6121              		.cfi_def_cfa_offset 48
 683:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "YCbCr2RGB()");
 6122              		.loc 1 683 5
 6123 4190 89EF     		movl	%ebp, %edi
 6124              		.loc 1 684 1
 6125 4192 5B       		popq	%rbx
 6126              		.cfi_def_cfa_offset 40
 683:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "YCbCr2RGB()");
 6127              		.loc 1 683 5
 6128 4193 BE000000 		movl	$.LC78, %esi
 6128      00
 6129              		.loc 1 684 1
 6130 4198 5D       		popq	%rbp
 6131              		.cfi_def_cfa_offset 32
 6132 4199 415C     		popq	%r12
 6133              		.cfi_def_cfa_offset 24
 6134              	.LVL312:
 6135 419b 415D     		popq	%r13
 6136              		.cfi_def_cfa_offset 16
 6137 419d 415E     		popq	%r14
 6138              		.cfi_def_cfa_offset 8
 6139              	.LVL313:
 683:RGB2YCbCr.c   ****     results(end_t - start_t, height*width, "YCbCr2RGB()");
 6140              		.loc 1 683 5
 6141 419f E9000000 		jmp	results
 6141      00
 6142              	.LVL314:
 6143              	.L176:
 6144              		.cfi_restore_state
 651:RGB2YCbCr.c   ****         exit(-1);
 6145              		.loc 1 651 9 is_stmt 1
 6146 41a4 BF000000 		movl	$.LC73, %edi
 6146      00
 6147              	.LVL315:
 6148 41a9 E8000000 		call	puts
 6148      00
 6149              	.LVL316:
 652:RGB2YCbCr.c   ****     }
 6150              		.loc 1 652 9
 6151 41ae 83CFFF   		orl	$-1, %edi
 6152 41b1 E8000000 		call	exit
 6152      00
 6153              	.LVL317:
 6154              		.cfi_endproc
 6155              	.LFE23:
 6157              		.section	.rodata.cst4,"aM",@progbits,4
 6158              		.align 4
 6159              	.LC1:
 6160 0000 8716993E 		.long	1050220167
 6161              		.align 4
 6162              	.LC3:
 6163 0004 A245163F 		.long	1058424226
 6164              		.align 4
 6165              	.LC4:
 6166 0008 D578E93D 		.long	1038710997
 6167              		.align 4
 6168              	.LC5:
 6169 000c 21C92CBE 		.long	3190606113
 6170              		.align 4
 6171              	.LC6:
 6172 0010 00000043 		.long	1124073472
 6173              		.align 4
 6174              	.LC7:
 6175 0014 6F9BA9BE 		.long	3198786415
 6176              		.align 4
 6177              	.LC8:
 6178 0018 0000003F 		.long	1056964608
 6179              		.align 4
 6180              	.LC9:
 6181 001c 465ED6BE 		.long	3201719878
 6182              		.align 4
 6183              	.LC10:
 6184 0020 E886A6BD 		.long	3181807336
 6185              		.section	.rodata.cst32,"aM",@progbits,32
 6186              		.align 32
 6187              	.LC13:
 6188 0000 80       		.byte	-128
 6189 0001 80       		.byte	-128
 6190 0002 80       		.byte	-128
 6191 0003 80       		.byte	-128
 6192 0004 80       		.byte	-128
 6193 0005 80       		.byte	-128
 6194 0006 00       		.byte	0
 6195 0007 00       		.byte	0
 6196 0008 00       		.byte	0
 6197 0009 00       		.byte	0
 6198 000a 00       		.byte	0
 6199 000b 00       		.byte	0
 6200 000c 00       		.byte	0
 6201 000d 00       		.byte	0
 6202 000e 00       		.byte	0
 6203 000f 00       		.byte	0
 6204 0010 80       		.byte	-128
 6205 0011 80       		.byte	-128
 6206 0012 80       		.byte	-128
 6207 0013 80       		.byte	-128
 6208 0014 80       		.byte	-128
 6209 0015 80       		.byte	-128
 6210 0016 02       		.byte	2
 6211 0017 05       		.byte	5
 6212 0018 08       		.byte	8
 6213 0019 0B       		.byte	11
 6214 001a 0E       		.byte	14
 6215 001b 80       		.byte	-128
 6216 001c 80       		.byte	-128
 6217 001d 80       		.byte	-128
 6218 001e 80       		.byte	-128
 6219 001f 80       		.byte	-128
 6220              		.align 32
 6221              	.LC14:
 6222 0020 00       		.byte	0
 6223 0021 03       		.byte	3
 6224 0022 06       		.byte	6
 6225 0023 09       		.byte	9
 6226 0024 0C       		.byte	12
 6227 0025 0F       		.byte	15
 6228 0026 80       		.byte	-128
 6229 0027 80       		.byte	-128
 6230 0028 80       		.byte	-128
 6231 0029 80       		.byte	-128
 6232 002a 80       		.byte	-128
 6233 002b 80       		.byte	-128
 6234 002c 80       		.byte	-128
 6235 002d 80       		.byte	-128
 6236 002e 80       		.byte	-128
 6237 002f 80       		.byte	-128
 6238 0030 80       		.byte	-128
 6239 0031 80       		.byte	-128
 6240 0032 80       		.byte	-128
 6241 0033 80       		.byte	-128
 6242 0034 80       		.byte	-128
 6243 0035 80       		.byte	-128
 6244 0036 80       		.byte	-128
 6245 0037 80       		.byte	-128
 6246 0038 80       		.byte	-128
 6247 0039 80       		.byte	-128
 6248 003a 80       		.byte	-128
 6249 003b 80       		.byte	-128
 6250 003c 80       		.byte	-128
 6251 003d 80       		.byte	-128
 6252 003e 80       		.byte	-128
 6253 003f 80       		.byte	-128
 6254              		.align 32
 6255              	.LC15:
 6256 0040 80       		.byte	-128
 6257 0041 80       		.byte	-128
 6258 0042 80       		.byte	-128
 6259 0043 80       		.byte	-128
 6260 0044 80       		.byte	-128
 6261 0045 80       		.byte	-128
 6262 0046 80       		.byte	-128
 6263 0047 80       		.byte	-128
 6264 0048 80       		.byte	-128
 6265 0049 80       		.byte	-128
 6266 004a 80       		.byte	-128
 6267 004b 01       		.byte	1
 6268 004c 04       		.byte	4
 6269 004d 07       		.byte	7
 6270 004e 0A       		.byte	10
 6271 004f 0D       		.byte	13
 6272 0050 00       		.byte	0
 6273 0051 03       		.byte	3
 6274 0052 06       		.byte	6
 6275 0053 09       		.byte	9
 6276 0054 0C       		.byte	12
 6277 0055 0F       		.byte	15
 6278 0056 80       		.byte	-128
 6279 0057 80       		.byte	-128
 6280 0058 80       		.byte	-128
 6281 0059 80       		.byte	-128
 6282 005a 80       		.byte	-128
 6283 005b 80       		.byte	-128
 6284 005c 80       		.byte	-128
 6285 005d 80       		.byte	-128
 6286 005e 80       		.byte	-128
 6287 005f 80       		.byte	-128
 6288              		.align 32
 6289              	.LC16:
 6290 0060 80       		.byte	-128
 6291 0061 80       		.byte	-128
 6292 0062 80       		.byte	-128
 6293 0063 80       		.byte	-128
 6294 0064 80       		.byte	-128
 6295 0065 80       		.byte	-128
 6296 0066 02       		.byte	2
 6297 0067 05       		.byte	5
 6298 0068 08       		.byte	8
 6299 0069 0B       		.byte	11
 6300 006a 0E       		.byte	14
 6301 006b 80       		.byte	-128
 6302 006c 80       		.byte	-128
 6303 006d 80       		.byte	-128
 6304 006e 80       		.byte	-128
 6305 006f 80       		.byte	-128
 6306 0070 80       		.byte	-128
 6307 0071 80       		.byte	-128
 6308 0072 80       		.byte	-128
 6309 0073 80       		.byte	-128
 6310 0074 80       		.byte	-128
 6311 0075 80       		.byte	-128
 6312 0076 80       		.byte	-128
 6313 0077 80       		.byte	-128
 6314 0078 80       		.byte	-128
 6315 0079 80       		.byte	-128
 6316 007a 80       		.byte	-128
 6317 007b 80       		.byte	-128
 6318 007c 80       		.byte	-128
 6319 007d 80       		.byte	-128
 6320 007e 80       		.byte	-128
 6321 007f 80       		.byte	-128
 6322              		.align 32
 6323              	.LC17:
 6324 0080 00       		.byte	0
 6325 0081 01       		.byte	1
 6326 0082 02       		.byte	2
 6327 0083 03       		.byte	3
 6328 0084 04       		.byte	4
 6329 0085 05       		.byte	5
 6330 0086 06       		.byte	6
 6331 0087 07       		.byte	7
 6332 0088 08       		.byte	8
 6333 0089 09       		.byte	9
 6334 008a 0A       		.byte	10
 6335 008b 0B       		.byte	11
 6336 008c 0C       		.byte	12
 6337 008d 0D       		.byte	13
 6338 008e 0E       		.byte	14
 6339 008f 0F       		.byte	15
 6340 0090 00       		.byte	0
 6341 0091 01       		.byte	1
 6342 0092 02       		.byte	2
 6343 0093 03       		.byte	3
 6344 0094 04       		.byte	4
 6345 0095 05       		.byte	5
 6346 0096 80       		.byte	-128
 6347 0097 80       		.byte	-128
 6348 0098 80       		.byte	-128
 6349 0099 80       		.byte	-128
 6350 009a 80       		.byte	-128
 6351 009b 80       		.byte	-128
 6352 009c 80       		.byte	-128
 6353 009d 80       		.byte	-128
 6354 009e 80       		.byte	-128
 6355 009f 80       		.byte	-128
 6356              		.align 32
 6357              	.LC18:
 6358 00a0 80       		.byte	-128
 6359 00a1 80       		.byte	-128
 6360 00a2 80       		.byte	-128
 6361 00a3 80       		.byte	-128
 6362 00a4 80       		.byte	-128
 6363 00a5 80       		.byte	-128
 6364 00a6 80       		.byte	-128
 6365 00a7 80       		.byte	-128
 6366 00a8 80       		.byte	-128
 6367 00a9 80       		.byte	-128
 6368 00aa 80       		.byte	-128
 6369 00ab 80       		.byte	-128
 6370 00ac 80       		.byte	-128
 6371 00ad 80       		.byte	-128
 6372 00ae 80       		.byte	-128
 6373 00af 80       		.byte	-128
 6374 00b0 80       		.byte	-128
 6375 00b1 80       		.byte	-128
 6376 00b2 80       		.byte	-128
 6377 00b3 80       		.byte	-128
 6378 00b4 80       		.byte	-128
 6379 00b5 80       		.byte	-128
 6380 00b6 80       		.byte	-128
 6381 00b7 80       		.byte	-128
 6382 00b8 80       		.byte	-128
 6383 00b9 80       		.byte	-128
 6384 00ba 80       		.byte	-128
 6385 00bb 01       		.byte	1
 6386 00bc 04       		.byte	4
 6387 00bd 07       		.byte	7
 6388 00be 0A       		.byte	10
 6389 00bf 0D       		.byte	13
 6390              		.align 32
 6391              	.LC19:
 6392 00c0 80       		.byte	-128
 6393 00c1 80       		.byte	-128
 6394 00c2 80       		.byte	-128
 6395 00c3 80       		.byte	-128
 6396 00c4 80       		.byte	-128
 6397 00c5 00       		.byte	0
 6398 00c6 00       		.byte	0
 6399 00c7 00       		.byte	0
 6400 00c8 00       		.byte	0
 6401 00c9 00       		.byte	0
 6402 00ca 00       		.byte	0
 6403 00cb 00       		.byte	0
 6404 00cc 00       		.byte	0
 6405 00cd 00       		.byte	0
 6406 00ce 00       		.byte	0
 6407 00cf 00       		.byte	0
 6408 00d0 80       		.byte	-128
 6409 00d1 80       		.byte	-128
 6410 00d2 80       		.byte	-128
 6411 00d3 80       		.byte	-128
 6412 00d4 80       		.byte	-128
 6413 00d5 00       		.byte	0
 6414 00d6 03       		.byte	3
 6415 00d7 06       		.byte	6
 6416 00d8 09       		.byte	9
 6417 00d9 0C       		.byte	12
 6418 00da 0F       		.byte	15
 6419 00db 80       		.byte	-128
 6420 00dc 80       		.byte	-128
 6421 00dd 80       		.byte	-128
 6422 00de 80       		.byte	-128
 6423 00df 80       		.byte	-128
 6424              		.align 32
 6425              	.LC20:
 6426 00e0 01       		.byte	1
 6427 00e1 04       		.byte	4
 6428 00e2 07       		.byte	7
 6429 00e3 0A       		.byte	10
 6430 00e4 0D       		.byte	13
 6431 00e5 80       		.byte	-128
 6432 00e6 80       		.byte	-128
 6433 00e7 80       		.byte	-128
 6434 00e8 80       		.byte	-128
 6435 00e9 80       		.byte	-128
 6436 00ea 80       		.byte	-128
 6437 00eb 80       		.byte	-128
 6438 00ec 80       		.byte	-128
 6439 00ed 80       		.byte	-128
 6440 00ee 80       		.byte	-128
 6441 00ef 80       		.byte	-128
 6442 00f0 80       		.byte	-128
 6443 00f1 80       		.byte	-128
 6444 00f2 80       		.byte	-128
 6445 00f3 80       		.byte	-128
 6446 00f4 80       		.byte	-128
 6447 00f5 80       		.byte	-128
 6448 00f6 80       		.byte	-128
 6449 00f7 80       		.byte	-128
 6450 00f8 80       		.byte	-128
 6451 00f9 80       		.byte	-128
 6452 00fa 80       		.byte	-128
 6453 00fb 80       		.byte	-128
 6454 00fc 80       		.byte	-128
 6455 00fd 80       		.byte	-128
 6456 00fe 80       		.byte	-128
 6457 00ff 80       		.byte	-128
 6458              		.align 32
 6459              	.LC21:
 6460 0100 80       		.byte	-128
 6461 0101 80       		.byte	-128
 6462 0102 80       		.byte	-128
 6463 0103 80       		.byte	-128
 6464 0104 80       		.byte	-128
 6465 0105 80       		.byte	-128
 6466 0106 80       		.byte	-128
 6467 0107 80       		.byte	-128
 6468 0108 80       		.byte	-128
 6469 0109 80       		.byte	-128
 6470 010a 80       		.byte	-128
 6471 010b 02       		.byte	2
 6472 010c 05       		.byte	5
 6473 010d 08       		.byte	8
 6474 010e 0B       		.byte	11
 6475 010f 0E       		.byte	14
 6476 0110 01       		.byte	1
 6477 0111 04       		.byte	4
 6478 0112 07       		.byte	7
 6479 0113 0A       		.byte	10
 6480 0114 0D       		.byte	13
 6481 0115 80       		.byte	-128
 6482 0116 80       		.byte	-128
 6483 0117 80       		.byte	-128
 6484 0118 80       		.byte	-128
 6485 0119 80       		.byte	-128
 6486 011a 80       		.byte	-128
 6487 011b 80       		.byte	-128
 6488 011c 80       		.byte	-128
 6489 011d 80       		.byte	-128
 6490 011e 80       		.byte	-128
 6491 011f 80       		.byte	-128
 6492              		.align 32
 6493              	.LC22:
 6494 0120 80       		.byte	-128
 6495 0121 80       		.byte	-128
 6496 0122 80       		.byte	-128
 6497 0123 80       		.byte	-128
 6498 0124 80       		.byte	-128
 6499 0125 00       		.byte	0
 6500 0126 03       		.byte	3
 6501 0127 06       		.byte	6
 6502 0128 09       		.byte	9
 6503 0129 0C       		.byte	12
 6504 012a 0F       		.byte	15
 6505 012b 80       		.byte	-128
 6506 012c 80       		.byte	-128
 6507 012d 80       		.byte	-128
 6508 012e 80       		.byte	-128
 6509 012f 80       		.byte	-128
 6510 0130 80       		.byte	-128
 6511 0131 80       		.byte	-128
 6512 0132 80       		.byte	-128
 6513 0133 80       		.byte	-128
 6514 0134 80       		.byte	-128
 6515 0135 80       		.byte	-128
 6516 0136 80       		.byte	-128
 6517 0137 80       		.byte	-128
 6518 0138 80       		.byte	-128
 6519 0139 80       		.byte	-128
 6520 013a 80       		.byte	-128
 6521 013b 80       		.byte	-128
 6522 013c 80       		.byte	-128
 6523 013d 80       		.byte	-128
 6524 013e 80       		.byte	-128
 6525 013f 80       		.byte	-128
 6526              		.align 32
 6527              	.LC23:
 6528 0140 00       		.byte	0
 6529 0141 01       		.byte	1
 6530 0142 02       		.byte	2
 6531 0143 03       		.byte	3
 6532 0144 04       		.byte	4
 6533 0145 05       		.byte	5
 6534 0146 06       		.byte	6
 6535 0147 07       		.byte	7
 6536 0148 08       		.byte	8
 6537 0149 09       		.byte	9
 6538 014a 0A       		.byte	10
 6539 014b 0B       		.byte	11
 6540 014c 0C       		.byte	12
 6541 014d 0D       		.byte	13
 6542 014e 0E       		.byte	14
 6543 014f 0F       		.byte	15
 6544 0150 00       		.byte	0
 6545 0151 01       		.byte	1
 6546 0152 02       		.byte	2
 6547 0153 03       		.byte	3
 6548 0154 04       		.byte	4
 6549 0155 80       		.byte	-128
 6550 0156 80       		.byte	-128
 6551 0157 80       		.byte	-128
 6552 0158 80       		.byte	-128
 6553 0159 80       		.byte	-128
 6554 015a 80       		.byte	-128
 6555 015b 80       		.byte	-128
 6556 015c 80       		.byte	-128
 6557 015d 80       		.byte	-128
 6558 015e 80       		.byte	-128
 6559 015f 80       		.byte	-128
 6560              		.align 32
 6561              	.LC24:
 6562 0160 80       		.byte	-128
 6563 0161 80       		.byte	-128
 6564 0162 80       		.byte	-128
 6565 0163 80       		.byte	-128
 6566 0164 80       		.byte	-128
 6567 0165 80       		.byte	-128
 6568 0166 80       		.byte	-128
 6569 0167 80       		.byte	-128
 6570 0168 80       		.byte	-128
 6571 0169 80       		.byte	-128
 6572 016a 80       		.byte	-128
 6573 016b 80       		.byte	-128
 6574 016c 80       		.byte	-128
 6575 016d 80       		.byte	-128
 6576 016e 80       		.byte	-128
 6577 016f 80       		.byte	-128
 6578 0170 80       		.byte	-128
 6579 0171 80       		.byte	-128
 6580 0172 80       		.byte	-128
 6581 0173 80       		.byte	-128
 6582 0174 80       		.byte	-128
 6583 0175 80       		.byte	-128
 6584 0176 80       		.byte	-128
 6585 0177 80       		.byte	-128
 6586 0178 80       		.byte	-128
 6587 0179 80       		.byte	-128
 6588 017a 80       		.byte	-128
 6589 017b 02       		.byte	2
 6590 017c 05       		.byte	5
 6591 017d 08       		.byte	8
 6592 017e 0B       		.byte	11
 6593 017f 0E       		.byte	14
 6594              		.align 32
 6595              	.LC25:
 6596 0180 80       		.byte	-128
 6597 0181 80       		.byte	-128
 6598 0182 80       		.byte	-128
 6599 0183 80       		.byte	-128
 6600 0184 80       		.byte	-128
 6601 0185 00       		.byte	0
 6602 0186 00       		.byte	0
 6603 0187 00       		.byte	0
 6604 0188 00       		.byte	0
 6605 0189 00       		.byte	0
 6606 018a 00       		.byte	0
 6607 018b 00       		.byte	0
 6608 018c 00       		.byte	0
 6609 018d 00       		.byte	0
 6610 018e 00       		.byte	0
 6611 018f 00       		.byte	0
 6612 0190 80       		.byte	-128
 6613 0191 80       		.byte	-128
 6614 0192 80       		.byte	-128
 6615 0193 80       		.byte	-128
 6616 0194 80       		.byte	-128
 6617 0195 01       		.byte	1
 6618 0196 04       		.byte	4
 6619 0197 07       		.byte	7
 6620 0198 0A       		.byte	10
 6621 0199 0D       		.byte	13
 6622 019a 80       		.byte	-128
 6623 019b 80       		.byte	-128
 6624 019c 80       		.byte	-128
 6625 019d 80       		.byte	-128
 6626 019e 80       		.byte	-128
 6627 019f 80       		.byte	-128
 6628              		.align 32
 6629              	.LC26:
 6630 01a0 02       		.byte	2
 6631 01a1 05       		.byte	5
 6632 01a2 08       		.byte	8
 6633 01a3 0B       		.byte	11
 6634 01a4 0E       		.byte	14
 6635 01a5 80       		.byte	-128
 6636 01a6 80       		.byte	-128
 6637 01a7 80       		.byte	-128
 6638 01a8 80       		.byte	-128
 6639 01a9 80       		.byte	-128
 6640 01aa 80       		.byte	-128
 6641 01ab 80       		.byte	-128
 6642 01ac 80       		.byte	-128
 6643 01ad 80       		.byte	-128
 6644 01ae 80       		.byte	-128
 6645 01af 80       		.byte	-128
 6646 01b0 80       		.byte	-128
 6647 01b1 80       		.byte	-128
 6648 01b2 80       		.byte	-128
 6649 01b3 80       		.byte	-128
 6650 01b4 80       		.byte	-128
 6651 01b5 80       		.byte	-128
 6652 01b6 80       		.byte	-128
 6653 01b7 80       		.byte	-128
 6654 01b8 80       		.byte	-128
 6655 01b9 80       		.byte	-128
 6656 01ba 80       		.byte	-128
 6657 01bb 80       		.byte	-128
 6658 01bc 80       		.byte	-128
 6659 01bd 80       		.byte	-128
 6660 01be 80       		.byte	-128
 6661 01bf 80       		.byte	-128
 6662              		.align 32
 6663              	.LC27:
 6664 01c0 80       		.byte	-128
 6665 01c1 80       		.byte	-128
 6666 01c2 80       		.byte	-128
 6667 01c3 80       		.byte	-128
 6668 01c4 80       		.byte	-128
 6669 01c5 80       		.byte	-128
 6670 01c6 80       		.byte	-128
 6671 01c7 80       		.byte	-128
 6672 01c8 80       		.byte	-128
 6673 01c9 80       		.byte	-128
 6674 01ca 00       		.byte	0
 6675 01cb 03       		.byte	3
 6676 01cc 06       		.byte	6
 6677 01cd 09       		.byte	9
 6678 01ce 0C       		.byte	12
 6679 01cf 0F       		.byte	15
 6680 01d0 02       		.byte	2
 6681 01d1 05       		.byte	5
 6682 01d2 08       		.byte	8
 6683 01d3 0B       		.byte	11
 6684 01d4 0E       		.byte	14
 6685 01d5 80       		.byte	-128
 6686 01d6 80       		.byte	-128
 6687 01d7 80       		.byte	-128
 6688 01d8 80       		.byte	-128
 6689 01d9 80       		.byte	-128
 6690 01da 80       		.byte	-128
 6691 01db 80       		.byte	-128
 6692 01dc 80       		.byte	-128
 6693 01dd 80       		.byte	-128
 6694 01de 80       		.byte	-128
 6695 01df 80       		.byte	-128
 6696              		.align 32
 6697              	.LC28:
 6698 01e0 80       		.byte	-128
 6699 01e1 80       		.byte	-128
 6700 01e2 80       		.byte	-128
 6701 01e3 80       		.byte	-128
 6702 01e4 80       		.byte	-128
 6703 01e5 01       		.byte	1
 6704 01e6 04       		.byte	4
 6705 01e7 07       		.byte	7
 6706 01e8 0A       		.byte	10
 6707 01e9 0D       		.byte	13
 6708 01ea 80       		.byte	-128
 6709 01eb 80       		.byte	-128
 6710 01ec 80       		.byte	-128
 6711 01ed 80       		.byte	-128
 6712 01ee 80       		.byte	-128
 6713 01ef 80       		.byte	-128
 6714 01f0 80       		.byte	-128
 6715 01f1 80       		.byte	-128
 6716 01f2 80       		.byte	-128
 6717 01f3 80       		.byte	-128
 6718 01f4 80       		.byte	-128
 6719 01f5 80       		.byte	-128
 6720 01f6 80       		.byte	-128
 6721 01f7 80       		.byte	-128
 6722 01f8 80       		.byte	-128
 6723 01f9 80       		.byte	-128
 6724 01fa 80       		.byte	-128
 6725 01fb 80       		.byte	-128
 6726 01fc 80       		.byte	-128
 6727 01fd 80       		.byte	-128
 6728 01fe 80       		.byte	-128
 6729 01ff 80       		.byte	-128
 6730              		.align 32
 6731              	.LC29:
 6732 0200 80       		.byte	-128
 6733 0201 80       		.byte	-128
 6734 0202 80       		.byte	-128
 6735 0203 80       		.byte	-128
 6736 0204 80       		.byte	-128
 6737 0205 80       		.byte	-128
 6738 0206 80       		.byte	-128
 6739 0207 80       		.byte	-128
 6740 0208 80       		.byte	-128
 6741 0209 80       		.byte	-128
 6742 020a 80       		.byte	-128
 6743 020b 80       		.byte	-128
 6744 020c 80       		.byte	-128
 6745 020d 80       		.byte	-128
 6746 020e 80       		.byte	-128
 6747 020f 80       		.byte	-128
 6748 0210 80       		.byte	-128
 6749 0211 80       		.byte	-128
 6750 0212 80       		.byte	-128
 6751 0213 80       		.byte	-128
 6752 0214 80       		.byte	-128
 6753 0215 80       		.byte	-128
 6754 0216 80       		.byte	-128
 6755 0217 80       		.byte	-128
 6756 0218 80       		.byte	-128
 6757 0219 80       		.byte	-128
 6758 021a 00       		.byte	0
 6759 021b 03       		.byte	3
 6760 021c 06       		.byte	6
 6761 021d 09       		.byte	9
 6762 021e 0C       		.byte	12
 6763 021f 0F       		.byte	15
 6764              		.align 32
 6765              	.LC30:
 6766 0220 8716993E 		.long	1050220167
 6767 0224 8716993E 		.long	1050220167
 6768 0228 8716993E 		.long	1050220167
 6769 022c 8716993E 		.long	1050220167
 6770 0230 8716993E 		.long	1050220167
 6771 0234 8716993E 		.long	1050220167
 6772 0238 8716993E 		.long	1050220167
 6773 023c 8716993E 		.long	1050220167
 6774              		.align 32
 6775              	.LC31:
 6776 0240 A245163F 		.long	1058424226
 6777 0244 A245163F 		.long	1058424226
 6778 0248 A245163F 		.long	1058424226
 6779 024c A245163F 		.long	1058424226
 6780 0250 A245163F 		.long	1058424226
 6781 0254 A245163F 		.long	1058424226
 6782 0258 A245163F 		.long	1058424226
 6783 025c A245163F 		.long	1058424226
 6784              		.align 32
 6785              	.LC32:
 6786 0260 D578E93D 		.long	1038710997
 6787 0264 D578E93D 		.long	1038710997
 6788 0268 D578E93D 		.long	1038710997
 6789 026c D578E93D 		.long	1038710997
 6790 0270 D578E93D 		.long	1038710997
 6791 0274 D578E93D 		.long	1038710997
 6792 0278 D578E93D 		.long	1038710997
 6793 027c D578E93D 		.long	1038710997
 6794              		.align 32
 6795              	.LC33:
 6796 0280 00000000 		.long	0
 6797 0284 0000E03F 		.long	1071644672
 6798 0288 00000000 		.long	0
 6799 028c 0000E03F 		.long	1071644672
 6800 0290 00000000 		.long	0
 6801 0294 0000E03F 		.long	1071644672
 6802 0298 00000000 		.long	0
 6803 029c 0000E03F 		.long	1071644672
 6804              		.align 32
 6805              	.LC34:
 6806 02a0 FFFF0000 		.long	65535
 6807 02a4 FFFF0000 		.long	65535
 6808 02a8 FFFF0000 		.long	65535
 6809 02ac FFFF0000 		.long	65535
 6810 02b0 FFFF0000 		.long	65535
 6811 02b4 FFFF0000 		.long	65535
 6812 02b8 FFFF0000 		.long	65535
 6813 02bc FFFF0000 		.long	65535
 6814              		.align 32
 6815              	.LC35:
 6832              		.align 32
 6833              	.LC36:
 6834 02e0 21C92CBE 		.long	3190606113
 6835 02e4 21C92CBE 		.long	3190606113
 6836 02e8 21C92CBE 		.long	3190606113
 6837 02ec 21C92CBE 		.long	3190606113
 6838 02f0 21C92CBE 		.long	3190606113
 6839 02f4 21C92CBE 		.long	3190606113
 6840 02f8 21C92CBE 		.long	3190606113
 6841 02fc 21C92CBE 		.long	3190606113
 6842              		.align 32
 6843              	.LC37:
 6844 0300 6F9BA9BE 		.long	3198786415
 6845 0304 6F9BA9BE 		.long	3198786415
 6846 0308 6F9BA9BE 		.long	3198786415
 6847 030c 6F9BA9BE 		.long	3198786415
 6848 0310 6F9BA9BE 		.long	3198786415
 6849 0314 6F9BA9BE 		.long	3198786415
 6850 0318 6F9BA9BE 		.long	3198786415
 6851 031c 6F9BA9BE 		.long	3198786415
 6852              		.align 32
 6853              	.LC38:
 6854 0320 0000003F 		.long	1056964608
 6855 0324 0000003F 		.long	1056964608
 6856 0328 0000003F 		.long	1056964608
 6857 032c 0000003F 		.long	1056964608
 6858 0330 0000003F 		.long	1056964608
 6859 0334 0000003F 		.long	1056964608
 6860 0338 0000003F 		.long	1056964608
 6861 033c 0000003F 		.long	1056964608
 6862              		.align 32
 6863              	.LC39:
 6864 0340 00000000 		.long	0
 6865 0344 00106040 		.long	1080037376
 6866 0348 00000000 		.long	0
 6867 034c 00106040 		.long	1080037376
 6868 0350 00000000 		.long	0
 6869 0354 00106040 		.long	1080037376
 6870 0358 00000000 		.long	0
 6871 035c 00106040 		.long	1080037376
 6872              		.align 32
 6873              	.LC40:
 6874 0360 465ED6BE 		.long	3201719878
 6875 0364 465ED6BE 		.long	3201719878
 6876 0368 465ED6BE 		.long	3201719878
 6877 036c 465ED6BE 		.long	3201719878
 6878 0370 465ED6BE 		.long	3201719878
 6879 0374 465ED6BE 		.long	3201719878
 6880 0378 465ED6BE 		.long	3201719878
 6881 037c 465ED6BE 		.long	3201719878
 6882              		.align 32
 6883              	.LC41:
 6884 0380 E886A6BD 		.long	3181807336
 6885 0384 E886A6BD 		.long	3181807336
 6886 0388 E886A6BD 		.long	3181807336
 6887 038c E886A6BD 		.long	3181807336
 6888 0390 E886A6BD 		.long	3181807336
 6889 0394 E886A6BD 		.long	3181807336
 6890 0398 E886A6BD 		.long	3181807336
 6891 039c E886A6BD 		.long	3181807336
 6892              		.align 32
 6893              	.LC42:
 6894 03a0 80       		.byte	-128
 6895 03a1 00       		.byte	0
 6896 03a2 06       		.byte	6
 6897 03a3 80       		.byte	-128
 6898 03a4 00       		.byte	0
 6899 03a5 07       		.byte	7
 6900 03a6 80       		.byte	-128
 6901 03a7 00       		.byte	0
 6902 03a8 08       		.byte	8
 6903 03a9 80       		.byte	-128
 6904 03aa 00       		.byte	0
 6905 03ab 09       		.byte	9
 6906 03ac 80       		.byte	-128
 6907 03ad 00       		.byte	0
 6908 03ae 0A       		.byte	10
 6909 03af 80       		.byte	-128
 6910 03b0 80       		.byte	-128
 6911 03b1 80       		.byte	-128
 6912 03b2 80       		.byte	-128
 6913 03b3 80       		.byte	-128
 6914 03b4 80       		.byte	-128
 6915 03b5 80       		.byte	-128
 6916 03b6 80       		.byte	-128
 6917 03b7 80       		.byte	-128
 6918 03b8 80       		.byte	-128
 6919 03b9 80       		.byte	-128
 6920 03ba 80       		.byte	-128
 6921 03bb 80       		.byte	-128
 6922 03bc 80       		.byte	-128
 6923 03bd 80       		.byte	-128
 6924 03be 80       		.byte	-128
 6925 03bf 80       		.byte	-128
 6926              		.align 32
 6927              	.LC43:
 6928 03c0 05       		.byte	5
 6929 03c1 80       		.byte	-128
 6930 03c2 80       		.byte	-128
 6931 03c3 06       		.byte	6
 6932 03c4 80       		.byte	-128
 6933 03c5 80       		.byte	-128
 6934 03c6 07       		.byte	7
 6935 03c7 80       		.byte	-128
 6936 03c8 80       		.byte	-128
 6937 03c9 08       		.byte	8
 6938 03ca 80       		.byte	-128
 6939 03cb 80       		.byte	-128
 6940 03cc 09       		.byte	9
 6941 03cd 80       		.byte	-128
 6942 03ce 80       		.byte	-128
 6943 03cf 0A       		.byte	10
 6944 03d0 80       		.byte	-128
 6945 03d1 80       		.byte	-128
 6946 03d2 80       		.byte	-128
 6947 03d3 80       		.byte	-128
 6948 03d4 80       		.byte	-128
 6949 03d5 80       		.byte	-128
 6950 03d6 80       		.byte	-128
 6951 03d7 80       		.byte	-128
 6952 03d8 80       		.byte	-128
 6953 03d9 80       		.byte	-128
 6954 03da 80       		.byte	-128
 6955 03db 80       		.byte	-128
 6956 03dc 80       		.byte	-128
 6957 03dd 80       		.byte	-128
 6958 03de 80       		.byte	-128
 6959 03df 80       		.byte	-128
 6960              		.align 32
 6961              	.LC44:
 6962 03e0 00       		.byte	0
 6963 03e1 80       		.byte	-128
 6964 03e2 00       		.byte	0
 6965 03e3 01       		.byte	1
 6966 03e4 80       		.byte	-128
 6967 03e5 00       		.byte	0
 6968 03e6 02       		.byte	2
 6969 03e7 80       		.byte	-128
 6970 03e8 00       		.byte	0
 6971 03e9 03       		.byte	3
 6972 03ea 80       		.byte	-128
 6973 03eb 00       		.byte	0
 6974 03ec 04       		.byte	4
 6975 03ed 80       		.byte	-128
 6976 03ee 00       		.byte	0
 6977 03ef 05       		.byte	5
 6978 03f0 80       		.byte	-128
 6979 03f1 80       		.byte	-128
 6980 03f2 80       		.byte	-128
 6981 03f3 80       		.byte	-128
 6982 03f4 80       		.byte	-128
 6983 03f5 80       		.byte	-128
 6984 03f6 80       		.byte	-128
 6985 03f7 80       		.byte	-128
 6986 03f8 80       		.byte	-128
 6987 03f9 80       		.byte	-128
 6988 03fa 80       		.byte	-128
 6989 03fb 80       		.byte	-128
 6990 03fc 80       		.byte	-128
 6991 03fd 80       		.byte	-128
 6992 03fe 80       		.byte	-128
 6993 03ff 80       		.byte	-128
 6994              		.align 32
 6995              	.LC45:
 6996 0400 80       		.byte	-128
 6997 0401 00       		.byte	0
 6998 0402 80       		.byte	-128
 6999 0403 80       		.byte	-128
 7000 0404 01       		.byte	1
 7001 0405 80       		.byte	-128
 7002 0406 80       		.byte	-128
 7003 0407 02       		.byte	2
 7004 0408 80       		.byte	-128
 7005 0409 80       		.byte	-128
 7006 040a 03       		.byte	3
 7007 040b 80       		.byte	-128
 7008 040c 80       		.byte	-128
 7009 040d 04       		.byte	4
 7010 040e 80       		.byte	-128
 7011 040f 80       		.byte	-128
 7012 0410 80       		.byte	-128
 7013 0411 80       		.byte	-128
 7014 0412 80       		.byte	-128
 7015 0413 80       		.byte	-128
 7016 0414 80       		.byte	-128
 7017 0415 80       		.byte	-128
 7018 0416 80       		.byte	-128
 7019 0417 80       		.byte	-128
 7020 0418 80       		.byte	-128
 7021 0419 80       		.byte	-128
 7022 041a 80       		.byte	-128
 7023 041b 80       		.byte	-128
 7024 041c 80       		.byte	-128
 7025 041d 80       		.byte	-128
 7026 041e 80       		.byte	-128
 7027 041f 80       		.byte	-128
 7028              		.align 32
 7029              	.LC46:
 7030 0420 80       		.byte	-128
 7031 0421 05       		.byte	5
 7032 0422 80       		.byte	-128
 7033 0423 80       		.byte	-128
 7034 0424 06       		.byte	6
 7035 0425 80       		.byte	-128
 7036 0426 80       		.byte	-128
 7037 0427 07       		.byte	7
 7038 0428 80       		.byte	-128
 7039 0429 80       		.byte	-128
 7040 042a 08       		.byte	8
 7041 042b 80       		.byte	-128
 7042 042c 80       		.byte	-128
 7043 042d 09       		.byte	9
 7044 042e 80       		.byte	-128
 7045 042f 80       		.byte	-128
 7046 0430 80       		.byte	-128
 7047 0431 80       		.byte	-128
 7048 0432 80       		.byte	-128
 7049 0433 80       		.byte	-128
 7050 0434 80       		.byte	-128
 7051 0435 80       		.byte	-128
 7052 0436 80       		.byte	-128
 7053 0437 80       		.byte	-128
 7054 0438 80       		.byte	-128
 7055 0439 80       		.byte	-128
 7056 043a 80       		.byte	-128
 7057 043b 80       		.byte	-128
 7058 043c 80       		.byte	-128
 7059 043d 80       		.byte	-128
 7060 043e 80       		.byte	-128
 7061 043f 80       		.byte	-128
 7062              		.align 32
 7063              	.LC47:
 7064 0440 00       		.byte	0
 7065 0441 01       		.byte	1
 7066 0442 80       		.byte	-128
 7067 0443 03       		.byte	3
 7068 0444 04       		.byte	4
 7069 0445 80       		.byte	-128
 7070 0446 06       		.byte	6
 7071 0447 07       		.byte	7
 7072 0448 80       		.byte	-128
 7073 0449 09       		.byte	9
 7074 044a 0A       		.byte	10
 7075 044b 80       		.byte	-128
 7076 044c 0C       		.byte	12
 7077 044d 0D       		.byte	13
 7078 044e 80       		.byte	-128
 7079 044f 0F       		.byte	15
 7080 0450 00       		.byte	0
 7081 0451 80       		.byte	-128
 7082 0452 02       		.byte	2
 7083 0453 03       		.byte	3
 7084 0454 80       		.byte	-128
 7085 0455 05       		.byte	5
 7086 0456 06       		.byte	6
 7087 0457 80       		.byte	-128
 7088 0458 08       		.byte	8
 7089 0459 09       		.byte	9
 7090 045a 80       		.byte	-128
 7091 045b 0B       		.byte	11
 7092 045c 0C       		.byte	12
 7093 045d 80       		.byte	-128
 7094 045e 0E       		.byte	14
 7095 045f 0F       		.byte	15
 7096              		.align 32
 7097              	.LC48:
 7098 0460 80       		.byte	-128
 7099 0461 80       		.byte	-128
 7100 0462 00       		.byte	0
 7101 0463 80       		.byte	-128
 7102 0464 80       		.byte	-128
 7103 0465 01       		.byte	1
 7104 0466 80       		.byte	-128
 7105 0467 80       		.byte	-128
 7106 0468 02       		.byte	2
 7107 0469 80       		.byte	-128
 7108 046a 80       		.byte	-128
 7109 046b 03       		.byte	3
 7110 046c 80       		.byte	-128
 7111 046d 80       		.byte	-128
 7112 046e 04       		.byte	4
 7113 046f 80       		.byte	-128
 7114 0470 80       		.byte	-128
 7115 0471 80       		.byte	-128
 7116 0472 80       		.byte	-128
 7117 0473 80       		.byte	-128
 7118 0474 80       		.byte	-128
 7119 0475 80       		.byte	-128
 7120 0476 80       		.byte	-128
 7121 0477 80       		.byte	-128
 7122 0478 80       		.byte	-128
 7123 0479 80       		.byte	-128
 7124 047a 80       		.byte	-128
 7125 047b 80       		.byte	-128
 7126 047c 80       		.byte	-128
 7127 047d 80       		.byte	-128
 7128 047e 80       		.byte	-128
 7129 047f 80       		.byte	-128
 7130              		.align 32
 7131              	.LC49:
 7132 0480 80       		.byte	-128
 7133 0481 80       		.byte	-128
 7134 0482 00       		.byte	0
 7135 0483 80       		.byte	-128
 7136 0484 80       		.byte	-128
 7137 0485 00       		.byte	0
 7138 0486 80       		.byte	-128
 7139 0487 80       		.byte	-128
 7140 0488 00       		.byte	0
 7141 0489 80       		.byte	-128
 7142 048a 80       		.byte	-128
 7143 048b 00       		.byte	0
 7144 048c 80       		.byte	-128
 7145 048d 80       		.byte	-128
 7146 048e 00       		.byte	0
 7147 048f 80       		.byte	-128
 7148 0490 80       		.byte	-128
 7149 0491 80       		.byte	-128
 7150 0492 80       		.byte	-128
 7151 0493 80       		.byte	-128
 7152 0494 80       		.byte	-128
 7153 0495 80       		.byte	-128
 7154 0496 80       		.byte	-128
 7155 0497 80       		.byte	-128
 7156 0498 80       		.byte	-128
 7157 0499 80       		.byte	-128
 7158 049a 80       		.byte	-128
 7159 049b 80       		.byte	-128
 7160 049c 80       		.byte	-128
 7161 049d 80       		.byte	-128
 7162 049e 80       		.byte	-128
 7163 049f 80       		.byte	-128
 7164              		.align 32
 7165              	.LC50:
 7166 04a0 00       		.byte	0
 7167 04a1 0B       		.byte	11
 7168 04a2 80       		.byte	-128
 7169 04a3 00       		.byte	0
 7170 04a4 0C       		.byte	12
 7171 04a5 80       		.byte	-128
 7172 04a6 00       		.byte	0
 7173 04a7 0D       		.byte	13
 7174 04a8 80       		.byte	-128
 7175 04a9 00       		.byte	0
 7176 04aa 0E       		.byte	14
 7177 04ab 80       		.byte	-128
 7178 04ac 00       		.byte	0
 7179 04ad 0F       		.byte	15
 7180 04ae 80       		.byte	-128
 7181 04af 00       		.byte	0
 7182 04b0 00       		.byte	0
 7183 04b1 80       		.byte	-128
 7184 04b2 80       		.byte	-128
 7185 04b3 01       		.byte	1
 7186 04b4 80       		.byte	-128
 7187 04b5 80       		.byte	-128
 7188 04b6 02       		.byte	2
 7189 04b7 80       		.byte	-128
 7190 04b8 80       		.byte	-128
 7191 04b9 03       		.byte	3
 7192 04ba 80       		.byte	-128
 7193 04bb 80       		.byte	-128
 7194 04bc 04       		.byte	4
 7195 04bd 80       		.byte	-128
 7196 04be 80       		.byte	-128
 7197 04bf 05       		.byte	5
 7198              		.align 32
 7199              	.LC51:
 7200 04c0 80       		.byte	-128
 7201 04c1 80       		.byte	-128
 7202 04c2 0B       		.byte	11
 7203 04c3 80       		.byte	-128
 7204 04c4 80       		.byte	-128
 7205 04c5 0C       		.byte	12
 7206 04c6 80       		.byte	-128
 7207 04c7 80       		.byte	-128
 7208 04c8 0D       		.byte	13
 7209 04c9 80       		.byte	-128
 7210 04ca 80       		.byte	-128
 7211 04cb 0E       		.byte	14
 7212 04cc 80       		.byte	-128
 7213 04cd 80       		.byte	-128
 7214 04ce 0F       		.byte	15
 7215 04cf 80       		.byte	-128
 7216 04d0 80       		.byte	-128
 7217 04d1 00       		.byte	0
 7218 04d2 80       		.byte	-128
 7219 04d3 80       		.byte	-128
 7220 04d4 01       		.byte	1
 7221 04d5 80       		.byte	-128
 7222 04d6 80       		.byte	-128
 7223 04d7 02       		.byte	2
 7224 04d8 80       		.byte	-128
 7225 04d9 80       		.byte	-128
 7226 04da 03       		.byte	3
 7227 04db 80       		.byte	-128
 7228 04dc 80       		.byte	-128
 7229 04dd 04       		.byte	4
 7230 04de 80       		.byte	-128
 7231 04df 80       		.byte	-128
 7232              		.align 32
 7233              	.LC52:
 7234 04e0 0A       		.byte	10
 7235 04e1 01       		.byte	1
 7236 04e2 02       		.byte	2
 7237 04e3 0B       		.byte	11
 7238 04e4 04       		.byte	4
 7239 04e5 05       		.byte	5
 7240 04e6 0C       		.byte	12
 7241 04e7 07       		.byte	7
 7242 04e8 08       		.byte	8
 7243 04e9 0D       		.byte	13
 7244 04ea 0A       		.byte	10
 7245 04eb 0B       		.byte	11
 7246 04ec 0E       		.byte	14
 7247 04ed 0D       		.byte	13
 7248 04ee 0E       		.byte	14
 7249 04ef 0F       		.byte	15
 7250 04f0 00       		.byte	0
 7251 04f1 01       		.byte	1
 7252 04f2 00       		.byte	0
 7253 04f3 03       		.byte	3
 7254 04f4 04       		.byte	4
 7255 04f5 01       		.byte	1
 7256 04f6 06       		.byte	6
 7257 04f7 07       		.byte	7
 7258 04f8 02       		.byte	2
 7259 04f9 09       		.byte	9
 7260 04fa 0A       		.byte	10
 7261 04fb 03       		.byte	3
 7262 04fc 0C       		.byte	12
 7263 04fd 0D       		.byte	13
 7264 04fe 04       		.byte	4
 7265 04ff 0F       		.byte	15
 7266              		.align 32
 7267              	.LC53:
 7268 0500 FF       		.byte	-1
 7269 0501 00       		.byte	0
 7270 0502 00       		.byte	0
 7271 0503 FF       		.byte	-1
 7272 0504 00       		.byte	0
 7273 0505 00       		.byte	0
 7274 0506 FF       		.byte	-1
 7275 0507 00       		.byte	0
 7276 0508 00       		.byte	0
 7277 0509 FF       		.byte	-1
 7278 050a 00       		.byte	0
 7279 050b 00       		.byte	0
 7280 050c FF       		.byte	-1
 7281 050d 00       		.byte	0
 7282 050e 00       		.byte	0
 7283 050f FF       		.byte	-1
 7284 0510 00       		.byte	0
 7285 0511 00       		.byte	0
 7286 0512 FF       		.byte	-1
 7287 0513 00       		.byte	0
 7288 0514 00       		.byte	0
 7289 0515 FF       		.byte	-1
 7290 0516 00       		.byte	0
 7291 0517 00       		.byte	0
 7292 0518 FF       		.byte	-1
 7293 0519 00       		.byte	0
 7294 051a 00       		.byte	0
 7295 051b FF       		.byte	-1
 7296 051c 00       		.byte	0
 7297 051d 00       		.byte	0
 7298 051e FF       		.byte	-1
 7299 051f 00       		.byte	0
 7300              		.align 32
 7301              	.LC54:
 7302 0520 00       		.byte	0
 7303 0521 80       		.byte	-128
 7304 0522 80       		.byte	-128
 7305 0523 00       		.byte	0
 7306 0524 80       		.byte	-128
 7307 0525 80       		.byte	-128
 7308 0526 00       		.byte	0
 7309 0527 80       		.byte	-128
 7310 0528 80       		.byte	-128
 7311 0529 00       		.byte	0
 7312 052a 80       		.byte	-128
 7313 052b 80       		.byte	-128
 7314 052c 00       		.byte	0
 7315 052d 80       		.byte	-128
 7316 052e 80       		.byte	-128
 7317 052f 00       		.byte	0
 7318 0530 80       		.byte	-128
 7319 0531 80       		.byte	-128
 7320 0532 06       		.byte	6
 7321 0533 80       		.byte	-128
 7322 0534 80       		.byte	-128
 7323 0535 07       		.byte	7
 7324 0536 80       		.byte	-128
 7325 0537 80       		.byte	-128
 7326 0538 08       		.byte	8
 7327 0539 80       		.byte	-128
 7328 053a 80       		.byte	-128
 7329 053b 09       		.byte	9
 7330 053c 80       		.byte	-128
 7331 053d 80       		.byte	-128
 7332 053e 0A       		.byte	10
 7333 053f 80       		.byte	-128
 7334              		.align 32
 7335              	.LC55:
 7336 0540 80       		.byte	-128
 7337 0541 80       		.byte	-128
 7338 0542 80       		.byte	-128
 7339 0543 80       		.byte	-128
 7340 0544 80       		.byte	-128
 7341 0545 80       		.byte	-128
 7342 0546 80       		.byte	-128
 7343 0547 80       		.byte	-128
 7344 0548 80       		.byte	-128
 7345 0549 80       		.byte	-128
 7346 054a 80       		.byte	-128
 7347 054b 80       		.byte	-128
 7348 054c 80       		.byte	-128
 7349 054d 80       		.byte	-128
 7350 054e 80       		.byte	-128
 7351 054f 80       		.byte	-128
 7352 0550 05       		.byte	5
 7353 0551 80       		.byte	-128
 7354 0552 80       		.byte	-128
 7355 0553 06       		.byte	6
 7356 0554 80       		.byte	-128
 7357 0555 80       		.byte	-128
 7358 0556 07       		.byte	7
 7359 0557 80       		.byte	-128
 7360 0558 80       		.byte	-128
 7361 0559 08       		.byte	8
 7362 055a 80       		.byte	-128
 7363 055b 80       		.byte	-128
 7364 055c 09       		.byte	9
 7365 055d 80       		.byte	-128
 7366 055e 80       		.byte	-128
 7367 055f 0A       		.byte	10
 7368              		.align 32
 7369              	.LC56:
 7370 0560 80       		.byte	-128
 7371 0561 00       		.byte	0
 7372 0562 80       		.byte	-128
 7373 0563 80       		.byte	-128
 7374 0564 00       		.byte	0
 7375 0565 80       		.byte	-128
 7376 0566 80       		.byte	-128
 7377 0567 00       		.byte	0
 7378 0568 80       		.byte	-128
 7379 0569 80       		.byte	-128
 7380 056a 00       		.byte	0
 7381 056b 80       		.byte	-128
 7382 056c 80       		.byte	-128
 7383 056d 00       		.byte	0
 7384 056e 80       		.byte	-128
 7385 056f 80       		.byte	-128
 7386 0570 80       		.byte	-128
 7387 0571 0B       		.byte	11
 7388 0572 80       		.byte	-128
 7389 0573 80       		.byte	-128
 7390 0574 0C       		.byte	12
 7391 0575 80       		.byte	-128
 7392 0576 80       		.byte	-128
 7393 0577 0D       		.byte	13
 7394 0578 80       		.byte	-128
 7395 0579 80       		.byte	-128
 7396 057a 0E       		.byte	14
 7397 057b 80       		.byte	-128
 7398 057c 80       		.byte	-128
 7399 057d 0F       		.byte	15
 7400 057e 80       		.byte	-128
 7401 057f 80       		.byte	-128
 7402              		.align 32
 7403              	.LC57:
 7404 0580 80       		.byte	-128
 7405 0581 80       		.byte	-128
 7406 0582 80       		.byte	-128
 7407 0583 80       		.byte	-128
 7408 0584 80       		.byte	-128
 7409 0585 80       		.byte	-128
 7410 0586 80       		.byte	-128
 7411 0587 80       		.byte	-128
 7412 0588 80       		.byte	-128
 7413 0589 80       		.byte	-128
 7414 058a 80       		.byte	-128
 7415 058b 80       		.byte	-128
 7416 058c 80       		.byte	-128
 7417 058d 80       		.byte	-128
 7418 058e 80       		.byte	-128
 7419 058f 80       		.byte	-128
 7420 0590 80       		.byte	-128
 7421 0591 80       		.byte	-128
 7422 0592 0B       		.byte	11
 7423 0593 80       		.byte	-128
 7424 0594 80       		.byte	-128
 7425 0595 0C       		.byte	12
 7426 0596 80       		.byte	-128
 7427 0597 80       		.byte	-128
 7428 0598 0D       		.byte	13
 7429 0599 80       		.byte	-128
 7430 059a 80       		.byte	-128
 7431 059b 0E       		.byte	14
 7432 059c 80       		.byte	-128
 7433 059d 80       		.byte	-128
 7434 059e 0F       		.byte	15
 7435 059f 80       		.byte	-128
 7436              		.align 32
 7437              	.LC58:
 7438 05a0 80       		.byte	-128
 7439 05a1 80       		.byte	-128
 7440 05a2 80       		.byte	-128
 7441 05a3 80       		.byte	-128
 7442 05a4 80       		.byte	-128
 7443 05a5 80       		.byte	-128
 7444 05a6 80       		.byte	-128
 7445 05a7 80       		.byte	-128
 7446 05a8 80       		.byte	-128
 7447 05a9 80       		.byte	-128
 7448 05aa 80       		.byte	-128
 7449 05ab 80       		.byte	-128
 7450 05ac 80       		.byte	-128
 7451 05ad 80       		.byte	-128
 7452 05ae 80       		.byte	-128
 7453 05af 80       		.byte	-128
 7454 05b0 80       		.byte	-128
 7455 05b1 05       		.byte	5
 7456 05b2 80       		.byte	-128
 7457 05b3 80       		.byte	-128
 7458 05b4 06       		.byte	6
 7459 05b5 80       		.byte	-128
 7460 05b6 80       		.byte	-128
 7461 05b7 07       		.byte	7
 7462 05b8 80       		.byte	-128
 7463 05b9 80       		.byte	-128
 7464 05ba 08       		.byte	8
 7465 05bb 80       		.byte	-128
 7466 05bc 80       		.byte	-128
 7467 05bd 09       		.byte	9
 7468 05be 80       		.byte	-128
 7469 05bf 80       		.byte	-128
 7470              		.align 32
 7471              	.LC59:
 7472 05c0 00       		.byte	0
 7473 05c1 80       		.byte	-128
 7474 05c2 02       		.byte	2
 7475 05c3 03       		.byte	3
 7476 05c4 80       		.byte	-128
 7477 05c5 05       		.byte	5
 7478 05c6 06       		.byte	6
 7479 05c7 80       		.byte	-128
 7480 05c8 08       		.byte	8
 7481 05c9 09       		.byte	9
 7482 05ca 80       		.byte	-128
 7483 05cb 0B       		.byte	11
 7484 05cc 0C       		.byte	12
 7485 05cd 80       		.byte	-128
 7486 05ce 0E       		.byte	14
 7487 05cf 0F       		.byte	15
 7488 05d0 80       		.byte	-128
 7489 05d1 01       		.byte	1
 7490 05d2 02       		.byte	2
 7491 05d3 80       		.byte	-128
 7492 05d4 04       		.byte	4
 7493 05d5 05       		.byte	5
 7494 05d6 80       		.byte	-128
 7495 05d7 07       		.byte	7
 7496 05d8 08       		.byte	8
 7497 05d9 80       		.byte	-128
 7498 05da 0A       		.byte	10
 7499 05db 0B       		.byte	11
 7500 05dc 80       		.byte	-128
 7501 05dd 0D       		.byte	13
 7502 05de 0E       		.byte	14
 7503 05df 80       		.byte	-128
 7504              		.align 32
 7505              	.LC60:
 7506 05e0 80       		.byte	-128
 7507 05e1 80       		.byte	-128
 7508 05e2 80       		.byte	-128
 7509 05e3 80       		.byte	-128
 7510 05e4 80       		.byte	-128
 7511 05e5 80       		.byte	-128
 7512 05e6 80       		.byte	-128
 7513 05e7 80       		.byte	-128
 7514 05e8 80       		.byte	-128
 7515 05e9 80       		.byte	-128
 7516 05ea 80       		.byte	-128
 7517 05eb 80       		.byte	-128
 7518 05ec 80       		.byte	-128
 7519 05ed 80       		.byte	-128
 7520 05ee 80       		.byte	-128
 7521 05ef 80       		.byte	-128
 7522 05f0 0A       		.byte	10
 7523 05f1 80       		.byte	-128
 7524 05f2 80       		.byte	-128
 7525 05f3 0B       		.byte	11
 7526 05f4 80       		.byte	-128
 7527 05f5 80       		.byte	-128
 7528 05f6 0C       		.byte	12
 7529 05f7 80       		.byte	-128
 7530 05f8 80       		.byte	-128
 7531 05f9 0D       		.byte	13
 7532 05fa 80       		.byte	-128
 7533 05fb 80       		.byte	-128
 7534 05fc 0E       		.byte	14
 7535 05fd 80       		.byte	-128
 7536 05fe 80       		.byte	-128
 7537 05ff 0F       		.byte	15
 7538              		.section	.rodata.cst8,"aM",@progbits,8
 7539              		.align 8
 7540              	.LC61:
 7541 0000 00000000 		.long	0
 7542 0004 0000E03F 		.long	1071644672
 7543              		.align 8
 7544              	.LC62:
 7545 0008 00000000 		.long	0
 7546 000c 00106040 		.long	1080037376
 7547              		.section	.rodata.cst32
 7548              		.align 32
 7549              	.LC64:
 7550 0600 00800043 		.long	1124106240
 7551 0604 00800043 		.long	1124106240
 7552 0608 00800043 		.long	1124106240
 7553 060c 00800043 		.long	1124106240
 7554 0610 00800043 		.long	1124106240
 7555 0614 00800043 		.long	1124106240
 7556 0618 00800043 		.long	1124106240
 7557 061c 00800043 		.long	1124106240
 7558              		.section	.rodata.cst4
 7559              		.align 4
 7560              	.LC65:
 7561 0024 00800043 		.long	1124106240
 7562              		.section	.rodata.cst32
 7563              		.align 32
 7564              	.LC67:
 7565 0620 00000043 		.long	1124073472
 7566 0624 00000043 		.long	1124073472
 7567 0628 00000043 		.long	1124073472
 7568 062c 00000043 		.long	1124073472
 7569 0630 00000043 		.long	1124073472
 7570 0634 00000043 		.long	1124073472
 7571 0638 00000043 		.long	1124073472
 7572 063c 00000043 		.long	1124073472
 7573              		.section	.rodata.cst4
 7574              		.align 4
 7575              	.LC74:
 7576 0028 F628B43F 		.long	1068771574
 7577              		.align 4
 7578              	.LC75:
 7579 002c 60E5B0BE 		.long	3199264096
 7580              		.align 4
 7581              	.LC76:
 7582 0030 C28637BF 		.long	3208087234
 7583              		.align 4
 7584              	.LC77:
 7585 0034 46B6E33F 		.long	1071887942
 7586              		.text
 7587              	.Letext0:
 7588              		.file 2 "/usr/local/gcc/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/stddef.h"
 7589              		.file 3 "/usr/include/bits/types.h"
 7590              		.file 4 "/usr/include/libio.h"
 7591              		.file 5 "/usr/include/stdio.h"
 7592              		.file 6 "/usr/include/time.h"
 7593              		.file 7 "/usr/include/malloc.h"
 7594              		.file 8 "jpeg_handler.h"
 7595              		.file 9 "misc.h"
 7596              		.file 10 "/usr/include/stdlib.h"
 7597              		.file 11 "/usr/include/bits/mathcalls.h"
 7598              		.file 12 "include/jpeglib.h"
 7599              		.file 13 "<interno>"
