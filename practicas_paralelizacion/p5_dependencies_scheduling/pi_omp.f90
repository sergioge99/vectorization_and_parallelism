PROGRAM PI_OMP
      IMPLICIT NONE
      real(8), PARAMETER:: nsubintervals=100000000
      real(8) x, pi, area, subinterval
      integer i, count1, count2, cr
      !! real(8) wtime1, wtime2
      real(8) wtr, tth1, tth2
      real(8) omp_get_wtick, omp_get_wtime		! funciones
      integer omp_get_max_threads, omp_get_num_procs	! funciones
      integer omp_get_num_threads, omp_get_thread_num	! funciones
      integer omp_set_dynamic, omp_get_dynamic		! funciones
      integer nprocsOMP, nthreadsOMP		! variables
      integer maxnthreadsOMP, threadID		! variables
      real etime, dtime				! funciones
      real t1, t2, tarray1(2), tarray2(2)	! variables

      maxnthreadsOMP = omp_get_max_threads()
      nprocsOMP = omp_get_num_procs()
      call system_clock(count_rate = cr)  ! resolucion system_clock() en Hz
      wtr = omp_get_wtick()		  ! resolucion omp_get_wtime() en segundos
  
      !! CALL OMP_SET_DYNAMIC(.TRUE.)
  
      print *," "
      print *,"Nº de procesadores"
      print *,"- omp_get_num_procs: ",nprocsOMP
      print *,"Nº de threads"
      print *,"- omp_get_max_threads: ",maxnthreadsOMP
      print *,"Resolución de los relojes:"
      print *,"- system_clock:", 1e6/cr," usg ->", cr/1e6," MHz"
      print *,"- omp_get_wtick:", 1e6*wtr," usg ->", 1.0/(1e6*wtr)," MHz"
      print *," "
  
      print *, "Calculando pi (nº intervalos: ", nsubintervals,")"
      print *, " "

      call system_clock(count=count1)   ! start timing
      t2 = etime(tarray2)        
      t1 = dtime(tarray1)

      ! omp_get_wtime() returns a double-precision floating-point value
      ! equal to the elapsed wall clock time in seconds since some time in the past
      ! wtime1 = omp_get_wtime()

      subinterval = 1.0 / nsubintervals;
      area = 0.0;

      nthreadsOMP = omp_get_num_threads()
      threadID = omp_get_thread_num()

      tth1 = omp_get_wtime()

	!$OMP PARALLEL DO SCHEDULE(guided,10000) REDUCTION(+:area)
      DO i = 1,nsubintervals
         ! threadID = omp_get_thread_num()
         ! print *, "Thread ",threadID, " : iteración", i
         x = (i-0.5)*subinterval;
         area = area + 4.0/(1.0 + x*x);
      ENDDO
	!$OMP END PARALLEL DO

      tth2 = omp_get_wtime()
      print *,"omp_get_wtime thread ",threadID,": ", tth2-tth1," sg"

      ! call sleep(10)

      ! wtime2 = omp_get_wtime()
      t1 = dtime(tarray1)
      t2 = etime(tarray2)        
      call system_clock(count=count2) ! stop timing
  
      pi = subinterval*area;

      print *,"***************************************"
      print *,"  PIcalculado =", pi
      print *,"  PIreal      = 3.1415926535897932385"
      print *,"***************************************"
      print *, " "

      print *,"- Threads utilizados (omp_get_num_threads):", nthreadsOMP
      print *, " "
  
      print *,"*** tiempos ***"      	 
      ! print *,"omp_get_wtime = ", wtime2-wtime1, " sg"
      print *,"system_clock =", (count2-count1)/1e6," sg"
      print *,"dtime =", t1," sg"
      print *,"etime =", t2," sg"
      print *,"-----------------------------------------------"
END
  
