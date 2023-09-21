#!/bin/bash

# Run execution subscript for fe calc inside each pose dir
x=0
while [   -lt NUMBER_OF_POSES ]; do
cd pose
source slurm_run-all-dd.bash
cd ../
let x=x+1
done

