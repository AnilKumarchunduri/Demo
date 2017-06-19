#!/usr/bin/perl
@months = (jan,feb,mar,apr,may,jun,jul,aug,sep,octo,nov,dec);
@days = (sun,mon,tue,wed,thurs,fri,sat);
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
print $sec = localtime();
#print "$mday $months[$mon] $days[$wday]\n";
