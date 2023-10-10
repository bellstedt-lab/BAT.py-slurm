#!/bin/bash

#SBATCH -J BAT3
#SBATCH -o 3_fe_createFiles_JobId%j.out


clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38
cd ../BAT

if [[ ! -d "./fe" ]]; then
	# Energy calculation
	echo "3) Create Files for Productive MD runs..."
	#python BAT_slurm.py -i input-dd-openmm.in -s fe 1> ./logs/2a_fe_prep.out 2>./logs/2a_fe_prep.err
	python BAT_slurm.py -i input-dd-openmm.in -s fe
	sleep 1
	echo "...Finished."
else
	echo "-) Skipping Productive MD run: fe directory already exists"
fi


