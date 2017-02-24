      INTEGER, PARAMETER:: r=SELECTED_REAL_KIND(P=8)
      INTEGER:: d,c,i,j,nmovies, natoms,f,l,k,indexx,q
      INTEGER:: n, nC, maxnumberatoms, nSITES, s
      INTEGER:: nbw, nbw1D, imaxsize, nmoviesmod 
      INTEGER:: numberofsites, nmaxSITE, jj, w, npseudo
      INTEGER:: tickstart, tickstop, tickrate
      INTEGER, ALLOCATABLE:: npossite(:), cs(:) 
      REAL (KIND=r), ALLOCATABLE:: x(:,:), y(:,:),z(:,:)
      REAL (KIND=r), ALLOCATABLE:: xsite(:,:), ysite(:,:),zsite(:,:)
      REAL (KIND=r), ALLOCATABLE:: xCOM(:,:), yCOM(:,:),zCOM(:,:)
      REAL (KIND=r), ALLOCATABLE:: radius(:), totalaverage(:)
      REAL (KIND=r), ALLOCATABLE:: radx(:), rady(:), radz(:)
      REAL (KIND=r):: distsc, totalperc, convfac, time
      REAL (KIND=r):: lx,ly,lz, stepsize, maxsize, stepsize2,stepsize3
      REAL (KIND=r):: alp, bet, gam, calp, cbet, cgam, salp, sbet, sgam
      REAL (KIND=r):: lysgam, lycgam
      REAL (KIND=r):: maxhistx, maxhisty, maxhistz
      CHARACTER (LEN=75):: firstline
      CHARACTER (LEN=6):: atom, mol,text
      CHARACTER (LEN=3):: compAvOPs2D, compAvOPs1D, compsites
      CHARACTER (LEN=21):: endlines, lines
      CHARACTER (LEN=15), ALLOCATABLE:: geom(:), geomoutput(:)
      CHARACTER (LEN=1), ALLOCATABLE:: dire(:)
      INTEGER, ALLOCATABLE:: maxi(:),counter(:,:)
      REAL (KIND=r), ALLOCATABLE:: perc(:,:)
      INTEGER, ALLOCATABLE:: intensityx(:),intensityy(:),intensityz(:)
      INTEGER, ALLOCATABLE:: intensityxy(:,:), intensityyz(:,:),&
                             intensityzx(:,:)
      INTEGER, ALLOCATABLE:: intensity3(:,:,:)
      REAL (KIND=r):: ix, iy, iz, ix2, ixp2, iyp2, izp2, ix2p2
      REAL, PARAMETER::ix1D=0.2
      REAL (KIND=r), PARAMETER::zero=0.0
      REAL (KIND=r), PARAMETER:: pi=4*atan(1.)
