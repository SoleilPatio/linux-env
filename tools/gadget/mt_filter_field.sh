#!/bin/bash
echo $0 header_keyword file index1 [index2 index3 ....]
echo $#
count=$[$#-2]
echo count=$count

if [ $count -le 0 ]
    then
    echo Exit!
    exit
    fi

echo -----------------------------------------------------------

if   [ $count -eq 1 ]
    then
    awk -F "," -v F1=$3 '{ if(/'"$1"'/) {print $F1 }  }' $2
elif [ $count -eq 2 ]
    then
    awk -F "," -v F1=$3 -v F2=$4 '{ if(/'"$1"'/) {print $F1","$F2 }  }' $2
elif [ $count -eq 3 ]
    then
    awk -F "," -v F1=$3 -v F2=$4 -v F3=$5 '{ if(/'"$1"'/) {print $F1","$F2","$F3 }  }' $2
elif [ $count -eq 4 ]
    then
    awk -F "," -v F1=$3 -v F2=$4 -v F3=$5 -v F4=$6 '{ if(/'"$1"'/) {print $F1","$F2","$F3","$F4 }  }' $2
elif [ $count -eq 5 ]
    then
    awk -F "," -v F1=$3 -v F2=$4 -v F3=$5 -v F4=$6 -v F5=$7 '{ if(/'"$1"'/) {print $F1","$F2","$F3","$F4","$F5 }  }' $2
fi

