      convfac=pi/180

      IF ( alp.EQ.90 ) THEN
       calp=0.0 ; salp=1.0
      ELSE
       calp=cos(alp*convfac); salp=sin(alp*convfac)
      END IF
      IF ( bet.EQ.90 ) THEN
       cbet=0.0 ; sbet=1.0
      ELSE
       cbet=cos(bet*convfac); sbet=sin(bet*convfac)
      END IF
      IF ( gam.EQ.90 ) THEN
       cgam=0.0 ; sgam=1.0
      ELSE
       cgam=cos(gam*convfac); sgam=sin(gam*convfac)
      END IF
        
      lycgam=ly*cgam
      lysgam=ly*sgam
      lzcbet=lz*cbet
      lzsbet=lz*sbet
      lzcalp=lx*calp
      lzsalp=lx*salp
      chi1=(calp-cgam*cbet)/sgam
      chi2=sqrt(1-cbet*cbet-chi1*chi1)


      IF ((alp.EQ.90).AND.(bet.EQ.90).AND.(gam.EQ.90)) structype="type0"
      IF ((alp.NE.90).AND.(bet.EQ.90).AND.(gam.EQ.90)) structype="type1"
      IF ((alp.EQ.90).AND.(bet.NE.90).AND.(gam.EQ.90)) structype="type2"
      IF ((alp.EQ.90).AND.(bet.EQ.90).AND.(gam.NE.90)) structype="type3"
      IF (((alp.NE.90).AND.(bet.NE.90)).OR.((bet.NE.90).AND.(gam.NE.90)).OR.&
         ((alp.NE.90).AND.(gam.NE.90))) structype="type4"
