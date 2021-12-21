!Filename: density.f
!
PROGRAM DENSITY
        IMPLICIT NONE

        INTEGER, PARAMETER:: NBINS=10
        INTEGER, PARAMETER:: NPARTICLES=100000
        REAL:: XMIN, XMAX, MAXMASS, MINMASS

        REAL, DIMENSION(NPARTICLES):: X_LOCATION, PARTICLE_MASS
        INTEGER, DIMENSION(NPARTICLES):: BIN
        REAL, DIMENSION(NBINS):: GRID_MASS, GRID_DENSITY
        INTEGER, DIMENSION(NBINS):: GRID_N

        REAL:: DX,DXINV,TOTAL_MASS,CHECK_MASS
        INTEGER:: I, CHECK_N, XMAX_LOC(1)

        GRID_MASS=0.0
        TOTAL_MASS=0.0
	GRID_N=0
        CHECK_MASS=0.0
        CHECK_N=0

! Initialize particle positions and masses
        CALL RANDOM_NUMBER(PARTICLE_MASS)
        CALL RANDOM_NUMBER(X_LOCATION)

        MAXMASS = MAXVAL(PARTICLE_MASS)
        MINMASS = MINVAL(PARTICLE_MASS)
        XMAX = MAXVAL(X_LOCATION)
        XMIN = MINVAL(X_LOCATION)
        PRINT *, 'MINMASS =',MINMASS,' MAXMASS = ',MAXMASS
        PRINT *, 'XMIN =',XMIN,' XMAX = ',XMAX


! Grid Spacing (and inverse)
        DX = (XMAX-XMIN) / FLOAT(NBINS)
        DXINV = 1/DX

!$OMP PARALLEL DEFAULT(SHARED) PRIVATE(I) REDUCTION(+:TOTAL_MASS)

!$OMP DO
        DO I = 1, NPARTICLES
                IF (I==XMAX_LOC(1)) THEN
                        BIN(I) = NBINS
                ELSE
                        BIN(I) = 1 + ( (X_LOCATION(I)-XMIN) * DXINV )
                END IF

                IF(BIN(I) < 1 .OR. BIN(I) > NBINS) THEN
!                  Off Grid!
                   PRINT *, 'ERROR: BIN =',BIN(I),' X =',X_LOCATION(I)  

                ELSE
!$OMP ATOMIC
                     GRID_MASS(BIN(I)) = GRID_MASS(BIN(I)) &
					+ PARTICLE_MASS(I)
!$OMP ATOMIC
                     GRID_N(BIN(I))    = GRID_N(BIN(I)) + 1

                     TOTAL_MASS = TOTAL_MASS + PARTICLE_MASS(I)
                END IF
        END DO
!$OMP END DO

!$OMP END PARALLEL

        DO I=1, NBINS
                GRID_DENSITY(I) = GRID_MASS(I) * DXINV
        END DO

        PRINT *, 'Total Particles =',NPARTICLES
        PRINT *, 'Total Mass =',TOTAL_MASS
        DO I=1,NBINS
                PRINT *, 'DENSITY(',I,' ) =',GRID_DENSITY(I),' &
			&MASS(',I,' ) =',GRID_MASS(I)
        END DO

! Check for consistency
        DO I=1,NBINS
                CHECK_MASS = CHECK_MASS + GRID_MASS(I)
                CHECK_N    = CHECK_N + GRID_N(I)
        END DO

        PRINT *, 'Particles on Grid =', CHECK_N
        PRINT *, 'Total Mass on Grid =', CHECK_MASS
END PROGRAM DENSITY
