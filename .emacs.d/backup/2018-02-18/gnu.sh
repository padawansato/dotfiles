gnuplot << EOF
   set datafile separator ","
#   set ticslevel 0
   set xlabel 'x point'
   set ylabel 'y point'
   set zlabel 'time'
   set style fill solid border lc rgb "black"
   splot "121.txt" u 2:3:1 with lines title "changed tripyramid.model"
#   set terminal svg
#   set output 'result.eps'
   set terminal png
   set output "3d.png"
   replot
   set output
EOF
