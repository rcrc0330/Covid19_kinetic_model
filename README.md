# COVID19_kinetics
## There are 2 ways to run the code:
1. From initial guess of previous run (should be run once to gather initial conditions to run the automatic code): 
    ```bash
    sbatch run3.bash
    ```
2. Now, run the automatic code, to use these gathered guesses and any new generated ones:
    ```bash
    sbatch run1.bash
    ```
    
## To change number of parallel processes:
   Change the ntasks-per-node in run1.bash/run3.bash along with parallel command "-j{}" in main.bash
## IMP: HOW TO RUN A NEW DATA SET:
   1. Change the name of the files so that there is no '_' or '.'(except for ".dat" part) using rename3.py(rename the folder with this data to dist_data2 and keep it at UGP-7thsem/dist_data2/ before running it or change the "path" variable accordingly)     --- (python rename3.py)
   2. Store the name of the files in plots/distlist.txt (in order to clean any "x" in the dataset in the next step) using rename.py("path" of folder is again UGP-7thsem/dist_data2/)           --- (python rename.py)
   3. run rename2.py (python rename.py) to save the clean data in UGP-7thsem/dist_data/         --- (python rename2.py)
   4. submit run3.bash          --- (sbatch run3.bash)  
   5. submit run1.bash          --- (sbatch run1.bash)
 ## IMP: To see run the number of iteration and time it ended finished till now:
  Check out.txt
  Each itearion should take 1 hour at max in the cluster settings, keep checking the out.txt last entry (once/twice a day would suffice)if the the time of run is >1 hr, just       cancel this run and start from one step ahead (for eg: if 67th iteration completed 2 hours ago, stop the run and start from 69th iteration)
## IMP: To cancel/stop the current run:
  Run squeue and note the {id} of run       --- (squeue)
  Run scancel {id}, let's say {id} = 691          --- (scancel 691)
## IMP: To run the code again from a specific iteration instead of start:
  Change the "i=1" in the for loop in run1.bash/run3.bash to "i={}" where {} (i=69) is iteration you want to start from
## IMP: To see the results:
  Open the folder UGP-7thsem/temp_dist/my/
## To use these results as initial guess:
  Paste the my (UGP-7thsem/temp_dist/my) folder at UGP-7thsem/temp_dist_res/my

## To change the 5 metric condition:
  open err.py(for run1.bash)/err2.py(for run3.bash) and change the for loop conidtions at the end containing error1,...,error4 and cases
## To change/see the 5 metrics themselves:
 open optimize.m and see err,
resnorm,
err2,
err_max,
M around line 155
## To change hard exit loop time condition:
open optimize.m and change del_T = 5, with del_T = {}, where {} is in minutes
## To see the details of individual runs in parallel:
open run_parallel.txt
## To run from existing converged parametes:
submit fit.bash, To individual file runs according to fit.m for each file in initial guesses list present in UGP-7thsem/temp_dist/my/
## To make a pdf of png files in a folder:
run UGP-7thsem/temp_dist/my/png_to_pdf.py to form p.pdf in the same folder
## To make excel file like present in result.csv from txt formats:
run txt_to_csv.py
