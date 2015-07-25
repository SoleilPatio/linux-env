#!/bin/bash

~/alps.l1/kernel-3.10/scripts/checkpatch.pl --show-types --no-tree --max-line-length=120 --ignore MEMORY_BARRIER,NEW_TYPEDEFS,VOLATILE -f $1

