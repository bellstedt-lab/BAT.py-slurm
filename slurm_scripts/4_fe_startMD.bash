#!/bin/bash

#SBATCH -J BAT4
#SBATCH -o 4_fe_startMD_JobId%j.out


clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38
cd ../BAT

if [[ -d "./fe/pose0/" && ! -d "./fe/pose0/Results/" ]]; then
	echo "4) Starting Productive MD runs..." 
	cd fe
	#bash sge_run-all-dd-all-poses.bash 1> ../logs/2b_fe_start_md.out 2> ../logs/2b_fe_start_md.err
	bash sge_run-all-dd-all-poses.bash
	echo "Finished."
else
	echo "-) Skipping Analysis"
fi
