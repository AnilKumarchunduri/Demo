#!/bin/bash

cd /var/lib/jenkins/jobs/Caramel/jobs/
cd "AM Test Suits"
cd builds
Buildnumber=$(echo `ls -lrt | grep lastSuccessfulBuild | cut -d" " -f14`)
cd $Buildnumber
rm -rf /home/jenkins/testcase/AmTestSuitReport
grep -n  "tests total\|test total" log | cut -d":" -f1 > /home/jenkins/testcase/file
for i in `cat /home/jenkins/testcase/file`
do
head -$i log | tail -4 >> /home/jenkins/testcase/AmTestSuitReport
echo "-----------------------------------------------------------------------------------------------------" >> /home/jenkins/testcase/AmTestSuitReport
done
cat /home/jenkins/testcase/AmTestSuitReport | mail -s "AM test Report for build - $Buildnumber" "rakumar@radisys.com,sakumar@radisys.com,OrgFE-CCMP-Dev@radisys.com,OrgFE-OVSDev@radisys.com,OrgFE-NPU-EZDRV-Dev@radisys.com,OrgITRelTeam@radisys.com,schaudhu@radisys.com"
#cat /home/jenkins/testcase/AmTestSuitReport | mail -s "AM test Report for build - $Buildnumber" "sakumar@radisys.com"
