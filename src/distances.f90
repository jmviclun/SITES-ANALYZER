       INTEGER, PARAMETER:: r=SELECTED_REAL_KIND(P=8)
         REAL (KIND=r)::xf,yf,zf,dist
         REAL (KIND=r)::x1,y1,z1,x2,y2,z2
          xf=ABS(x1-x2)
          yf=ABS(y1-y2)
          zf=ABS(z1-z2)
          IF (xf.GT.(lx/2.0)) xf=ABS(xf-lx)
          IF (yf.GT.(ly*sgam/2.0)) THEN
           yf=ABS(yf-(ly*sgam))
           xf=ABS(xf+(ly*cgam))
          END IF
!         IF (zf.GT.(lz/2.0)) zf=ABS(zf-lz)
          IF (zf.GT.(lz*sbet/2.0)) THEN 
           zf=ABS(zf-(lz*sbet))
           xf=ABS(xf+(lz*cbet))
          END IF
          dist=SQRT(xf*xf+yf*yf+zf*zf)
