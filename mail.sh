#!/bin/bash
rm -rf file2
grep -n  "tests total\|test total" log | cut -c -4 > file
for i in `cat file`
do
head -$i log | tail -4 >> file2
echo "-----------------------------------------------------------------------------------------------------" >> file2
done
