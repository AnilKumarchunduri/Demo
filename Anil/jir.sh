#!/usr/bin/perl
use JIRA::Client::Automated;
 
my $jira = JIRA::Client::Automated->new($url, $user, $password);
 
# If your JIRA instance does not use username/password for authorization 
my $jira = JIRA::Client::Automated->new($url);use JIRA::Client::Automated;
 
my $jira = JIRA::Client::Automated->new($url, $user, $password);
 
# If your JIRA instance does not use username/password for authorization 
my $jira = JIRA::Client::Automated->new($url);
