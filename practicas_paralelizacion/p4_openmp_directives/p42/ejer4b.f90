       PROGRAM ejer4b
        integer i, j, k
        real a(200),b(200),c(200,200)

        call random_number(a)

        DO i=1,200
          b(i) = 0
          DO j=1,200
             c(i,j)=200
          ENDDO
        ENDDO

        j = 0 
        DO i=1,100
          j = j + 2
          b(j) = a(i)
          
          DO k=1,i
             j = j + 1
             c(j,k) = a(i)
          END DO             
        ENDDO
        
        print *,a
        print *,b
        print *,c
       END
