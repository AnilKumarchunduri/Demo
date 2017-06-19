#!/bin/bash
echo
while read i
do
s=$(echo $i | awk -F" " '{print $1,$2,$3}')
set -- $s
x=$1
y=$2
z=$3
echo $x
echo $y
echo $z

cd test1
cd $x
git remote remove origin
git remote add origin $y
git remote show origin
echo
git checkout master
git pull origin master
echo
git remote remove origin
git remote add origin $z
echo
git remote show origin master
git push origin --all

done < oc.txt
