#!/usr/bin/perl

print 'enter the input :';
$var = <>;
if ($var =~ /anil/){
print "pattern matched";
}
else{
print "pattern not matched";
}
@words = split (/ +/,$var);
print  "@words\n";
