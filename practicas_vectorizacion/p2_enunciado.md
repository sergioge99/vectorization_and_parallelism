% Práctica 2: Limitaciones a la Vectorización:  
  Alineamiento, Solapamiento (Aliasing), Accesos a Memoria No Secuenciales (Stride), Condicionales.  
  30237 Multiprocesadores - Grado Ingeniería Informática  
  Esp. en Ingeniería de Computadores
% Jesús Alastruey Benedé y Víctor Viñals Yúfera  
  Área Arquitectura y Tecnología de Computadores  
  Departamento de Informática e Ingeniería de Sistemas  
  Escuela de Ingeniería y Arquitectura  
  Universidad de Zaragoza
% 8-marzo-2020

|                                                                                              |
|:--------------------------------------------------------------------------------------------:|
|![logo_diis](logo_diis.png){ height=70px } ![logo_eina](logo-eina.png){ height=70px }         |


## Resumen

_El objetivo de esta práctica es identificar las limitaciones existentes
a la hora de vectorizar código en una plataforma x86 y aprender a superarlas.
Analizaremos cómo afecta al proceso de vectorización
el alineamiento de las variables en memoria, su solapamiento,
los accesos a memoria no secuenciales (con stride) y
la presencia de sentencias condicionales.
También analizaremos su impacto en el rendimiento._

*****************************************************************************

## Trabajo previo

1. Requerimientos hardware y software:
    - CPU con soporte de la extensión vectorial AVX
    - SO Linux
    
    Los equipos del laboratorio L0.04 y L1.02 cumplen los requisitos indicados.
    Puede trabajarse en dichos equipos de forma presencial y también de forma remota
    si hay alguno arrancado con Linux.
    En el guión de la práctica 1 se explica cómo descubrir qué máquinas de un
    laboratorio están accesibles de forma remota.

2. Inicializar la variable de entorno CPU. Se utiliza para organizar los experimentos
   realizados en distintas máquinas en distintos directorios. Para ello hay que ejecutar:

            $ source ./initcpuname.sh

*****************************************************************************

## Parte 1. Efecto del alineamiento de los vectores en memoria

En esta parte vamos a trabajar con el fichero `ss_align.c`.
Analizaremos el efecto de la alineación de vectores
en la vectorización y en el rendimiento.
    
La función `ss_align_v1()` calcula el kernel _scale and shift_.
El vector `x[]` está alineado con el tamaño vectorial de AVX,
es decir, su dirección inicial es múltiplo de 32 bytes (256 bits).

        for (unsigned int i = 0; i < LEN; i++)
            x[i] = alpha*x[i] + beta;

La función `ss_align_v2()` hace el mismo cálculo pero con el vector `x[]` **NO**
alineado, ya que se procesa desde el elemento con índice 1:

        for (unsigned int i = 0; i < LEN; i++)
            x[i+1] = alpha*x[i+1] + beta;

1.  Compila con `gcc` el fichero `ss_align.c`:

            $ ./comp.sh -f ss_align.c

    Observa el informe del compilador.
    ¿Ha vectorizado los bucles en `ss_align_v1()` y `ss_align_v2()`?  
	Si, usando vectores de 32 bytes.
    Si el informe del compilador indica que ha aplicado alguna transformación, reséñala.
	../ss_align.c:107:5: optimized: loop vectorized using 32 byte vectors
	../ss_align.c:128:5: optimized: loop vectorized using 32 byte vectors


2.  Analiza el fichero que contiene el ensamblador del código vectorial y
    busca las instrucciones correspondientes a los bucles
    en `ss_align_v1()` y `ss_align_v2()`. ¿Qué diferencias hay?
	Cambia la instrucción vmovaps por vmovups, para guardar el resultado en memoria.

ss_align_v1()
  4007d0:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4007d4:	48 83 c0 20          	add    $0x20,%rax
  4007d8:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  4007dc:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  4007e1:	48 39 c3             	cmp    %rax,%rbx
  4007e4:	75 ea                	jne    4007d0 <ss_align_v1+0x50>
ss_align_v2()
  4008a0:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  4008a4:	48 83 c0 20          	add    $0x20,%rax
  4008a8:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  4008ac:	c5 fc 11 40 e0       	vmovups %ymm0,-0x20(%rax)
  4008b1:	48 39 c3             	cmp    %rax,%rbx
  4008b4:	75 ea                	jne    4008a0 <ss_align_v2+0x50>

3.  Las funciones `ss_align_v1_intr()` y `ss_align_v2_intr()` implementan
    con intrínsecos los bucles de las funciones `ss_align_v1()` y
    `ss_align_v2()` respectivamente. En el primer caso los
    accesos a memoria son alineados y en el segundo son no alineados.

    Observa de nuevo el informe del compilador.
    ¿Ha vectorizado los bucles en `ss_align_v1_intr()` y `ss_align_v2_intr()`?
	No optimiza, ya son intrínsecos.
    
    Analiza el fichero que contiene el ensamblador del código vectorial y
    busca las instrucciones correspondientes al bucle en `ss_align_v1_intr()` y `ss_align_v2_intr()`.
    ¿Qué diferencias hay entre las versiones `v1` y `v1_intr`? ¿Y entre las versiones `v2` y `v2_intr`?
	Entre las versiones optimizadas y las intrínsecas no hay diferencias.

ss_align_v1_intr()
  400970:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  400974:	48 83 c0 20          	add    $0x20,%rax
  400978:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  40097c:	c5 fc 29 40 e0       	vmovaps %ymm0,-0x20(%rax)
  400981:	48 39 c3             	cmp    %rax,%rbx
  400984:	75 ea                	jne    400970 <ss_align_v1_intr+0x50>
ss_align_v2_intr()
  400a40:	c5 e4 59 00          	vmulps (%rax),%ymm3,%ymm0
  400a44:	48 83 c0 20          	add    $0x20,%rax
  400a48:	c5 fc 58 c2          	vaddps %ymm2,%ymm0,%ymm0
  400a4c:	c5 fc 11 40 e0       	vmovups %ymm0,-0x20(%rax)
  400a51:	48 39 c3             	cmp    %rax,%rbx
  400a54:	75 ea                	jne    400a40 <ss_align_v2_intr+0x50>

    Nota: si se compila para generaciones de procesadores anteriores a Haswell,
    el compilador puede dividir cada acceso a memoria de 32 bytes (256 bits)
    en dos accesos de 16 bytes (128 bits). Ver [1] para más detalles.

    Crea un enlace simbólico a las versión 7.2 de `gcc`:
    
        $ ln -s /usr/local/gcc-7.2.0/bin/gcc $HOME/usr/bin/gcc-7

    Compila:
    
        $ ./comp.sh -f ss_align.c -c gcc-7
    
    Observa el ensamblador del bucle en `ss_align_v2()` y compáralo con el generado en el apartado anterior.

	En la version compilada con gcc 7.2 evita utilizar instrucciones de acceso no alineado a memoria, 
	para ello calcula los primeros 7 elementos antes del bucle utilizando instrucciones de memoria no alineada (4 en 
	packed y 3 en escalar),	después ejecuta el bucle con instrucciones alineadas a memoria y por último calcula los 
	elementos restantes con	instrucciones no alineadas.
    
4.  Ejecuta las dos versiones del programa `ss_align`:

            $ ./run.sh -f ss_align.c
            $ ./run.sh -f ss_align.c -c gcc-7

    Comenta brevemente los tiempos de ejecución obtenidos.

	Los tiempos son bastente similares, a excepción del bucle ss_align_v2() el cual obtiene un tiempo menor con la
	version gcc 7.2 que utiliza instrucciones alineadas en el bucle (88,5 to 77,7 (ns)).

5.  La función `ss_align_v1_intru()` es igual que `ss_align_v1_intr()` excepto en que
    el vector `x[]` se procesa desde el elemento con índice 1.
    
    Quita el comentario en la siguiente línea del programa principal:

            // ss_align_v1_intru();

    Recompila y ejecuta:

            $ ./comp.sh -f ss_align.c
            $ ./run.sh -f ss_align.c

    ¿Qué ocurre? ¿Cuál crees que es la causa?  
	Segmentation fault, al intentar acceder con una instruccion de acceso alineado (vmovaps) a una dirección no alineada.
    Para obtener más información de lo que ha ocurrido, 
    cargamos en `gdb` el binario y el fichero `core` generado:

            $ gdb ss_align.1k.single.native.gcc core.xyz

    `gdb` nos mostrará la línea de código que ha provocado el error.  
    En caso de que no se haya generado fichero `core`, habilita su creación y
    vuelve a ejecutar:

            $ ulimit -c unlimited
            $ ./ss_align.1k.single.native.gcc

    Para ver la última instrucción ejecutada:

            $ (gdb) layout asm


## Parte 2. Efecto del solapamiento de las variables en memoria

En esta parte vamos a trabajar con el fichero `ss_alias.c`.
Analizaremos el efecto del solapamiento de vectores
en la vectorización y en el rendimiento.
    
La función `ss_alias_v1()` calcula el kernel _scale and shift_ ($y = alpha \times x + beta$).
Las direcciones de los vectores origen y destino son parámetros de la función.

        for (unsigned int i = 0; i < LEN; i++)
            vy[i] = alpha*vx[i] + beta;

1.  Compila con `gcc` el programa `ss_alias.c`:

            $ ./comp.sh -f ss_alias.c

    Observa el informe del compilador.  
    ¿Ha vectorizado el bucle en `ss_alias_v1()`?
	Si.
    Indica las transformaciones realizadas por el compilador.
	../ss_alias.c:109:5: optimized: loop vectorized using 32 byte vectors
	../ss_alias.c:109:5: optimized:  loop versioned for vectorization because of possible aliasing

    Analiza el fichero que contiene el ensamblador del código vectorial AVX
    e identifica **TODOS** los bloques de código correspondientes al bucle.
    Ayuda: ten presente las transformaciones realizadas por el compilador.

	Hay dos bloques, el vectorial y el escalar.

2.  La función `ss_alias_v2()` es una versión de `ss_alias_v1()` en la que
    se han declarado como `restrict` los punteros que se pasan como parámetros:
        
            int ss_alias_v2(real * restrict vy, real * restrict vx)

    Busca en el actual estándar de C el significado de la palabra clave
    `restrict` y explica su efecto en esta función.

	La palabra clave restrict representa que ese puntero apunta a un objeto el cual no es apuntado por ningun otro puntero,
	lo cual utiliza el compilador para optimizar el bucle ya que no existe solapamiento.

    Analiza el informe del compilador y el código ensamblador de la función `ss_alias_v2()`.

../ss_alias.c:131:5: optimized: loop vectorized using 32 byte vectors


3.  La función `ss_alias_v3()` es una versión de `ss_alias_v1()` en la que
    se ha insertado antes del bucle la siguiente línea:

            #pragma GCC ivdep

    Busca en la documentación de `gcc` el significado del citado pragma
    y explica su efecto en esta función.

	Utilizando esto, el usuario afirma que no existen dependencias, el compilador optimizará el bucle incondicionalmente.

    Analiza el informe del compilador y el código ensamblador de la función `ss_alias_v3()`.

../ss_alias.c:154:5: optimized: loop vectorized using 32 byte vectors


4.  La función `ss_alias_v4()` es una versión de `ss_alias_v2()` en la que
    el bucle trabaja con las siguientes variables locales:

            real *xx = __builtin_assume_aligned(vx, ARRAY_ALIGNMENT);
            real *yy = __builtin_assume_aligned(vy, ARRAY_ALIGNMENT);

    Busca en la documentación de `gcc` el significado de
    `__builtin_assume_aligned()` y explica su efecto en esta función.

	Esta función devuelve el puntero pasado por parámetro, el compilador lo asumirá alineado al numero de bytes pasados por parámetro.

    Analiza el informe del compilador y el código ensamblador de la función `ss_alias_v4()`.

../ss_alias.c:178:5: optimized: loop vectorized using 32 byte vectors


5.  Ejecutar el programa:

            $ ./run.sh -f ss_alias.c

    Comenta brevemente los tiempos de ejecución obtenidos.
    Relaciona los resultados con las características de cada cada código ejecutado.

             Loop     ns       características  
       ss_alias_v1  3954.1    solapamiento y dependencia
       ss_alias_v1   480.8    solapamiento, no dependencia
       ss_alias_v1   480.8    solapamiento, no dependencia
       ss_alias_v1    78.8    no solapamiento, no dependencia
       ss_alias_v2    92.3    no solapamiento, no dependencia y restrict
       ss_alias_v2    78.3    no solapamiento, no dependencia y restrict
       ss_alias_v3    92.3    no solapamiento, no dependencia y #pragma GCC ivdep
       ss_alias_v3    78.3    no solapamiento, no dependencia y #pragma GCC ivdep
       ss_alias_v4    78.3    no solapamiento, no dependencia y restrict + __builtin_assume_aligned()
   scale_and_shift    76.1    solapamiento, no dependencia y variables globales


## Parte 3. Efecto de los accesos no secuenciales (stride) a memoria

En esta sección vamos a trabajar con el fichero `ss_stride.c`.
Las función `ss_stride_vec()` calcula ss(S=2), es decir,
el kernel scale and shift para **uno de cada dos elementos**:

        for (unsigned int i = 0; i < 2*LEN; i+=2)
            x[i] = alpha*x[i] + beta;

La función `ss_stride_esc()` hace el mismo cálculo pero se ha inhibido la vectorización
con la directiva `__attribute__((optimize("no-tree-vectorize")))`.

1.  Compila con `gcc` el programa `ss_stride.c`:

            $ ./comp.sh -f ss_stride.c

    Observa el informe del compilador.
	../ss_stride.c:139:5: optimized: loop vectorized using 32 byte vectors
    ¿Ha vectorizado el bucle en `ss_stride_vec()`?
	Sip.

    Analiza el fichero que contiene el ensamblador del código vectorial y
    echa un vistazo a las instrucciones correspondientes al bucle.  

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
  40083e:	48 3d c0 30 60 00    	cmp    $0x6030c0,%rax
  400844:	75 92                	jne    4007d8 <ss_stride_vec+0x48>

    ¿Cuántas instrucciones vectoriales corresponden al cuerpo del bucle interno?
	20-3=17 (vectoriales)
    Ayuda: utiliza las etiquetas al final de cada línea para identificarlas.

    **OPTATIVO**. Detalla las operaciones realizadas por las instrucciones
    vectoriales del bucle interno en `ss_stride_vec()`.


2.  **OPTATIVO**.
    Para este apartado se facilita el informe de compilación y el código ensamblador
    generados por `icc` 18.0.2 (por si no tenéis disponible una versión reciente del mismo).
    Observa el informe generado por el compilador.
    ¿Ha vectorizado el bucle en `ss_stride_vec()`?

    En caso afirmativo, analiza el fichero que contiene el ensamblador del código vectorial y
    echa un vistazo a las instrucciones correspondientes al bucle.  
    ¿Cuántas instrucciones vectoriales corresponden al cuerpo del bucle?
    Ayuda: utiliza las etiquetas al final de cada línea para identificarlas.
    
    Detalla las operaciones realizadas por las instrucciones
    vectoriales del bucle con stride.

3.  Ejecuta los programas generados por `gcc` e `icc` (este último es facilitado
    por si no tenéis disponible una versión reciente de `icc`):

            $ ./run.sh -f ss_stride.c

    Calcula las aceleraciones (_speedup_) de la versiones vectoriales sobre las escalares.  
	470.1/608.0 -> 77% speedup
    Calcula la aceleración (_speedup_) de la versión `icc` sobre la `gcc`.  
	esc 470.1/470.2 -> 
	vec 608.0/770.2 ->
    Comenta muy brevemente los tiempos de ejecución obtenidos.


## Parte 4. Efecto de las sentencias condicionales en el cuerpo del bucle

En esta sección vamos a trabajar con el fichero `cond.c`.
La función `cond_vec()` contiene una sentencia condicional en el cuerpo del bucle:

        if (y[i] < umbral)
            z[i] = y[i];
        else
            z[i] = x[i];

La función `cond_esc()` realiza el mismo cálculo, pero se ha inhibido la vectorización
con la directiva `__attribute__((optimize("no-tree-vectorize")))`.

1.  Compila con `gcc` el programa `cond.c`:

            $ ./comp.sh -f cond.c

    Observar el informe del compilador.
    ¿Ha vectorizado el bucle en `cond_vec()`?

2.  Analiza el fichero que contiene el ensamblador y
    echa un vistazo a las instrucciones correspondientes al bucle vectorizado.  
    ¿Cuántas instrucciones vectoriales corresponden al cuerpo del bucle interno?  
    Detalla las operaciones realizadas por las instrucciones vectoriales del bucle.

3.  Ejecuta el programa generado:

            $ ./run.sh -f cond.c

    Calcula la aceleración (_speedup_) de la versión vectorial sobre la escalar.


## Referencias

[1] Why doesn't gcc resolve _mm256_loadu_pd as single vmovupd?. 
[https://stackoverflow.com/questions/52626726/why-doesnt-gcc-resolve-mm256-loadu-pd-as-single-vmovupd] [r1]

[r1]: https://stackoverflow.com/questions/52626726/why-doesnt-gcc-resolve-mm256-loadu-pd-as-single-vmovupd


## Bibliografía

- Estándar C11 (documento WG14 N1570 con fecha 12-04-2011, es la última versión pública disponible de C11). Fecha de consulta: 6-marzo-2016. Disponible en:  
[http://www.open-std.org/JTC1/SC22/WG14/www/docs/n1570.pdf](http://www.open-std.org/JTC1/SC22/WG14/www/docs/n1570.pdf)

- Auto-vectorization with gcc 4.7. Fecha de consulta: 6-marzo-2016. Disponible en:  
[http://locklessinc.com/articles/vectorize/](http://locklessinc.com/articles/vectorize/)


