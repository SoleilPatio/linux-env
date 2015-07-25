#!/bin/bash
source _awsinclude.sh
CMD="ssh -i $PRIVATE_KEY $USER@$HOST"
echo $CMD
`echo $CMD`
