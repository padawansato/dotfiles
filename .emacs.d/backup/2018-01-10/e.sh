gnuplot << EOF
   set datafile separator ","
   set xlabel 'sec'
   set ylabel 'rad'
   set style fill solid border lc rgb "black"
   plot 'default.csv' using 1:3 with lines lw 2  title "default Kv 0.05",\
        'Kv_small.csv' using 1:3 with lines lw 2  title "Kv 0.04",\
        'Kv_big.csv' using 1:3 with lines lw 2  title "Kv 0.06"
#   set terminal svg
#   set output 'result.eps'
   set terminal png
   set output "Kv.png"
   replot
   set output
EOF
