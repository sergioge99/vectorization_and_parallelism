       PROGRAM ejer3a
        integer i
        real a(200),b(200),c(200)

        call random_number(a)

		!$OMP PARALLEL DO PRIVATE(t)
        DO i=1,200
          t = a(i)
          b(i) = t + t**2
          c(i) = t + 2
        ENDDO
		!$OMP END PARALLEL DO
        
        print *,a
        print *,b
        print *,c
       END
