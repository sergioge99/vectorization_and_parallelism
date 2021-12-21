PROGRAM PI_G4
      IMPLICIT NONE
      real(8), parameter:: nsubintervals=100000000
      real(8) x, pi, area, subinterval
      real(8) varea(4)
      integer i
      integer count1, count2, cr
      real etime, dtime				! funciones
      real t1, t2, tarray1(2), tarray2(2)	! variables

      call system_clock(count_rate = cr)  ! resolucion system_clock()

      print *," "
      print *,"Nº de procesadores: 1"
      print *,"Nº de threads: 1"
      print *,"Resolución de los relojes:"
      print *,"- system_clock:", 1e6/cr," usg ->", cr/1e6," MHz"
      print *," "

      print *, "Calculando pi (nº intervalos: ", nsubintervals,")"
  
      call system_clock(count=count1) ! start timing
      t2 = etime(tarray2)        
      t1 = dtime(tarray1)
  
      subinterval = 1.0 / nsubintervals;
      area = 0.0;
      varea(1) = 0.0
      varea(2) = 0.0
      varea(3) = 0.0
      varea(4) = 0.0

      !DO i = 1,nsubintervals
      !   x = (i-0.5)*subinterval;
      !   area = area + 4.0/(1.0 + x*x);
      !ENDDO

      DO i = 1,nsubintervals,4
         x = (i-0.5)*subinterval
         varea(1) = varea(1) + 4.0/(1.0 + x*x);

         x = (i+0.5)*subinterval
         varea(2) = varea(2) + 4.0/(1.0 + x*x);

         x = (i+1.5)*subinterval
         varea(3) = varea(3) + 4.0/(1.0 + x*x);

         x = (i+2.5)*subinterval
         varea(4) = varea(4) + 4.0/(1.0 + x*x);
      ENDDO

      ! area = SUM(varea)
      area = varea(1) + varea(2) + varea(3) + varea(4)
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

      print *,"*** tiempos ***"      	 
      print *,"system_clock =", (count2-count1)/1e6," sg"
      print *,"dtime =", t1," sg"
      print *,"etime =", t2," sg"
      print *,"-----------------------------------------------"
END
