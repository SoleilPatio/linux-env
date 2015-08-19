#!/bin/bash


find -D tree $AND	\
	\( \(		\
	-not -path "$AND/kernel-*/*"    -and  -not -path "$AND/out/*"   -and \
	-not -path "$AND/prebuilts/*"   -and  -not -path "$AND/tools/*" -and \
	-not -path "$AND/development/*" -and  -not -path "$AND/ndk/*"   -and \
	-not -path "$AND/sdk/*"         -and  -not -path "$AND/docs/*"  -and  -not -path "$AND/native-toolchain/*" -and \
	-not -path "$AND/external/*"    -and  -not -path "$AND/cts/*"   -and  -not -path "$AND/developers/*" -and  \
	-not -path "$AND/HTML/*"  -and 	\
	-not -path "$AND/hardware/*"   	\
	\) -or				\
	\(				\
	-path "$AND/hardware/mediatek/*" -o -path "$AND/hardware/libhardware/*" -o -path "$AND/hardware/libhardware_legacy/*"	\
	\) \) -and 			\
	\( $FILE_TYPE \)	

