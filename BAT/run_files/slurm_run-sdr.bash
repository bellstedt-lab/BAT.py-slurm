

x=0
while [  $x -lt 10 ]; do
cd e0$x
sbatch --wait SLURM-run
cd ../
cd v0$x
sbatch --wait SLURM-run
cd ../
let x=x+1
done

if [ $x -ge 10 ]; then
while [  $x -lt 12 ]; do
cd e$x
sbatch --wait SLURM-run
cd ../
cd v$x
sbatch --wait SLURM-run
cd ../
let x=x+1
done
fi
