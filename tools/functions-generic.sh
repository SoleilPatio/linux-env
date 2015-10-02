#!/bin/bash
SEPARATOR="---------------------------------"
note-list()
{
	ls ~/linux-env/tools/gadget/note-*.txt

}

ff()
{
	if [ $# -gt 0 ]
	then
		grep $1 cscope.files
	else
		echo ff FILENAME_PATTERN
	fi
}