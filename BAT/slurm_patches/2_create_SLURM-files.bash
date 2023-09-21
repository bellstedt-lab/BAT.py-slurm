#!/bin/bash

# Change to correct directory
cd ../run_files/

# Define the header text
HEADER1="#!/bin/bash\n\n"

JOBNAME_FIX="#SBATCH -J BAT\n"

# Loop through all files starting with 'PBS-'
for file in PBS-*; do

  # Step 1: Copy each file, replacing "PBS-" with "SLURM-"
  new_file="${file/PBS-/SLURM-}"
  cp "$file" "$new_file"

  # Step 2: Check if the new file contains "#PBS -N", and replace with "#SLURM --jobname"
  JOBNAME=$(grep "#PBS -N" "$new_file")
  if [ ! -z "$JOBNAME" ]; then
    JOBNAME="${JOBNAME/PBS -N/SBATCH -J}"
  fi

  # Step 3a: Delete every line that comes before the "### Execute" line
  if grep -q "Execute" "$new_file"; then
    sed -i '/### Execute/,$!d' "$new_file"
  fi

  # Step 3b: Delete every line that comes before and including the line with "PBS_O_WORKDIR"
  if grep -q "PBS_O_WORKDIR" "$new_file"; then
    sed -i '0,/PBS_O_WORKDIR/d' "$new_file"
  fi

  # Step 4: Insert the Header and JOBNAME line before the other lines
  if [ ! -z "$JOBNAME" ]; then
    HEADER="$HEADER1$JOBNAME\n"
  else
    HEADER="$HEADER1$JOBNAME_FIX"
  fi

  echo -e "$HEADER" | cat - "$new_file" > temp && mv temp "$new_file"

  # Unset JOBNAME for the next iteration
  unset JOBNAME
done

# Change back to original dir
cd ../slurm_patches
