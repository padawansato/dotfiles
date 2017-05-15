gnuplot -e "
set title 'Fitness transition with the weight'
set xlabel 'Generation'
set ylabel 'Value'
set y2label 'Weight'
set terminal x11
set output "rerulst.eps"
plot "1-1-KP_List_1.data-100.max" using 2 axis x1y1 'Value' with line, \
  "1-1-KP_List_1.data-100.max" using 3 axis x1y2 title 'Weight' with line
"
