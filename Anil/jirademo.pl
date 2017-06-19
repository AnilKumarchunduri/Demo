#!/usr/bin/perl

use JIRA::Client::Automated;
 
$url = "https://almsbx.radisys.com/jira/login.jsp";
$user = "sakumar";
$password = "rsys@1234";
my $jira = JIRA::Client::Automated->new($url, $user, $password);
