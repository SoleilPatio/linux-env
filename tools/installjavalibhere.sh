#!/bin/bash
if [ -z $1 ];then

    echo "Enter JAVA library directory.."

else

    echo "install *.jar under \"$1\" into current directory"
    for i in `find $1 -iname "*.jar"`; 
    do 
        echo $i;
        ln -s $i `basename $i`; 
    done
fi
