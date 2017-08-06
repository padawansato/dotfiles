#!/bin/sh

file=test.txt //出力したいファイル名

for size in `seq $size`
do
go run mergesort.go 1001 | sed -e "s/N= //g" | sed -e :loop -e 'N; $!b loop' -e 's/\n/,/g' >> $file
done
