#!/usr/bin/perl

format Employee = 
============================
@<<<<<<<<< @<< @#####.###
$name $age $salary
============================
.

format Employee_Top =
==================================================
Name                   Age             Salary

=====================================================

.
select(STDOUT);
$~ = Employee;
$^ = Employee_Top;
@n = ('Anil','Sai','Kumar');
@a = (23,19,22);
@s = (2000.00,3456.78,12233);
$i = 0;
foreach (@n){
   $name = $_;
   $age = $a[$i];
   $salary = $s[$i++];
   write;
}
