
       OPEN(5,file="3D-sites-surface.pdb",STATUS='NEW', ACTION='WRITE')
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!    CUBIC      !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        DO s=1,numberofsites
        IF (geom(s).EQ."cubic") THEN
        IF ((radx(s).NE.rady(s)).OR.(radx(s).NE.radz(s)).OR. &
             (rady(s).NE.radz(s))) THEN
        PRINT*, "ERROR, RADIUS DOESN'T DEFINE A CUBE!"; PRINT*, ""
        WRITE(4,*)"ERROR, RADIUS DOESN'T DEFINE A CUBE!" ;WRITE(4,*) " "
        STOP
        END IF
        geom(s)="rectangular"
        END IF
        END DO
       
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!    CUBIC      !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!   MAIN LOOP   !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          idsite=1

         DO s=1,numberofsites ! loop 1
          jj=npossite(s)

        SELECT CASE (geom(s))
       
        CASE DEFAULT
        PRINT*, "ERROR, WRONG GEOMETRY!"; PRINT*, ""
        WRITE(4,*) "ERROR, WRONG GEOMETRY!" ; WRITE(4,*) " "
        STOP   

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!  SPHERICAL    !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        CASE ("spherical")
        IF ((radx(s).NE.rady(s)).OR.(radx(s).NE.radz(s)).OR. &
             (rady(s).NE.radz(s))) THEN
        PRINT*, "ERROR, RADIUS DOESN'T DEFINE A SPHERE!"; PRINT*, ""
        WRITE(4,*)"ERROR, RADIUS DOESN'T DEFINE A SPHERE!";WRITE(4,*)" "
        STOP
        END IF
        radius(s)=radx(s)
          sepc=15 
          theta=pi/sepc
          phi=pi/sepc
          DO w=1,jj           ! loop 2.1
           DO i=1,2*sepc+1
            DO j=1,sepc+1
             xs=xsite(s,w)+radius(s)*cos((i-1.0)*theta)*sin((j-1.0)*phi)
             ys=ysite(s,w)+radius(s)*sin((i-1.0)*theta)*sin((j-1.0)*phi)
             zs=zsite(s,w)+radius(s)*cos((j-1.0)*phi)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            END DO
           END DO 
          END DO              ! loop 2.1
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!  SPHERICAL    !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!  RECTANGULAR  !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        CASE ("rectangular")
          sep=1
          gridxend=INT(2*radx(s))
          gridyend=INT(2*rady(s))
          gridzend=INT(2*radz(s))
          nsx=INT(gridxend/(2*sep))
          nsy=INT(gridyend/(2*sep))
          nsz=INT(gridzend/(2*sep))
          
          DO w=1,jj           ! loop 2.2
         !PLANE XY 
          DO i=1,nsx+1          ! loop 3.1  
           DO j=1,nsy+1         ! loop 4.1 
            xs=xsite(s,w)-radx(s)+(i-1)*sep
            ys=ysite(s,w)-rady(s)+(j-1)*sep
            zs=zsite(s,w)-radz(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs+(2*radz(s)), & 
                 "1.00  0.00           N" 
            idsite=idsite+1
            xs=xsite(s,w)+radx(s)-(i-1)*sep
            ys=ysite(s,w)+rady(s)-(j-1)*sep
            zs=zsite(s,w)-radz(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs+(2*radz(s)), & 
                 "1.00  0.00           N" 
            idsite=idsite+1
           END DO           ! loop 4.1 
          END DO            ! loop 3.1
          DO i=1,nsx+1          ! loop 3.1  
           DO j=1,nsy+1         ! loop 4.1 
            xs=xsite(s,w)-radx(s)+(i-1)*sep
            ys=ysite(s,w)+rady(s)-(j-1)*sep
            zs=zsite(s,w)-radz(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs+(2*radz(s)), & 
                 "1.00  0.00           N" 
            idsite=idsite+1
            xs=xsite(s,w)+radx(s)-(i-1)*sep
            ys=ysite(s,w)-rady(s)+(j-1)*sep
            zs=zsite(s,w)-radz(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs+(2*radz(s)), & 
                 "1.00  0.00           N" 
            idsite=idsite+1
           END DO           ! loop 4.1 
          END DO            ! loop 3.1
         !PLANE YZ
          DO i=1,nsy+1      ! loop 3.2  
           DO j=1,nsz+1     ! loop 4.2 
            ys=ysite(s,w)-rady(s)+(i-1)*sep
            zs=zsite(s,w)-radz(s)+(j-1)*sep
            xs=xsite(s,w)-radx(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs+(2*radx(s)),ys,zs, & 
                 "1.00  0.00           N" 
            idsite=idsite+1
            ys=ysite(s,w)+rady(s)-(i-1)*sep
            zs=zsite(s,w)+radz(s)-(j-1)*sep
            xs=xsite(s,w)-radx(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs+(2*radx(s)),ys,zs, & 
                 "1.00  0.00           N" 
            idsite=idsite+1
           END DO           ! loop 4.2 
          END DO            ! loop 3.2
          DO i=1,nsy+1      ! loop 3.2  
           DO j=1,nsz+1     ! loop 4.2 
            ys=ysite(s,w)+rady(s)-(i-1)*sep
            zs=zsite(s,w)-radz(s)+(j-1)*sep
            xs=xsite(s,w)-radx(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs+(2*radx(s)),ys,zs, & 
                 "1.00  0.00           N" 
            idsite=idsite+1
            ys=ysite(s,w)-rady(s)+(i-1)*sep
            zs=zsite(s,w)+radz(s)-(j-1)*sep
            xs=xsite(s,w)-radx(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs+(2*radx(s)),ys,zs, & 
                 "1.00  0.00           N" 
            idsite=idsite+1
           END DO           ! loop 4.2 
          END DO            ! loop 3.2
         !PLANE ZX
          DO i=1,nsz+1      ! loop 3.3  
           DO j=1,nsx+1     ! loop 4.3 
            zs=zsite(s,w)-radz(s)+(i-1)*sep
            xs=xsite(s,w)-radx(s)+(j-1)*sep
            ys=ysite(s,w)-rady(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys+(2*rady(s)),zs, & 
                 "1.00  0.00           N" 
            idsite=idsite+1
            zs=zsite(s,w)+radz(s)-(i-1)*sep
            xs=xsite(s,w)+radx(s)-(j-1)*sep
            ys=ysite(s,w)-rady(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys+(2*rady(s)),zs, & 
                 "1.00  0.00           N" 
            idsite=idsite+1
           END DO           ! loop 4.3 
          END DO            ! loop 3.3
          DO i=1,nsz+1      ! loop 3.3  
           DO j=1,nsx+1     ! loop 4.3 
            zs=zsite(s,w)+radz(s)-(i-1)*sep
            xs=xsite(s,w)-radx(s)+(j-1)*sep
            ys=ysite(s,w)-rady(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys+(2*rady(s)),zs, & 
                 "1.00  0.00           N" 
            idsite=idsite+1
            zs=zsite(s,w)-radz(s)+(i-1)*sep
            xs=xsite(s,w)+radx(s)-(j-1)*sep
            ys=ysite(s,w)-rady(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys+(2*rady(s)),zs, & 
                 "1.00  0.00           N" 
            idsite=idsite+1
           END DO           ! loop 4.3 
          END DO            ! loop 3.3

          END DO              ! loop 2.2
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!  RECTANGULAR  !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!  CYLINDRICAL  !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        CASE ("cylindrical")

          sepc=15
          sep=1
          theta=pi/sepc
          gridxend=INT(2*radx(s))
          gridyend=INT(2*rady(s))
          gridzend=INT(2*radz(s))
          nsx=INT(gridxend/(2*sep))
          nsy=INT(gridyend/(2*sep))
          nsz=INT(gridzend/(2*sep))

        IF ((dire(s).NE."x").AND.(dire(s).NE."y").AND. &
             (dire(s).NE."z")) THEN
        PRINT*, "ERROR, WRONG DIRECTION SELECTED IN INPUT FILE!"
        WRITE(4,*) "ERROR, WRONG DIRECTION SELECTED IN INPUT FILE!"
        PRINT*, "" ; WRITE(4,*) " "
        STOP
        END IF
          DO w=1,jj           ! loop 2.1

          IF ( dire(s).EQ."x" ) THEN   ! CONDITION x
           IF (rady(s).NE.radz(s)) THEN  ! check radius 1
          PRINT*, "ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
        WRITE(4,*)"ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
            PRINT*, "" ; WRITE(4,*) " "
            STOP
           END IF                         ! check radius 1
        DO i=1,2*sepc+1      ! loop 3.1
         DO j=1,nsx+1        ! loop 4.1
           xs=xsite(s,w)-radx(s)+(j-1)
           ys=ysite(s,w)+rady(s)*cos((i-1.0)*theta)     
           zs=zsite(s,w)+rady(s)*sin((i-1.0)*theta)     
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
         END DO              ! loop 4.1
        END DO               ! loop 3.1
        DO i=1,2*sepc+1      ! loop 3.2
         DO j=1,nsx+1        ! loop 4.2
           xs=xsite(s,w)+radx(s)-(j-1)
           ys=ysite(s,w)-rady(s)*cos((i-1.0)*theta)     
           zs=zsite(s,w)-rady(s)*sin((i-1.0)*theta)     
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
         END DO              ! loop 4.2
        END DO               ! loop 3.2
        DO i=1,2*sepc+1      ! loop 3.3
         DO j=1,nsx+1        ! loop 4.3
           xs=xsite(s,w)-radx(s)
           ys=ysite(s,w)+rady(s)*cos((i-1.0)*theta)*(j-1)/nsx     
           zs=zsite(s,w)+rady(s)*sin((i-1.0)*theta)*(j-1)/nsx     
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs+(2*radx(s)),ys,zs, &
                 "1.00  0.00           N" 
            idsite=idsite+1
         END DO              ! loop 4.3
        END DO               ! loop 3.3

           END IF                      ! CONDITION x

          IF ( dire(s).EQ."y" ) THEN   ! CONDITION y
           IF (radx(s).NE.radz(s)) THEN  ! check radius 2
          PRINT*, "ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
        WRITE(4,*)"ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
            PRINT*, "" ; WRITE(4,*) " "
            STOP
           END IF                         ! check radius 2
        DO i=1,2*sepc+1      ! loop 3.4
         DO j=1,nsy+1        ! loop 4.4
           xs=xsite(s,w)+radz(s)*sin((i-1.0)*theta)
           ys=ysite(s,w)-rady(s)+(j-1)
           zs=zsite(s,w)+radz(s)*cos((i-1.0)*theta)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N"
            idsite=idsite+1
         END DO              ! loop 4.4
        END DO               ! loop 3.4
        DO i=1,2*sepc+1      ! loop 3.5
         DO j=1,nsy+1        ! loop 4.5
           xs=xsite(s,w)-radz(s)*sin((i-1.0)*theta)
           ys=ysite(s,w)+rady(s)-(j-1)
           zs=zsite(s,w)-radz(s)*cos((i-1.0)*theta)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N"
            idsite=idsite+1
         END DO              ! loop 4.5
        END DO               ! loop 3.5
        DO i=1,2*sepc+1      ! loop 3.6
         DO j=1,nsy+1        ! loop 4.6
           xs=xsite(s,w)+radz(s)*sin((i-1.0)*theta)*(j-1)/nsy
           ys=ysite(s,w)-rady(s)
           zs=zsite(s,w)+radz(s)*cos((i-1.0)*theta)*(j-1)/nsy
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N"
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys+(2*rady(s)),zs, &
                 "1.00  0.00           N"
            idsite=idsite+1
         END DO              ! loop 4.6
        END DO               ! loop 3.6
           END IF                      ! CONDITION y
       

          IF ( dire(s).EQ."z" ) THEN   ! CONDITION z
           IF (radx(s).NE.rady(s)) THEN  ! check radius 3
          PRINT*, "ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
        WRITE(4,*)"ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
            PRINT*, "" ; WRITE(4,*) " "
            STOP
           END IF                         ! check radius 3
        DO i=1,2*sepc+1      ! loop 3.7
         DO j=1,nsz+1        ! loop 4.7
           xs=xsite(s,w)+radx(s)*cos((i-1.0)*theta)
           ys=ysite(s,w)+radx(s)*sin((i-1.0)*theta)
           zs=zsite(s,w)-radz(s)+(j-1)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N"
            idsite=idsite+1
         END DO              ! loop 4.7
        END DO               ! loop 3.7
        DO i=1,2*sepc+1      ! loop 3.8
         DO j=1,nsz+1        ! loop 4.8
           xs=xsite(s,w)-radx(s)*cos((i-1.0)*theta)
           ys=ysite(s,w)-radx(s)*sin((i-1.0)*theta)
           zs=zsite(s,w)+radz(s)-(j-1)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N"
            idsite=idsite+1
         END DO              ! loop 4.8
        END DO               ! loop 3.8
        DO i=1,2*sepc+1      ! loop 3.9
         DO j=1,nsz+1        ! loop 4.9
           xs=xsite(s,w)+radx(s)*cos((i-1.0)*theta)*(j-1)/nsz
           ys=ysite(s,w)+radx(s)*sin((i-1.0)*theta)*(j-1)/nsz
           zs=zsite(s,w)-radz(s)
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs, &
                 "1.00  0.00           N"
            idsite=idsite+1
            WRITE(5,'(A4,I7,A3,A6,F18.3,F8.3,F8.3,A24)') &
                 "ATOM", idsite,chems(s,w),"MOL",xs,ys,zs+(2*radz(s)), &
                 "1.00  0.00           N"
            idsite=idsite+1
         END DO              ! loop 4.9
        END DO               ! loop 3.9
           END IF                      ! CONDITION z

          END DO              ! loop 2.1
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!  CYLINDRICAL  !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

        END SELECT
5     END DO                  ! loop 1
      CLOSE (UNIT=5)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!   MAIN LOOP   !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
