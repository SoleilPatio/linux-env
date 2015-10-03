#!/bin/bash
LOGFILE=log-repo.log
SEPARATOR="---------------------------------"

cls-repo-checkout-tag()
{
	if [ $# -eq 0 ]
	then
		echo ${FUNCNAME[ 0 ]} TAG_NAME
		echo "==> repo forall -p -c \"git checkout -B TAG_NAME -f TAG_NAME\""
		return
	else
		echo "repo forall -p -c \"git checkout -B $1 -f $1\"" | tee -a $LOGFILE
		repo forall -p -c "git checkout -B $1 -f $1"
	fi
}

cls-repo-list-tags()
{
	cls-find-up .repo
	echo FIND_UP_RESULT=$FIND_UP_RESULT
		
	git --git-dir $FIND_UP_RESULT/manifests/.git/ tag -l
}

cls-repo-info()
{
	cls-find-up .repo
	echo FIND_UP_RESULT=$FIND_UP_RESULT
	
	echo [manifest list]
	ls  $FIND_UP_RESULT/manifests
	echo $SEPARATOR
	echo [manifest link]
	ls -l $FIND_UP_RESULT/manifest.xml
	echo $SEPARATOR
	echo [git config]
	cat $FIND_UP_RESULT/manifests/.git/config
	echo $SEPARATOR
}

cls-repo-grep-manifest()
{
	cls-find-up .repo
	echo FIND_UP_RESULT=$FIND_UP_RESULT
	
	grep -i $1 $FIND_UP_RESULT/manifest.xml
	
}
