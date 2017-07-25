#!/bin/sh
echo `gdate '+%y/%m/%d %H:%M:%S'`
#処理時間を計測したい処理#ここでは仮にsleep 5 としています
go run mergesort.go
echo `gdate '+%y/%m/%d %H:%M:%S'`
NANOTIME1=`gdate +%N`
NANOTIME2=`gdate +%N`
NANOTIME=`echo "scale=3; (${NANOTIME2} - ${NANOTIME1})/1000000000" | bc`
echo "It took ${NANOTIME} sec"
