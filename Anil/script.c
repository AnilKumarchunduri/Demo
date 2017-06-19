#!/bin/bash
echo
echo
cd test1
git remote remove origin
git remote add origin https:/\/github.com/AnilKumarchunduri/test1.git
git remote show origin
echo
git pull origin master
echo
git remote remove origin
git remote add origin ssh:/\/git@stash.radisys.com:7999/demo/test1.git
echo 
git remote show origin master
git push origin --all 
