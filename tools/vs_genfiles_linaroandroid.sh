#!/bin/bash

LNX=./kernel/linaro/pandaboard
AND=.

rm cscope.files

source _my_cscope_filegen_linux_include.sh
source _my_cscope_filegen_android_include.sh

ln -s cscope.files gtags.files

