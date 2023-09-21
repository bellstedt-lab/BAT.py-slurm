#!/bin/bash

source /opt/conda/etc/profile.d/conda.sh
conda activate py38

python BAT_slurm.py -i input-dd-openmm.in -s equil
