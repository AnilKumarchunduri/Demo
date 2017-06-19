#!/usr/bin/perl
print "Enter the number :";
$n1 = <>;
chop($n1);
print "Enter the 2nd Number :";
$n2 = <>;
chop($n2);
if($n1 < $n2){
print "$n2 is greater\n";
}
else{
print "$n1 is greater\n";
}
