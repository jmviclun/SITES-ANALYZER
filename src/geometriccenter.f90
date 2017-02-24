      OPEN(2,FILE="atom-positions.dat",STATUS='OLD', ACTION='READ')
      f=0
      l=1
      xCOM=0;yCOM=0;zCOM=0
      DO i=1,nmovies
      f=INT(maxi(i)/npseudo)
       DO j=1,f
         DO k=1,npseudo
          READ(2,*) x(i,l),y(i,l),z(i,l)
          xCOM(i,j)=xCOM(i,j)+x(i,l)
          yCOM(i,j)=yCOM(i,j)+y(i,l)
          zCOM(i,j)=zCOM(i,j)+z(i,l)
          l=l+1
         END DO
         xCOM(i,j)=xCOM(i,j)/npseudo
         yCOM(i,j)=yCOM(i,j)/npseudo
         zCOM(i,j)=zCOM(i,j)/npseudo
       END DO
      END DO
      CLOSE (UNIT=2)
