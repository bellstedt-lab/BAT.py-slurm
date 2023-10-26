#!/bin/bash

cd ..
if [[ ! -d "./results" ]]; then
    mkdir ./results
fi

cd ./BAT/fe/

echo ""

host=$(hostname)

for pose in pose*; do
    if [[ -f "./$pose/Results/Results.dat" ]]; then
        cp "./$pose/Results/Results.dat" "../../results/results_$pose_$host.dat"
        # extract SMILES representation of ligand and add to Results file
        smiles=$(cat "../equil/$pose/vac_ligand.pdb" | obabel -ipdb -osmi 2>/dev/null)
        echo "" >> "../../results/results_$pose_$host.dat"
        echo "SMILES of Ligand:" >> "../../results/results_$pose_$host.dat"
        echo "$smiles" >> "../../results/results_$pose_$host.dat"
        echo "Results for $pose on $host:"
        echo ""
        cat "../../results/results_$pose_$host.dat"
        echo ""
    elif [ -d "./$pose/" ]; then
        touch "../../results/results_$pose_$host.err"
        echo "NO results for $pose on $host"
    else
       touch "../../results/results.err"
       echo "Pose directory not found on host $host"
    fi
done
