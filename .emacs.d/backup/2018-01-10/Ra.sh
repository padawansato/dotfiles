gnuplot << EOF
   set datafile separator ","
   set xlabel 'sec'
   set ylabel 'rad'
   set style fill solid border lc rgb "black"
   plot 'default.csv' using 1:3 with lines lw 2  title "default",\
        'Ra_small.csv' using 1:3 with lines lw 2  title "Ra 0.5",\
        'Ra_big.csv' using 1:3 with lines lw 2  title "Ra 2.0"
#   set terminal svg
#   set output 'result.eps'
   set terminal png
   set output "default_Ra_small.png"
   replot
   set output
EOF
