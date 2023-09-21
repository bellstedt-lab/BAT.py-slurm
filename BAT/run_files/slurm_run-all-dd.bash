cd rest
cp ./run_files/slurm_run-rest.bash ./
source slurm_run-rest.bash
cd ../
cd dd/
cp ./run_files/slurm_run-dd-site.bash ./
cp ./run_files/slurm_run-dd-bulk.bash ./
source slurm_run-dd-site.bash
source slurm_run-dd-bulk.bash
cd ../
