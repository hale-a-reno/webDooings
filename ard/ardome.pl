use Data::Dumper;
use XML::Simple;






				my $xml = new XML::Simple;
				my $in = $xml->XMLin("soapIn.xml") || die "Failed to Parse Ardome XML $xmlFile";
				#my $in = $xml->XMLin("soapInMulti.xml") || die "Failed to Parse Ardome XML $xmlFile";
				my $segs = $in->{'soap:Body'}->{GetImplItemRes}->{item}->{segments};
				
				my $txIn = new XML::Simple;
				my $tx =  $txIn->XMLin($segs);
				
				my $rt = $tx->{segment_profiles}->{segment_profile}->{segments}->{segment};
				
				
				
				
				
				print Dumper ($rt);
				
					my %test =();
					
					
				    while( my ($k, $v) = each %$rt ) {
					print "key: $k, value: $v.\n";
					
					$test{$k} = $v;
					
					}		

				print Dumper (\%test);
				
				
