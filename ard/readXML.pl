
use XML::Simple;
use Data::Dumper;

my $xmlFile = shift;

print "$xmlFile \n";


my $xml = new XML::Simple;
my $in = $xml->XMLin($xmlFile);

my $ext = $in->{Ext}->{'ext:CategoryImage'};




#print Dumper($ext);


#getKeys($ext);

my $result = findSourceUrl($ext, "content:SourceUrl");

print "$result \n";











sub getKeys{

my $data = $_[0];


while ( my ($key, $value) = each(%$data) ) {
    						print "$key => $value\n";
						}



	}


sub findSourceUrl {
			my $hash = $_[0];
			my $searchTerm = $_[1];

			while (($key, $val) = each %$hash) {
    								return $val if $key eq $searchTerm; # or whatever you are looking for
								}



		}
