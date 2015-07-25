#!/bin/bash
echo "Job is : $*"
bsub  -I -q tpe-mob-android -J my_bsub.sh "$*"

