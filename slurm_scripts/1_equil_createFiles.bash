#!/bin/bash

#SBATCH -J BAT1
#SBATCH -o slurm_1_equil_createFiles_JobId%j.out

clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38
cd ../BAT

if [[ ! -d "./equil" ]]; then
	# Create Files for equilibration & start
	echo "1) Creating Files for Equilibration (might take a while) ..."
	#python BAT_slurm.py -i input-dd-openmm.in -s equil 1> ./logs/1a_equil.out 2>./logs/1a_equil.err
	python BAT_slurm.py -i input-dd-openmm.in -s equil
	echo "...Finished."
else
	echo "-) Skipping creation of equilibration folder: equil folder already exists:"
	echo ""
	#tree ./equil
fi

