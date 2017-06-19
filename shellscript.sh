#!/bin/bash
#l=$(tail -1 /home/sakumar/Anil/.version)
#ld=$(echo $l | cut -d "-" -f2)
#n=`expr $ld + 1`
#echo "D-"$n >> /home/sakumar/Anil/.versioAn
LAST_B_NO=$(tail -1  /home/sakumar/Anil/.version)
LAST_BUILD_VERSION=$(echo $LAST_B_NO | cut -d "-" -f2)
FE_SW_BUILD_NUM=`expr $LAST_BUILD_VERSION + 1`
if [ "$1" = "fe_2k_int" ]
then
echo "I-"$FE_SW_BUILD_NUM >> /home/sakumar/Anil/.version
elif [ "$1" = "fe_2k_dev" ]
then
echo "D-"$FE_SW_BUILD_NUM >> /home/sakumar/Anil/.version
fi
