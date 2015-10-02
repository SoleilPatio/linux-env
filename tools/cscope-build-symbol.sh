#/bin/sh
#author: clouds.lee

showHelp()
{
	echo "$0  [-D] -profile=android|linux|generic -androidpath=ANDROID_PATH -linuxpath=LINUX_PATH -filter='mtXXXX mtXXXX mtXXXX'"
	echo "-D: \"find -D tree\" debug"
	echo ""
	echo "ex."
	echo "cscope-build-symbol.sh -p=android -a=. -l=./kernel-3.10/ -f='mt6735 mt6755 mt6753'"
	echo ""
	
}

initVariable()
{
	set -f
	PROFILE=generic
	OUT_FILE=cscope.files
	FILE_TYPE="-iname *.[chxsS]   -iname *.c -o -iname kconfig -o -iname makefile  -o \
	   -iname *_defconfig -o -iname *.mk    -o -iname *.aidl    -o \
	   -iname *.cc        -o -iname *.cpp   -o -iname *.cxx     -o -iname *.hpp -o\
	   -iname *.aidl      -o -iname *.java" 
	ANDROIDPATH=.
	LINUXPATH=.
	FIND_DEBUG=  
}

showInfo()
{
	echo [Config] -------------------------------
	echo PROFILE=$PROFILE
	echo ANDROIDPATH=$ANDROIDPATH
	echo LINUXPATH=$LINUXPATH
	echo FILTER=$FILTER
	echo FILE_TYPE=$FILE_TYPE
	echo OUT_FILE=$OUT_FILE
	echo FIND_DEBUG=$FIND_DEBUG
	echo ----------------------------------------
}



parseArgument()
{
	for i in "$@"
	do
	case $i in
	    -p=*|-profile=*)
	    PROFILE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	    ;;
	    
	    -a=*|-androidpath=*)
	    ANDROIDPATH=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	    ;;
	    
	    -l=*|-linuxpath=*)
	    LINUXPATH=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	    ;;
	    
	    -f=*|-filter=*)
	    FILTER=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
	    ;;
	    
	    -D)
	    FIND_DEBUG="-D tree"
	    ;;
	    
	    *)
	            # unknown option
	    ;;
	esac
	done
}



genFileListLinux()
{
	echo "generating files for Linux...."
	find $FIND_DEBUG  $LINUXPATH 							\
		\( \(								\
		-not -path "$LINUXPATH/arch/*"    -and 				\
		-not -path "$LINUXPATH/tmp/*"     -and -not -path "$LINUXPATH/out/*" -and 	\
		-not -path "$LINUXPATH/scripts/*" -and -not -path "$LINUXPATH/HTML/*" 	\
		\) -or								\
		\(								\
		-path "$LINUXPATH/arch/arm*" -o -path "$LINUXPATH/Documentation/*.txt" 	\
		\) \) -and							\
		\( $FILE_TYPE \)	>> 	$OUT_FILE
		
}

genFileListAndroid()
{
	echo "generating files for Android...."
	find $FIND_DEBUG $ANDROIDPATH	\
		\( \(		\
		-not -path "$ANDROIDPATH/kernel-*/*"    -and  -not -path "$ANDROIDPATH/out/*"   -and \
		-not -path "$ANDROIDPATH/prebuilts/*"   -and  -not -path "$ANDROIDPATH/tools/*" -and \
		-not -path "$ANDROIDPATH/development/*" -and  -not -path "$ANDROIDPATH/ndk/*"   -and \
		-not -path "$ANDROIDPATH/sdk/*"         -and  -not -path "$ANDROIDPATH/docs/*"  -and  -not -path "$ANDROIDPATH/native-toolchain/*" -and \
		-not -path "$ANDROIDPATH/external/*"    -and  -not -path "$ANDROIDPATH/cts/*"   -and  -not -path "$ANDROIDPATH/developers/*" -and  \
		-not -path "$ANDROIDPATH/HTML/*"  -and 	\
		-not -path "$ANDROIDPATH/hardware/*"   	\
		\) -or				\
		\(				\
		-path "$ANDROIDPATH/hardware/mediatek/*" -o -path "$ANDROIDPATH/hardware/libhardware/*" -o -path "$ANDROIDPATH/hardware/libhardware_legacy/*"	\
		\) \) -and 			\
		\( $FILE_TYPE \)	>> 	$OUT_FILE
}

genFileListGeneric()
{
	echo "generating files for Generic...."
	find $FIND_DEBUG .  \
		 \( $FILE_TYPE \) 	>> 	$OUT_FILE
}

filterMtPlatform()
{
	if     [ $# -eq 0 ]
	then
	    echo "no filter applied..."
	    return
	fi
	
	mv $OUT_FILE $OUT_FILE.backup
	
	
	if [ $# -eq 1 ]
	then
	    echo "filter $1..."
	    awk '{if  ( /mt[0-9][0-9][0-9][0-9]\// ) {if(/'"$1"'/) print $0;} else print $0; }' $OUT_FILE.backup > $OUT_FILE
	elif [ $# -eq 2 ]
	then
	    echo "filter $1 $2"
	    awk '{if  ( /mt[0-9][0-9][0-9][0-9]\// ) {if(/'"$1"'/ || /'"$2"'/) print $0;} else print $0; }' $OUT_FILE.backup > $OUT_FILE
	elif [ $# -eq 3 ]
	then
	    echo "filter $1 $2 $3"
	    awk '{if  ( /mt[0-9][0-9][0-9][0-9]\// ) {if(/'"$1"'/ || /'"$2"'/ || /'"$3"'/) print $0;} else print $0; }' $OUT_FILE.backup > $OUT_FILE
	else
	    echo "Too many platforms, unsupported platform number."
	    exit
	fi
	
	#cp cscope.files cscope.files.tmp
	#echo "Filter out kernel-3.4..."
	#awk '{if  ( !/kernel-3.4\// ) print $0; }' cscope.files.tmp > cscope.files
	#rm cscope.files.tmp

}

buildCscopeSymbol()
{
	echo "build cscope symbols in background...."
	rm tags
	ctags -R -L cscope.files &
	cscope -b -q &
}



#Main Part---------------------------------------------------------------

#echo $#
#if [ $# -eq 0 ]
#then
	showHelp
#fi

#0. Setup
initVariable
parseArgument "$@"
showInfo

#1. reset file
echo > $OUT_FILE

#2. generating file list
case $PROFILE in
	android)
	genFileListLinux
	genFileListAndroid
    ;;
    
    linux)
    genFileListLinux
    ;;
    
    *)
    genFileListGeneric
    ;;

	esac
	    
#3. filter
filterMtPlatform $FILTER

#4. build symbol
buildCscopeSymbol
	    



