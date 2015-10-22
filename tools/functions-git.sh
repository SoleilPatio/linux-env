#!/bin/bash
SEPARATOR="---------------------------------"
cls_git_info()
{
	cls_find_up .git
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

cls_git_show_local_commit()
{
	cls_color_HEAD
	echo -e "command: git log `git symbolic-ref HEAD` --not --remotes $*"
	cls_color_reset

	git log `git symbolic-ref HEAD` --not --remotes $*
	#git log @{u}.. $*
}

