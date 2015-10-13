#!/bin/bash

#Original
# ~/alps.l1/kernel-3.10/scripts/checkpatch.pl --show-types --no-tree --max-line-length=120 --ignore MEMORY_BARRIER,NEW_TYPEDEFS,VOLATILE -f $1

#git 3.18
#~/alps.l1/kernel-3.18/scripts/checkpatch.pl --no-tree --show-types --max-line-length=120 --ignore NEW_TYPEDEFS,LINUX_VERSION_CODE -f $1
~/gitmtk/alps-trunk-m0.tk/kernel-3.18/scripts/checkpatch.pl --show-types --no-tree --max-line-length=120 --ignore MEMORY_BARRIER,NEW_TYPEDEFS,VOLATILE -f $1
