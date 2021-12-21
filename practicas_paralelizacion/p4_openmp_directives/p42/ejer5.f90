       PROGRAM ejer5
        integer i, j
        real a(200),b(200),q

        call random_number(a)
        call random_number(b)

        DO i=1,100
          a(i) = a(i) + b(i)
          q = q + a(i)
        ENDDO
        
        print *,a
        print *,b
	print *,q
       END
