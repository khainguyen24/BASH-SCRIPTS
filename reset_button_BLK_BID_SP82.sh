#!/bin/bash
#just adding some comments into this file from ATOM
# backing up all the files after BLK bid ingest.. ie hitting the "reset button"
#


# param
#Check to see if $1 parameter was specified the 7th column was specified as the awk pattern to use in the script"

if [ -z "$1" ]
then
    echo -e "\nMissing parameter...exiting.\n"
    echo "How to use this script:"
    echo "./reset_button_BLK_BID_SP82.sh <the 2 digit day format \"DD\"> <SP*#>"
    echo -e "\nExample:"
    echo "./reset_button_BLK_BID_SP82.sh 15 SP82"
    echo -e "\n"
    exit 1;

else

    DATE_VALUE=$1
fi

##Check to see if $2 parameter was specified. required.. ie "SP82"
if [ -z "$2" ]
then
    echo -e "\nMissing parameter...exiting.\n"
    echo "How to use this script:"
    echo "./reset_button_BLK_BID_SP82.sh <the 2 digit day format \"DD\"> <SP*#>"
    echo -e "\nExample:"
    echo "./reset_button_BLK_BID_SP82.sh 15 SP82"
    echo -e "\n"
    exit 1;

else

    BUILD_NUMBER=$2
    BACKUP_STRING='_Blk_Bid_post-processing_backup'
    BACKUP_DIR="$BUILD_NUMBER$BACKUP_STRING"
    BASE_DIR=/root/my_fedora_folder/
fi

date="$(date +%F)"



# move all the files created that day

function backup_BLK_BID_Post_processing () {
	DATE_VALUE=$1
	BUILD_NUMBER=$2
    BACKUP_STRING='Blk_Bid_post-processing_backup_'
    BACKUP_DIR="$BACKUP_STRING${BUILD_NUMBER}_${date}"
    echo $DATE_VALUE
	echo $BUILD_NUMBER
	echo $BACKUP_STRING
	echo $BACKUP_DIR
# creating backup dir(update with the correct path to the post-processing files) with appeded build and date
  mkdir -p /root/my_fedora_folder/$BACKUP_DIR
  FULL_PATH_DIR="$BASE_DIR${BACKUP_DIR}/"
	#ll /var/i2ar/temp_khai/ | awk -v DATE_VALUE="$DATE_VALUE" -v BACKUP_DIR="$BACKUP_DIR" '$7=={print DATE_VALUE}{print "mv",$9,"/var/webadmin/automated_Import_Scripts/{print BACKUP_DIR}"}' | sh -x
	#ls -l /var/i2ar/temp_khai/ | grep -i -Z -r -l '${DATE_VALUE}' | xargs -I{} mv {} /var/webadmin/automated_Import_Scripts/${BACKUP_DIR}
  # ll | awk '$7==15{print "cp -rp" , $9 , "/root/my_fedora_folder/post-processing-bak"}' (this worked on the command line.. need to add the | sh -x to make it stick)
  # ls -l /var/i2ar/temp_khai/ | grep -i -Z -r -l '${DATE_VALUE}' | xargs -I{} mv {} /var/webadmin/automated_Import_Scripts/${BACKUP_DIR}
  # worked! ls -l /root/my_fedora_folder/DV-53-majorCount/* | awk '$7==15{print "cp" , $9 , "/root/my_fedora_folder/Blk_Bid_post-processing_backup_SP82_2019-10-25"}' | sh -x
ls -l "/root/my_fedora_folder/DV-53-majorCount/"* | awk -v DATE_VALUE="$DATE_VALUE" -v BASE_DIR="$BASE_DIR" -v FULL_PATH_DIR="$FULL_PATH_DIR" -v BACKUP_DIR="$BACKUP_DIR" '$7==DATE_VALUE{ print  "cp -rp", $9 ,FULL_PATH_DIR}' | sh -x
  sleep 1

}

#Run stuff
backup_BLK_BID_Post_processing $DATE_VALUE $BUILD_NUMBER
echo "all done.. BLK BID post processing files backed up to: /root/my_fedora_folder/$BACKUP_DIR"

exit 0;
