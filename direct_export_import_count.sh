#!/bin/bash
# script to count the BI2R pre-split data type file .ie .."attachments" and a file count for I2AR post-split

# Script takes these required inputs parameters:
#       1. (Required) filename for BI2R pre-split data type
#       2. (Required) directory name that holds the post-split individual files for the data type.




#function to display Optional HELP MENU
#### HELP MENU OPTION START ##############################################################################
echo
function display_help_menu() {
	echo -e "
      \nThis script takes these required inputs parameters and will search both the BI2R Export and
      I2AR Import directory passed into it.
#       1. (Required) BI2R Export directory name (check Appendix A)
#       2. (Required) I2AR Import directory name (check Appendix B)
#
#      How to use this script:
       ./direct_export_import_count.sh <BI2R export directory - Appendix A> <I2AR archived directory - Appendix B>

       Example:
      ./direct_export_import_count.sh twpdes twpdes

#      Using the Appendix below to locate the Export and Import directories
#      NOTE: This Script will not work on the export's \"attachments\" directory cause i haven't figures out where it maps to just yet.
#      Also will not work on subdirectories that have the same names ..ie. \"attachments\" \"drivers\" you get the point.
#      Will not work on BI2R Export files that require \"SPLIT\".. note to self add an \"*\" to the ones that require \"SPLIT\"
#      Use the \"split_file_count.sh\" script for that.

*****************************************************
**** APENDIX A - BI2R Export Directory Structure ****
*****************************************************
├── aims
│   ├── AIM1
│   └── IMG1
├── aims_additional_data
├── atpDetails
├── attachments
│   └── IMG1
├── attributes
├── bat_attachments
│   └── ATT_2_1
├── batcxi_attachments
│   └── ATT_JOB3_1
├── batcxi_photos
│   └── IMG_JOB3_1
├── batcxiRptAnalystNotes
├── batcxi_rr_attachments
│   └── attachments
│       ├── ACT1
│       ├── EVT1
│       ├── FAC1
│       ├── INTR1
│       ├── ORG1
│       ├── PROJ1
│       ├── RFI1
│       ├── RPT1
│       ├── RQT1
│       ├── TACT1
│       ├── TECH1
│       └── TPORT1
├── batcxi_rr_photos
│   └── COMM1
├── batcxi_xml
│   ├── DB1
│   ├── TH_JOB0_1
│   └── UP1
├── bat_photos
│   └── IMG_1_1
├── batRptAnalystNotes
├── bat_rr_attachments
│   └── attachments
│       ├── ACT1
│       ├── EVT1
│       ├── FAC1
│       ├── INTR1
│       ├── ORG1
│       ├── PROJ1
│       ├── TACT1
│       ├── TECH1
│       └── TPORT1
├── bat_rr_photos
│   └── INTR1
├── bat_xml
│   ├── DB1
│   ├── TH_JOB0_1
│   └── UP1
├── bewl
├── bewl_history
├── bi2r-j
│   └── bi2r-sensors
│       └── UA1
├── bi2r-s
│   ├── abis-attachments
│   │   └── IMG_JOB1_1
│   ├── abis-sensors
│   │   ├── MF1
│   │   └── MM1
│   ├── bi2r-attachments
│   │   └── IMG_JOB1_1
│   ├── bi2r-sensors
│   │   └── UA1
│   ├── i2d-attachments
│   │   └── IMG_JOB1_1
│   ├── i2d-sensors
│   │   └── MF1
│   ├── ss-attachments
│   └── ss-sensors
│       └── MF1
├── bids
├── datamasking_rules
├── deconfliction_trackers
├── efts_attachments
│   └── ATT_4_1
├── encounters
│   └── UA1
├── events
│   ├── attachments
│   │   └── ATT1
│   ├── comments
│   │   └── COM1
│   ├── encounters
│   │   └── ENC1
│   └── EVT1
├── export_lists
├── harmony
├── identityCrosslinks
├── identityHistory
├── identityMasks
├── identityMerges
├── identityRelationships
├── idml
│   └── IDML1
├── link_transactions
├── lov
│   ├── agency_data
│   ├── attribute
│   └── bewl
├── matchml_bid
│   ├── bi2r-j
│   │   └── bi2r-sensors
│   └── bi2r-s
│       ├── abis-sensors
│       │   └── MF1
│       ├── bi2r-sensors
│       ├── i2d-sensors
│       │   └── MF1

*****************************************************
**** APENDIX B - I2AR Import Directory Structure ****
*****************************************************
├── aims
│   ├── attachments
│   │   ├── AIM1
│   │   └── IMG1
│   └── drivers
│       ├── AIM1
│       └── IMG1
├── aims_additional_data
│   ├── <files within subdirectories>
├── atpDetails
│   ├── <files within subdirectories>
├── attributes
│   ├── <files within subdirectories>
├── bat_attachments
│   ├── attachments
│   │   └── ATT_2_1
│   └── drivers
│       └── ATT_2_1
├── batcxi_attachments
│   ├── attachments
│   │   └── ATT_JOB3_1
│   └── drivers
│       └── ATT_JOB3_1
├── batcxi_photos
│   ├── attachments
│   │   └── IMG_JOB3_1
│   └── drivers
│       └── IMG_JOB3_1
├── batcxi_rr_attachments
│   ├── attachments
│   │   ├── ACT1
│   │   ├── EVT1
│   │   ├── FAC1
│   │   ├── INTR1
│   │   ├── ORG1
│   │   ├── PROJ1
│   │   ├── RFI1
│   │   ├── RPT1
│   │   ├── RQT1
│   │   ├── TACT1
│   │   ├── TECH1
│   │   └── TPORT1
│   └── drivers
│       ├── ACT1
│       ├── EVT1
│       ├── FAC1
│       ├── INTR1
│       ├── ORG1
│       ├── PROJ1
│       ├── RFI1
│       ├── RPT1
│       ├── RQT1
│       ├── TACT1
│       ├── TECH1
│       └── TPORT1
├── batcxi_rr_photos
│   ├── attachments
│   │   └── COMM1
│   └── drivers
│       └── COMM1
├── batcxi_xml
│   ├── DB1
│   ├── TH_JOB0_1
│   └── UP1
├── bat_photos
│   ├── attachments
│   │   └── IMG_1_1
│   └── drivers
│       └── IMG_1_1
├── bat_rr_attachments
│   ├── attachments
│   │   ├── ACT1
│   │   ├── EVT1
│   │   ├── FAC1
│   │   ├── INTR1
│   │   ├── ORG1
│   │   ├── PROJ1
│   │   ├── TACT1
│   │   ├── TECH1
│   │   └── TPORT1
│   └── drivers
│       ├── ACT1
│       ├── EVT1
│       ├── FAC1
│       ├── INTR1
│       ├── ORG1
│       ├── PROJ1
│       ├── TACT1
│       ├── TECH1
│       └── TPORT1
├── bat_rr_photos
│   ├── attachments
│   │   └── INTR1
│   └── drivers
│       └── INTR1
├── bat_xml
│   ├── DB1
│   ├── TH_JOB0_1
│   └── UP1
├── bi2r-j
│   └── bi2r-sensors
│       └── UA1
├── bi2r-s
│   ├── abis-attachments
│   │   └── IMG_JOB1_1
│   ├── abis-sensors
│   │   ├── MF1
│   │   └── MM1
│   ├── bi2r-attachments
│   │   └── IMG_JOB1_1
│   ├── bi2r-sensors
│   │   └── UA1
│   ├── i2d-attachments
│   │   └── IMG_JOB1_1
│   ├── i2d-sensors
│   │   └── MF1
│   └── ss-sensors
│       └── MF1
├── efts_attachments
│   ├── attachments
│   │   └── ATT_4_1
│   └── drivers
│       └── ATT_4_1
├── encounters
│   └── UA1
├── eventAttachments
│   ├── attachments
│   │   └── ATT1
│   └── drivers
│       └── ATT1
├── eventComments
│   └── COM1
├── eventEncounters
│   └── ENC1
├── events
│   └── EVT1
├── harmony
│   └── <files within subdirectories>
├── identity_comments
│   ├── <files within subdirectories>
├── identityCrosslinks
│   ├── <files within subdirectories>
├── identityEdits-identity_merge
│   ├── <files within subdirectories>
├── identityEdits-identity_relationships
│   ├── <files within subdirectories>
├── identityMasks
│   ├── <files within subdirectories>
├── identitySetPrimary-name
│   └── <files within subdirectories>
├── identitySetPrimary-photo
│   └── <files within subdirectories>
├── link_transactions
├── product
│   ├── attachments
│   │   └── PROD1
│   └── drivers
│       └── PROD1
├── product_attachments
│   ├── attachments
│   │   └── PRODATT1
│   └── drivers
│       └── PRODATT1
├── related_reports
│   ├── AC1
│   ├── COM1
│   ├── EV1
│   ├── FAC1
│   ├── INTN1
│   ├── ORG1
│   ├── PROD1
│   ├── PROJ1
│   ├── REQ1
│   ├── RFI1
│   ├── TECH1
│   ├── TRNS1
│   └── TRNSP1
├── rir
│   └── RIR1
├── socom
│   ├── <files within subdirectories>
├── twpdes
│   └── TWP1
├── twpdes_deletes
├── uhn
│   └── UHN1
├── userAddedAttachments
│   ├── attachments
│   │   └── IMG1
│   └── drivers
│       └── IMG1
├── userAddedPhotos
│   ├── attachments
│   │   └── IMG1
│   └── drivers
│       └── IMG1
├── uspTrackerData
│   ├── <files within subdirectories>
├── watchlistEntries-bewl
│   └── <files within subdirectories>
├── watchlistEntries-bewl_history
│   ├── <files within subdirectories>
└── watchlistEntries-bewl_history-deletes
    └── <files within subdirectories>

"
}

HELP_MENU=$(display_help_menu)
# Getopts option menu for display the HELP MENU with "-h"
while getopts "hf:" OPTION
do
	case $OPTION in
		h)
			echo "***************************************************"
			echo "      HELP MENU: direct_export_import_count.sh      "
			echo "***************************************************"
			echo "$HELP_MENU"
			echo "***************************************************"
			echo "                   - END -                          "
			echo "***************************************************"
			exit
			;;
		\?)
			echo "Used -h for the help menu"
			exit
			;;
	esac
done

#### HELP MENU OPTION END ##############################################################################







#parameters check (Script calls for 2 parameters to be passed in)
if [ "$#" -ne 2 ]
then
    echo -e "\nMissing parameter...exiting. NOTE: Use the -h flag to see the help menu and Appendix A and B\n"
    echo "How to use this script:"
    echo "./direct_export_import_count.sh <BI2R export directory - Appendix A> <I2AR archived directory - Appendix B>"
    echo -e "\nExample:"
    echo -e "./direct_export_import_count.sh twpdes twpdes\n"
    echo -e "NOTE: Will not work on BI2R Export files that require \"SPLIT\" Use the \"split_file_count.sh\" script for that."
    echo -e "\n"
    exit 1;

else
    BI2R_EXPORT=$1
    I2AR_IMPORT=$2
    sleep 1
    #echo "$BI2R_EXPORT"
    #echo "$I2AR_IMPORT"

fi


#funtion to get the counts

function GET_COUNTS () {
  BI2R_EXPORT=$1
  I2AR_IMPORT=$2
  #set the BIR path to files
  echo
  echo -e "************************ \e[32mRESULTS: BI2R EXPORT vs. I2AR IMPORT\e[0m *********************************"
  echo "***********************************************************************************************"
  BI2R_EXPORT_FILE_PATH="$(find /var/temp/20* -type d -name $BI2R_EXPORT -print -quit)"
  BIR_EXPORT_COUNT="$(find $BI2R_EXPORT_FILE_PATH -type f | wc -l)"
  echo "BI2R Export Count: [$BIR_EXPORT_COUNT] for \"$BI2R_EXPORT_FILE_PATH\""
  #set the I2AR path to the directory
  I2AR_IMPORT_ARCHIVE_DIR_PATH="$(find /var/i2ar/archive/ -type d -name $I2AR_IMPORT)"
  I2AR_IMPORT_FILE_COUNT="$(find $I2AR_IMPORT_ARCHIVE_DIR_PATH -type f | wc -l)"
  echo "I2AR Import Count: [$I2AR_IMPORT_FILE_COUNT] for \"$I2AR_IMPORT_ARCHIVE_DIR_PATH\""
}

# Run STUFF

GET_COUNTS $BI2R_EXPORT $I2AR_IMPORT
echo "All done! if the counts are off check the error or duplicate directories."
