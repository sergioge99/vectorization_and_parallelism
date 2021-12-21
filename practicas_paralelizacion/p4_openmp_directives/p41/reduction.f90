!Filename: reduction.f
!
!This program shows the use of the REDUCTION clause.

      PROGRAM REDUCTION 
         IMPLICIT NONE
         INTEGER tnumber, OMP_GET_THREAD_NUM
         INTEGER I,J,K

!$OMP PARALLEL DEFAULT(PRIVATE) REDUCTION(+:I)&
!$OMP			 REDUCTION(*:J) REDUCTION(MAX:K)
         tnumber=OMP_GET_THREAD_NUM()

         I = tnumber
         J = tnumber
         K = tnumber

         PRINT *, "Thread ",tnumber, "I =",I," J =", J," K =",K

 !$OMP END PARALLEL

         PRINT *, ""
         PRINT *, "After Parallel Region:  I =",I," J =", J," K =",K

      END
