#!/bin/bash

repo-checkout-tag()
{
	if [ $# -eq 0 ]
	then
		echo repo-checkout-tag TAG_NAME
		echo "==> repo forall -p -c \"git checkout -B TAG_NAME -f TAG_NAME\""
		return
	else
		echo "repo forall -p -c \"git checkout -B $1 -f $1\""
		repo forall -p -c "git checkout -B $1 -f $1"
	fi
}
