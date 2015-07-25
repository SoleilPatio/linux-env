#!/bin/bash

if     [ $# -eq 0 ]
then
    echo "$0 [ plat1 plat2 plat3 ...(ex. mt6735)]"
    exit
fi

mv cscope.files cscope.files.backup


if [ $# -eq 1 ]
then
    echo "filter $1..."
    awk '{if  ( /mt[0-9][0-9][0-9][0-9]\// ) {if(/'"$1"'/) print $0;} else print $0; }' cscope.files.backup > cscope.files
elif [ $# -eq 2 ]
then
    echo "filter $1 $2"
    awk '{if  ( /mt[0-9][0-9][0-9][0-9]\// ) {if(/'"$1"'/ || /'"$2"'/) print $0;} else print $0; }' cscope.files.backup > cscope.files
elif [ $# -eq 3 ]
then
    echo "filter $1 $2 $3"
    awk '{if  ( /mt[0-9][0-9][0-9][0-9]\// ) {if(/'"$1"'/ || /'"$2"'/ || /'"$3"'/) print $0;} else print $0; }' cscope.files.backup > cscope.files
else
    echo "Too many platforms, unsupported platform number."
    exit
fi

cp cscope.files cscope.files.tmp

echo "Filter out kernel-3.4..."
awk '{if  ( !/kernel-3.4\// ) print $0; }' cscope.files.tmp > cscope.files

rm cscope.files.tmp


