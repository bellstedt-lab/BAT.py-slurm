#!/bin/bash

#SBATCH -J BAT2

clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38
cd ../BAT

if [[ -d "./equil" ]]; then
	# start MD simulations
	cd equil
	echo "2) Starting MD for equilibration..."
	#bash slurm_run-all-equil.bash 1> ../logs/1b_equil_start_md.out 2> ../logs/1b_equil_start_md.err
	bash slurm_run-all-equil.bash
	echo "...Finished."
else
	echo "-) Skipping Equilibration step: no equil directory"
fi

