use XML::Simple;
use Data::Dumper;
use Scalar::Util qw/reftype/;

#use strict;
use warnings;
my $xmlFile = shift;

my $itemID;

eval {$itemID = getItemID($xmlFile);};
if ($@) { print $@ . "\n" . " failed to get ITEMID"; exit (-1);};

print $itemID ."\n";













sub getItemID {

my $xmlFile = $_[0];
my $item_ID;
my $xml = new XML::Simple;
my $in = $xml->XMLin($xmlFile) || die "Failed to Parse Ardome XML $xmlFile";


$item_ID = $in->{itm_id};

if ($item_ID eq "" ){
	
	die "Failed to Retrieve item ID from $xmlFile" ;
	}
	else {
		return $item_ID;
		}

		}
		

				


