!Filename: parallel.f
!
!This simply shows that code in a PARALLEL
!region is executed by each thread.

      PROGRAM PARALLEL
         IMPLICIT NONE
         INTEGER I

         I=1

 !$OMP PARALLEL FIRSTPRIVATE(I)

         PRINT *, I
	 
 !$OMP END PARALLEL 


      END
      
