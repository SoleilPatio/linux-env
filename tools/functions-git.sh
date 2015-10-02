#!/bin/bash
SEPARATOR="---------------------------------"
git-info()
{
	echo [git config]
	cat .git/config
	echo $SEPARATOR
	
	echo [local branch]
	git branch -vv
	echo $SEPARATOR
	
	echo [status]
	git status
	echo $SEPARATOR
}
