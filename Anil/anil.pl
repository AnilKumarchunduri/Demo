#!/usr/bin/perl
$epco = time();
$week = $epco - 7 * 24 * 60 * 60 ;
@months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
 ($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime($week);
 $year = 1900 + $yearOffset;
 $theTime = "$dayOfMonth-$months[$month]-$year";
 print $theTime; 
