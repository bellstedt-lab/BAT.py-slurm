cd rest
cd a-comp
sbatch --wait SLURM-a
cd ../
cd l-comp
sbatch --wait SLURM-l
cd ../
cd t-comp
sbatch --wait SLURM-t
cd ../
cd c-comp
sbatch --wait SLURM-c
cd ../
cd r-comp
sbatch --wait SLURM-r
cd ../
cd ../

cd dd
cd e-comp
sbatch --wait SLURM-e
cd ../
cd v-comp
sbatch --wait SLURM-v
cd ../
cd w-comp
sbatch --wait SLURM-w
cd ../
cd f-comp
sbatch --wait SLURM-f
cd ../
cd ../
