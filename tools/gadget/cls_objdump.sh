#!/bin/bash

echo  "objdump -W --dwarf=decodedline $1 > $1.objdum"

objdump -W --dwarf=decodedline $1 > $1.objdump
