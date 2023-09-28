

x=0
while [  $x -lt 10 ]; do
cd u0$x
sbatch SLURM-*
cd ../
let x=x+1
done

if [ $x -ge 10 ]; then
while [  $x -lt 41 ]; do
cd u$x
sbatch SLURM-*
cd ../
let x=x+1
done
fi
