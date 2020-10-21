#!/bin/bash
# script to count the BI2R pre-split data type file .ie .."attachments" and a file count for I2AR post-split

# Script takes these required inputs parameters:
#       1. (Required) filename for BI2R pre-split data type
#       2. (Required) directory name that holds the post-split individual files for the data type.
#       3. If the BI2R export file is more than one file then use a wild card to include all the files into the count i.e. identity_attribute_export_*.xml

# Change log
# 3/12/2020 - updated the APENDIX A and B (added new data type that are now exported and ingested) Updated the help menu with a TIP.
# 6/02-2020 - updated APENDIX A and B for SP94 and updated example for including multiple BIR Export files in a single count

#### HELP MENU OPTION START ##############################################################################
echo
function display_help_menu() {
	echo -e "
      \nThis script takes these required inputs parameters and will count the pre-split BI2R Export file and the post-split
      I2AR Import directory passed into it.
#       1. (Required) BI2R pre-split filename (check Appendix A)
#       2. (Required) I2AR post-split root directory containing the post-split files (check Appendix B)
#       3. If the BI2R export file is more than one file then use a wild card to include all the files into the count i.e. identity_attribute_export_*.xml
#
#      How to use this script:
       ./split_file_count.sh <BI2R pre-split data type file(s) - Appendix A> <I2AR directory containing the post-split files - Appendix B>

       Example:
      ./split_file_count.sh identity_attribute_export_*.xml attributes

			TIP: to display just the pre-split files and the post-split subdirectories
			./split_file_count.sh -h | grep \*

			NOTE: For data types that are directly ingested (do not require splitting)... Use the "direct_export_import_count.sh"
#      Using the Appendix below to locate the pre-split data type file within the Export.
#      Locate the root Import directory containing the post-split files and directories
#      Note: files that require split is denoted with an asterisk *

\e[32m*****************************************************
**** APENDIX A - BI2R Export Directory Structure ****
*****************************************************
├── aims
│   ├── AIM1
│   └── IMG1
├── aims_additional_data
│   └── aims_additional_data_export_*.xml *
├── atpDetails
│   └── identity_atp_score_export_*.xml *
├── attachments
│   └── IMG1
├── attributes
│   └── identity_attribute_export_*.xml *
├── bat_attachments
│   └── ATT_2_1
├── batcxi_attachments
│   └── ATT_JOB3_1
├── batcxi_photos
│   ├── IMG_JOB3_1
│   └── IMG_JOB3_2
├── batcxi_rr_attachments
│   └── attachments
│       ├── ACT1
│       ├── EVT1
│       ├── FAC1
│       ├── INTR1
│       ├── MAT1
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
│   ├── TH_JOB0_10
│   ├── TH_JOB0_11
│   ├── TH_JOB0_2
│   ├── TH_JOB0_3
│   ├── TH_JOB0_4
│   ├── TH_JOB0_5
│   ├── TH_JOB0_6
│   ├── TH_JOB0_7
│   ├── TH_JOB0_8
│   ├── TH_JOB0_9
│   └── UP1
├── bat_photos
│   ├── IMG_1_1
│   └── IMG_1_2
├── batRptAnalystNotes
│   └── bat_rpt_analystnotes_export.xml * (not ready for ingest)
├── bat_rr_attachments
│   └── attachments
│       ├── ACT1
│       ├── COM1
│       ├── EVT1
│       ├── FAC1
│       ├── IGT1
│       ├── INTR1
│       ├── MAT1
│       ├── ORG1
│       ├── PROD1
│       ├── PROJ1
│       ├── RFI1
│       ├── RPT1
│       ├── RQT1
│       ├── TACT1
│       ├── TECH1
│       └── TPORT1
├── bat_rr_photos
│   ├── COM1
│   ├── EVT1
│   ├── FAC1
│   ├── INTR1
│   ├── MAT1
│   ├── ORG1
│   ├── PROD1
│   ├── PROJ1
│   ├── RPT1
│   ├── TECH1
│   └── TPORT1
├── bat_xml
│   ├── DB1
│   ├── TH_JOB0_1
│   ├── TH_JOB0_10
│   ├── TH_JOB0_11
│   ├── TH_JOB0_2
│   ├── TH_JOB0_3
│   ├── TH_JOB0_4
│   ├── TH_JOB0_5
│   ├── TH_JOB0_6
│   ├── TH_JOB0_7
│   ├── TH_JOB0_8
│   ├── TH_JOB0_9
│   └── UP1
├── bewl
│   └── bewl_export_data_*.xml *
├── bewl_cr
│   └── bewl_cr_export_data_*.xml *
├── bewl_cr_history
│   └── bewl_cr_history_export_data_*.xml *
├── bewl_history
│   ├── bewl_history.xml *
│   └── bewl_delete_history_record_*.xml *
├── bi2r-j (by default contains ‘MatchML by Bids’)
│   ├── bi2r-attachments
│   ├── bi2r-sensors
│   │   └── MF1
│   ├── jj-sensors
│   │   └── MF1
│   ├── ss-attachments
│   │   └── IMG_JOB1_1
│   └── ss-sensors
│       └── MF1
├── bi2r-s (by default contains ‘MatchML by Bids’)
│   ├── abis-attachments
│   │   ├── IMG_JOB1_1
│   │   ├── IMG_JOB1_10
│   ├── abis-sensors
│   │   ├── MF1
│   │   └── MF93
│   ├── bi2r-attachments
│   │   └── IMG_JOB1_1
│   ├── bi2r-sensors
│   │   └── MF1
│   ├── DHS-sensors
│   │   └── MF1
│   ├── I2D-attachments
│   │   └── IMG_JOB1_1
│   ├── I2D-sensors
│   │   └── MF1
│   ├── ss-attachments
│   └── ss-sensors
│       └── MF1
├── bids
│   └── bid_mapping_export_*.xml <file split-up in to multiple files>
├── datamasking_rules
│   └── masking-rules.xml
├── deconflict_attachments
│   ├── attachments
│   └── drivers
├── efts_attachments
│   └── <files within subdirectories>
├── encounters
│   └── UA1
├── events
│   ├── attachments (AttachmentInfo types)
│   │   └── ATT1
│   ├── comments (SourceComment types)
│   │   └── COM1
│   ├── encounters (GroupMembership types)
│   │   ├── ENC1
│   ├── EVT1 (EVT subdirectories are GroupInfo types)
├── export_lists (contains BIR count files)
├── harmony
│   └── harmony_links_data_export_*.xml *
├── identityCrosslinks
│   └── identity_crosslink_export_*.xml *
├── identityHistory
│   └── identity_history_export_*.xml *
├── identityMasks
│   └── identity_mask_data_export.xml *
├── identityMerges
│   └── identity_link_export.xml *
├── identityRelationships
│   └── identity_relationship_export.xml *
├── idml
│   └── <files within subdirectories>
├── link_transactions
│   └── link_logging_export.xml
├── lov
│   ├── agency_data (agencyOriMap.xml)
│   ├── attribute (various TEXT,DATE,GEOLOC,LIST xml config files)
│   ├── bewl (various config files)
│   └── event_types (event_types.xml)
├── misc
│   ├── blacklist_data_export.xml
│   └── blacklist_link_data.xml
├── mml-archive (contains 'Normal' matchML)
│   ├── bi2r-j
│   │   ├── abis-sensors
│   │   │   └── DS1
│   │   ├── bi2r-sensors
│   │   │   └── UA1
│   │   ├── jj-sensors
│   │   │   ├── DS1
│   │   │   └── MF1
│   │   └── ss-sensors
│   └── bi2r-s
│       ├── abis-sensors
│       │   ├── DS1
│       │   └── MM1
│       ├── bi2r-sensors
│       │   └── UA1
│       ├── DHS-sensors
│       │   └── MF1
│       ├── I2D-sensors
│       │   └── MF1
│       └── ss-sensors
│           ├── DS1
│           ├── MF1
│           └── MM1
├── nonsensor_matchml
│   ├── rir
│   │   └── RIR1
│   └── uhn
│       └── UHN1
├── photos
│   └── IMG1
├── primaryName
│   └── identity_primary_name_export.xml *
├── primaryPhoto
│   └── identity_primary_photo_export.xml *
├── product
│   ├── PROD1
│   └── PROD2
├── product_attachments
│   └── PRODATT1
├── related_reports
│   ├── AC1
│   ├── AC2
│   ├── AC3
│   ├── CE1
│   ├── COM1
│   ├── COM2
│   ├── EV1
│   ├── EV2
│   ├── FAC1
│   ├── FAC2
│   ├── INTN1
│   ├── INTN2
│   ├── INTR1
│   ├── INTR2
│   ├── MRR1
│   ├── ORG1
│   ├── PROD1
│   ├── PROD2
│   ├── PROJ1
│   ├── PROJ2
│   ├── REQ1
│   ├── REQ2
│   ├── RFI1
│   ├── RFI2
│   ├── RPT1
│   ├── RPT2
│   ├── TECH1
│   ├── TECH2
│   ├── TRNS1
│   ├── TRNS2
│   ├── TRNSP1
│   └── TRNSP2
├── socom
│   └── socom_export.xml *
├── sourceComments
│   └── identity_comments_data_export.xml *
├── spreadsheet_history
│   ├── ATT1
│   ├── EVT1
│   ├── MRI1
│   └── WLI1
├── twpdes
│   ├── TWP1
│   ├── TWP2
│   └── TWP3
├── twpdes_deletes
│   └── twpdes_deletes_export.xml
├── userSettings
│   └── user_preference_export.xml
├── usp_rfi
│   └── usp_rfi_data_export.xml
├── usp_rules
│   └── usp_rules_export.xml
├── uspTrackerData
│   └── us_person_data.xml *
└── work_notes
    ├── bewl
    │   └── WNWL_JOB0_1
    ├── bewl_hits
    │   └── WNWLH_JOB0_1
    ├── deconflict
    └── usp
        └── WNU_JOB0_1

 \e[0m

\e[35m*****************************************************
**** APENDIX B - I2AR Import Directory Structure ****
*****************************************************
├── aims
│   ├── attachments
│   │   ├── AIM1
│   │   └── IMG1
│   └── drivers
│       ├── AIM1
│       └── IMG1
├── aims_additional_data *
│   └── <files within subdirectories>
├── atpDetails *
│   └── <files within subdirectories>
├── attributes *
│   └──  <files within subdirectories>
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
│   └── IMG_JOB3_1 (folder now includes both attachments and drivers)
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
│   └── COMM1 (folder now includes both attachments and drivers)
├── batcxi_xml
│   ├── DB1
│   ├── TH_JOB0_1
│   └── UP1
├── bat_photos
│   └── IMG_1_1 (folder now includes both attachments and drivers)
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
│   ├── COM1
│   ├── EVT1
│   ├── FAC1
│   ├── INTR1
│   ├── MAT1
│   ├── ORG1
│   ├── PROD1
│   ├── PROJ1
│   ├── RPT1
│   ├── TECH1
│   └── TPORT1
├── bat_xml
│   ├── DB1
│   ├── TH_JOB0_1
│   ├── TH_JOB0_10
│   ├── TH_JOB0_11
│   ├── TH_JOB0_2
│   ├── TH_JOB0_3
│   ├── TH_JOB0_4
│   ├── TH_JOB0_5
│   ├── TH_JOB0_6
│   ├── TH_JOB0_7
│   ├── TH_JOB0_8
│   ├── TH_JOB0_9
│   └── UP1
├── bi2r-j (by default contains ‘MatchML by Bids’)
│   ├── bi2r-sensors
│   │   └── MF1
│   ├── jj-sensors
│   │   └── MF1
│   ├── ss-attachments
│   │   └── IMG_JOB1_1
│   └── ss-sensors
│       └── MF1
├── bi2r-s (by default contains ‘MatchML by Bids’)
│   ├── abis-attachments
│   │   └── IMG_JOB1_1
│   ├── abis-sensors
│   │   └── MF1
│   ├── bi2r-attachments
│   │   └── IMG_JOB1_1
│   ├── bi2r-sensors
│   │   └── MF1
│   ├── I2D-attachments
│   │   └── IMG_JOB1_1
│   ├── I2D-sensors
│   │   └── MF1
│   ├── ss-attachments
│   │   └── IMG_JOB1_1
│   └── ss-sensors
│       └── MF1
├── efts_attachments
│   └──  <files within subdirectories>
├── encounters
│   └── UA1
├── eventAttachments
│   ├── attachments
│   └── drivers
├── eventComments
│   └── COM1
├── eventEncounters
│   └──  <files within ENC subdirectories>
├── events
│   └──  <files within EVT subdirectories>
├── harmony *
│   └── <files within subdirectories>
├── identity_comments *
│   └── <files within subdirectories>
├── identityCrosslinks
│   └── <files within subdirectories>
├── identityEdits-identity_merge *
│   └── <files within subdirectories>
├── identityEdits-identity_relationships *
│   └── <files within subdirectories>
├── identityHistory *
│   └── <files within subdirectories>
├── identityMasks *
│   └── <files within subdirectories>
├── identitySetPrimary-name *
│   └── <files within subdirectories>
├── identitySetPrimary-photo *
│   └── <files within subdirectories>
├── link_transactions
├── mml-archive
│   ├── bi2r-j
│   │   ├── abis-sensors
│   │   │   └── DS1
│   │   ├── bi2r-sensors
│   │   │   └── UA1
│   │   └── jj-sensors
│   │       ├── DS1
│   │       └── MF1
│   └── bi2r-s
│       ├── abis-sensors
│       │   ├── DS1
│       │   ├── MF1
│       │   └── MM1
│       ├── bi2r-sensors
│       │   └── UA1
│       └── ss-sensors
│           ├── DS1
│           └── MF1
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
│   ├── AC2
│   ├── AC3
│   ├── CE1
│   ├── COM1
│   ├── COM2
│   ├── EV1
│   ├── EV2
│   ├── FAC1
│   ├── FAC2
│   ├── INTN1
│   ├── INTN2
│   ├── INTR1
│   ├── INTR2
│   ├── MRR1
│   ├── ORG1
│   ├── PROD1
│   ├── PROD2
│   ├── PROJ1
│   ├── PROJ2
│   ├── REQ1
│   ├── REQ2
│   ├── RFI1
│   ├── RFI2
│   ├── RPT1
│   ├── RPT2
│   ├── TECH1
│   ├── TECH2
│   ├── TRNS1
│   ├── TRNS2
│   ├── TRNSP1
│   └── TRNSP2
├── rir
│   └── RIR1
├── socom *
│   ├── JM
│   └── JQ
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
│   └── IMG1
├── uspTrackerData *
│   └── <files within subdirectories>
├── watchlist-changeRequests *
│   └── <files within subdirectories>
├── watchlist-changeRequests_history *
│   └── <files within subdirectories>
├── watchlistEntries-bewl *
│   └── <files within subdirectories>
├── watchlistEntries-bewl_history *
│   └── <files within subdirectories>
└── watchlistEntries-bewl_history-deletes *
    └── <files within subdirectories>

\e[0m
"
}

HELP_MENU=$(display_help_menu)
# Getopts option menu for display the HELP MENU with "-h"
while getopts "hf:" OPTION
do
	case $OPTION in
		h)
			echo "***************************************************"
			echo "      HELP MENU: split_file_count.sh      "
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
    echo "./split_file_count.sh <BI2R pre-split data type file> <I2AR directory containing the post-split files>"
    echo -e "\nExample:"
    echo "./split_file_count.sh identity_attribute_export_*.xml attributes"
    echo -e "\n"
		echo -e "TIP: to display just the pre-split files and the post-split subdirectories"
		echo -e "./split_file_count.sh -h | grep \*"
		echo -e "\n"
		echo -e "NOTE: For data types that are directly ingested (do not require splitting)... Use the \"direct_export_import_count.sh\""
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

function GET_SPLIT_COUNTS () {
  BI2R_EXPORT=$1
  I2AR_IMPORT=$2
  #set the BIR path to files
  echo
  echo -e "************************ \e[35mRESULTS: BI2R pre-split vs. I2AR post-split\e[0m *********************************"
  echo "******************************************************************************************************"
  BI2R_EXPORT_SPLIT_FILE_PATH="$(find /var/ -type f -name $BI2R_EXPORT)"
  BIR_PRE_SPLIT_COUNT="$(grep I2AR:begin $BI2R_EXPORT_SPLIT_FILE_PATH | wc -l)"
  echo "BI2R pre-split  Count: [$BIR_PRE_SPLIT_COUNT] for \"$BI2R_EXPORT_SPLIT_FILE_PATH\""
  #set the I2AR path to the directory
  I2AR_IMPORT_POST_SPLIT_DIR_PATH="$(find /var/i2ar/archive/ -type d -name $I2AR_IMPORT)"
  I2AR_POST_SPLIT_FILE_COUNT="$(find $I2AR_IMPORT_POST_SPLIT_DIR_PATH -type f | wc -l)"
  echo "I2AR post-split Count: [$I2AR_POST_SPLIT_FILE_COUNT] for \"$I2AR_IMPORT_POST_SPLIT_DIR_PATH\""
}

# Run STUFF

GET_SPLIT_COUNTS $BI2R_EXPORT $I2AR_IMPORT
echo "All done! if the counts are off check the error or duplicate directories."
