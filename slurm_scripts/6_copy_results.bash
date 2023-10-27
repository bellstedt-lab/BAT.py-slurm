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
        cp "./$pose/Results/Results.dat" "../../results/results_${pose}_${host}.dat"
        # extract SMILES representation of ligand and add to Results file
        smiles=$(cat "../equil/$pose/vac_ligand.pdb" | obabel -ipdb -osmi --gen3d --minimize 2>/dev/null)
        # convert ligand to sdf and save in results dir just be be sure in case it is needed afterwards
        obabel "../equil/$pose/vac_ligand.pdb" -O "../../results/ligand_${pose}_${host}.sdf" 2>/dev/null
        echo "" >> "../../results/results_${pose}_${host}.dat"
        echo "SMILES of Ligand extracted from $pose running on $host:" >> "../../results/results_${pose}_${host}.dat"
        echo "$smiles" >> "../../results/results_${pose}_${host}.dat"
        echo "- Results for $pose on $host:"
        cat "../../results/results_${pose}_${host}.dat"
        echo ""
    elif [ -d "./$pose/" ]; then
        touch "../../results/results_${pose}_${host}.err"
        echo "NO results for $pose on $host"
    else
       touch "../../results/results.err"
       echo "Pose directory not found on host $host"
    fi
done
