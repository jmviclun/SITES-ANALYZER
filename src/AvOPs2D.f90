       ix=(lx-lycgam-lzcbet)/nbw
       iy=(lysgam-lzcalp)/nbw
       iz=(lzsbet*salp)/nbw
   
       ALLOCATE (intensityxy(1:nbw,1:nbw), intensityyz(1:nbw,1:nbw), &
                 intensityzx(1:nbw,1:nbw))
     
       SELECT CASE (structype)

       CASE ("type0")
       initx=0.0
       inity=0.0

       CASE ("type1")

       IF (alp.GT.90.0) THEN 
       iy=(lysgam-lzcalp)/nbw
       inity=lzcalp
       initx=0.0
       ELSE IF (alp.LE.90.0) THEN
       iy=(lysgam+lzcalp)/nbw
       inity=0.0  
       initx=0.0
       END IF

       CASE ("type2")

       IF (bet.GT.90.0) THEN 
       ix=(lx-lzcbet)/nbw
       initx=lzcbet
       inity=0.0
       ELSE IF (bet.LE.90.0) THEN
       ix=(lx+lzcbet)/nbw
       initx=0.0 
       inity=0.0 
       END IF

       CASE ("type3")

       IF (gam.GT.90.0) THEN 
       ix=(lx-lycgam)/nbw
       initx=lycgam
       inity=0.0 
       ELSE IF (gam.LE.90.0) THEN
       ix=(lx+lycgam)/nbw
       initx=0.0  
       inity=0.0  
       END IF
      
       CASE ("type4")
       IF (ABS(lycgam).GT.ABS(lzcbet)) THEN
        IF (gam.GT.90.0) THEN
        ix=(lx+ABS(lycgam))/nbw
        initx=-1*ABS(lycgam)
        ELSE IF (gam.LE.90.0) THEN
        ix=(lx+ABS(lycgam))/nbw
        initx=0.0
        END IF
       ELSE
        IF (bet.GT.90.0) THEN
        ix=(lx+ABS(lzcbet))/nbw
        initx=-1*ABS(lzcbet)
        ELSE IF (bet.LE.90.0) THEN
        ix=(lx+ABS(lzcbet))/nbw
        initx=-1*ABS(lzcbet)
        END IF
       END IF
       iy=(lysgam+ABS(lzcalp))/nbw
       inity=-1*ABS(lzcalp)

       END SELECT

       ixp2=ix/2.0
       iyp2=iy/2.0
       izp2=iz/2.0

       intensityxy=0.0
       intensityyz=0.0
       intensityzx=0.0
      OPEN(21,file="AvOPs/2D/AvOPs-2D-XY.dat",&
           STATUS='NEW', ACTION='WRITE')
      WRITE(21,'(A42)') "# Position-x    Position-y    Intensity   "
      WRITE(21,'(A42)') "#========================================="
      OPEN(22,file="AvOPs/2D/AvOPs-2D-YZ.dat",&
           STATUS='NEW', ACTION='WRITE')
      WRITE(22,'(A42)') "# Position-y    Position-z    Intensity   "
      WRITE(22,'(A42)') "#========================================="
      OPEN(23,file="AvOPs/2D/AvOPs-2D-ZX.dat",&
           STATUS='NEW', ACTION='WRITE')
      WRITE(23,'(A42)') "# Position-z    Position-x    Intensity   "
      WRITE(23,'(A42)') "#========================================="
       DO i=1,nmovies                                  ! loop 1
        f=INT(maxi(i)/npseudo)
        DO j=1,f                                       ! loop 2 
         DO k=1,nbw                                    ! loop 3
          DO l=1,nbw                                   ! loop 4
      IF ((xCOM(i,j).GT.(ix*k-ixp2+initx)).AND.(xCOM(i,j).LE.(ix*k+ixp2+initx))&
         .AND.(yCOM(i,j).GT.(iy*l-iyp2+inity)).AND.(yCOM(i,j).LE.(iy*l+iyp2+inity))) &
         intensityxy(k,l)=intensityxy(k,l)+1
      IF ((yCOM(i,j).GT.(iy*k-iyp2+inity)).AND.(yCOM(i,j).LE.(iy*k+iyp2+inity))&
         .AND.(zCOM(i,j).GT.(iz*l-izp2)).AND.(zCOM(i,j).LE.(iz*l+izp2))) &
         intensityyz(k,l)=intensityyz(k,l)+1
      IF ((zCOM(i,j).GT.(iz*k-izp2)).AND.(zCOM(i,j).LE.(iz*k+izp2))&
         .AND.(xCOM(i,j).GT.(ix*l-ixp2+initx)).AND.(xCOM(i,j).LE.(ix*l+ixp2+initx))) &
         intensityzx(k,l)=intensityzx(k,l)+1
          END DO                                      ! loop 4
         END DO                                       ! loop 3   
        END DO                                        ! loop 2 
       END DO                                         ! loop 1

       DO k=1,nbw
        DO l=1,nbw
        WRITE(21,'(F8.2,F8.2,I12)') ix*k+initx,iy*l+inity,intensityxy(k,l)
        WRITE(22,'(F8.2,F8.2,I12)') iy*k+inity,iz*l,intensityyz(k,l)
        WRITE(23,'(F8.2,F8.2,I12)') iz*k,ix*l+initx,intensityzx(k,l)
        IF (l.EQ.nbw) THEN
        WRITE(21,*) " "
        WRITE(22,*) " "
        WRITE(23,*) " "
        END IF
        END DO
       END DO
      CLOSE (UNIT=21); CLOSE (UNIT=22); CLOSE (UNIT=23)
