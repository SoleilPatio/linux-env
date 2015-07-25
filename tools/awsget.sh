#bin/sh
source _awsinclude.sh

CMD="scp -i $PRIVATE_KEY $USER@$HOST:$1 $2"
echo $CMD
`echo $CMD`

