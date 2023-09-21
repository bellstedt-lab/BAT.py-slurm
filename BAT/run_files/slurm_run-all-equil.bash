#!/bin/bash

# Start equilibration of all poses
# nr_of_poses is replaced by correct integer via BAT.py
x=0
while [   -lt NUMBER_OF_POSES ]; do
cd pose
sbatch SLURM-run
cd ../
let x=x+1
done

