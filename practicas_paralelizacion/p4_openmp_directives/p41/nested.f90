!Filename: nested.f90

PROGRAM NESTED
        IMPLICIT NONE
        INTEGER nthreads,tnumber
        INTEGER OMP_GET_NUM_THREADS,OMP_GET_THREAD_NUM

        CALL OMP_SET_DYNAMIC (.TRUE.)
        ! CALL OMP_SET_NESTED (.TRUE.)
        CALL OMP_SET_NUM_THREADS (2)

!$OMP PARALLEL DEFAULT(PRIVATE)

        tnumber=OMP_GET_THREAD_NUM()
        PRINT *, "First parallel region: thread ",tnumber, &
                 " of ", OMP_GET_NUM_THREADS()
        CALL OMP_SET_NUM_THREADS (4)

!$OMP PARALLEL FIRSTPRIVATE(tnumber)

        PRINT *, "Nested parallel region (team ",tnumber, &
		 "): thread ",OMP_GET_THREAD_NUM(), &
		 " of ", OMP_GET_NUM_THREADS()

!$OMP END PARALLEL

!$OMP END PARALLEL

END PROGRAM NESTED
