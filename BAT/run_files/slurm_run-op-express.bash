cd rest
cd m-comp
sbatch SLURM-m
cd ../
cd n-comp
sbatch SLURM-n
cd ../
cd ../

cd sdr
cd e-comp
sbatch SLURM-e
cd ../
cd v-comp
sbatch SLURM-v
cd ../
cd ../
