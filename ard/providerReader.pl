use XML::Simple;
use Data::Dumper;
use Scalar::Util qw/reftype/;

use strict;
use warnings;
my $xmlFile = shift;
my $CGproviderNumber;


my $xml = new XML::Simple;
my $in = $xml->XMLin($xmlFile);

				eval($CGproviderNumber = getContentGroupVersionNumber($in));
				if ($@){print "Cannot get ContentGroup Number Failing ......."; exit (-1);};

				print " Content Group Provider Number  = $CGproviderNumber \n";
				
				my @xmlElements;
				@xmlElements = getAllElements($in);					
				
				for my $ele (@xmlElements) { 
												
																																									
								my $subEle = $in->{$ele};
								my $out =for_hash($subEle);
								my $k = "1";
												
												
													
																		
								while (my ($key, $value) = each %$out) {
									if (index($key, 'providerVersionNum') != -1){
										if ($CGproviderNumber == $value){
												print "$ele Matched \n";
												}
												else
												{
												print "$ele and Content Group mismatch CG = $CGproviderNumber where $ele = $value \n";
												exit (-1);
												}
																																				
											}
								}
													
												
												
												
											
												
					}
												
																
sub verifyCGProviderNumbers {
					my $cgProviderNumber = $_[0];
					my $in = $_[1];       		
				}


sub getContentGroupVersionNumber {
				my $adi = $_[0];		
				my $cg = $adi->{ContentGroup}->{providerVersionNum} || die "Cannot Find Content Group";
                               	return $cg;
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



