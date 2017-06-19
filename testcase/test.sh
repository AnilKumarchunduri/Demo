#!/bin/bash

cd /var/lib/jenkins/jobs/Caramel/jobs/
cd "AM Test Suits"
cd builds
#fol=$(echo `ls -lrt | tail -1 | cut -d" " -f9`)
fol=$(echo `ls -lrt | grep lastSuccessfulBuild | cut -d" " -f14`)
echo $fol
cd $fol
echo `pwd`
rm -rf file2
grep -n  "tests total" log | cut -d":" -f1 > /home/jenkins/testcase/file
for i in `cat /home/jenkins/testcase/file`
do
head -$i log | tail -4 >> /home/jenkins/testcase/file2
echo "-----------------------------------------------------------------------------------------------------" >> /home/jenkins/testcase/file2
done
cat /home/jenkins/testcase/file2 | mail -s "AM Report for build - $fol" "rakumar@radisys.com,sakumar@radisys.com,OrgFE-CCMP-Dev@radisys.com,OrgFE-OVSDev@radisys.com,OrgFE-NPU-EZDRV-Dev@radisys.com,OrgITRelTeam@radisys.com,schaudhu@radisys.com"


#cd
#cd /var/lib/jenkins/jobs/Caramel/jobs/
#cd "AM traffic Test Suits"
#cd builds
#bul=$(echo `ls -lrt | grep lastSuccessfulBuild | cut -d" " -f14`)
#echo $bul
#cd $bul
#rm -rf file4
#grep -n  "tests total" log | cut -d":" -f1 > /home/jenkins/testcase/file3
#for j in `cat /home/jenkins/testcase/file3`
#do
#head -$j log | tail -4 >> /home/jenkins/testcase/file4
#echo "-----------------------------------------------------------------------------------------------------" >> /home/jenkins/testcase/file4
#done


