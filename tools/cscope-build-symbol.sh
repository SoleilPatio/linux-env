#/bin/sh
#author: clouds.lee

showHelp()
{
	echo ""
	echo "Usage:"
	echo "$SCRIPT_NAME  [-D] [-fileonly] -profile=android|linux|generic|ubuntu_ko -androidpath=ANDROID_PATH -linuxpath=LINUX_PATH -filter='mtXXXX mtXXXX mtXXXX'"
	echo ""
	echo "-D: \"find -D tree\" debug"
	echo ""
	echo "ex."
	echo "$SCRIPT_NAME -p=android -a=. -l=./kernel-3.10 -f='mt6735 mt6755 mt6753'"
	echo ""
	
}

initVariable()
{
	#disable file name expansion first
	set -f
	
	
	PROFILE=generic
	OUT_FILE=cscope.files
	FILE_TYPE="-iname *.[chxsS] 	-o -iname kconfig	-o -iname makefile	-o -iname *.dts		-o -iname *.dtsi 	-o\
	   -iname *_defconfig		-o -iname *.mk		-o -iname *.aidl	-o -iname *.txt		-o -iname README	-o\
	   -iname *.cc        		-o -iname *.cpp		-o -iname *.cxx		-o -iname *.hpp		-o -iname *.rc		-o\
	   -iname *.aidl      		-o -iname *.java" 
	ANDROIDPATH=.
	LINUXPATH=.
	LINUX_ARCH=arm
	FIND_OPT1="-L" #follow link
	FIND_OPT2="-type f"
	FIND_EXEC="-exec realpath {} ;"
	OPT_FIND_DEBUG=
	OPT_FILE_ONLY=false  
}

showInfo()
{
	echo [Config] -------------------------------
	echo SCRIPT_NAME=$SCRIPT_NAME
	echo PROFILE=$PROFILE
	echo ANDROIDPATH=$ANDROIDPATH
	echo LINUXPATH=$LINUXPATH
	echo LINUX_ARCH=$LINUX_ARCH
	echo FILTER=$FILTER
	echo FILE_TYPE=$FILE_TYPE
	echo OUT_FILE=$OUT_FILE
	echo FIND_OPT1=$FIND_OPT1
	echo FIND_OPT2=$FIND_OPT2
	echo FIND_EXEC=$FIND_EXEC
	echo OPT_FIND_DEBUG=$OPT_FIND_DEBUG
	echo OPT_FILE_ONLY=$OPT_FILE_ONLY
	echo ----------------------------------------
}



parseArgument()
{
	#
	#For each arguments
	#
	for i in "$@"
	do
		case $i in
			-h)
				showHelp
				exit
				;;

			-p=*|-profile=*)
				PROFILE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
				;;
				    
			-a=*|-androidpath=*)
				ANDROIDPATH=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
				#strip "/",for find compare
				ANDROIDPATH=${ANDROIDPATH%/}
				;;
			    
			-l=*|-linuxpath=*)
				LINUXPATH=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
				#strip "/",for find compare
				LINUXPATH=${LINUXPATH%/}
				;;
			    
			-f=*|-filter=*)
				FILTER=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
				;;
			    
			-D)
				OPT_FIND_DEBUG="-D tree"
				;;
			    
			-fileonly)
				OPT_FILE_ONLY=true
				;;
			    
			*)
				# unknown option
				echo "Unknown option : $i"
				echo "-h : Help"
				exit
				;;
		esac
	done
	
	#
	#For Profiles
	#
	case $PROFILE in
		android)
			LINUX_ARCH=arm
		    ;;
	    
	    linux)
	    	LINUX_ARCH=arm
		    ;;
	    
	    generic)
		    ;;
	    
	    ubuntu_ko)
	    	LINUX_ARCH=x86
	    	LINUXPATH=/lib/modules/$(uname -r)/build
	    	;;
	
		*)
			echo Unknown profile : $PROFILE
			exit
		    ;;
	esac
}

#$1 : Linux source directory
#$2 : Linux Platform , arm , x86 , etc...
genFileListLinux()
{
	echo "generating files for Linux...."
	find $FIND_OPT1 $OPT_FIND_DEBUG  $1 $FIND_OPT2				\
		\( \(								\
		-not -path "*/\.*"		  -and	 			\
		-not -path "$LINUXPATH/arch/*"    -and 				\
		-not -path "$LINUXPATH/tmp/*"     -and -not -path "$LINUXPATH/out/*" -and 	\
		-not -path "$LINUXPATH/scripts/*" -and -not -path "$LINUXPATH/HTML/*" 	\
		\) -or								\
		\(								\
		-path "$LINUXPATH/arch/$2*"					\
		\) \) -and							\
		\( $FILE_TYPE \)	$FIND_EXEC >> 	$OUT_FILE
		
}

genFileListAndroid()
{
	echo "generating files for Android...."
	find $FIND_OPT1 $OPT_FIND_DEBUG $1 $FIND_OPT2	\
		\( \(		\
		-not -path "*/\.*" 			-and \
		-not -path "$ANDROIDPATH/kernel-*/*"    -and  -not -path "$ANDROIDPATH/out/*"   -and \
		-not -path "$ANDROIDPATH/prebuilts/*"   -and  -not -path "$ANDROIDPATH/tools/*" -and \
		-not -path "$ANDROIDPATH/development/*" -and  -not -path "$ANDROIDPATH/ndk/*"   -and \
		-not -path "$ANDROIDPATH/sdk/*"         -and  -not -path "$ANDROIDPATH/docs/*"  -and  -not -path "$ANDROIDPATH/native-toolchain/*" -and \
		-not -path "$ANDROIDPATH/cts/*"         -and  -not -path "$ANDROIDPATH/developers/*" -and  \
		-not -path "$ANDROIDPATH/hardware/*"   	-and  -not -path "$ANDROIDPATH/external/*" \
		\) -or				\
		\(				\
		-path "$ANDROIDPATH/hardware/mediatek/*" -o -path "$ANDROIDPATH/hardware/libhardware/*" -o -path "$ANDROIDPATH/hardware/libhardware_legacy/*"	\
		\) \) -and 			\
		\( $FILE_TYPE \)	$FIND_EXEC >> 	$OUT_FILE
}

genFileListGeneric()
{
	echo "generating files for Generic...."
	find $FIND_OPT1 $OPT_FIND_DEBUG . $FIND_OPT2 \
		-not -path "*/\.*" \
		 \( $FILE_TYPE \) 	$FIND_EXEC >> 	$OUT_FILE
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
SCRIPT_NAME=$(basename $0)


#0. Setup
initVariable
parseArgument "$@"
showInfo

#1. reset file
echo > $OUT_FILE

#2. generating file list
case $PROFILE in
	android)
		genFileListLinux	$LINUXPATH $LINUX_ARCH
		genFileListAndroid	$ANDROIDPATH
		;;
    
	linux)
		genFileListLinux	$LINUXPATH $LINUX_ARCH
	    	;;
    
	generic)
		genFileListGeneric
	    	;;
    
	ubuntu_ko)
    		genFileListGeneric
		genFileListLinux	$LINUXPATH $LINUX_ARCH
    		;;
    
    	*)
		echo Unknown profile : $PROFILE
		exit
		;;
esac
	    
#3. filter
filterMtPlatform $FILTER

#4. build symbol
if [ $OPT_FILE_ONLY = true ]
then
	echo "Bypass cscope symbol generation."
else
	buildCscopeSymbol
fi
	    



