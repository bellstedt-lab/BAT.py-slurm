

x=0
while [  $x -lt 7 ]; do
cd f0$x
sbatch SLURM-*
cd ../
cd w0$x
sbatch SLURM-*
cd ../
let x=x+1
done
