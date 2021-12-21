/* parallel.c */
/* el numero de threads puede configurarse
   con la variable de entorno OMP_NUM_THREADS */
/* hendrix02:~/ setenv OMP_NUM_THREADS n */

#include <omp.h>
#include <stdio.h>

int
main(void)
{
    int i;
    
    //omp_set_dynamic(0);
    //omp_set_num_threads(4);

    #pragma omp parallel private(i)
    {
	i = omp_get_thread_num();
	if (i == 0)
	    printf("soy el master thread (tid = %d)\n", i);
	else
	    printf("soy el thread con tid %d\n", i);
    }
    return 0;
}
