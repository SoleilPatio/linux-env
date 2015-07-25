#bin/sh
source _awsinclude.sh
CMD="scp -i $PRIVATE_KEY $1 $USER@$HOST:$2"
echo $CMD
`echo $CMD`

