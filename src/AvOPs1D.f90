       maxsize=MAX(lx,ly,lz)
       imaxsize=INT(maxsize)+1
       nbw1D=INT(imaxsize/ix1D)
       ALLOCATE (intensityx(1:nbw1D), intensityy(1:nbw1D), &
                 intensityz(1:nbw1D))
       intensityx=0.0
       intensityy=0.0
       intensityz=0.0
     OPEN(11,file="AvOPs/1D/AvOPs-1D-X.dat",STATUS='NEW',ACTION='WRITE')
      WRITE(11,'(A42)') "# Position-x  Intensity   Intensity-norm  "
      WRITE(11,'(A42)') "#========================================="
     OPEN(12,file="AvOPs/1D/AvOPs-1D-Y.dat",STATUS='NEW',ACTION='WRITE')
      WRITE(12,'(A42)') "# Position-y  Intensity   Intensity-norm  "
      WRITE(12,'(A42)') "#========================================="
     OPEN(13,file="AvOPs/1D/AvOPs-1D-Z.dat",STATUS='NEW',ACTION='WRITE')
      WRITE(13,'(A42)') "# Position-z  Intensity   Intensity-norm  "
      WRITE(13,'(A42)') "#========================================="
       DO i=1,nmovies
        f=INT(maxi(i)/npseudo)
        DO j=1,f
         DO k=1,nbw1D
          IF (xCOM(i,j).LT.(ix1D-ix1D/2.0)) xCOM(i,j)=xCOM(i,j)+lx
          IF (xCOM(i,j).GT.lx) xCOM(i,j)=xCOM(i,j)-lx
          IF (yCOM(i,j).LT.(ix1D-ix1D/2.0)) yCOM(i,j)=yCOM(i,j)+ly
          IF (yCOM(i,j).GT.ly) yCOM(i,j)=yCOM(i,j)-ly
          IF (zCOM(i,j).LT.(ix1D-ix1D/2.0)) zCOM(i,j)=zCOM(i,j)+lz
          IF (zCOM(i,j).GT.lz) zCOM(i,j)=zCOM(i,j)-lz
      IF ((xCOM(i,j).GT.(ix1D*k-ix1D/2.0)).AND.(xCOM(i,j).LE.ix1D*k+ix1D/2.0)) &
         intensityx(k)=intensityx(k)+1
      IF ((yCOM(i,j).GT.(ix1D*k-ix1D/2.0)).AND.(yCOM(i,j).LE.ix1D*k+ix1D/2.0)) &
         intensityy(k)=intensityy(k)+1
      IF ((zCOM(i,j).GT.(ix1D*k-ix1D/2.0)).AND.(zCOM(i,j).LE.ix1D*k+ix1D/2.0)) &
         intensityz(k)=intensityz(k)+1
         END DO
        END DO
       END DO

       maxhistx=MAXVAL(intensityx)
       maxhisty=MAXVAL(intensityy)
       maxhistz=MAXVAL(intensityz)
       DO k=1,nbw1D
        stepsize=ix1D*k
        WRITE(11,'(F8.2,I12,F12.4)') stepsize, intensityx(k), &
                                     intensityx(k)/maxhistx
        WRITE(12,'(F8.2,I12,F12.4)') stepsize, intensityy(k), &
                                     intensityy(k)/maxhisty
        WRITE(13,'(F8.2,I12,F12.4)') stepsize, intensityz(k), &
                                     intensityz(k)/maxhistz
       END DO
      CLOSE (UNIT=11); CLOSE (UNIT=12); CLOSE (UNIT=13)
