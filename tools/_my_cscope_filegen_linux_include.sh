#!/bin/bash


find -D tree $LNX 							\
	\( \(								\
	-not -path "$LNX/arch/*"    -and 				\
	-not -path "$LNX/tmp/*"     -and -not -path "$LNX/out/*" -and 	\
	-not -path "$LNX/scripts/*" -and -not -path "$LNX/HTML/*" 	\
	\) -or								\
	\(								\
	-path "$LNX/arch/arm*" -o -path "$LNX/Documentation/*.txt" 	\
	\) \) -and							\
	\( $FILE_TYPE \)						\



