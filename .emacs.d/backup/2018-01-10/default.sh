gnuplot << EOF
   set datafile separator ","
   set xlabel 'sec'
   set ylabel 'rad'
   set style fill solid border lc rgb "black"
   plot 'lm_small.csv' using 1:3 with lines lw 2  title "lm small"
#   set terminal svg
#   set output 'result.eps'
   set terminal png
   set output "lm_small.png"
   replot
   set output
EOF
