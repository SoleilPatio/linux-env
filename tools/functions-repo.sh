#!/bin/bash
LOGFILE=log-repo.log
SEPARATOR="---------------------------------"
repo-checkout-tag()
{
	if [ $# -eq 0 ]
	then
		echo repo-checkout-tag TAG_NAME
		echo "==> repo forall -p -c \"git checkout -B TAG_NAME -f TAG_NAME\""
		return
	else
		echo "repo forall -p -c \"git checkout -B $1 -f $1\"" | tee -a $LOGFILE
		repo forall -p -c "git checkout -B $1 -f $1"
	fi
}

repo-list-tags()
{
	git --git-dir .repo/manifests/.git/ tag -l
}

repo-manifest-info()
{
	echo [manifest list]
	ls  .repo/manifests
	echo $SEPARATOR
	echo [manifest link]
	ls -l .repo/manifest.xml
	echo $SEPARATOR
	echo [git config]
	cat .repo/manifests/.git/config
	echo $SEPARATOR
}
