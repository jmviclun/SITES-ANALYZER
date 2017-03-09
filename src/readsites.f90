      OPEN(3,FILE="SITE-positions.dat",STATUS='OLD', ACTION='READ')

      DO i=1,numberofsites
       jj=npossite(i)
       DO j=1,jj
       READ(3,*) chems(i,j),xsite(i,j),ysite(i,j),zsite(i,j)
       END DO
      END DO
      CLOSE (UNIT=3)

       PRINT*, numberofsites, "DEFINED SITES:"; PRINT*,""
       WRITE(4,*) numberofsites, "DEFINED SITES:"; WRITE(4,*) ""
      DO s=1,numberofsites
       WRITE(*,'(A5,I4,A6,I6,A16,A20,A8)') "SITE",s,"HAS",npossite(s),&
             "POSITIONS WITH", geomoutput(s), "GEOMETRY"
       WRITE(*,'(A10,A4,F7.3,A4,F7.3,A4,F7.3)') "Radius-->", "x:",&
             radx(s),"y:",rady(s),"z:",radz(s)
       PRINT*,""
       WRITE(4,'(A5,I4,A6,I6,A16,A20,A8)') "SITE",s,"HAS",npossite(s),&
             "POSITIONS WITH", geomoutput(s), "GEOMETRY"
       WRITE(4,'(A10,A4,F7.3,A4,F7.3,A4,F7.3)') "Radius-->", "x:",&
             radx(s),"y:",rady(s),"z:",radz(s)
       WRITE(4,*) ""

      END DO

