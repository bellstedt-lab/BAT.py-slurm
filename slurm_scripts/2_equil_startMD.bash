#!/bin/bash

#SBATCH -J BAT2
#SBATCH -o slurm_2_equil_StartMD_JobId%j.out


clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38
cd ../BAT

if [[ -d "./equil" ]]; then
	# start MD simulations
	cd equil
	echo "2) Starting MD for equilibration..."
	bash slurm_run-all-equil.bash
	sleep 2
        echo "...Finished."
else
	echo "-) Skipping Equilibration step: no equil directory"
fi

