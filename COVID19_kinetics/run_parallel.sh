#!/bin/bash
str=""
while read LINE
	do 
		cp optimize.m optimize_${LINE}.m
		sed -i "s/state=.*/state=\"$LINE\"/" optimize_${LINE}.m
		echo "exit" >> optimize_${LINE}.m
		str="$str ${LINE}"
	done < plots/plot_statelist.txt

parallel -j5 --joblog run_parallel.log --resume 'matlab -nodisplay -r optimize_{1}' ::: $str

sleep 2
for file in $str; do
	rm -f optimize_${file}.m
done
