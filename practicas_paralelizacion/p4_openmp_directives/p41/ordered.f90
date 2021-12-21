PROGRAM ORDERED
        IMPLICIT NONE

        INTEGER, PARAMETER:: N=1000, M=4000
        REAL, DIMENSION(N,M):: X,Y
        REAL, DIMENSION(N):: Z
        INTEGER I,J

        CALL RANDOM_NUMBER(X)
        CALL RANDOM_NUMBER(Y)
        Z=0.0

        PRINT *, 'The first 20 values of Z are:'

!$OMP PARALLEL DEFAULT(SHARED) PRIVATE(I,J)

!$OMP DO SCHEDULE(DYNAMIC,2) ORDERED
        DO I=1,N
                DO J=1,M
                        Z(I) = Z(I) + X(I,J)*Y(J,I)
                END DO

!$OMP ORDERED
                IF(I<21) THEN
                        PRINT *, 'Z(',I,') =',Z(I)
                END IF
!$OMP END ORDERED

        END DO

!$OMP END DO

!$OMP END PARALLEL


END PROGRAM ORDERED

