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

cls-git-show-local-commit()
{
	cls-color-HEAD
	echo -e "command: git log `git symbolic-ref HEAD` --not --remotes $*"
	cls-color-reset

	git log `git symbolic-ref HEAD` --not --remotes $*
	#git log @{u}.. $*
}

