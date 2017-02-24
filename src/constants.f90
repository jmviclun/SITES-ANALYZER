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
