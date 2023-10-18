#!/bin/bash

cd ..
if [[ ! -d "$dir_path" ]]; then
    mkdir ./results
fi

cd ./BAT/fe/

echo ""

for pose in pose*; do
    if [[ -f "./$pose/Results/Results.dat" ]]; then
        cp "./$pose/Results/Results.dat" "../../results/results_$pose.dat"
        echo "Results for $pose:"
        echo ""
        cat "../../results/results_$pose.dat"
        echo ""
    elif [ -d "./$pose/" ]; then
        touch "../../results/results_$pose.err"
        echo "NO results for $pose"
    else
       touch "../../results/results.err"
       echo "Pose directory not found"
    fi
done
