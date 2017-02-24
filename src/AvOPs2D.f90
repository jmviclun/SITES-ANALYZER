       lycgam=ly*cgam
       lysgam=ly*sgam
       ix=(lx-lycgam)/nbw
       ix2=lx/nbw
       iy=lysgam/nbw
       iz=lz/nbw
       ixp2=ix/2.0
       ix2p2=ix2/2.0
       iyp2=iy/2.0
       izp2=iz/2.0
   
       ALLOCATE (intensityxy(1:nbw,1:nbw), intensityyz(1:nbw,1:nbw), &
                 intensityzx(1:nbw,1:nbw))
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
      IF ((xCOM(i,j).GT.(ix*k-ixp2+lycgam)).AND.(xCOM(i,j).LE.(ix*k+ixp2+lycgam))&
         .AND.(yCOM(i,j).GT.(iy*l-iyp2)).AND.(yCOM(i,j).LE.(iy*l+iyp2))) &
         intensityxy(k,l)=intensityxy(k,l)+1
      IF ((yCOM(i,j).GT.(iy*k-iyp2)).AND.(yCOM(i,j).LE.(iy*k+iyp2))&
         .AND.(zCOM(i,j).GT.(iz*l-izp2)).AND.(zCOM(i,j).LE.(iz*l+izp2))) &
         intensityyz(k,l)=intensityyz(k,l)+1
      IF ((zCOM(i,j).GT.(iz*k-izp2)).AND.(zCOM(i,j).LE.(iz*k+izp2))&
         .AND.(xCOM(i,j).GT.(ix2*l-ix2p2)).AND.(xCOM(i,j).LE.(ix2*l+ix2p2))) &
         intensityzx(k,l)=intensityzx(k,l)+1
          END DO                                      ! loop 4
         END DO                                       ! loop 3   
        END DO                                        ! loop 2 
       END DO                                         ! loop 1

       DO k=1,nbw
        DO l=1,nbw
        WRITE(21,'(F8.2,F8.2,I12)') ix*k+lycgam,iy*l,intensityxy(k,l)
        WRITE(22,'(F8.2,F8.2,I12)') iy*k,iz*l,intensityyz(k,l)
        WRITE(23,'(F8.2,F8.2,I12)') iz*k,ix2*l,intensityzx(k,l)
        IF (l.EQ.nbw) THEN
        WRITE(21,*) " "
        WRITE(22,*) " "
        WRITE(23,*) " "
        END IF
        END DO
       END DO
      CLOSE (UNIT=21); CLOSE (UNIT=22); CLOSE (UNIT=23)
