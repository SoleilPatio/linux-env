#!/bin/bash
SEPARATOR="---------------------------------"
cls-find-up()
{
	#find up cscope.files
	find_dir=$(pwd -P 2>/dev/null || command pwd)
	while [ ! -e "$find_dir/$1" ]; do
		find_dir=${find_dir%/*}
		if [ "$find_dir" = "" ]; then break; fi
	done
	
	FIND_UP_RESULT=$find_dir/$1
}

cls-kern-log()
{
	sudo tail -f /var/log/kern.log
}

cls-reload()
{
#Run 1st
	. ~/.bashrc > /dev/null 2>&1
#Run 2nd
	. ~/.profile > /dev/null 2>&1
}




cls-ff()
{

	if [ $# -gt 0 ]
	then
		cls-find-up cscope.files
		echo FIND_UP_RESULT=$FIND_UP_RESULT
		grep -i $1 $FIND_UP_RESULT
	else
		echo ${FUNCNAME[ 0 ]} FILENAME_PATTERN
	fi
}


cls-grep()
{

	if [ $# -gt 0 ]
	then
		cls-find-up cscope.files
		echo FIND_UP_RESULT=$FIND_UP_RESULT
		_CMD="cat $FIND_UP_RESULT | xargs grep  --color=always -n $* 2>/dev/null "
		cls-color-HEAD
		echo $_CMD
		cls-color-reset
		cat $FIND_UP_RESULT | xargs grep  --color=always -n $* 2>/dev/null
	else
		echo ${FUNCNAME[ 0 ]} PATTERN [GREP_OPTIONS]
	fi
}


cls-cd()
{

	if [ $# -gt 0 ]
	then
		cd $(dirname `realpath $1`)
	else
		echo ${FUNCNAME[ 0 ]} SYMBOLIC_LINK_FILE
	fi
}

cls-note-list()
{
	ls ~/linux-env/tools/notes/note-*.txt
}

cls-note()
{
	cls-color-HEAD
	echo command: ${FUNCNAME[ 0 ]} [e]
	echo "   e : edit note"
	cls-color-reset

	_NOTEFILE=$1
	if [ $# -gt 1 ]
	then
		if [ $2 = "e" ]
		then
		gvim $_NOTEFILE
		fi
	else
		cat $_NOTEFILE
	fi 
}

cls-note-build-android()
{
	cls-note ~/linux-env/tools/notes/note-build-android.txt $1
}

cls-note-build-linux()
{
	cls-note ~/linux-env/tools/notes/note-build-linux.txt $1
}

cls-note-build-symbol()
{
	cls-note ~/linux-env/tools/notes/note-build-symbol.txt $1
}

cls-note-repo-init()
{
	cls-note ~/linux-env/tools/notes/note-repo-init.txt $1
}

cls-ubuntu-update()
{
	sudo apt-get update        # Fetches the list of available updates
	sudo apt-get upgrade       # Strictly upgrades the current packages
	sudo apt-get dist-upgrade  # Installs updates (new ones)
}

cls-color()
{
	echo -e "\e[$*m"
}

cls-color-reset()
{
	cls-color 0
}

cls-color-blue()
{
	cls-color 34
}

cls-color-bg-blue()
{
	cls-color 44
}

cls-color-HEAD()
{
	cls-color-bg-blue
}
