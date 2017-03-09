       INTEGER, PARAMETER:: r=SELECTED_REAL_KIND(P=8)
         REAL (KIND=r)::xf,yf,zf,dist
         REAL (KIND=r)::x1,y1,z1,x2,y2,z2
          xf=ABS(x1-x2)
          yf=ABS(y1-y2)
          zf=ABS(z1-z2)

         SELECT CASE (structype)

         CASE ("type0")
          IF (xf.GT.(lx/2.0)) xf=ABS(xf-lx)
          IF (yf.GT.(ly/2.0)) yf=ABS(yf-ly)
          IF (zf.GT.(lz/2.0)) zf=ABS(zf-lz)

         CASE DEFAULT

          IF (xf.GT.(lx/2.0)) xf=ABS(xf-lx)
          IF (yf.GT.(lysgam/2.0)) THEN
           yf=ABS(yf-(lysgam))
           xf=ABS(xf+(lycgam))
          END IF
          IF (zf.GT.(lz*chi2/2.0)) THEN 
           zf=ABS(zf-(lz*chi2))
           yf=ABS(yf-(lz*chi1))
           xf=ABS(xf+(lzcbet))
          END IF
          END SELECT 
          dist=SQRT(xf*xf+yf*yf+zf*zf)


          
