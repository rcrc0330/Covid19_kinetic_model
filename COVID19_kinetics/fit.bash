#!/bin/bash
#
#SBATCH --job-name=test
#SBATCH --ntasks-per-node=64
#SBATCH --nodes=1
#SBATCH --time=120:00:00
#SBATCH --nodelist=n004
#SBATCH -p matl
cd /home/rajat/COVID19_kinetics2/new2/COVID19_kinetics/
str=""
while read LINE
        do 
                cp fit.m fit_${LINE}.m
                sed -i "s/state=.*/state=\"$LINE\"/" fit_${LINE}.m
                echo "exit" >> fit_${LINE}.m
                str="$str ${LINE}"
        done < plots/distlist.txt


parallel -j64 --delay .5 --joblog run_parallel.log '/software/Matlab/bin/matlab -nodisplay -r fit_{1}' ::: $str
echo "s1                                     "
sleep 2
echo "s2                                        "
for file in $str; do
    rm -f fit_${file}.m
done
echo "s3                                        "
