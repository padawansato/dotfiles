gnuplot << EOF
   set datafile separator ","
   set xlabel 'sec'
   set ylabel 'rad'
   set style fill solid border lc rgb "black"
   plot 'testresult.csv' using 1:3 with lines lw 2  title "default"
#   set terminal svg
#   set output 'result.eps'
   set terminal png
   set output "default.png"
   replot
   set output
EOF
