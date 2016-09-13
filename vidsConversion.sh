#!/bin/bash
# Shell script to generate bash lines re encode h264 vids using ffmpeg on windows
# 
# input: formatted CSV file from amennet xls. format is: 
# account_num; Date_operation;Description;number_piece;Date_value;debit;credit
# output QIF file for winancial
# 

if [ $# -lt 1 ] ; then
    echo "Usage: $0 vidsToConvert.txt"
    echo output is : convertVids.bat²:w
    exit 0
fi

INPUT_FILE=$1
FFMPEG="ffmpeg.exe"
inputVid=""
outputVid=""
	

while read -r inputVid ; do
	#echo $inputVid
	outputVid="${inputVid%.*}"
	outputVid=$outputVid.mkv
	#echo $outputVid
	echo $FFMPEG -i \"$inputVid\" -c:v libx264 -preset veryfast \"$outputVid\" 
	echo DEL \"$inputVid\" >> vidsToDelete.bat


done < "$INPUT_FILE"

echo Done!
exit 1
