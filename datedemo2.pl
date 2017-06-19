#!/usr/bin/perl

use Time::Piece;
use Time::Seconds;
my $t = localtime() - ONE_WEEK;
my $date = $t->day_of_month;
print $date;
my $month = $t->monname;
print $month;
my $year = $t->year;
my $sevenDaysbak = "$date-$month-$year";
print "$sevenDaysbak \n"; 

