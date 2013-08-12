#!/usr/bin/perl -w

use strict;
use warnings;
use CGI;
use CGI::Carp qw/fatalsToBrowser/;
use DBI;
use JSON;
use Data::Dumper;

# read the CGI params
my $cgi = CGI->new;
my $json = JSON->new;

# Get db settings
my $dbHost = "localhost";
my $dbUser = "root";
my $dbPass = "lampy";
my $dbName = "ott";

my $username = $cgi->param("username");
my $password = $cgi->param("password");

# connect to the database
my $conn = connectToDb();

# Create query
my $sql = qq{SELECT * FROM Job};

# Prepare query
my $sth = $conn->prepare($sql) or die $conn->errstr;

# Execute query
$sth->execute() or die $sth->errstr;


my @output;

while ( my $row = $sth->fetchrow_hashref ){
    push @output, $row;
}

$json = $json->pretty;

print $cgi->header( 'application/json' );
print $json->encode( { myData => \@output } );

sub connectToDb
{
	my $connStr = "DBI:mysql:$dbName:$dbHost";

	my $dbh = DBI->connect($connStr, $dbUser, $dbPass,
	{ RaiseError => 1, AutoCommit => 1, HandleError=>\&handle_error },) or die $DBI::errstr;

	return $dbh;
}

sub handle_error
{
	print "error";
}

