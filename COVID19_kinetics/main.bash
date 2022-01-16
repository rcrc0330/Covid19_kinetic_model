#!/bin/bash
str=""
while read LINE
        do 
                cp optimize.m optimize_${LINE}.m
                sed -i "s/state=.*/state=\"$LINE\"/" optimize_${LINE}.m
                echo "exit" >> optimize_${LINE}.m
                str="$str ${LINE}"
        done < plots/distlist1.txt


parallel -j64 --delay .5 --joblog run_parallel.log '/software/Matlab/bin/matlab -nodisplay -r optimize_{1}' ::: $str
echo "s1                                     "
sleep 2
echo "s2                                        "
for file in $str; do
    rm -f optimize_${file}.m
done
echo "s3                                        "