!Filename: single.f90
!
!This shows use of the SINGLE directive.
!

PROGRAM SINGLE 
        IMPLICIT NONE
        INTEGER, PARAMETER:: N=12
        REAL, DIMENSION(N):: A,B,C,D
        INTEGER:: I
        REAL:: SUMMED

!$OMP PARALLEL SHARED(A,B,C,D) PRIVATE(I)

!***** Reading files fort.10, fort.11, fort.12 in parallel

!$OMP SECTIONS
!$OMP SECTION
        READ(10,*) (A(I),I=1,N)
!$OMP SECTION
        READ(11,*) (B(I),I=1,N)
!$OMP SECTION
        READ(12,*) (C(I),I=1,N)
!$OMP END SECTIONS

!$OMP SINGLE
        SUMMED = SUM(A) + SUM(B) + SUM(C)
        PRINT *, "Sum of A+B+C=",SUMMED
!$OMP END SINGLE 

!$OMP DO SCHEDULE(STATIC,4)
        DO I=1,N
                D(I) = A(I) + B(I)*C(I)
        END DO
!$OMP END DO

!$OMP END PARALLEL

        PRINT *, "The values of D are", D

END PROGRAM SINGLE
 
