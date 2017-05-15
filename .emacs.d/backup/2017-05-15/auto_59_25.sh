#!/bin/sh

#if [ -f output.txt ] ; then
#	rm output.txt
#fi
#
#for hidden in `seq 2 1 $1`
#do
#	for alpha in `seq 0.1 0.1 0.9`
#	do
#		for eta in `seq 0.1 0.1 1.9`
#		do
#			for seed in `seq 1000 1000 10000`
#			do
#./nnnum $seed $hidden $eta $alpha < command.txt | sed '$d' | sed -n '$p' | sed -e "s/iteration = \([0-9]*\).*/\1/g" >> output.txt
#            seedcount=$(expr $seedcount + 1000)
#			done
#        etacount=$(expr $etacount + 1)
#		done
#    alphacount=$(expr $alphacount + 1)
#	done
#done

#./nnnum 1000 2 1.0 1.0 < command.txt | sed '$d' | sed -n '$p' | sed -e "s/iteration = \([0-9]*\).*/\1/g" >> output.txt


#for hidden in `seq 19 1 30`
#do
	for alpha in `seq 0.540 0.001 0.550`
	do
		for eta in `seq 1.670 0.0001 1.680`
		do
#			for seed in `seq 1000 1000 10000`
#			do
./nn_num 1000 25 $eta $alpha < command.txt | sed '$d' | tail -n 1 | awk '{print $3}' > test4_result_auto_59_25/25\_$eta\_$alpha.txt
#./nn_num $seed $hidden $eta $alpha < command.txt | sed '$d' | tail -n 1 | awk '{print $3}' >> test1_result_auto/$hidden\_$eta\_$alpha.txt
#			done
		done
	done
#done
#./nn_num 1000 2 1.0 1.0 < command.txt | sed '$d' | tail -n 1 | awk '{print $3}'

#最小値を求めるには
#cat *.txt >> hoge.txt
#awk '{sum += $1; min = min < $1 ? min : $1} !(FNR%6){print min;sum=min = ""}' hoge.txt
#awk 'BEGIN{m=100000}{if(m>$1) m=$1} END{print m}'

#空行削除
# cat hoge.txt | sed '/^$/d'

#平均
#awk '{sum+=$1}END{print sum/NR}' hoge.txt

#収束はだいたい，hidden22 の 155くらいだと言うが，その時，eta alp は1.999とか小数点第三位ほどまで求めていた．

#min
#find result |grep "\.txt$" | xargs cat| sed '/^$/d' >> hoge.txt
#|awk '{sum += $1; min = min < $1 ? min : $1} !(FNR%6){print min;sum=min = ""}' hoge.txt
