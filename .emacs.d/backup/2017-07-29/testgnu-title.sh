#.shでないファイルを入ってから渡すときgnuplot>load 'fuga’とする．                                                                        
#$file="result/100-100-1000000.csv"

#空行抜き
gnuplot << EOF
   set datafile separator ","
   set xlabel 'size'
   set ylabel 'time'
   set style fill solid border lc rgb "black"
   plot 'result/100-100-1000000.csv' using 1:2 with lines lw 2  title "mergesort.go"
   set output 'testgnu.svg'
   replot
   set output
   set terminal png
   set output "testgnu.png"
   replot
EOF
