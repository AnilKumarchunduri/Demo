#!/bin/bash

for i in $(cat file)
do
echo `chmod 764 $i`
done
