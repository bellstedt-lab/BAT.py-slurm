#!/bin/bash

# Change to correct directory
cd ../run_files/

# Loop through all bash files starting with 'run-'
for file in run-*.bash; do
  # Copy each file with a 'slurm_' prefix
  new_file="slurm_$file"
  cp "$file" "$new_file"

  # Replace PBS with SLURM syntax and adjust filenames 
  sed -i 's/qsub PBS/sbatch SLURM/g' "$new_file"
  sed -i 's|./run_files/run-|./run_files/slurm_run-|g' "$new_file"
  sed -i 's/source run-/source slurm_run-/g' "$new_file"
done

# Change back to original dir
cd ../slurm_patches/
