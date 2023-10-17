#!/bin/bash

# Change to correct directory
cd ../BAT

# Define new BAT-script name
newbat="BAT_slurm.py"

cp "BAT.py" "$newbat"

# Replace PBS with SLURM syntax and adjust filenames 
sed -i 's/python2/python3/g' "$newbat"
sed -i 's/PBS/SLURM/g' "$newbat"

# Change back to original dir
cd ../slurm_patches
