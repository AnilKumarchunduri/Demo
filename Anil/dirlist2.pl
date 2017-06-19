#!/usr/bin/perl
opendir(dir,'.');
foreach($files =grep(".c",readdir(dir))){

print "$file\n"
}
