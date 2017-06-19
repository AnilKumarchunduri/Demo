#!/bin/bash

########################################################
# build number increments automatically when this
# script is run - DO NOT HAND LINES IN THIS BANNER
if [ $# -eq 0 ]
then
echo "No arguments supplied"
exit
fi
FE_SW_BUILD_TYPE=$1
FE_SW_BUILD_TIMESTAMP=$( date +"%d-%m-%Y_%H-%M-%S" )
if [ "$3" = "label_build" ]
then
LABEL_BUILD=1
else
LABEL_BUILD=0
fi

if [ $LABEL_BUILD -eq 1 ]
then
FE_SW_BUILD_NUM=1;#build number marker
next_n=$[$FE_SW_BUILD_NUM+1]
sed -i "/#build number marker$/s/=.*#/=$next_n;#/" ${0}
else
FE_SW_BUILD_NUM=Pvt
fi

LAST_B_NO=$(tail -1  /home/sakumar/Anil/.version)
LAST_BUILD_VERSION=$(echo $LAST_B_NO | cut -d "-" -f2)
FE_SW_BUILD_NUM=`expr $LAST_BUILD_VERSION + 1`
echo "D-"$FE_SW_BUILD_NUM>> /home/sakumar/Anil/.version




########################################################
FE_SW_VERSION=fe-3.0.0.0
FE_SW_BUILD_LBL=D-$FE_SW_BUILD_NUM
FE_SW_DP_SDK_VER=`readlink /opt/ezchip/nps400-sdk`

########################################################

##### git commands to checkout and check-in the file

########################################################

if [ "$2" = "clean" ]
then
make clean-all FE_SW_VERSION_PASSED=$FE_SW_VERSION \
               FE_SW_BUILD_LBL_PASSED=$FE_SW_BUILD_LBL\
               FE_SW_DP_SDK_VER_PASSED=$FE_SW_DP_SDK_VER\
               FE_SW_BUILD_TYPE_PASSED=$FE_SW_BUILD_TYPE
               if [[ $? -ne 0 ]] ; then
               echo "Build clean failed"
               exit 1
               fi
fi

make build-all FE_SW_VERSION_PASSED=$FE_SW_VERSION \
               FE_SW_BUILD_LBL_PASSED=$FE_SW_BUILD_LBL\
               FE_SW_DP_SDK_VER_PASSED=$FE_SW_DP_SDK_VER\
               FE_SW_BUILD_TYPE_PASSED=$FE_SW_BUILD_TYPE
if [[ $? -ne 0 ]] ; then
echo "Build failed"
exit 1
fi

make package   FE_SW_VERSION_PASSED=$FE_SW_VERSION \
               FE_SW_BUILD_LBL_PASSED=$FE_SW_BUILD_LBL\
               FE_SW_DP_SDK_VER_PASSED=$FE_SW_DP_SDK_VER\
               FE_SW_BUILD_TYPE_PASSED=$FE_SW_BUILD_TYPE\
               FE_SW_BUILD_TIMESTAMP_PASSED=$FE_SW_BUILD_TIMESTAMP
if [[ $? -ne 0 ]] ; then
echo "Build package failed"
exit 1
fi

echo "SW Version: $FE_SW_VERSION"
echo "Build Label: $FE_SW_BUILD_LBL"
echo "Build SDK version: $FE_SW_DP_SDK_VER"
echo "Build Label: $FE_SW_BUILD_TYPE"

FE_BUILD_LABEL=$FE_SW_VERSION-$FE_SW_BUILD_LBL-$FE_SW_DP_SDK_VER
echo "CI Label for code: $FE_BUILD_LABEL"
echo "Timestamp: $FE_SW_BUILD_TIMESTAMP"
