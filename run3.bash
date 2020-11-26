#!/bin/bash
#
#SBATCH --job-name=test
#SBATCH --ntasks-per-node=64
#SBATCH --nodes=1
#SBATCH --time=120:00:00
#SBATCH -p matl
cd /home/rajat/COVID19_kinetics2/COVID19_kinetics/
k=`ls UGP-7thsem/temp_dist_res/my |wc -l`
k=$((k / 2))
echo $k
python ing_file_gen2.py
for ((i = 1; i <= $k; i++)); do
    rm UGP-7thsem/temp_dist/*
    python ing_gen.py $i
    python list_gen2.py
    bash main.bash
    python err2.py $i
    k=`ls UGP-7thsem/temp_dist_res/my |wc -l`
    k=$((k / 2))
done

