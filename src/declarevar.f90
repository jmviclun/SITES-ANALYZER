      INTEGER, PARAMETER:: r=SELECTED_REAL_KIND(P=8)
      INTEGER:: d,c,i,j,nmovies, natoms,f,l,k,indexx,q
      INTEGER:: n, nC, maxnumberatoms, nSITES, s, nsx,nsy,nsz
      INTEGER:: nbw, nbw1D, imaxsize, nmoviesmod, sep, sepc 
      INTEGER:: numberofsites, nmaxSITE, jj, w, npseudo
      INTEGER:: tickstart, tickstop, tickrate
      INTEGER:: gridxend, gridyend, gridzend, idsite
      REAL (KIND=r):: theta, phi
      INTEGER, ALLOCATABLE:: npossite(:), cs(:) 
      REAL (KIND=r), ALLOCATABLE:: x(:,:), y(:,:),z(:,:)
      REAL (KIND=r), ALLOCATABLE:: xsite(:,:), ysite(:,:),zsite(:,:)
      REAL (KIND=r), ALLOCATABLE:: xCOM(:,:), yCOM(:,:),zCOM(:,:)
      REAL (KIND=r), ALLOCATABLE:: radius(:), totalaverage(:)
      REAL (KIND=r), ALLOCATABLE:: radx(:), rady(:), radz(:)
      REAL (KIND=r):: distsc, totalperc, convfac, time
      REAL (KIND=r):: lx,ly,lz, stepsize, maxsize, stepsize2,stepsize3
      REAL (KIND=r):: alp, bet, gam, calp, cbet, cgam, salp, sbet, sgam
      REAL (KIND=r):: lysgam, lycgam, lzsbet, lzcbet, lzsalp, lzcalp
      REAL (KIND=r):: chi1, chi2
      REAL (KIND=r):: maxhistx, maxhisty, maxhistz
      REAL (KIND=r):: xs, ys, zs
      CHARACTER (LEN=75):: firstline
      CHARACTER (LEN=6):: atom, mol
      CHARACTER (LEN=40):: text
      CHARACTER (LEN=3):: compAvOPs2D,compAvOPs1D,compsites,writesitsurf
      CHARACTER (LEN=21):: endlines, lines
      CHARACTER (LEN=5):: structype
      CHARACTER (LEN=15), ALLOCATABLE:: geom(:), geomoutput(:)
      CHARACTER (LEN=1), ALLOCATABLE:: dire(:)
      CHARACTER (LEN=1), ALLOCATABLE:: chems(:,:)
      INTEGER, ALLOCATABLE:: maxi(:),counter(:,:)
      REAL (KIND=r), ALLOCATABLE:: perc(:,:)
      INTEGER, ALLOCATABLE:: intensityx(:),intensityy(:),intensityz(:)
      INTEGER, ALLOCATABLE:: intensityxy(:,:), intensityyz(:,:),&
                             intensityzx(:,:)
      INTEGER, ALLOCATABLE:: intensity3(:,:,:)
      REAL (KIND=r):: ix, iy, iz, ixp2, iyp2, izp2, initx, inity
      REAL, PARAMETER::ix1D=0.2
      REAL (KIND=r), PARAMETER::zero=0.0
      REAL (KIND=r), PARAMETER:: pi=4*atan(1.)
