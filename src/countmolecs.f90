      OPEN(1,FILE="INPUT.pdb",STATUS='OLD', ACTION='READ')
      j=0;c=0;d=0
      DO i=1,n
        READ(1,'(A4)')atom
        IF(atom.eq.'MODE')THEN
          j=j+1
          GOTO 10
        END IF
        IF(atom.eq.'CRYS')GOTO 10
        IF(atom.eq.'ATOM')c=c+1

        IF(atom.eq.'ENDM')THEN
           maxi(j)=c
        IF(c.ge.d)d=c
           c=0
        END IF
10    END DO
      CLOSE (UNIT=1)
