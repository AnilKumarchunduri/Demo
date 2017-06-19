# This scripts used to create links between JIRA issue using CQ ID's
#!perl 
use JIRA::REST;
use REST::Client;
use MIME::Base64;
use JSON;
use Data::Dumper;
use Config::Simple;
# Links data file
my $linkFile  = $ARGV[0];

# Configuration file
my $config = "config.cfg";
# Access Configuration file - 
Config::Simple->import_from("$config", \%Config);
my $cfg = new Config::Simple("$config");
# JIRA login Details
my $user = $cfg->param('JIRAUSER');
my $pass = $cfg->param('JIRAPASSWD');

my $client = REST::Client->new();
 
#A host can be set for convienience ** production instace **
#$client->setHost('http://jira.radisys.com:8080/jira');

# Test instace URl 
$client->setHost('http://jira.radisys.com:8080/jira');

# REST API header 
my $headers = { Authorization => 'Basic '. encode_base64($user . ':' . $pass), 'Content-Type' => 'application/json'};

#Log file 
# file to write the linked issues
my $linksIssuefile = "linksLog.txt";
open(LH, '>', $linksIssuefile) or die "Could not open file '$linksIssuefile' $!";

# Read link data file 

       	#RESt GET Method 
	#$client->GET( "/rest/api/2/search?jql=%22Old%20ID%22%20~%20$id" , $headers );
	$client->GET( "/rest/api/2/search?jql=project%20%3D%20ASSFDC%20%20AND%20issuefunction%20in%20hasLinkType(\"Cloners\")" , $headers );

 
	# to convert the data into a hash, use the JSON module
	my $res_data = from_json( $client->responseContent() );
	# Open to print Hash Data
	print Dumper($res_data). "\n";

	#Print Issue Keys from HASh
	my $k = $res_data->{'issues'}[0]{'key'};
	#my $j = $res_data->{'issue'}[0]{'issuelinks'}{'key'};
	#print "$j \n";
	print "$k \n";
