#!/bin/bash
echo $0 header_keyword file
awk -F "," '{if(/'"$1"'/) { for( x=1; x <= NF ; x++ ){ print x":"$x } } }' $2
