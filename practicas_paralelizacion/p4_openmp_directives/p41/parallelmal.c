#include <omp.h>
#include <stdio.h>
#include <unistd.h>

/* setenv OMP_NUM_THREADS n */

int
main(void)
{
    int i;
    
    //omp_set_dynamic(0);
    //omp_set_num_threads(4);

    #pragma omp parallel shared(i)
    {
	i = omp_get_thread_num();
	sleep(1);
	if (i == 0)
	    printf("soy el master thread (tid = %d)\n", i);
	else
	    printf("soy el thread con tid %d\n", i);
    }
    return 0;
}
