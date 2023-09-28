

x=0
while [  $x -lt 7 ]; do
cd e0$x
sbatch SLURM-*
cd ../
cd v0$x
sbatch SLURM-*
cd ../
let x=x+1
done
