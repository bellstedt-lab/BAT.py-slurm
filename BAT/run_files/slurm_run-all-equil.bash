#!/bin/bash

# Start equilibration of all poses
# nr_of_poses is replaced by correct integer via BAT.py
x=0
while [ $x -lt NUMBER_OF_POSES ]; do
cd pose$x
sbatch --wait SLURM-equil
cd ../
let x=x+1
done
wait
