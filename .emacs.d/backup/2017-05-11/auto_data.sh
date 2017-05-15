i=1; while [ $i -le 50 ]; do ; i=$(expr $i + 1); echo $(($RANDOM % 100)) >> data1.txt ;done; 
