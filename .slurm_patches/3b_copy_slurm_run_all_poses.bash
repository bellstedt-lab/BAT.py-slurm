#!/bin/bash

SCRIPT="\
#!/bin/bash

# Run execution subscript for fe calc inside each pose dir
x=0
while [ \$x -lt NUMBER_OF_POSES ]; do
cd pose\$x
source slurm_run-all-fe.bash
cd ../
let x=x+1
done
"

echo -e "$SCRIPT" > ../BAT/run_files/slurm_run-all-fe-all-poses.bash
