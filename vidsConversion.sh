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

debug = 0
INPUT_FILE=$1
FFMPEG="ffmpeg.exe"
inputVid=""
outputVid=""
	

while read -r inputVid ; do
	echo $inputVid
	outputVid="${inputVid%.*}"
	outputVid=$outputVid.mkv
	echo $outputVid
done < "$INPUT_FILE"


if [[ $debug == 1 ]]; then 

	FORMATTED_QIF=$2

	FORMATTED_QIF=$(basename "$DEFAULT_CSV")
	FORMATTED_QIF="${FORMATTED_QIF%.*}"
	FORMATTED_QIF=$FORMATTED_QIF.qif
	echo "$FORMATTED_QIF"

	echo "Converting $DEFAULT_CSV, writing to $FORMATTED_QIF"

	#format csv file to have "|" as separator with take care of the comma inside quotes
	awk -F'"' '{gsub(/,/,"|",$1);gsub(/,/,"|",$3);} 1' $DEFAULT_CSV > temp_formatted.csv

	DEFAULT_CSV=temp_formatted.csv
	export IFS="|"

	cat $DEFAULT_CSV | while read account_num date_op description num date_val debit credit 
	do 
	   echo "D$date_op" >> $FORMATTED_QIF
	   echo "M$description" >> $FORMATTED_QIF
	   echo "N$num" >> $FORMATTED_QIF
	   if [ $debit ] ; then 
	      echo "T-$debit" | sed -e "s/ //g" >> $FORMATTED_QIF #this sed is used to erase the space left on the inside quote value
	   else
	      echo "T$credit" | sed -e "s/ //g" >> $FORMATTED_QIF
	   fi 
	   echo "^" >> $FORMATTED_QIF
	done

	rm temp_formatted.csv

echo Done!
exit 1
