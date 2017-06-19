#!/bin/bash
echo
while read i
do
s=$(echo $i | awk -F" " '{print $1,$2,$3}')
set -- $s
echo $1
echo $2
echo $3

done < oc.txt
