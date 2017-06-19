#!/usr/bin/perl
$a = 10;
$var = <<"EOF";
Testing for perl value of a is $a
this is example for double quotes
EOF
print "$var\n";

$var = <<'EOF';
Testing for perl value of a is $a
this is example for double quotes
EOF
print "$var\n"
