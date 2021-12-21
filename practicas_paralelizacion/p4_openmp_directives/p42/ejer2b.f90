       PROGRAM ejer2b
        integer i
        real a(400), b(400)

        call random_number(a)

		!$OMP PARALLEL 
        DO i=2,200
          b(i) = a(i) - a(i-1)
        ENDDO
		!$OMP END PARALLEL
        
        print *,a
        print *,b
       END

        
