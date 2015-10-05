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

cls-reload()
{
#Run 1st
	. ~/.bashrc > /dev/null 2>&1
#Run 2nd
	. ~/.profile > /dev/null 2>&1
}

cls-note-list()
{
	ls ~/linux-env/tools/gadget/note-*.txt

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

cls-cd()
{

	if [ $# -gt 0 ]
	then
		cd $(dirname `realpath $1`)
	else
echo ${FUNCNAME[ 0 ]} SYMBOLIC_LINK_FILE
	fi
}

cls-test()
{
	echo "I am test2"
}
