#!/usr/bin/perl

open(line,"<test.txt");
while (<line>){
$i = $_;
@m  = split(' ',$i);
for ( $j = 0 ; $j <= $#m ; $j++ ){
$s[$j] += $m[$j];
}
}
for ( $j = 0 ; $j <= $#m ; $j++ ){
print "$s[$j]\n";
}
