use XML::Simple;
use Data::Dumper;
use LWP::UserAgent;
use HTTP::Request::Common;
use HTTP::Request;





my $xmlFile = shift;



my $xml = new XML::Simple;
my $in = $xml->XMLin($xmlFile);


#print Dumper($in);


my $message ="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:rhoz=\"http://Rhozet.com/Rhozet.Services.IJmLib\">
   <soapenv:Header/>
   <soapenv:Body>
      <rhoz:GetVersion/>
   </soapenv:Body>
</soapenv:Envelope>";













		my $userAgent = LWP::UserAgent->new();
		my $httpR = HTTP::Request->new(POST => 'http://10.64.20.210:8731/Rhozet.JobManager.JMServices/SOAP');
		$httpR->header(SOAPAction => 'http://Rhozet.com/Rhozet.Services.IJmLib/IJmLib/GetVersion');
		$httpR->content($message);
		$httpR->content_type("text/xml");
		my $response = $userAgent->request($httpR);
#		print Dumper ($httpR);
		print $httpR;
	

		if ($response->is_success) {
        					print $response->decoded_content;
    						}
    		else {
        		print $response->status_line;
        		exit (-1);
    			}
