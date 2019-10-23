#!/bin/bash
while getopts "bf:" OPTION
do
	case $OPTION in
		b)
			echo "You set flag -b"
			exit
			;;
		f)
			echo "The value of -f is $OPTARG"
			MYOPTF=$OPTARG
			echo $MYOPTF
			exit
			;;
		\?)
			echo "Used for the help menu"
			exit
			;;
	esac
done
