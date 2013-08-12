use XML::Simple;
use Data::Dumper;
use Scalar::Util qw/reftype/;

use strict;
use warnings;
my $xmlFile = shift;
my $CGproviderNumber;


my $xml = new XML::Simple;
my $in = $xml->XMLin($xmlFile);

			

				
				
				my @xmlElements;
				@xmlElements = getAllElements($in);					
				
				for my $ele (@xmlElements) { 
												
								print $ele ."\n";
								



																
								my $subEle = $in->{$ele};
								my $out =for_hash($subEle);
								#my $k = "1";
												
												
													
																		
								while (my ($key, $value) = each %$out) {
								#print $ele . "  " . $key . "  " . $value . "\n";								
								if (index($key, 'SourceUrl') != -1){
														print $value . "\n";
													}

																
										}							
					}
												
																

sub getAllElements {

			my $adi = $_[0];
			my @adiElements;

			foreach my $key ( keys %$adi )
							{
							
							if (index($key, 'xmlns') != -1){}
							else{	
												
								push (@adiElements, $key);									
							}		
							}
		
			return @adiElements;
		}


	sub for_hash {
					my ($hash, $fn) = @_;
					my %outputs =();
					
					
					while (my ($key, $value) = each %$hash) {
										if ('HASH' eq ref $value) {
											my $iter = for_hash($value);
											while (my ($key, $value) = each %$iter) {
																					
																$outputs{$key} = $value;		
																}
																									
																}
																else {
																	$outputs{$key} = $value;
																		
																		
																		}
						
																}
						
						
						return \%outputs;										
					}



