#!/bin/bash

#SBATCH -J BAT5

clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38
cd ../BAT

#echo "------  SLURM Automatisiation Script for Binding Affinity Tool (BAT) --------"
#echo ""

if [[ -d "./fe/pose0/" && ! -d "./fe/pose0/Results/" ]]; then
	echo "5) Analysing MD runs and calculate binding energy..." 
	python BAT_slurm.py -i input-dd-openmm.in -s analysis 1> ./logs/5a_fe_analysis.out 2>./logs/5a_fe_analysis.err
    echo "...Finished. Directory structure:"
    echo ""
    tree fe
else
	echo "-) Skipping Analysis: Analysis results exist already"
fi
