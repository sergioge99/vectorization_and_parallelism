       PROGRAM ejer2a
        integer i
        real a(500), b(500), c(500)

        call random_number(a)
        call random_number(b)

        DO i=1,500
          c(i) = 0
        ENDDO

		!$OMP PARALLEL DO SCHEDULE(DYNAMIC)
        DO i=1,200
          a(2*i) = b(i)
          c(2*i) = a(2*i)
          c(2*i + 1) = a(2*i + 1)
        ENDDO
		!$OMP END PARALLEL DO
        
        print *,a
        print *,b
        print *,c	
       END
