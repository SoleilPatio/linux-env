#!/bin/bash
LOGFILE=log-repo.log
SEPARATOR="---------------------------------"

cls_repo_setenv_LOGFILE()
{
	cls_find_up .repo
	echo FIND_UP_RESULT=$FIND_UP_RESULT
		
	LOGFILE=$FIND_UP_RESULT/../log-repo.log

}

cls_repo_init()
{
	echo "[Profile]:"
	echo "1:Google Android"
	echo "2:Alps"
	echo "3:Alps Build"
	echo ""
	read -p "Input : " in_profile </dev/tty
	
	case "$in_profile" in
	1) 
		in_profile=google
		_REPO_URL="https://android.googlesource.com/platform/manifest"
    	;;
	2) 
		in_profile=alps
		_REPO_URL="http://gerrit.mediatek.inc:8080/alps/platform/manifest"
    	;;
	3)
		in_profile=alpsbuild
		_REPO_URL="http://gerrit.mediatek.inc:8080/alps/build/manifest"
    	;;
	*)
    		echo "Invalid input."
	    	return
	esac
	
	echo "----------------------------------------------------------------------------"
	echo "in_profile = "$in_profile
	echo "_REPO_URL = "$_REPO_URL
	echo "----------------------------------------------------------------------------"

	echo "[Branch/Tags/Revision]:"
	if   [ $in_profile = google ]
	then
		in_branch=master
		echo "master"
		echo "android-6.0.0_r1"
		echo "refs/tags/<tag_name>"
		echo ""
		read -e -p "Input : " -i "$in_branch" in_branch </dev/tty
		
	
	elif [ $in_profile = alps ] || [ $in_profile = alpsbuild ]
	then
		#Assign default value
		in_branch=alps-trunk-m1.tk
		echo "alps-trunk-m0.tk"
		echo "alps-mp-m0.mp1"
		echo "refs/tags/t-alps-mp-m1.mp3-of.p10 (equal to latest version in LFK)"
		echo ""
		read -e -p "Input : " -i "$in_branch" in_branch </dev/tty
		
	fi
	
	echo "----------------------------------------------------------------------------"
	echo "in_branch = "$in_branch
	echo "----------------------------------------------------------------------------"
	
	
	echo "[Manifest]:"
	if   [ $in_profile = google ]
	then
		in_manifest=default.xml
	
	elif [ $in_profile = alps ]
	then
		in_manifest=manifest-hq.xml
		
	elif [ $in_profile = alpsbuild ]
	then
		in_manifest=2015_10_13_02_00
		echo "2015_10_13_02_00"
		echo ""
		read -e -p "Input : " -i "$in_manifest" in_manifest </dev/tty
		in_manifest=$in_manifest-hq.xml
		
	fi
	
	echo "----------------------------------------------------------------------------"
	echo "in_manifest = "$in_manifest
	echo "----------------------------------------------------------------------------"
	
	cls_repo_setenv_LOGFILE
	_EXECMD="repo init -u $_REPO_URL -b $in_branch -m $in_manifest"
	echo "Execute :"
	cls_color_HEAD
	echo "$_EXECMD | tee -a $LOGFILE"
	cls_color_reset
	echo "----------------------------------------------------------------------------"
	time $_EXECMD | tee -a $LOGFILE


	
	#Special command for LFK repo
	if [ $in_profile = alps ] || [ $in_profile = alpsbuild ]
	then
		_EXECMD="ln -s /mtkoss/git/hooks/wsd/prepare-commit-msg .repo/repo/hooks/"
		echo "Execute :"
		cls_color_HEAD
		echo $_EXECMD
		cls_color_reset
		$_EXECMD
	fi

		
}



cls_repo_checkout_tag()
{
	if [ $# -eq 0 ]
	then
		echo ${FUNCNAME[ 0 ]} TAG_NAME
		echo "==> repo forall -p -c \"git checkout -B TAG_NAME -f TAG_NAME\""
		return
	else
		cls_repo_setenv_LOGFILE
		echo "repo forall -p -c \"git checkout -B $1 -f $1\"" | tee -a $LOGFILE
		repo forall -p -c "git checkout -B $1 -f $1"
	fi
}

cls_repo_list_tags()
{
	cls_find_up .repo
	echo FIND_UP_RESULT=$FIND_UP_RESULT
		
	git --git-dir $FIND_UP_RESULT/manifests/.git/ tag -l
}

cls_repo_info()
{
	cls_find_up .repo
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

cls_repo_grep_manifest()
{
	cls_find_up .repo
	echo FIND_UP_RESULT=$FIND_UP_RESULT
	
	grep -i $1 $FIND_UP_RESULT/manifest.xml $FIND_UP_RESULT/manifests/hq-only.xml $FIND_UP_RESULT/manifests/sub.xml $FIND_UP_RESULT/manifests/aosp.xml $FIND_UP_RESULT/manifests/trusty.xml
	
}
