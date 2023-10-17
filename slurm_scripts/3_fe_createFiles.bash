#!/bin/bash

#SBATCH -J BAT3
#SBATCH -o slurm_3_fe_createFiles_JobId%j.out


clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38
cd ../BAT

if [[ ! -d "./fe" ]]; then
	# Energy calculation
	echo "3) Create Files for Productive MD runs..."
	python BAT_slurm.py -i input-dd-openmm.in -s fe
	sleep 2
	echo "...Finished."
else
	echo "-) Skipping creation of productive MD run directory: fe directory already exists"
fi


