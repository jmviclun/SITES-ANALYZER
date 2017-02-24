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
      DO s=1,numberofsites
       PRINT*, ""
      WRITE(*,'(F7.3,A25,I4)')totalaverage(s),"% of molecules in SITE",s
      END DO
      PRINT*,""
      PRINT*,"========================================================="
      PRINT*,""
      WRITE(*,'(F7.3,A34)')totalperc, "% of molecules in defined SITES"
       GOTO 25
       END IF

       PRINT*, numberofsites, "DEFINED SITES:"; PRINT*,""
      DO s=1,numberofsites
       WRITE(*,'(A5,I4,A6,I6,A16,A20,A8)') "SITE",s,"HAS",npossite(s),&
             "POSITIONS WITH", geomoutput(s), "GEOMETRY"
       WRITE(*,'(A10,A4,F7.3,A4,F7.3,A4,F7.3)') "Radius-->", "x:",&
             radx(s),"y:",rady(s),"z:",radz(s)
       PRINT*,""
      END DO


      PRINT*,""; PRINT*, "RESULTS:"
      PRINT*,"========================================================="
      DO s=1,numberofsites
       totalaverage(s)=totalaverage(s)/REAL(nmoviesmod)
       totalperc=totalperc+totalaverage(s)
       PRINT*, ""
      WRITE(*,'(F7.3,A25,I4)')totalaverage(s),"% of molecules in SITE",s
      END DO
      PRINT*,""
      PRINT*,"========================================================="
      PRINT*,""
      WRITE(*,'(F8.3,A34)')totalperc, "% of molecules in defined SITES"
      PRINT*,"========================================================="

25    PRINT*, " "

