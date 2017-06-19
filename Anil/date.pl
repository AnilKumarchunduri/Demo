#!/usr/bin/perl

chomp($sysdate = `date '+%d-%b-%Y'`);
print $sysdate
$weekdate = time() - 7 * 24 * 60 * 60;
$weekdate = localtime($weekdate);
#$week = `$weekdate '+%d-%b-%Y'`;
print $weekdate

