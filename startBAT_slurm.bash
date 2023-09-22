#!/bin/bash

#SBATCH -J POSE-CMPN-comp
#SBATCH -p cpu

clear
source /opt/conda/etc/profile.d/conda.sh
conda activate py38

echo "------  Automatisiation Script for Binding Affinity Tool (BAT) --------"
echo ""

exc=0

if [[ exc -eq 0 && ! -d "./equil" ]]; then
	# Create Files for equilibration & start
	echo "1) Creating Files for Equilibration (might take a while) ..."
	python BAT.py -i input-dd-openmm.in -s equil 1> ./logs/1a_equil.out 2>./logs/1a_equil.err
	sleep 2s
	cd equil
	echo "2) Starting MD for equilibration..."
	bash sge_run-all-equil.bash 1> ../logs/1b_equil_start_md.out 2> ../logs/1b_equil_start_md.err
	cd ..
	sleep 2s
	echo ""
	squeue 1> ./logs/1c_equil_qstat_after_start_md.out 2> ./logs/1c_equil_qstat_after_start_md.err
	echo ""
	exc=1
else
	echo "-) Skipping Equilibration step"
fi

if [[ exc -eq 0 && ! -d "./fe" ]]; then
	# Energy calculation
	echo "3) Create Files for Productive MD runs..."
	python BAT.py -i input-dd-openmm.in -s fe 1> ./logs/2a_fe_prep.out 2>./logs/2a_fe_prep.err
	sleep 2
        cd fe
	echo "4) Starting Productive MD runs..." 
	bash sge_run-all-poses-dd.bash 1> ../logs/2b_fe_start_md.out 2> ../logs/2b_fe_start_md.err
	cd ..
	sleep 2
	squeue 1> ./logs/1c_fe_qstat_after_start_md.out 2> ./logs/2c_fe_qstat_after_start_md.err
	echo ""
	exc=1
else
	echo "-) Skipping Productive MD run"
fi

if [[ exc -eq 0 && -d "./fe/pose0/" && ! -d "./fe/pose0/Results/" ]]; then
	echo "5) Analysing MD runs and calculate binding energy..." 
	python BAT.py -i input-dd-openmm.in -s analysis 1> ./logs/5a_fe_analysis.out 2>./logs/5a_fe_analysis.err
	exc=1
else
	echo "-) Skipping Analysis"
fi
