
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

      DO i=1,nmovies          ! loop 1
       f=INT(maxi(i)/npseudo); IF (f.EQ.0) GOTO 5
       cs=0
        DO j=1,f              ! loop 2
         DO s=1,numberofsites ! loop 3
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
          DO w=1,jj           ! loop 4.1

         CALL distance(xCOM(i,j),yCOM(i,j),zCOM(i,j),xsite(s,w), & 
                       ysite(s,w),zsite(s,w),distsc,xs,ys,zs)

          IF (distsc.LE.radius(s)) THEN  ! condition 1.1
           cs(s)=cs(s)+1  
          END IF                         ! condition 1.1
          END DO              ! loop 4.1
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!  SPHERICAL    !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!  RECTANGULAR  !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        CASE ("rectangular")
          DO w=1,jj           ! loop 4.2

         CALL distance(xCOM(i,j),yCOM(i,j),zCOM(i,j),xsite(s,w), &
                       ysite(s,w),zsite(s,w),distsc,xs,ys,zs)

         IF (xs.LE.radx(s)) THEN ! condition 1.1
          IF (ys.LE.rady(s)) THEN ! condition 1.2
           IF (zs.LE.radz(s)) THEN ! condition 1.3
           cs(s)=cs(s)+1  
            END IF                       ! condition 1.3
           END IF                       ! condition 1.2
          END IF                       ! condition 1.1
          END DO              ! loop 4.2
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!  RECTANGULAR  !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!  CYLINDRICAL  !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        CASE ("cylindrical")
        IF ((dire(s).NE."x").AND.(dire(s).NE."y").AND. &
             (dire(s).NE."z")) THEN
        PRINT*, "ERROR, WRONG DIRECTION SELECTED IN INPUT FILE!"
        WRITE(4,*) "ERROR, WRONG DIRECTION SELECTED IN INPUT FILE!"
        PRINT*, "" ; WRITE(4,*) " "
        STOP
        END IF
          DO w=1,jj           ! loop 4.1

          IF ( dire(s).EQ."x" ) THEN   ! CONDITION x
           IF (rady(s).NE.radz(s)) THEN  ! check radius 1
          PRINT*, "ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
        WRITE(4,*)"ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
            PRINT*, "" ; WRITE(4,*) " "
            STOP
           END IF                         ! check radius 1

         CALL distance(xCOM(i,j),yCOM(i,j),zCOM(i,j),xsite(s,w), &
                       ysite(s,w),zsite(s,w),distsc,xs,ys,zs)

           distsc=SQRT(ys*ys+zs*zs)            
           IF (distsc.LE.rady(s)) THEN  ! condition 1.1
            IF (xs.LE.radx(s)) THEN     ! condition 1.2
             cs(s)=cs(s)+1
            END IF                      ! condition 1.2
           END IF                       ! condition 1.1
          END IF                 ! CONDITION x

          IF ( dire(s).EQ."y" ) THEN   ! CONDITION y
           IF (radx(s).NE.radz(s)) THEN  ! check radius 2
          PRINT*, "ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
        WRITE(4,*)"ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
            PRINT*, "" ; WRITE(4,*) " "
            STOP
           END IF                         ! check radius 2

         CALL distance(xCOM(i,j),yCOM(i,j),zCOM(i,j),xsite(s,w), &
                       ysite(s,w),zsite(s,w),distsc,xs,ys,zs)

           distsc=SQRT(xs*xs+zs*zs)      
           IF (distsc.LE.radx(s)) THEN  ! condition 2.1
            IF (ys.LE.rady(s)) THEN     ! condition 2.2
             cs(s)=cs(s)+1
            END IF               ! condition 2.2
           END IF                ! condition 2.1
          END IF                 ! CONDITION y

          IF ( dire(s).EQ."z" ) THEN   ! CONDITION z
           IF (radx(s).NE.rady(s)) THEN  ! check radius 3
          PRINT*, "ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
        WRITE(4,*)"ERROR, RADIUS DOESN'T AGREE WITH SELECTED DIRECTION!"
            PRINT*, "" ; WRITE(4,*) " "
            STOP
           END IF                         ! check radius 3

        CALL distance(xCOM(i,j),yCOM(i,j),zCOM(i,j),xsite(s,w), &
                       ysite(s,w),zsite(s,w),distsc,xs,ys,zs)

           distsc=SQRT(xs*xs+ys*ys)      
           IF (distsc.LE.radx(s)) THEN  ! condition 3.1
            IF (zs.LE.radz(s)) THEN     ! condition 3.2
             cs(s)=cs(s)+1
            END IF               ! condition 3.2
           END IF                ! condition 3.1
          END IF                 ! CONDITION z

          END DO              ! loop 4.1

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!  CYLINDRICAL  !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

        END SELECT
         counter(i,s)=cs(s)
         END DO               ! loop 3
        END DO                ! loop 2
5     END DO                  ! loop 1

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!   MAIN LOOP   !!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
