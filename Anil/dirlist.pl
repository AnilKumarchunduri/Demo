#!/usr/bin/perl
$dir = "/home/sakumar/.*";
@files = glob( $dir );
foreach ( @files ){
print "$_\n"
}

