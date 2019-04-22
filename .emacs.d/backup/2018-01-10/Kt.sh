gnuplot << EOF
   set datafile separator ","
   set xlabel 'sec'
   set ylabel 'rad'
   set style fill solid border lc rgb "black"
   plot 'default.csv' using 1:3 with lines lw 2  title "default Kt 0.05",\
        'Kt_small.csv' using 1:3 with lines lw 2  title "Kt 0.04",\
        'Kt_big.csv' using 1:3 with lines lw 2  title "Kt 0.05"
#   set terminal svg
#   set output 'result.eps'
   set terminal png
   set output "Kt.png"
   replot
   set output
EOF
