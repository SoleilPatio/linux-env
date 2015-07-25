#!/bin/bash

if [ -z $LNX ]
then
	LNX=./kernel-3.10
	echo "LNX is not set, default is "$LNX
fi

AND=.


echo LNX=$LNX
echo AND=$AND

rm cscope.files

source _my_cscope_filegen_linux_include.sh

source _my_cscope_filegen_android_include.sh

ln -s cscope.files gtags.files

