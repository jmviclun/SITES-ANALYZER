
set palette model RGB defined ( 0 "black", 0.2 "cyan", 0.5 "green", 0.6 "yellow", 0.9 "red" )


set size ratio -1
set title "PDD-x"
unset xtics
unset ytics
set pm3d map scansautomatic
set cbrange [0:	1   	]
set pm3d implicit at b
set output "PDD-x.ps"
set term postscript eps enhanced color size 10.5,10.5
splot 'PDD-x.dat' with pm3d notitle
set term png enhanced size 640.0,640.0
set output "PDD-x.png"
replot

