      OPEN(14,FILE="input-fortran",STATUS='OLD', ACTION='READ')

      READ(14,*) n ! Lines in the input file
      READ(14,*) nmovies ! Movies number
      READ(14,*) nC ! Atoms number
      READ(14,*) lx, ly, lz, alp, bet, gam ! Box lengths and angles
      READ(14,*) text, npseudo ! Number of atoms of the adsorbate

      READ(14,*) text, compAvOPs2D     ! character yes/no
      READ(14,*) text, nbw             ! resolution 2D plots
      READ(14,*) text, compAvOPs1D     ! character yes/no
      READ(14,*) text, compsites       ! character yes/no

       IF (compsites.NE."yes") GOTO 55

      READ(14,*) text
      READ(14,*) text, numberofsites
      ALLOCATE (npossite(1:numberofsites), radius(1:numberofsites))
      ALLOCATE (radx(1:numberofsites), rady(1:numberofsites), &
                radz(1:numberofsites))
      ALLOCATE (geom(1:numberofsites), geomoutput(1:numberofsites), &
                dire(1:numberofsites))
      DO i=1,numberofsites
       READ(14,*) indexx, npossite(i), radx(i), rady(i), radz(i)
       READ(14,*) geom(i), dire(i)
      END DO

      PRINT*, ""; PRINT*, ""
       geomoutput=geom
       nmaxSITE=MAXVAL(npossite)

      ALLOCATE (counter(1:nmovies, 1:numberofsites))
      ALLOCATE (perc(1:nmovies,1:numberofsites))
      ALLOCATE (xsite(1:numberofsites,1:nmaxSITE), &
                ysite(1:numberofsites,1:nmaxSITE), &
                zsite(1:numberofsites,1:nmaxSITE))
      ALLOCATE (cs(1:numberofsites))
      ALLOCATE (totalaverage(1:numberofsites))
      counter=0
      perc=0
      totalperc=0
      totalaverage=0


55    ALLOCATE (maxi(1:nmovies))
      CLOSE (UNIT=14)
      maxi=0
      IF ( mod(nC,npseudo).NE.0 ) THEN
        PRINT*, "ERROR, WRONG ATOM NUMBERS!"; PRINT*, ""
        STOP
      END IF
