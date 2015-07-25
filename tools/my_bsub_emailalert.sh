#!/bin/bash
echo "Job is : $*"
bsub  -q tpe-mob-android -J my_bsub.sh "$*"

