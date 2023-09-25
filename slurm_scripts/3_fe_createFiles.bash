#!/bin/bash

#SBATCH -J BAT3

clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38
cd ../BAT

#echo "------  SLURM Automatisiation Script for Binding Affinity Tool (BAT) --------"
#echo ""

if [[ ! -d "./fe" ]]; then
	# Energy calculation
	echo "3) Create Files for Productive MD runs..."
	python BAT_slurm.py -i input-dd-openmm.in -s fe 1> ./logs/2a_fe_prep.out 2>./logs/2a_fe_prep.err
	sleep 1
	echo "...Finished"
else
	echo "-) Skipping Productive MD run: fe directory already exists"
fi


