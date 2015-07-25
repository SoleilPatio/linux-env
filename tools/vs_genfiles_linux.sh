#!/bin/bash

LNX=.

rm cscope.files

source _my_cscope_filegen_linux_include.sh

ln -s cscope.files gtags.files
