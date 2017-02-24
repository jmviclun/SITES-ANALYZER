#!/bin/gnuplot

set palette model RGB defined ( 0 "black", 0.0625 "grey", 0.125 "cyan", 0.3 "green", 0.4 "yellow" , 0.7 "orange", 1 "red" )

#change for adjust the color scale
maxrange=5

set size ratio -1
set title "XY view"
unset xtics
unset ytics
set pm3d map interpolate 4,4 scansautomatic
set cbrange [0:maxrange]
set pm3d implicit at b
set term png enhanced size 640.0,640.0
set output "AvOPs-2D-XY.png"
splot 'AvOPs-2D-XY.dat' with pm3d notitle
#set term postscript eps enhanced color 
#set output "AvOPs-2D-XY.eps"
#replot

set size ratio -1
set title "YZ view"
unset xtics
unset ytics
set pm3d map interpolate 4,4 scansautomatic
set cbrange [0:maxrange]
set pm3d implicit at b
set term png enhanced size 640.0,640.0
set output "AvOPs-2D-YZ.png"
splot 'AvOPs-2D-YZ.dat' with pm3d notitle
#set term postscript eps enhanced color 
#set output "AvOPs-2D-YZ.eps"
#replot

set size ratio -1
set title "ZX view"
unset xtics
unset ytics
set pm3d map interpolate 4,4 scansautomatic
set cbrange [0:maxrange]
set pm3d implicit at b
set term png enhanced size 640.0,640.0
set output "AvOPs-2D-ZX.png"
splot 'AvOPs-2D-ZX.dat' with pm3d notitle
#set term postscript eps enhanced color 
#set output "AvOPs-2D-ZX.eps"
#replot


# palette examples
#set palette model RGB defined ( 0 "black", 0.2 "cyan", 0.5 "green", 0.6 "yellow", 0.9 "red" )
#set palette model RGB defined ( 0 "#ffffff",  0.5 "#B0E0E6", 0.7 "#FFFF00", 1.0 "#0000FF" )
#set palette model RGB defined ( 0 "white", 0.5 "orange", 1 "red" )
#set palette model RGB defined ( 0 "white", 0.5 "grey", 0.7 "blue", 1 "red" )
#set palette model RGB defined ( 0 "white", 0.3 "cyan", 0.5 "green", 0.6 "yellow", 0.9 "red" )
#set palette model RGB defined ( 0 "black", 0.2 "cyan", 0.5 "green", 0.6 "yellow", 0.9 "red" )
#set palette model RGB defined ( 0 "black", 0.125 "cyan", 0.35 "green", 0.625 "yellow", 0.9 "red" ) 
#set palette model RGB defined ( 0 "black", 0.0625 "cyan", 0.125 "green", 0.25 "yellow", 0.625 "orange", 1 "red" ) 
#set palette model RGB defined ( 0 "black", 1 "white" )
#set palette model RGB defined ( 0 "red", 0.5 "yellow", 1 "green" )
#set palette model RGB defined ( 0 "white", 1 "black")
#set palette model RGB defined ( 0  "white", 0.8 "green",  1  "black" )
