       PROGRAM ejer2c
        integer i
        real a(200)

        call random_number(a)

        DO i=2,200
          a(i) = a(i) - a(i-1)
        ENDDO
        
        print *,a
       END
