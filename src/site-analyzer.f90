! SITE-ANALYZER version beta_1.0
! Developed by J.M. Vicent-Luna and A. Sławek
! First version created: January 2017
! Last version modified: 09 March 2017

      PROGRAM siteAnalyzer
      IMPLICIT NONE

      INCLUDE 'declarevar.f90'

      OPEN(4,file="output-SITE.data",STATUS='NEW', ACTION='WRITE')

      CALL SYSTEM_CLOCK(tickstart,tickrate)

      CALL readinput

      INCLUDE 'constants.f90'
      
      CALL countmolecs
      
      maxnumberatoms=MAXVAL(maxi)

      ALLOCATE (x(1:nmovies,1:nC),&
                y(1:nmovies,1:nC),&
                z(1:nmovies,1:nC))
      ALLOCATE (xCOM(1:nmovies,1:maxnumberatoms),&
                yCOM(1:nmovies,1:maxnumberatoms),&
                zCOM(1:nmovies,1:maxnumberatoms))

      CALL geometriccenter

      IF (compAvOPs2D.EQ."yes".OR.compAvOPs2D.EQ."YES") CALL AvOPs2D
      IF (compAvOPs1D.EQ."yes".OR.compAvOPs1D.EQ."YES") CALL AvOPs1D

        IF (compsites.EQ."yes") THEN
      CALL readsites   
         IF (writesitsurf.EQ."yes".OR.writesitsurf.EQ."YES") THEN
      CALL writepdbsites
         END IF
      CALL computesites      
      CALL finalresults
        ELSE 
         IF (writesitsurf.EQ."yes".OR.writesitsurf.EQ."YES") THEN
      CALL readsites   
      CALL writepdbsites
         END IF
        END IF


        CALL SYSTEM_CLOCK(tickstop)
        time=FLOAT(tickstop-tickstart)/FLOAT(tickrate)

        WRITE(*,*) " "
        WRITE(*,*) " Computation time: "
        WRITE(*,*) " "
        WRITE(*,'(F12.4,A15,F8.4,A8)') time, "seconds  ===>>",&
                                       time/60.0, "minutes"
      WRITE(*,*) "====================================================="

        PRINT*, " "; PRINT*, "  End Of Program"; PRINT*, " "

        WRITE(4,*) " "
        WRITE(4,*) " Computation time: "
        WRITE(4,*) " "
        WRITE(4,'(F12.4,A15,F8.4,A8)') time, "seconds  ===>>",&
                                       time/60.0, "minutes"
      WRITE(4,*) "====================================================="

        WRITE(4,*) " "; WRITE(4,*) "  End Of Program"; WRITE(4,*) " "

        CLOSE (UNIT=4)


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        

      CONTAINS
      SUBROUTINE readinput
       INCLUDE 'readinput.f90'
      END SUBROUTINE readinput

      SUBROUTINE countmolecs
       INCLUDE 'countmolecs.f90'
      END SUBROUTINE countmolecs

      SUBROUTINE geometriccenter
       INCLUDE 'geometriccenter.f90'
      END SUBROUTINE geometriccenter

      SUBROUTINE readsites
       INCLUDE 'readsites.f90'
      END SUBROUTINE readsites

      SUBROUTINE computesites
       INCLUDE 'computesites.f90'
      END SUBROUTINE computesites

      SUBROUTINE writepdbsites
       INCLUDE 'writepdbsites.f90'
      END SUBROUTINE writepdbsites

      SUBROUTINE distance(x1,y1,z1,x2,y2,z2,dist,xf,yf,zf)
       INCLUDE 'distances.f90'
      END SUBROUTINE distance

      SUBROUTINE AvOPs2D
       INCLUDE 'AvOPs2D.f90'
      END SUBROUTINE AvOPs2D

      SUBROUTINE AvOPs1D
       INCLUDE 'AvOPs1D.f90'
      END SUBROUTINE AvOPs1D
 
      SUBROUTINE finalresults
       INCLUDE 'finalresults.f90'
      END SUBROUTINE finalresults

      END PROGRAM
