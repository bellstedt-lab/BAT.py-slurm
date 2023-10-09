cd rest
cd m-comp
sbatch --wait SLURM-m
cd ../
cd n-comp
sbatch --wait SLURM-n
cd ../
cd ../

cd sdr
cd e-comp
sbatch --wait SLURM-e
cd ../
cd v-comp
sbatch --wait SLURM-v
cd ../
cd ../
