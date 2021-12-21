       PROGRAM ejer3b
        integer i
        real a(200,200),b(200,200),c(200,200),t(200)

        call random_number(a)
        call random_number(b)
        call random_number(c)

        DO i=1,200
            DO j=1,200
              t(j) = a(i,j)+ b(i,j)
              c(i,j) = t(j) + c(i,j)
            ENDDO
        ENDDO

        print *,a
        print *,b
        print *,c
       END
