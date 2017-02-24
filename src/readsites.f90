      OPEN(3,FILE="SITE-positions.dat",STATUS='OLD', ACTION='READ')

      DO i=1,numberofsites
       jj=npossite(i)
       DO j=1,jj
       READ(3,*) xsite(i,j),ysite(i,j),zsite(i,j)
       END DO
      END DO
      CLOSE (UNIT=3)
