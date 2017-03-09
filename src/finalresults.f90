            nmoviesmod=nmovies
      DO i=1,nmovies
       f=INT(maxi(i)/npseudo)
       IF (f.EQ.0) THEN
        nmoviesmod=nmoviesmod-1
        GOTO 15
       END IF
       DO s=1,numberofsites
       perc(i,s)=REAL(counter(i,s))/(REAL(maxi(i))/npseudo*1.0)*100
        totalaverage(s)=totalaverage(s)+perc(i,s)
       END DO
15     END DO

       IF (nmoviesmod.EQ.0) THEN
       totalaverage=0.0 ; totalperc=0.0
       PRINT*, ""; PRINT*, "WARNING: No adsorbed molecules"; PRINT*,""
      PRINT*,""; PRINT*, "RESULTS:"
      PRINT*,"========================================================="
       WRITE(4,*) ""; WRITE(4,*) "WARNING: No adsorbed molecules"
      WRITE(4,*) ""
      WRITE(4,*) ""; WRITE(4,*)  "RESULTS:"
      WRITE(4,*) "====================================================="

      DO s=1,numberofsites
       PRINT*, ""
      WRITE(*,'(F7.3,A25,I4)')totalaverage(s),"% of molecules in SITE",s
      WRITE(4,*) ""
      WRITE(4,'(F7.3,A25,I4)')totalaverage(s),"% of molecules in SITE",s
      END DO
      PRINT*,""
      PRINT*,"========================================================="
      PRINT*,""
      WRITE(*,'(F7.3,A34)')totalperc, "% of molecules in defined SITES"
      WRITE(4,*) ""
      WRITE(4,*) "====================================================="
      WRITE(4,*) ""
      WRITE(4,'(F7.3,A34)')totalperc, "% of molecules in defined SITES"
       GOTO 25
       END IF

      PRINT*,""; PRINT*, "RESULTS:"
      WRITE(4,*) ""; WRITE(4,*)  "RESULTS:"
      PRINT*,"========================================================="
      WRITE(4,*) "====================================================="
      DO s=1,numberofsites
       totalaverage(s)=totalaverage(s)/REAL(nmoviesmod)
       totalperc=totalperc+totalaverage(s)
       PRINT*, ""; WRITE(4,*) ""
      WRITE(*,'(F7.3,A25,I4)')totalaverage(s),"% of molecules in SITE",s
      WRITE(4,'(F7.3,A25,I4)')totalaverage(s),"% of molecules in SITE",s
      END DO
      PRINT*,""
      PRINT*,"========================================================="
      PRINT*,""
      WRITE(*,'(F8.3,A34)')totalperc, "% of molecules in defined SITES"
      PRINT*,"========================================================="

      WRITE(4,*) ""
      WRITE(4,*) "====================================================="
      WRITE(4,*) ""
      WRITE(4,'(F8.3,A34)')totalperc, "% of molecules in defined SITES"
      WRITE(4,*) "====================================================="
25    PRINT*, " "

