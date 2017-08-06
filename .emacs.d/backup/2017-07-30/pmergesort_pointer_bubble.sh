#!/bin/sh

s_start=100 ##初めのサイズ
s_end=1000000 ##終わりのサイズ
s_intv=100 ##インクリメントする間隔

## mkdir result/
if [ ! -e result ]; then
mkdir result/
fi


for size in `seq 10 10 10000`
do
    go run pmergesort_pointer_bubble.go $size | sed -e "s/N= //g" | sed -e :loop -e 'N; $!b loop' -e 's/\n/,/g' >> result/pmergesort_pointer_bubble.csv
done
