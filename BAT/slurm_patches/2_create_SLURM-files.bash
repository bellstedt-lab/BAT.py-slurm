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
  
  # Step 5: Cosmetics (Remove lines)
  sed -i '/### Copy back to Original Work Dir./d' "$new_file"
  
  # Handle specialities
  if grep -q "@" "$new_file"; then
    echo "$new_file have to be translated to bash syntax now due to @ syntax. Applying patches."

    # Patch 1: PBS-equil-op
    sed -i \
    -e 's/@ i = 1/i=1/' \
    -e 's/while ($i <= RANGE)/while [[ $i -le ${RANGE#0} ]]/' \
    -e 's/set x = `printf "%02.0f" $i`/x=$(printf "%02.0f" $i)/' \
    -e 's/@ i += 1/i=$((i+1))/' \
    -e 's/end/done/' "$new_file"
    
    # Patch 2: PBS-equil
    sed -i \
    -e 's/@ i = 1/i=1/' \
    -e 's/while ($i <= RANGE)/while [[ $i -le ${RANGE#0} ]]/' \
    -e 's/@ j = ($i - 1)/j=$((i-1))/' \
    -e 's/set x = `printf "%02.0f" $i`/x=$(printf "%02.0f" $i)/' \
    -e 's/set y = `printf "%02.0f" $j`/y=$(printf "%02.0f" $j)/' \
    -e 's/@ i += 1/i=$((i+1))/' \
    -e 's/end/done/' "$new_file"
    
    #Patch 3: PBS-prep
    sed -i \
    -e 's/@ i = 1/i=1/' \
    -e 's/while ($i <= RANGE)/while [[ $i -le ${RANGE#0} ]]/' \
    -e 's/@ j = ($i - 1)/j=$((i-1))/' \
    -e 's/set x = `printf "%03.0f" $i`/x=$(printf "%03.0f" $i)/' \
    -e 's/set y = `printf "%03.0f" $j`/y=$(printf "%03.0f" $j)/' \
    -e 's/@ i += 1/i=$((i+1))/' \
    -e 's/end/done/' "$new_file"
 
  fi
  
done

# Change back to original dir
cd ../slurm_patches
