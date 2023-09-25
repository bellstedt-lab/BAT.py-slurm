#!/bin/bash

#SBATCH -J BAT1

clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38
cd ../BAT

#echo "------  SLURM Automatisiation Script for Binding Affinity Tool (BAT) --------"
#echo ""

if [[ ! -d "./equil" ]]; then
	# Create Files for equilibration & start
	echo "1) Creating Files for Equilibration (might take a while) ..."
	python BAT_slurm.py -i input-dd-openmm.in -s equil 1> ./logs/1a_equil.out 2>./logs/1a_equil.err
	echo "...Finished"
else
	echo "-) Skipping Equilibration step: equil folder already exists"
fi

