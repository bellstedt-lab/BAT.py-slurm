#!/bin/bash

#SBATCH -J BAT5
#SBATCH -o 5_fe_analyseMD_JobId%j.out


clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38
cd ../BAT

if [[ -d "./fe/pose0/" && ! -d "./fe/pose0/Results/" ]]; then
	echo "5) Analysing MD runs and calculate binding energy..." 
	#python BAT_slurm.py -i input-dd-openmm.in -s analysis 1> ./logs/5a_fe_analysis.out 2>./logs/5a_fe_analysis.err
	python BAT_slurm.py -i input-dd-openmm.in -s analysis
    echo "...Finished."
else
	echo "-) Skipping Analysis: Analysis results exist already"
fi
