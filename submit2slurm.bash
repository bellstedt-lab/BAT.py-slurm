#!/bin/bash

start_time=$(date +%s)

#change to correct directory
cd slurm_scripts

#Adjust type of FE if argument is given 
if [ -z "$1" ]; then
    # no arg givven, set to dd
    fe='dd'
elif [[ $1 = 'dd' ]]; then
    find . -type f -name "*.bash" -exec grep -l 'input-sdr-openmm.in' {} \; | xargs sed -i 's/input-sdr-openmm.in/input-dd-openmm.in/g'
    fe='dd'
elif [[ $1 = 'sdr' ]]; then
    find . -type f -name "*.bash" -exec grep -l 'input-dd-openmm.in' {} \; | xargs sed -i 's/input-dd-openmm.in/input-sdr-openmm.in/g'
    fe='sdr'
fi

# Submit the first job
JOB_ID=$(sbatch 1_* | awk '{print $NF}')

# Use a loop to submit the rest of the jobs
for script in 2_*.bash 3_*.bash 4_*.bash 5_*.bash; do
    JOB_ID=$(sbatch --dependency=afterok:$JOB_ID $script | awk '{print $NF}')
done

while true; do
    clear
    echo "Automatisation of BAT via SLUM Workload Manager"
    echo "-----------------------------------------------"
    echo ""
    echo "Type of FE: $fe"
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
