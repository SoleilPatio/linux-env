#!/bin/bash
SEPARATOR="---------------------------------"
cls-git-info()
{
	cls-find-up .git
	echo FIND_UP_RESULT=$FIND_UP_RESULT
	
	echo [git config]
	cat $FIND_UP_RESULT/config
	echo $SEPARATOR
	
	echo [local branch]
	git branch -vv
	echo $SEPARATOR
	
	echo [status]
	git status
	echo $SEPARATOR
}
