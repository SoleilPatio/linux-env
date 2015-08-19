#!/bin/bash

if [ -z $LNX ]
then
	LNX=./kernel-3.10
	echo "LNX is not set, default is "$LNX
fi

AND=.
FILE_TYPE="-iname *.[chxsS]   -o -iname kconfig -o -iname makefile  -o \
	   -iname *_defconfig -o -iname *.mk    -o -iname *.aidl    -o \
	   -iname *.cc        -o -iname *.cpp   -o -iname *.cxx     -o -iname *.hpp -o\
	   -iname *.aidl      -o -iname *.java "  


echo find = `which find`
echo LNX=$LNX
echo AND=$AND



rm cscope.files

#source _my_cscope_filegen_linux_include.sh >> cscope.files

source _my_cscope_filegen_android_include.sh >> cscope.files

ln -s cscope.files gtags.files

