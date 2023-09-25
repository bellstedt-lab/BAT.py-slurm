#!/bin/bash

# Submit the first job
JOB_ID=$(sbatch 1_* | awk '{print $NF}')

# Use a loop to submit the rest of the jobs
for script in 2_*.bash 3_*.bash 4_*.bash 5_*.bash; do
    JOB_ID=$(sbatch --dependency=afterok:$JOB_ID $script | awk '{print $NF}')
done
