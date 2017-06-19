#!/bin/bash

git clone ssh://git@stash.radisys.com:7999/fe/fe-2k.git
cd fe-2k
git tag | cut -c1-8 | grep C01 | tail -1 > /home/sakumar/Anil/relversion.txt
cd ..
rm -rf fe-2k
var=$(cat relversion.txt)
echo $var
