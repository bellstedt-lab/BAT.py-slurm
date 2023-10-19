#!/bin/bash

# Run execution subscript for fe calc inside each pose dir
x=0
while [ $x -lt NUMBER_OF_POSES ]; do
cd pose$x
source slurm_run-all-fe.bash
cd ../
let x=x+1
done

