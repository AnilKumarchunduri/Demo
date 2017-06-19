#!/usr/bin/perl
$line = " Hi this is Anil kumar ";
print "$line\n";
$line =~ s/^\s+//;
print $line;
$line =~ s/\s+$//;
print $line;

