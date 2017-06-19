#!/bin/bash

cd /var/lib/jenkins/jobs/Caramel/jobs/
cd "AM traffic Test Suits"
cd builds
buildnumber=$(echo `ls -lrt | grep lastSuccessfulBuild | cut -d" " -f14`)
cd $buildnumber
rm -rf /home/jenkins/testcase/AmTrafficReport
grep -n  "tests total\|test total" log | cut -d":" -f1 > /home/jenkins/testcase/file3
for i in `cat /home/jenkins/testcase/file3`
do
head -$i log | tail -3 >> /home/jenkins/testcase/AmTrafficReport
echo "-----------------------------------------------------------------------------------------------------" >> /home/jenkins/testcase/AmTrafficReport
done
cat /home/jenkins/testcase/AmTrafficReport | mail -s "AM Traffic Test Suit Report for build - $buildnumber" "rakumar@radisys.com,sakumar@radisys.com,OrgFE-CCMP-Dev@radisys.com,OrgFE-OVSDev@radisys.com,OrgFE-NPU-EZDRV-Dev@radisys.com,OrgITRelTeam@radisys.com,schaudhu@radisys.com"
#cat /home/jenkins/testcase/AmTrafficReport | mail -s "AM Report for build - $buildnumber" "sakumar@radisys.com"


