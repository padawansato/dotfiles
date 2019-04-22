gnuplot << EOF
   set datafile separator ","
#   set ticslevel 0
   set xlabel 'x point'
   set ylabel 'y point'
   set style fill solid border lc rgb "black"
   splot "121.txt" u 1:2:3 with lines
#   plot '121.txt' using 2:3 w lp  title "default"
#   set terminal svg
#   set output 'result.eps'
   set terminal png
   set output "default.png"
   replot
   set output
EOF
