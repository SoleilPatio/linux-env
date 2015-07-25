#!/bin/bash

rm cscope.files

find . \
    -iname "*.aidl" -print -o -iname "*.xml" -print -o \
    -iname "*.cc"   -print -o -iname "*.h"  -print -o -iname "*.c" -print -o -iname "*.cpp" -print -o -iname "*.py" -print -o\
    -iname "*.java" -print -o -iname "*.mk" -print -o -iname "makefile" -print -o -iname "kconfig" -print -o -iname "*_defconfig" -print -o\
    -iname "*.cxx"  -print -o -iname "*.hpp" -print -o\
    -path "*Documentation*.txt" -print \
    >> cscope.files


ln -s cscope.files gtags.files

