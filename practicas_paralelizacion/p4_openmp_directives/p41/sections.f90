!Filename: sections.f
!
!This shows code that is executed 
!in sections.

PROGRAM SECTIONS 
        IMPLICIT NONE
        INTEGER OMP_GET_THREAD_NUM, tnumber 

!$OMP PARALLEL
!$OMP SECTIONS PRIVATE(tnumber) 

!$OMP SECTION
        tnumber=OMP_GET_THREAD_NUM()
        PRINT *,"This is section 1 being executed by thread",tnumber    
!$OMP SECTION
        tnumber=OMP_GET_THREAD_NUM()
        PRINT *,"This is section 2 being executed by thread",tnumber    
!$OMP SECTION
        tnumber=OMP_GET_THREAD_NUM()
        PRINT *,"This is section 3 being executed by thread",tnumber    
!$OMP SECTION
        tnumber=OMP_GET_THREAD_NUM()
        PRINT *,"This is section 4 being executed by thread",tnumber    
!$OMP END SECTIONS 
!$OMP END PARALLEL

END PROGRAM SECTIONS 


