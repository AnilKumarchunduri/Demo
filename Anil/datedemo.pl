#!/usr/bin/perl

my $inp= "/home/sakumar/Anil/date.txt";
my $todate;
my $fromdate;

open(date,"$inp");
while(<date>)
{
$todate = $_ ;
print "$todate \n";
}
$fromdate = $todate - 10 ;
print $fromdate;

