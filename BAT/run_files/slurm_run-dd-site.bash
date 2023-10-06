

x=0
while [  $x -lt 7 ]; do
cd e0$x
sbatch SLURM-run
cd ../
cd v0$x
sbatch SLURM-run
cd ../
let x=x+1
done
