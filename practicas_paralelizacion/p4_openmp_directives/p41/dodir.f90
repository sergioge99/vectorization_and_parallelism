!Filename: dodir.f
!

PROGRAM DODIR 
        IMPLICIT NONE
        INTEGER I,L
        INTEGER, PARAMETER:: DIM=16
        REAL A(DIM),B(DIM),S
        INTEGER nthreads,tnumber
        INTEGER OMP_GET_NUM_THREADS,OMP_GET_THREAD_NUM

        CALL RANDOM_NUMBER(A)
        CALL RANDOM_NUMBER(B)

!$OMP PARALLEL DEFAULT(PRIVATE) SHARED(A,B)
!$OMP DO SCHEDULE(STATIC,4)
        DO I=2,DIM
                B(I) = ( A(I) - A(I-1) ) / 2.0

                nthreads=OMP_GET_NUM_THREADS()
                tnumber=OMP_GET_THREAD_NUM()
                print *, "Thread",tnumber," of",nthreads," has I=",I
        END DO
!$OMP END DO
!$OMP END PARALLEL

        S=MAXVAL(B)
        L=MAXLOC(B,1)

        PRINT *, "Maximum gradient: ",S," at location:",L

END PROGRAM DODIR 
