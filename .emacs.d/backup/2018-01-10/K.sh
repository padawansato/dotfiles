gnuplot << EOF
   set datafile separator ","
   set xlabel 'sec'
   set ylabel 'rad'
   set style fill solid border lc rgb "black"
   plot 'default.csv' using 1:3 with lines lw 2  title "default e 1.0",\
        'e_small.csv' using 1:3 with lines lw 2  title "e 0.5",\
        'e_big.csv' using 1:3 with lines lw 2  title "e 2.0"
#   set terminal svg
#   set output 'result.eps'
   set terminal png
   set output "e.png"
   replot
   set output
EOF
