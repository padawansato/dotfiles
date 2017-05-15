#!/bin/sh
#seed:初期集団作成用シード値
#op:GAオペレータ用シード値
#荷重ファイル（KP_List.data)
#gene:終了世代数


for seed in `seq 1 1 2`
do
    for op in `seq 1 1 2`
    do
	for gene in `seq 1 1 2`
	do
./run_ga.sh  $seed $op KP_List.data $gene
	done
    done
done
