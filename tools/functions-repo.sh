#!/bin/bash
LOGFILE=log-repo.log
SEPARATOR="---------------------------------"

cls-repo-setenv-LOGFILE()
{
	cls-find-up .repo
	echo FIND_UP_RESULT=$FIND_UP_RESULT
		
	LOGFILE=$FIND_UP_RESULT/../log-repo.log

}

cls-repo-init()
{
	
	if [ $# -eq 0 ]
	then
		echo "Usage:"
		echo "${FUNCNAME[ 0 ]} [google|alps|alpsbuild] [google:REVISION|BRANCH|TAG / alps_build:yyyy_mm_dd_tt ]"
		echo "==> repo init -u https://android.googlesource.com/platform/manifest -b REVISION_OF_MANIFEST"
		echo ""
		return
	fi


	if [ -z "$2" ]
	then
		_REVISION=master
	else
		_REVISION=$2
	fi


	case $1 in
	google)
		_REPO_URL="https://android.googlesource.com/platform/manifest"
		;;

	alps)
		_REPO_URL="http://gerrit.mediatek.inc:8080/alps/platform/manifest"
		_REVISION="alps-trunk-m0.tk -m manifest-hq.xml"
		;;

	alpsbuild)
		_REPO_URL="http://gerrit.mediatek.inc:8080/alps/build/manifest"
		_REVISION="alps-trunk-m0.tk -m $2-hq.xml"
		;;

	*)
		echo Unknown profile : $1
		echo "valid profile is [google|alps|alpsbuild]"
		exit
		;;
	esac



	
	cls-repo-setenv-LOGFILE
	echo "repo init -u $_REPO_URL -b $_REVISION" | tee -a $LOGFILE
	repo init -u $_REPO_URL -b $_REVISION
}

cls-repo-checkout-tag()
{
	if [ $# -eq 0 ]
	then
		echo ${FUNCNAME[ 0 ]} TAG_NAME
		echo "==> repo forall -p -c \"git checkout -B TAG_NAME -f TAG_NAME\""
		return
	else
		cls-repo-setenv-LOGFILE
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
	
	echo [git branch]
	git --git-dir $FIND_UP_RESULT/manifests/.git/ branch -vv
	echo $SEPARATOR

}

cls-repo-grep-manifest()
{
	cls-find-up .repo
	echo FIND_UP_RESULT=$FIND_UP_RESULT
	
	grep -i $1 $FIND_UP_RESULT/manifest.xml
	
}
