PROGRAM PI_F90
      IMPLICIT NONE
      real(8), PARAMETER:: nsubintervals=100000000
      real(8) x, pi, area, subinterval
      integer i, count1, count2, cr
      integer num_procs, num_threads	! funciones
      integer nprocs, nthreads		! variables
      real etime, dtime
      real t1, t2, tarray1(2), tarray2(2)
  
      ! nprocs = num_procs()
      ! nthreads = num_threads()
      call system_clock(count_rate = cr)  ! resolucion system_clock()

      print *," "
      ! print *,"Nº de procesadores"
      ! print *,"- num_procs: ",nprocs
      ! print *,"Nº de threads"
      ! print *,"- num_threads:", nthreads
      print *,"Resolución de los relojes:"
      print *,"- system_clock:", 1e6/cr," usg ->", cr/1e6," MHz"
      print *," "

      print *, "Calculando pi (nº intervalos: ", nsubintervals,")"
 
      call system_clock(count = count1) ! start timing
      t2 = etime(tarray2)        
      t1 = dtime(tarray1)
  
      subinterval = 1.0 / nsubintervals;
      area = 0.0;
  
      DO i = 1,nsubintervals
         x = (i-0.5)*subinterval;
         area = area + 4.0/(1.0 + x*x);
      ENDDO

      pi = subinterval*area;

      ! call sleep(10)

      t1 = dtime(tarray1)
      t2 = etime(tarray2)        
      call system_clock(count=count2) ! stop timing
  
      print *,"***************************************"
      print *,"  PIcalculado =", pi
      print *,"  PIreal      = 3.1415926535897932385"
      print *,"***************************************"
      print *, " "
  
      ! print *,"- Threads utilizados (num_threads)", nthreads
      ! print *, " "
        	 
      print *,"*** tiempos ***"      	 
      print *,"system_clock =", (count2-count1)/1e6," sg"
      print *,"dtime =", t1," sg"
      print *,"etime =", t2," sg"
      print *,"-----------------------------------------------"
END
