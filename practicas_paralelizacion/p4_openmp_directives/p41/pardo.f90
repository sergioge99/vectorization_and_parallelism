 PROGRAM PARDO 
         IMPLICIT NONE
         INTEGER I,J
         INTEGER, PARAMETER:: DIM1=50000, DIM2=200
         REAL A(DIM1),B(DIM2,DIM1),C(DIM2,DIM1)
         REAL t1, t2, dtime, etime, S
         INTEGER count1, count2, cr 
         REAL tarray1(2),tarray2(2)

         INTEGER nthreadsOMP, tnumber, maxnthreads, numprocsOMP
         INTEGER OMP_GET_NUM_THREADS,OMP_GET_THREAD_NUM
         INTEGER OMP_GET_MAX_THREADS,OMP_GET_NUM_PROCS,OMP_SET_NUM_THREADS
         INTEGER OMP_SET_DYNAMIC, OMP_GET_DYNAMIC

         CALL RANDOM_NUMBER(A)

         PRINT *," "

         maxnthreads=OMP_GET_MAX_THREADS()
         numprocsOMP=OMP_GET_NUM_PROCS()
         !! CALL OMP_SET_DYNAMIC(.TRUE.)

         PRINT *, "Entorno de ejecución"
         PRINT *, " - Máximo nº de threads disponibles (omp_get_max_threads): ",maxnthreads
         PRINT *, " - Nº de procesadores disponibles (omp_get_num_procs): ",numprocsOMP

         call system_clock(count_rate=cr)  ! find count rate
         call system_clock(count=count1) ! start timing
         t2 = etime(tarray2)        
         t1 = dtime(tarray1)
                         
!$OMP PARALLEL DO SCHEDULE(RUNTIME) PRIVATE(I,J) SHARED (A,B,C,nthreadsOMP)

         DO J=1,DIM2
             nthreadsOMP = OMP_GET_NUM_THREADS()
             DO I=2, DIM1
                 B(J,I) = ( (A(I)+A(I-1))/2.0 ) / SQRT(A(I))
                 C(J,I) = SQRT( A(I)*2 ) / ( A(I)-(A(I)/2.0) )
                 B(J,I) = C(J,I) * ( B(J,I)**2 ) * SIN(A(I))
             END DO
         END DO

 !$OMP END PARALLEL DO

         t1 = dtime(tarray1)
         t2 = etime(tarray2)
         call system_clock(count=count2) ! stop timing

         S=MAXVAL(B)

         !!WRITE(6,'("Maximum of B=",1pe8.2," found in ",1pe8.2," seconds -dtime- using", &
         !!                &I2," threads")') S,t1,nthreadsOMP

         !!WRITE(6,'("Maximum of B=",1pe8.2," found in ",1pe8.2," seconds -etime- using", &
         !!                &I2," threads")') S,t2,nthreadsOMP

         PRINT *," - Threads utilizados (omp_get_num_threads)", nthreadsOMP
         PRINT *, " "

         PRINT *,"*** dtime ***"
         WRITE(6,'("Tiempo total=",1pe8.2)') t1
         WRITE(6,'("Tiempo de usuario=",1pe8.2)') tarray1(1)
         WRITE(6,'("Tiempo de sistema=",1pe8.2)') tarray1(2)
         PRINT *, " "

         PRINT *,"*** etime ***"
         WRITE(6,'("Tiempo total=",1pe8.2)') t2
         WRITE(6,'("Tiempo de usuario=",1pe8.2)') tarray2(1)
         WRITE(6,'("Tiempo de sistema=",1pe8.2)') tarray2(2)
       	 PRINT *, " "
        	 
         PRINT *,"*** system_clock ***"        	 
         WRITE(6,'(" Tiempo total=",1pe8.2)') count2-count1
         PRINT *,"Resolución del reloj del sistema (msg)=", 1.0/cr
      
 END PROGRAM PARDO 
