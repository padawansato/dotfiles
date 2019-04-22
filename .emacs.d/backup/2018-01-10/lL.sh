gnuplot << EOF
   set datafile separator ","
   set xlabel 'sec'
   set ylabel 'rad'
   set style fill solid border lc rgb "black"
   plot 'default.csv' using 1:3 with lines lw 2  title "default Dm 4.4e{-05}",\
        'Dm_small.csv' using 1:3 with lines lw 2  title "Dm 4.4e{-06}",\
        'Dm_big.csv' using 1:3 with lines lw 2  title "Dm 4.4e{-04}"
#   set terminal svg
#   set output 'result.eps'
   set terminal png
   set output "Dm.png"
   replot
   set output
EOF
