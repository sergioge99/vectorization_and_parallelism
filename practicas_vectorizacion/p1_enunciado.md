% Práctica 1: Fundamentos de Vectorización en x86:  
  Extensiones Vectoriales, Vectorización Automática y Manual  
  30237 Multiprocesadores - Grado Ingeniería Informática  
  Esp. en Ingeniería de Computadores
% Jesús Alastruey Benedé y Víctor Viñals Yúfera  
  Área Arquitectura y Tecnología de Computadores  
  Departamento de Informática e Ingeniería de Sistemas  
  Escuela de Ingeniería y Arquitectura  
  Universidad de Zaragoza
% 13-febrero-2020


## Resumen

_El objetivo de esta práctica es familiarizarse con las extensiones vectoriales
AVX y AVX-512 de Intel.
Analizaremos las instrucciones SIMD generadas por el compilador al vectorizar
de forma automática un bucle sencillo.
También estudiaremos el código generado al vectorizar un bucle de forma manual
mediante intrínsecos.
Por último, ejecutaremos las versiones escalar y vectorial del bucle y
compararemos su rendimiento._

![Operación vectorial¹](x86_vector.png){ height=250px }

¹Stephen Blair-Chappell (Intel Compiler Labs). The significance of SIMD, SSE and AVX for Robust HPC Development.

|                                                                                              |
|:--------------------------------------------------------------------------------------------:|
|![logo_diis](logo_diis.png){ height=70px } ![logo_eina](logo-eina.png){ height=70px }         |




## Ficheros de trabajo

Se proporciona un paquete `.tar.gz` en el que se encuentran los siguientes ficheros:

- `p1.md` y `p1.pdf`: ficheros en formatos _markdown_ y _pdf_ con el guión de la práctica.

- `scale_shift.c`: programa en C con dos versiones de un bucle,
    una **vectorizable** de forma automática (compilador):

            for (unsigned int i = 0; i < LEN; i++)
                x[i] = alpha*x[i] + beta;

    y otra **vectorizada** de forma manual (programador) mediante intrínsecos SSE:

            vscalar = _mm_set1_ps(scalar);
            for (unsigned int i = 0; i < LEN; i+= SSE_LEN)
            {
                vX = _mm_load_ps(&x[i]);
                vX = _mm_mul_ps(valpha, vX);
                vX = _mm_add_ps(vX, vbeta);
                _mm_store_ps(&x[i], vA);
            }

- `precision.h`: fichero donde se define
    - el tipo de dato `real`: `float` o `double`
    - el número de elementos procesados por cada instrucción vectorial
      para las extensiones vectoriales SSE, AVX y AVX-512

- `dummy.c`: función cuyo objetivo es forzar al compilador a generar código 
  que ejecute el bucle de trabajo un número especificado de repeticiones.

- `init_cpuname.sh`: script que inicializa la variable CPU (`export CPU=cpu_model`),
  utilizada para organizar los resultados de los experimentos.

- `comp.sh`: script que compila versiones escalares y vectoriales del programa `scale_shift.c`.
  Soporta versiones recientes de los compiladores `gcc`, `clang` e `icc` (intel C compiler).  
  Nota: compiladores disponibles en las maquinas del DIIS:
    - `gcc 9.2.0`, `gcc 7.2.0`

- `run.sh`: script que ejecuta las compilaciones escalar y vectorial del programa de trabajo.

- `sde.sh`: script para ejecutar las compilaciones escalar y vectorial del programa de trabajo
            con la herramienta Intel SDE.

- `comp.run.all.len.sh`: script para compilar y ejecutar las versiones
   escalares y vectoriales del programa `scale_shift.c` con distintos tipos de datos
   y longitudes de los vectores de trabajo.

*****************************************************************************

## Trabajo previo

1.  Requerimientos hardware y software:

    - CPU con soporte de la extensión vectorial AVX
    - SO linux
    
    Los equipos del laboratorio L0.04 y L1.02 cumplen los requisitos indicados.
    Puede trabajarse en dichos equipos de forma presencial y también de forma remota
    si hay alguno arrancado con Linux.
    Para saber qué máquinas de un laboratorio están accesibles de forma remota,
    ejecutar la siguiente orden en `hendrix`:

            $ rcmds -f lab102 -s -- uptime

    Puede cambiarse el nombre de laboratorio cuyos equipos se quieren inspeccionar.
    En la web de la asignatura se proporciona otro script que genera una lista
    de las direcciones IP y SO de las máquinas que están arrancadas en el L1.02.

2.  Identificar la plataforma de trabajo (lab004, lab102, equipo propio):

    a. Características de la plataforma de trabajo: CPU, sistema operativo, versión
    del compilador ...
    b. Detallar qué extensiones vectoriales soporta la CPU. No respondáis con
    volcados crudos de comandos.
       Ayuda: consulta el fichero `/proc/cpuinfo`.
    
    En caso de trabajar en un equipo del DIIS, para usar la reciente versión 9.2
    del compilador `gcc` hay que editar el fichero oculto `.software`
    que está en vuestro `$HOME` y añadir la palabra clave `gcc`.
    Este cambio tendrá efecto en los terminales que se abran a partir de ese momento.
    Para verificar la versión de `gcc`:

            $ gcc -v
            [...]
            gcc versión 9.2.0 (GCC) 

    Nota: conviene señalar que cuando se hace login en Linux con el sistema
    gráfico por defecto, normalmente los terminales que se ejecutan no utilizan
    un `login shell` por defecto. Esto significa que muchas variables de entorno
    necesarias no se inicializan, por ejemplo, la que controla la versión de `gcc`.
    La solución consiste en cambiar las preferencias del terminal
    para que por defecto utilice un `login shell`.

    En `gnome-terminal`:

            Menu->Edit->Profile Preferences->Command:
            [x] Run command as a login shell

    Y antes de usar el compilador de intel (`icc`):

            $ . /usr/local/intel/config.sh  # no dejarse el punto inicial

    En los equipos del DIIS no es posible trabajar en una misma sesión con
    `icc` y una versión reciente de `gcc`.

3.  Inicializar la variable de entorno CPU. Se utiliza para organizar los experimentos
    realizados en distintas máquinas en distintos directorios. Para ello hay que ejecutar:

        $ source ./init_cpuname.sh

    Esta orden ejecuta el script en el shell existente, lo que permite que la
    variable creada por el script esté disponible después de que el script
    finalice su ejecución. Si se invoca el script directamente

        $ ./init_cpuname.sh

    se ejecuta en otro shell, por lo que la variable de entorno
    no estará inicializada en el shell de trabajo.

*****************************************************************************

## Parte 1. Vectorización automática

En esta parte vamos a estudiar la capacidad para vectorizar bucles del compilador `gcc`.
También analizaremos el rendimiento del código vectorizado.

1.  Analiza y comprende el contenido de los ficheros `scale_shift.c` y `comp.sh`.
    `scale_shift()` es una operación que se utiliza para normalizar los datos
    que entrenan una red neuronal (_batch normalization_).
    También se utiliza en procesado de imagen.
    Hemos escogido un tamaño del vector que permite su almacenamiento en cache.
    De esta forma, los elementos de los vectores se leerán de memoria cache
    en lugar de memoria principal. `comp.sh` es un fichero para automatizar
    las tareas de compilación. Observa con detenimiento las opciones
    de compilación que especifican las extensiones vectoriales a utilizar.

2.  Compila con `gcc` las distintas versiones escalares y vectoriales
    (avx, avx+fma, avx512) del programa `scale_shift.c`:

            $ ./comp.sh

    Observa los informes del compilador que se han generado en el directorio `reports`,
    en especial la información correspondiente al bucle interno en la función `scale_shift()`.
    ¿Ha vectorizado el bucle en `scale_shift()`?

	En las 3 versiones escalares no, en las versiones vectoriales si, en avx y avx+fma en vectores de 32 bytes y en avx512 en vectores de 64 bytes.

3.  Analiza los ficheros que contienen el ensamblador de los siguientes códigos escalares y
    vectoriales: esc.avx, vec.avx, vec.avxfma y vec.avx512.
    Busca las instrucciones correspondientes al cuerpo del bucle en la función `scale_shift()`:

            x[i] = alpha*x[i] + beta
  
    Indica qué instrucciones se usan para:

     - leer el vector x[] de memoria y multiplica
	esc.avx vmulss
	vec.avx vmulps
	vec.avxfma vfmadd132ps
	vec.avx512 vmulps
     - sumar
	esc.avx vaddss
	vec.avx vaddps
	vec.avxfma vfmadd132ps
	vec.avx512 vaddps
     - escribir el vector resultado en memoria
	esc.avx vmovss
	vec.avx vmovaps
	vec.avxfma vmovaps
	vec.avx512 vmovaps
    

    ¿Hay alguna diferencia entre las instrucciones AVX y AVX-512?  
	En el bucle todas las instrucciones son las mismas, solo cambia el numero de elementos que se calculan por operación.

4.  ¿Cuántas instrucciones se ejecutan en el bucle interno (esc.avx, vec.avx, vec.avxfma y vec.avx512)?
	6 en todas.

            for (int i = 0; i < LEN; i++)
                x[i] = alpha*x[i] + beta

    Por ejemplo, para la versión esc.avx:
    
    $$
    \begin{aligned}
        ICOUNT = N \times LEN = 6 \times 1024 = 6144 \ instrucciones
    \end{aligned}
    $$        

    siendo $N$ el número de instrucciones del cuerpo del bucle (6) y $LEN$ el
    número de iteraciones del bucle (1024).

    Calcula la reducción en el número de instrucciones respecto la versión esc.avx.

	|  versión   |   icount   | reducción(%) | reducción(factor) |
	|:----------:|:----------:|:------------:|:-----------------:|
	|  esc.avx   |    6144    |       0      |        1.0        |
	|  vec.avx   |     768    |     87,5     |        8.0        |
	| vec.avxfma |     768    |     87,5     |        8.0        |
	| vec.avx512 |     384    |     93,75    |       16.0        |

5.  Ejecuta los programas compilados anteriormente:

            $ ./run.sh

    La columna Time muestra el tiempo medio de ejecución
    del bucle interno (kernel scale_shift), no el tiempo de todas sus ejecuciones.
    La columna TPI (tiempo por iteración) muestra el tiempo medio de ejecución
    de una iteración del código de alto nivel (C), no de una iteración en código máquina.

    ¿Qué ocurre al ejecutar la versión vec.avx512?
	Illegal instruction

            $ ./scale_shift.1k.single.vec.avx512.gcc
        
    Para obtener más información de lo que ha ocurrido, 
    cargamos en `gdb` el binario y el fichero `core` generado:

            $ gdb scale_shift.1k.single.vec.avx512.gcc core.xyz

    `gdb` nos mostrará la línea de código que ha provocado el error.  
    En caso de que no se haya generado fichero `core`, habilita su creación y
    vuelve a ejecutar:

            $ ulimit -c unlimited
            $ ./scale_shift.1k.single.vec.avx512.gcc

    Para ver la última instrucción ejecutada:

            $ (gdb) layout asm

	instruccion ilegal
	vmovaps -> 0x400713
 	
    
6.  A partir de los tiempos de ejecución obtenidos en el punto anterior,
    calcula las siguientes métricas para todas las versiones ejecutadas:

    - Aceleraciones (_speedups_) de las versiones vectoriales sobre sus escalares (vec.avx y vec.avxfma respecto esc.avx).
    - Rendimiento (R) en GFLOPS.
    - Rendimiento pico (R~pico~) teórico de un núcleo (_core_), en GFLOPS.
      Para las versiones escalares, considerar que las unidades funcionales trabajan en modo escalar.
      Considerar asimismo la capacidad FMA de las unidades funcionales solamente para las versiones compiladas con soporte FMA.
    - Velocidad de ejecución de instrucciones (V~I~), en Ginstrucciones por segundo (GIPS).

	|  versión   | tiempo(ns)|  speed-up |  R(GFLOPS)  |R~pico~(GFLOPS)| V~I~(GIPS) |
	|:----------:|:---------:|:---------:|:-----------:|:-------------:|:----------:|
	|  esc.avx   |   466.9   |    1.0    |    4,386    |      7,4      |   13,15    |
	|  vec.avx   |    77.1   |    6.05   |   26,562    |     59,2      |    9,79    |
	| vec.avxfma |    70.5   |    6.62   |   29,049    |    118,4      |   10,89    |

	2048 FLOPs
	Calculado con 3,7GHz
	

    Nota: GFLOPS = 10^9^ FLOPS. GIPS = 10^9^ IPS.

    Comenta brevemente la tabla de resultados obtenidos (tiempo de ejecución, _speedup_, rendimiento, velocidad).  
	
    ¿La velocidad de ejecución de instrucciones es un buen indicador de rendimiento?  
	No, no todas las instrucciones tardan lo mismo.
    ¿Son consistentes los resultados (_checksums_) de las distintas versiones?
	Si.

7.  **Optativo**.
    Usa la herramienta Intel Software Development Emulator (Intel SDE) [2] para
    obtener el número total de instrucciones ejecutadas por el bucle en la función `scale_shift()`.
    Para ello, ejecuta:

            $ ./sde.sh

    Este script ejecuta bajo SDE las versiones esc.avx, vec.avx, vec.avxfma y vec.avx512 y
    genera informes con la cuenta de instrucciones correspondiente al
    bucle en la función `scale_shift()`:

            $ $SDE_PATH/sde64 -skx -iform 1 -omix sde_esc.avx    -- ./binario_esc.avx
            $ $SDE_PATH/sde64 -skx -iform 1 -omix sde_vec.avx    -- ./binario_vec.avx
            $ $SDE_PATH/sde64 -skx -iform 1 -omix sde_vec.avxfma -- ./binario_vec.avxfma
            $ $SDE_PATH/sde64 -skx -iform 1 -omix sde_vec.avx512 -- ./binario_vec.avx512

    Por ejemplo, para la versión esc.avx:

            BLOCK: 0   PC: 0000000000400790   ICOUNT: 96636764160   EXECUTIONS: 16106127360
            #BYTES: 36   %:  99.7   cumltv%:  99.7  FN: scale_shift

    El número total de instrucciones ejecutadas (`ICOUNT`) es 96636764160.
    Se puede comprobar que coincide con el obtenido mediante la siguiente fórmula:
    
    $$
    \begin{aligned}
        ICOUNT = N \times LEN \times NTIMES = 6 \times 1024 \times 15 \times 1024^2 = 96.64 \times 10^9
    \end{aligned}
    $$        

    siendo $N$ el número de instrucciones del cuerpo del bucle (6), $LEN$ las iteraciones
    del bucle interno (1024) y $NTIMES$ las iteraciones del bucle externo ($15 \times 1024^2$).

    El número de ejecuciones del cuerpo del bucle interno (`EXECUTIONS`) es 16106127360,
    que coincide con el producto $LEN \times NTIMES = 1024 \times 15 \times 1024^2$.

    El número de instrucciones de una ejecución del bucle interno se puede obtener
    dividiendo el número total de instrucciones ejecutadas por el número de veces
    que se ha ejecutado el bucle interno:

    $$
    \begin{aligned}
        ICOUNT_{bucle} = \frac{ICOUNT}{NTIMES} = \frac{96636764160}{15 \times 1024^2} = 6144
    \end{aligned}
    $$        

    Nota: verifica que las siguientes líneas de código estén comentadas para acelerar la ejecución:

            scale_shift_intr_SSE();
            scale_shift_intr_AVX();

## Parte 2. Vectorización manual mediante intrínsecos

1.  Observa el informe del compilador correspondiente a la compilación con soporte AVX.
    ¿Hay alguna indicación de que haya vectorizado el bucle en `scale_shift_intr_SSE()`?

2.  Escribe una nueva versión del bucle, `scale_shift_intr_AVX()`, vectorizando de forma
    manual con intrínsecos AVX. Está el esqueleto de la función. El siguiente enlace
    puede ser de utilidad:
    
     <https://software.intel.com/sites/landingpage/IntrinsicsGuide/>

3.  Quita los comentarios de las llamadas a las funciones `scale_shift_intr_SSE()` y
    `scale_shift_intr_AVX()`. Recompila y ejecuta el código:

            $ ./comp.sh
            $ ./run.sh

    Analiza el fichero que contiene el ensamblador de la versión AVX y
    busca las instrucciones correspondientes al bucle en `scale_shift_intr_AVX()`.  
    ¿Hay alguna diferencia con las instrucciones correspondientes al bucle en `scale_shift()`?  
    ¿Hay diferencia en el rendimiento de las funciones `scale_shift()` y `scale_shift_intr_AVX()` (binario AVX)?  
    ¿Hay diferencia en el rendimiento de las versiones vec.avx y vec.avxfma correspondientes al bucle `scale_shift_intr_AVX()`?
    Compara las instrucciones generadas por el compilador para ambas versiones.


## Apartados optativos

1.  El flag `-march=native` genera flags de compilación para la máquina donde se está compilando.
    Para saber los flags que se generan:
    
        $ gcc -march=native -E -v - </dev/null 2>&1 | grep cc1
    
    Para compilar y ejecutar las versiones escalar y vectorial native:

        $ ./comp.sh -n
        $ ./run.sh -n

    Compara el rendimiento de las versiones native (esc.native y vec.native) con
    el de las versiones avx (esc.avx y vec.avx).

2.  Repite los puntos anteriores con vectores de precisión doble (`double`).
    El tipo de dato `real` se puede seleccionar como `float` o `double`
    mediante la variable `p` en el fichero `comp.sh`.
    
3.  Repite los puntos anteriores con el compilador `icc`.
    Se recomienda que utilicéis una versión reciente,
    que podéis conseguir en el siguiente enlace:

    [https://software.intel.com/en-us/qualify-for-free-software/student](https://software.intel.com/en-us/qualify-for-free-software/student)

    En caso de usar la versión disponible en los laboratorios (10.1)
    tendrás que modificar los _flags_ de compilación del fichero `comp.sh`.

4.  Analiza el rendimiento y las aceleraciones del código procesando otros tamaños de vectores.
    Para ello, puedes ayudarte del script `comp.run.all.len.sh`.


## Referencias   

[1] STREAM: Sustainable Memory Bandwidth in High Performance Computers. [http://www.cs.virginia.edu/stream/][r1]

[2] Intel® Software Development Emulator. [https://software.intel.com/en-us/articles/intel-software-development-emulator][r2]

[r1]: http://www.cs.virginia.edu/stream/
[r2]: https://software.intel.com/en-us/articles/intel-software-development-emulator


## Bibliografía relacionada

- Stephen Blair-Chappell (Intel Compiler Labs). The significance of SIMD, SSE and AVX for Robust HPC Development.

-  How do I achieve the theoretical maximum of 4 FLOPs per cycle?  
[http://stackoverflow.com/questions/8389648/how-do-i-achieve-the-theoretical-maximum-of-4-flops-per-cycle] [b1]

- Obtaining peak bandwidth on Haswell in the L1 cache: only getting 62%.  
[http://stackoverflow.com/questions/25899395/obtaining-peak-bandwidth-on-haswell-in-the-l1-cache-only-getting-62] [b2]

- Do FMA always produce the same result as a mul then add instruction?  
[http://stackoverflow.com/questions/29086377/do-fma-fused-multiply-add-instructions-always-produce-the-same-result-as-a-mul] [b3]


[b1]: http://stackoverflow.com/questions/8389648/how-do-i-achieve-the-theoretical-maximum-of-4-flops-per-cycle
[b2]: http://stackoverflow.com/questions/25899395/obtaining-peak-bandwidth-on-haswell-in-the-l1-cache-only-getting-62
[b3]: http://stackoverflow.com/questions/29086377/do-fma-fused-multiply-add-instructions-always-produce-the-same-result-as-a-mul
