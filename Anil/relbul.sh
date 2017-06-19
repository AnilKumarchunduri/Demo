ST_B_NO=$(tail -1  /home/sakumar/Anil/.version)
LAST_BUILD_VERSION=$(echo $LAST_B_NO | cut -d "-" -f2)
FE_SW_BUILD_NUM=`expr $LAST_BUILD_VERSION + 1`
echo "D-"$FE_SW_BUILD_NUM>> /home/sakumar/Anil/.version

