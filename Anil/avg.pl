#!/usr/bin/perl

sub average{
$n = scalar(@_);
$sum = 0;
foreach $i (@_){
$sum += $i
}
$avg = $sum / $n;
print "$avg";
}

average(10,20,30);
