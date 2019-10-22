#!/bin/bash
#
# script to count induvidual files that make up the a particular Major Count .ie .."attachments_photos" count
#
# Inputs:
#       1. (Required) prefix file


# Maybe in the future add function to locate the files autoamtically..echo "Finding ATTACHMENT_PHOTOS.TXT and attachment_photos.txt"
#note for the matchml major count i had to change to use fgrep (due to the grep looking for range [])

#param #1
if [ -z "$1" ]
then
    echo -e "\nMissing parameter...exiting.\n"
    echo "How to use this script:"
    echo "./prefix_count_compare_tool.sh <prefixList1.txt> <BI2R_INPUT_FILE> <I2AR_INPUT_FILE> <outputfilename.txt>"
    echo -e "\nExample:"
    echo "./prefix_count_compare_tool.sh prefixList1.txt ATTACHMENTS_PHOTOS.TXT attachments_photos_compare.txt outputfilename.txt"
    echo -e "\n"
    exit 1;

else
    PREFIX_LIST=$1

fi


#param $2
if [ -z "$2" ]
then
    echo -e "\nMissing parameter \$2...exiting.\n"
    echo "How to use this script:"
    echo "./prefix_count_compare_tool.sh <prefixList1.txt> <BI2R_INPUT_FILE> <I2AR_INPUT_FILE> <outputfilename.txt>"
    echo -e "\nExample:"
    echo "./prefix_count_compare_tool.sh prefixList1.txt ATTACHMENTS_PHOTOS.TXT attachments_photos_compare.txt outputfilename.txt"
    echo -e "\n"
    exit 1;
else
    BI2R_INPUT_FILE=$2
fi
#param $3
if [ -z "$3" ]
then
    echo -e "\nMissing parameter \$3...exiting.\n"
    echo "How to use this script:"
    echo "./prefix_count_compare_tool.sh <prefixList1.txt> <BI2R_INPUT_FILE> <I2AR_INPUT_FILE> <outputfilename.txt>"
    echo -e "\nExample:"
    echo "./prefix_count_compare_tool.sh prefixList1.txt ATTACHMENTS_PHOTOS.TXT attachments_photos_compare.txt outputfilename.txt"
    echo -e "\n"
    exit 1;

else
    I2AR_INPUT_FILE=$3
fi

#param $4
if [ -z "$4" ]
then
    echo -e "\nMissing parameter \$4...exiting.\n"
    echo "How to use this script:"
    echo "./prefix_count_compare_tool.sh <prefixList1.txt> <BI2R_INPUT_FILE> <I2AR_INPUT_FILE> <outputfilename.txt>"
    echo -e "\nExample:"
    echo "./prefix_count_compare_tool.sh prefixList1.txt ATTACHMENTS_PHOTOS.TXT attachments_photos_compare.txt outputfilename.txt"
    echo -e "\n"
    exit 1;

else
    OUTPUT_FILE=$4
fi

#user message this may take some time depending on file size
echo "Working on it..may take some time depending on size of file.. hang tight.."

# function to grep using the prefix list (or should this funtion need to go line by line?)
function totalCount () {
        PREFIX_LIST=$1
        BI2R_INPUT_FILE=$2
        I2AR_INPUT_FILE=$3
        OUTPUT_FILE=$4
        #this is over kill.. gonna change it to just a simple cat $I2AR_INPUT_FILE | wc -l)
        #on second thought it was useful showing that matchml didn't match
        I2ARTotal="$(grep -Ff $PREFIX_LIST $I2AR_INPUT_FILE | wc -l)"
        BI2RTotal="$(grep -Ff $PREFIX_LIST $BI2R_INPUT_FILE | wc -l)"
        BASENAME="$(basename $3 .txt)"


        echo "Total Count for $BASENAME: BI2R:$BI2RTotal  I2ARTotal:$I2ARTotal" >>  $OUTPUT_FILE
}


#function to count each prefix in the file individually
function prefixCount () {
        PREFIX_LIST=$1
        BI2R_INPUT_FILE=$2
        I2AR_INPUT_FILE=$3
        OUTPUT_FILE=$4
        i=1
        COUNTER="$(cat $PREFIX_LIST | wc -l)"
        while (( i != (COUNTER+1)  ))
        do
        p="${i}p"
#Prefix count value for BI2R
        PREFIX_TYPE="$(cat $PREFIX_LIST | sed -n -e $p)"
        PREFIX_TYPE_COUNT_BI2R="$(cat $PREFIX_LIST | sed -n -e $p | xargs -i{} fgrep -i {} $BI2R_INPUT_FILE | wc -l)"

#Prefix count value for I2AR
        PREFIX_TYPE_COUNT_I2AR="$(cat $PREFIX_LIST | sed -n -e $p | xargs -i{} fgrep -i {} $I2AR_INPUT_FILE | wc -l)"
        echo "$PREFIX_TYPE BI2R:$PREFIX_TYPE_COUNT_BI2R  I2AR:$PREFIX_TYPE_COUNT_I2AR" >> $OUTPUT_FILE
        ((i=i+1))
        # added just to test the value of echo "$i"
    done

}

# run stuff
totalCount $PREFIX_LIST  $BI2R_INPUT_FILE $I2AR_INPUT_FILE $OUTPUT_FILE
prefixCount $PREFIX_LIST $BI2R_INPUT_FILE $I2AR_INPUT_FILE $OUTPUT_FILE

echo
echo -e "Done processing: [ $PREFIX_LIST | $BI2R_INPUT_FILE | $I2AR_INPUT_FILE ] >> $OUTPUT_FILE"
echo -e "See $OUTPUT_FILE for the results.\n"

exit 0;
