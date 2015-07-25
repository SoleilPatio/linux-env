#!/bin/bash
rm tags
ctags -R -L cscope.files &
cscope -b -q &

