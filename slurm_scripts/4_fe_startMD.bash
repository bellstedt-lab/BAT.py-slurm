#!/bin/bash

#SBATCH -J BAT4
#SBATCH -o slurm_4_fe_startMD_JobId%j.out


clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38
cd ../BAT

if [[ -d "./fe/pose0/" && ! -d "./fe/pose0/Results/" ]]; then
	echo "4) Starting Productive MD runs..." 
	cd fe
	bash slurm_run-all-dd-all-poses.bash
	echo "Finished."
else
	echo "-) Skipping Produtive MD run execution: either /fe/pose0/Results/ exist or /fe/pose0/ does not exist"
fi
