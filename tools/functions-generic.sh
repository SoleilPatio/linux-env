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

cls_kern_log()
{
	sudo tail -f /var/log/kern.log
}

cls_reload()
{
#Run 1st
	. ~/.bashrc > /dev/null 2>&1
#Run 2nd
#	. ~/.profile > /dev/null 2>&1
}

cls_edit_functions()
{
	gvim ~/linux-env/tools/functions-*.sh ~/linux-env/tools/cscope-build-symbol.sh
}


cls_ff()
{

	if [ $# -gt 0 ]
	then
		cls_find_up cscope.files
		echo FIND_UP_RESULT=$FIND_UP_RESULT
		grep -i --color=always $1 $FIND_UP_RESULT
	else
		echo ${FUNCNAME[ 0 ]} FILENAME_PATTERN
	fi
}


cls_grep()
{

	if [ $# -gt 0 ]
	then
		cls_find_up cscope.files
		echo FIND_UP_RESULT=$FIND_UP_RESULT
		_CMD="cat $FIND_UP_RESULT | xargs grep  --color=always -n $* 2>/dev/null "
		cls_color_HEAD
		echo $_CMD
		cls_color_reset
		cat $FIND_UP_RESULT | xargs grep  --color=always -n $* 2>/dev/null
	else
		echo ${FUNCNAME[ 0 ]} PATTERN [GREP_OPTIONS]
	fi
}


cls_cd()
{

	if [ $# -gt 0 ]
	then
		cd $(dirname `realpath $1`)
	else
		echo ${FUNCNAME[ 0 ]} SYMBOLIC_LINK_FILE
	fi
}

cls_tar_create()
{
	_DIRNAME=${1%/}

	_CMD="tar -cvf $_DIRNAME.tar $_DIRNAME"
	cls_color_HEAD
	echo command: $_CMD
	cls_color_reset

	$_CMD

}

cls_tar_list()
{

	_CMD="tar -tf $1"
	cls_color_HEAD
	echo command: $_CMD
	cls_color_reset

	$_CMD

}

cls_note_list()
{
	ls ~/linux-env/tools/notes/note-*.txt
}

cls_note()
{
	cls_color_HEAD
	echo command: ${FUNCNAME[ 0 ]} [e]
	echo "   e : edit note"
	cls_color_reset

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

cls_note_build_android()
{
	cls_note ~/linux-env/tools/notes/note-build-android.txt $1
}

cls_note_build_linux()
{
	cls_note ~/linux-env/tools/notes/note-build-linux.txt $1
}

cls_note_build_symbol()
{
	cls_note ~/linux-env/tools/notes/note-build-symbol.txt $1
}

cls_note_repo_init()
{
	cls_note ~/linux-env/tools/notes/note-repo-init.txt $1
}

cls_ubuntu_update()
{
	sudo apt-get update        # Fetches the list of available updates
	sudo apt-get upgrade       # Strictly upgrades the current packages
	sudo apt-get dist-upgrade  # Installs updates (new ones)
}

cls_color()
{
	echo -e "\e[$*m"
}

cls_color_reset()
{
	cls_color 0
}

cls_color_blue()
{
	cls_color 34
}

cls_color_bg_blue()
{
	cls_color 44
}

cls_color_HEAD()
{
	cls_color_bg_blue
}
