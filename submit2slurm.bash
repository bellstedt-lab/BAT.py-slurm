#!/bin/bash

#change to correct directory
cd slurm_scripts

# Submit the first job
JOB_ID=$(sbatch 1_* | awk '{print $NF}')

# Use a loop to submit the rest of the jobs
for script in 2_*.bash 3_*.bash 4_*.bash 5_*.bash; do
    JOB_ID=$(sbatch --dependency=afterok:$JOB_ID $script | awk '{print $NF}')
done

start_time=$(date +%s)

while true; do
    clear
    echo "Automatisation of BAT via SLUM Workload Manager"
    echo "-----------------------------------------------"
    echo ""
    current_time=$(date +%s)
    elapsed_time=$(( (current_time - start_time) / 60 ))
    echo "Time since start of script: $elapsed_time minutes (Page will reload after 5 sec.)"
    echo ""

    output=$(squeue)
    echo "$output"
    line_count=$(echo "$output" | wc -l)

    if [[ $line_count -le 1 ]]; then
        break
    fi

    sleep 5
done

# Copy and Show results
echo "Calculation finished after $elapsed_time minutes."
source 6_copy_results.bash
