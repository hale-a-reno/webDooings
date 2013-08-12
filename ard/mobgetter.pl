
use XML::Simple;
use Data::Dumper;
use LWP::UserAgent;
use HTTP::Request::Common;



my $id ="1100130702756717921";

#my $id ="1100130809276441121";

my $mobdata = getArdomeItemData($id);

#print Dumper($mobdata);


my $parts =retrieveSegments($mobdata);


print Dumper ($parts);












sub retrieveSegments {
			my $ardomeInfo = $_[0];
			my $xml = new XML::Simple;
				my $in = $xml->XMLin($ardomeInfo) || die "Failed to Parse Ardome XML $xmlFile";
				my $segs = $in->{'soap:Body'}->{GetImplItemRes}->{item}->{segments};
				#print Dumper($segs);
				my $t = new XML::Simple;
				my $s = $t->XMLin($segs);
				
			
				my $segments =  $s->{segment_profiles}->{segment_profile}->{segments}->{segment};
				my $rt = $s->{segment_profiles}->{segment_profile}->{segments}->{segment};
													
				my @keys= keys $segments;
				
				
				my %parts= ();
				
				my @testKeys;
				
				
					
					for my $k (@keys){
					
					#print $k ."\n";
					
						
						if ('HASH' eq ref $segments->{$k})
												
													{
														print "Mulitpart ". $segments->{$k}." \n ";
														$parts{$k} = $segments->{$k};
																				
																									
													}
						else
													{
														
														push (@testKeys, $k);
														
														}		
											
					}
					
					print scalar(@testKeys) ."\n";
					
					
					if (scalar(@testKeys) >0){						
						my $t =createPartHash($segments, \@testKeys);					
						print Dumper ($t);
						$parts{"single"} = $t;
						
						}
					
												
						
										
			
				
				
				return \%parts;			
				
					}







sub createPartHash {
					my $hash = $_[0];
					my @keys = @{$_[1]};
					my %part =();
					
					
					
					#print "PRINT DUMPER **************************************************** \n";
					
					#print Dumper($hash);
					#print Dumper(@keys);
	
					
					 while( my ($k, $v) = each %$hash ) {
					#print "key: $k, value: $v.\n";
					
					if (grep($k,@keys)){
						#print $k ." ". $v ."\n";
						$part{$k} = $v;
						
						}
					
					
					}		
					
					
					 #print Dumper (\%part);
					
					return \%part;
					
					
	
	
	}
	




sub for_hash {
	
                   my ($hash, $fn) = @_;
                   my %outputs =();

					#print "PRINTING HASH \n";
					#print Dumper ($hash);
					
                   while (my ($key, $value) = each %$hash) {
                                                                 print "FOR HASH :" .$key ." ".$value ."\n";              
                                                                                                                            
																if ('HASH' eq ref $value) {
                                                                 $outputs{$key} = $value;
                                                               }

                                                                                                                                


                                                return \%outputs;
                                        }

}









sub processTimecodes{
	
	my $parts = $_[0];
	my $startTC = $_[1];
	
	my $numberOfParts = keys %$parts;
	print "there are $numberOfParts \n";
	
	my $inOuts ;
	
	
	
	
	
	#Inpoint_1.QWD="23490000000" Outpoint_1.QWD="42714000000" Inpoint_0.QWD="810000000" Outpoint_0.QWD="19739160000
	
	foreach my $key (keys %$parts) {
			
			print $key ."\n";
			
			
			my ($tcIn, $tcOut, $part);
			
			$tcIn = $parts->{$key}->{in};
			$tcOut = $parts->{$key}->{out};
			$part = $parts->{$key}->{seq_no};
			
			print "tcIn $tcIn tcOut $tcOut part $part \n"; 
			
			
			my ($inFixed, $outFixed, $RhozetPart);
			
			$inFixed = fixTimeCode($tcIn, $startTC);
			$outFixed = fixTimeCode($tcOut, $startTC);
			$RhozetPart = $part -1;
			
			$inOuts .= " Inpoint_" . $RhozetPart .".QWD=\"".$inFixed."\" Outpoint_".$RhozetPart.".QWD=\"".$outFixed."\"";
			
			
			
			
				
		}
	
	
	return $inOuts;
	
	
	
	}













sub getArdomeMobData {
						my $item_ID = $_[0];	
						my $soapMessage = createMOBdataMessage($item_ID);
						
						#print $soapMessage ."\n";
						
						my $userAgent = LWP::UserAgent->new(agent => 'perl post');
						my $response;
						
						#Add eval Here........
						$response = $userAgent->request(POST 'http://esb2-vip-live.broadcast.bskyb.com:9576/cookiemanager?service=DataModelAPI',		
						Content_Type => 'text/xml',
						Content => $soapMessage);
						
						if ($response->is_success){
							
							#print $response->decoded_content;
							return $response->decoded_content;
							
														
							}else {
							
							print $response->error_as_HTML . "\n";
							die "Error getting MOB data";
							}		
						
	
	
					}
					
sub createMOBdataMessage{
	
						my $item_ID = $_[0];
						
						my $message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:dat=\"ARDOME/SOAP/EXTERNAL/datamodelapi\" xmlns:com=\"ARDOME/SCHEMAS/complextype\">".
				"<soapenv:Header/>".
				   "<soapenv:Body>".
					  "<dat:getMobs>".
						 "<dat:mob>".
							"<dat:mob_itm_id>" .$item_ID ."</dat:mob_itm_id>".
							"<dat:mob_type>V</dat:mob_type>".
							"<dat:mob_subtype>-</dat:mob_subtype>".
						 "</dat:mob>".
					  "</dat:getMobs>".
				   "</soapenv:Body>".
				"</soapenv:Envelope>";
print $message ."\n";

	return $message;
	
	
		}
		
		
		
sub getArdomeItemData {
						my $item_ID = $_[0];	
						my $soapMessage = createItemDataMessage($item_ID);
						my $userAgent = LWP::UserAgent->new(agent => 'perl post');
						my $response;
						
						#Add eval Here........
						$response = $userAgent->request(POST 'http://esb2-vip-live.broadcast.bskyb.com:9576/esiteminternal',		
						Content_Type => 'text/xml',
						Content => $soapMessage);
						
						if ($response->is_success){
							
							#print $response->decoded_content;
							return $response->decoded_content;
							
														
							}else {
							
							print $response->error_as_HTML . "\n";
							die "Error getting MOB data";
							}					
	
	
	}
	
	
sub createItemDataMessage{
							my $item_ID = $_[0];
							my $message ="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:core=\"http://mam.bskyb.com/schema/core\" xmlns:com=\"ARDOME/SCHEMAS/complextype\">".
							"<soapenv:Header/>".
							"<soapenv:Body>".
							  "<core:GetImplItemReq>".
								 "<core:itm_id>".$item_ID."</core:itm_id>".
							  "</core:GetImplItemReq>".
						   "</soapenv:Body>".
						"</soapenv:Envelope>";

						return $message;
	
							}
	
	
