#!/bin/perl

$a = 1;
print "The value of \$a is $a";
@arr = (1,2,3,4);
print "The value in array is @arr\n";
foreach (@arr) {
print "$_\n";
}
$f = open(file,"/home/sakumar/Anil/oc.txt");
print "$f\n";
$var = <file>;
close(file);
#foreach (@var){
#print "$_";
#}
print "$var";

#open(file1,">>/home/sakumar/Anil/test.txt");
#print file1 ("20 30 40");
#close (file1);
$n1 = 10;
$n2 = 20;
&m1($n1,$n2);
#&m1;
#print $total;
sub m1 {

#$n1 = <stdin>;
#$n2 = <stdin>;
my ($l1,$l2) = @_;
print $l1;
print "$l2\n";
#$l1 = 10;
#$l2 = 20;
$tot = $l1 + $l2 ;
print "total = $tot";
}

