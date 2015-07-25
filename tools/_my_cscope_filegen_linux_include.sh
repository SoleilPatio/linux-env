#!/bin/bash

which find

find  $LNX                                                                \
	-path "$LNX/arch/*" ! -path "$LNX/arch/arm*" -prune -o               \
	-path "$LNX/tmp*" -prune -o                                           \
    -path "$LNX/out*" -prune -o                                           \
	-path "$LNX/scripts*" -prune -o                                       \
	-path "$LNX/HTML*" -prune -o                                          \
    -path "$LNX/Documentation/*.txt" -o \
    -iname "*.[chxsS]" -o -iname "kconfig" -o -iname "makefile" -o -iname "*_defconfig" -o -iname "*.mk" \
    >> cscope.files

   
 
#-print >> cscope.files

