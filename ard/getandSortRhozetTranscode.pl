use XML::Simple;
use Data::Dumper;
use LWP::UserAgent;
use HTTP::Request::Common;

use Scalar::Util qw/reftype/;

use strict;
use warnings;
my $xmlFile = shift;

my $itemID;

#**************MAIN**************

eval {$itemID = getItemID($xmlFile);};
if ($@) { print $@ . "\n" . " failed to get ITEMID"; exit (-1);};



my $itemInfo;
#ADD eval Here .......

$itemInfo = getArdomeItemData($itemID);

my $partInfo = retrieveSegments($itemInfo);


my $mobInfo;
#ADD eval Here .......
$mobInfo =getArdomeMobData($itemID);


my $startTC = getStartTimeCode($mobInfo);

my $startTCframes = getFrames($startTC);



my $partingInfo = processTimecodes($partInfo, $startTCframes);

print $partingInfo ."\n";

my $fileName = getFileName($xmlFile);



$fileName .=".mxf";




my $rhozetCallMessage = RhozetMessage($partingInfo, $fileName);

my $sent = callRhozet($rhozetCallMessage);




sub RhozetMessage {
	
	my $parting = $_[0];
	my $filename = 'z:\\' . $_[1];
	my $fullUNC = '\\\ostcmstrnsp101\\z$\\'.$_[1];
	 
	my $destination = 'Z:\\PDL output';
	
	
	
	
	my $message ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:rhoz="http://Rhozet.com/Rhozet.Services.IJmLib">
   <soapenv:Header/>
   <soapenv:Body>
      <rhoz:QueueJobXML>
         <rhoz:sourceXml><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<cnpsXML ProjectID.DWD="161428257" CreatedByAppVersion="3.23.0">
<Sources>
<Module_0 Inpoint.QWD="-1" Outpoint.QWD="-1" Duration.QWD="48600000000" MultiSource.DWD="1">
<ModuleData>
<StreamTypeTable StreamSelector_0.DWD="0" StreamType_0.DWD="0" StreamPtr_0.DWD="0" StreamSelector_1.DWD="2" StreamType_1.DWD="0" StreamPtr_1.DWD="0"/>
<SourceModules>
<MultiSrcModule_0 MultiSource.DWD="0" Filename="'.$filename.'" CreatorMachine="OSTCMSTRNSP101" CreatorUser="SVC-APP-CMSOTMM" FullUNCFilename="'.$fullUNC.'">
<ModuleData/>
</MultiSrcModule_0>
</SourceModules>
</ModuleData>
<InOutPoints Inpoint_0.QWD="810000000" Outpoint_0.QWD="19739160000" Inpoint_1.QWD="19737000000" Outpoint_1.QWD="42714000000"/>
<Filter_0>
<Module_0 ModuleGUID="{A04B166C-3E8F-489C-B07A-33DC75AD1736}" PresetGUID="{A04B166C-3E8F-489C-B07A-33DC75AD1736}">
<ModuleData TCOffset="00:00:00" UpdFrameTC.DWD="0" VBIAutoDetect.DWD="1" VBIRelative.DWD="0" VBILine.DWD="19" VBILine2.DWD="21"/>
</Module_0>
<Module_1 ModuleGUID="{D87AFAD8-D7AA-4332-B4AD-01A69C91694A}" PresetGUID="{D87AFAD8-D7AA-4332-B4AD-01A69C91694A}">
<ModuleData TimeSource.DWD="2" TextColor.DWD="0" TextPlacement.DWD="4" HTextPlacement.DWD="2" TextSize.DWD="1" UseDropFrameTimecode.DWD="0" UseBkgColor.DWD="1" BkgColor.DWD="0" MakeBkgTransp.DWD="1"/>
</Module_1>
</Filter_0>
<Filter_1/>
</Module_0>
</Sources>
<Destinations>
<Module_0 ModuleGUID="{DF227069-514D-4127-BB25-BF31D1E732AA}" PresetGUID="{DF227069-514D-4127-BB25-BF31D1E732AA}">
<ModuleData CML_P_BaseFileName="SKY_%s_16x9-VM" CML_P_Path="Z:\PDL output" DestFileUseSource.DWD="1" CML_P_SplitSelection.DWD="0"
 CML_P_SplitTime.DWD="10" stream.DWD="2" mux_type.DWD="0" trick_mode_type.DWD="0" video_ts_packetization.DWD="1" 
Multiple_Audio_AUs_packetization.DWD="0" use_constant_rx.DWD="0" PCR_PID.DWD="2064" PMT_PID.DWD="480" VideoPID.DWD="2064"
 pat_repeat_rate.DWD="0" pcr_repeat_rate.DWD="0" t_std_delay.DWD="0" ts_id.DWD="0" program_number.DWD="1" use_smpte_2038.DWD="0"
 align_abr.DWD="0" smpte_2038_pid.DWD="4095" moov_at_beginning.DWD="1" add_free_box.DWD="0" free_box_size.DWD="1024" moov_compact_size.DWD="0"
  MP4_device_compatibility.DWD="0" UsedStreamVideo.DWD="1" Profile.DWD="1" Level.DWD="31" CML_V_SizeX.DWD="720" CML_V_SizeY.DWD="404" FrameRateList.DWD="17"
   FrameRate.DBL="25.000002" interlace_mode.DWD="2" AspectRatio.BIN="QAAAAC0AAAA=" PixelAspect_X.DWD="64" PixelAspect_Y.DWD="45" AspectRatio.DWD="32768"
    use_pixel_aspect.DWD="0" bitrate_mode.DWD="0" number_of_passes.DWD="2" CML_V_BitrateAvg.DWD="1440" CML_V_BitrateMax.DWD="4500" useFrameAccurateDPI.DWD="0" 
    vbv_buffer_size.DWD="0" use_vbr_muxrate.DWD="0" setmuxrate.DWD="0" muxrate.DWD="3550" entropy_coding.DWD="1" number_of_slices.DWD="1" mbaff.DWD="1" 
    closed_caption_mode.DWD="0" Active_20_Format_20_Descriptor.DWD="65535" maintain_hrd.DWD="1" enable_noUnderflow.DWD="0" write_timestamps.DWD="1" write_au_delimiters.DWD="1"
     write_seq_end_code.DWD="0" idr_interval.DWD="75" min_idr_interval.DWD="1" enable_scene_change_detection.DWD="1" idr_frequency.DWD="1" nb_of_search_frames.DWD="4"
      reordering_delay.DWD="2" use_adaptative_b_frames.DWD="0" b_slice_as_reference.DWD="0" b_slice_pyramid.DWD="0" denoise_strength_y.DWD="0" denoise_strength_c.DWD="0"
       black_normalization_level.DWD="16" use_weighted_p_mode.DWD="1" use_simple_aquant_strength.DWD="0" aquant_strength_simple.DBL="50.000000" aquant_strength_brightness.DBL="0.000000"
        aquant_strength_complexity.DBL="0.000000" aquant_strength_contrast.DBL="0.000000" I_2d_frame_20_Beating_20_Reduction.DWD="0" use_deblocking.DWD="1" deblocking_alpha.DBL="-1.000000"
         deblocking_beta.DBL="-1.000000" use_adaptive_deblocking.DWD="1" chroma_offset.DWD="1" colour_description.DWD="0" search_shape.DWD="1" motion_est_search_mode.DWD="2" fast_decisions.DWD="0"
          use_fast_multi_ref_me.DWD="0" use_fast_subblock_me.DWD="0" rate_distortion.DWD="1" fast_rate_distortion_opt.DWD="1" Refined_20_Rate_2d_Distortion_20_Motion_20_Detection.DWD="0" use_intra_big.DWD="1"
           use_intra_8x8.DWD="1" use_intra_4x4.DWD="1" use_inter_big.DWD="1" use_inter_8x8.DWD="1" use_inter_4x4.DWD="1" UseExternalDllEncoder.DWD="0" ExternalDllConfig="" ExternalDllConfig2ndPass="" UsedStreamAudio.DWD="1"
            NumberOfLanguages.DWD="1" SelectLanguage.DWD="0" AudioCompression.DWD="4" AudioCompressions=" 4 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2" AudioAc3BufferSize.DWD="0" AudioPID.DWD="2068" 
            AudioPIDs=" 2068 2069 2070 2071 2072 2073 2074 2075 2076 2077 2078 2079 2080 2081 2082 2083" AudioChannels.DWD="2" AudioChannelList=" 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2"
             AudioBitrate.DWD="96000" AudioBitrates=" 96000 128000 128000 128000 128000 128000 128000 128000 128000 128000 128000 128000 128000 128000 128000 128000"
              AudioSampleRate.DWD="44100" AudioSampleSize.DWD="16" AudioLanguage="eng" AudioLanguages="engengengengengengengengengengengengengengengeng"
               AACUseCRC.DWD="1" aac_format.DWD="0" AudioAC3BandwidthLowpass.DWD="0" AudioAC3BandwidthLowpasses=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
                AudioAC3LFELowpass.DWD="0" AudioAC3LFELowpasses=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0" AudioAC3DC.DWD="0" AudioAC3DCs=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
                 AudioAC3SurroundPhase.DWD="0" AudioAC3SurroundPhases=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0" AudioAC3DigitalDeemphasis.DWD="0"
                  AudioAC3DigitalDeemphasises=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0" AudioAC3LineMode.DWD="0" AudioAC3LineModes=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
                   AudioAC3RFMode.DWD="0" AudioAC3RFModes=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0" AudioAC3SurroundAttenuation.DWD="0" AudioAC3SurroundAttenuations=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
                    AudioAC3DialogNormalization.DWD="-27" AudioAC3DialogNormalizations=" -27 -27 -27 -27 -27 -27 -27 -27 -27 -27 -27 -27 -27 -27 -27 -27" AudioAC3SurroundMode.DWD="0"
                     AudioAC3SurroundModes=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0" AudioAC3LtRtCenter.DWD="4" AudioAC3LtRtCenters=" 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4" AudioAC3LtRtSurround.DWD="4"
                      AudioAC3LtRtSurrounds=" 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4" AudioAC3LoRoCenter.DWD="4" AudioAC3LoRoCenters=" 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4" AudioAC3LoRoSurround.DWD="4" 
                      AudioAC3LoRoSurrounds=" 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4" AudioAC3SurroundExMode.DWD="1" AudioAC3SurroundExModes=" 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1" AudioAC3PreferredDownmix.DWD="1"
                       AudioAC3PreferredDownmixes=" 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1" AudioAC3BitstreamMode.DWD="0" AudioAC3BitstreamModes=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
                        AudioAC3ProductionInfo.DWD="0" AudioAC3ProductionInfos=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0" AudioAC3MixLevel.DWD="80"
                         AudioAC3MixLevels=" 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80" AudioAC3RoomType.DWD="0" AudioAC3RoomTypes=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
                          AudioAC3HeadphoneMode.DWD="0" AudioAC3HeadphoneModes=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0" AudioAC3ADConverterType.DWD="0"
                           AudioAC3ADConverterTypes=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0" AudioAC3AutoSettings.DWD="0" AudioAC3AutoSettingss=" 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
                            AudioAC3MultiplexMethod.DWD="0" CML_P_ForcedSplitMinutes.DWD="0" CML_P_SourceSegmentSel.DWD="0" CML_P_SourceSegmentStart.DWD="-1" CML_P_SourceSegmentTime.DWD="-1"
                             CML_P_SourceSegmentStartDbl.DBL="0.000000" CML_P_SourceSegmentTimeDbl.DBL="0.000000" CreatorMachine="OSTCMSTRNSP101"
                              CreatorUser="SVC-APP-CMSOTMM" FullUNCPath="\\\OSTCMSTRNSP101\Z$\PDL output"/>
<Filter_0/>
<Filter_1/>
</Module_0>
</Destinations>
<ProjectSettings Stitching.DWD="0">
<KernelFlags KP_LetterBoxParam.DWD="0" KP_MethodVideoScaleUp.DWD="0" KP_MethodVideoScaleDown.DWD="0" KP_MethodVideoScaleThreads.DWD="0" KP_MethodVideoScaleOptions.DWD="0" KP_Activelinelength704.DWD="0" KP_TCFrameRateMode.DWD="0" KP_FrameRateMode.DWD="2" KP_SpecialMPEGScaling.DWD="1" KP_SpecialDeinterlacing.DWD="1" KP_SpecialD1toDVScaling.DWD="1" KP_RGB2YUV601.DWD="1" KP_YUV2RGB601.DWD="1" KP_AdjustDurationLimit.DWD="5" KP_AdjustDurationEnabled.DWD="1" KP_RestrictQuality.DWD="0" KP_AnamorphicScalingLimit.DWD="50" KP_AnamorphicScalingLimitEnabled.DWD="1" KP_SpecialVBIScaling.DWD="1" KP_DefaultSTLanguage.DWD="28261" KP_DefaultAudioLanguage.DWD="0" KP_ForceInternalMPEGDecoder.DWD="0" KP_SetChapterAtStitch.DWD="0" KP_UseDropFrame.DWD="1" KP_UseMPEGTimeStamp.DWD="0" KP_MaxMediaCut.DWD="5" KP_UseLegacyMPEG.DWD="0" KP_UseLegacyQT.DWD="0" KP_UseNTSCSafeLetterBox.DWD="0"/>
</ProjectSettings>
</cnpsXML>]]></rhoz:sourceXml>
      </rhoz:QueueJobXML>
   </soapenv:Body>
</soapenv:Envelope>';

	
	print $message ."\n";
	
	
return $message;

	
	
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
			if ($numberOfParts == 1){ $RhozetPart = $part;}
			 else{
			$RhozetPart = $part -1;
			}
			$inOuts .= " Inpoint_" . $RhozetPart .".QWD=\"".$inFixed."\" Outpoint_".$RhozetPart.".QWD=\"".$outFixed."\"";
			
			
			
			
				
		}
	
	
	return $inOuts;
	
	
	
	}




sub fixTimeCode {
	
	my $timecode = $_[0];
	my $offset = $_[1];
	
	my $return = $timecode - $offset;
	
	$return = $return * 1080000;
	
	return $return;
	
	
	}









sub processHashes {
					my $parts = $_[0];
					my $partNum = $_[1];
					
					my %tc=();
					
					while (my ($key, $value) = each %$parts) {
					
					
					
					if ($key eq "seq_no"){
						if ($value == $partNum){ print "Found part $value"; return "true";}
						}
												
					}
										
			}







sub getFrames {

    my $timecode = $_[0];
    # TODO test for HH:MM:SS:FF
    my @splitTime = split (/:/,$timecode);

    if (scalar(@splitTime) != 4) {
        die "Cannot process Timecode - Split is not Even";
    }


    my ($hrs, $mins, $secs, $frames);

    $hrs = $splitTime[0] * 90000;
    $mins = $splitTime[1] * 1500;
    $secs = $splitTime[2] * 25;
    $frames = $splitTime[3];

    my $numberOfFrames = $hrs + $mins + $secs + $frames;

    return $numberOfFrames;

            }













sub getStartTimeCode {
	
	my $mob_Info = $_[0];
	
	my $xml = new XML::Simple;
				my $in = $xml->XMLin($mob_Info) || die "Failed to Parse Ardome XML $xmlFile";
				
				my $tc = $in->{"soapenv:Body"}->{"dat:getMobsResponse"}->{"dat:moblist"}->{"com:mob"}->{"com:mob_tc_in"}->{"content"};			
				
				return $tc;
				
				
				
	
	
	}














#sub retrieveSegments {
#			my $ardomeInfo = $_[0];
#			my $xml = new XML::Simple;
#				my $in = $xml->XMLin($ardomeInfo) || die "Failed to Parse Ardome XML $xmlFile";
#				my $segs = $in->{'soap:Body'}->{GetImplItemRes}->{item}->{segments};
				
#				my $t = new XML::Simple;
#				my $s = $t->XMLin($segs);
				
#				my $segments =  $s->{segment_profiles}->{segment_profile}->{segments}->{segment};
				
#				my $parts = for_hash($segments);
				
				
#				return $parts;			
				
#					}





#######ARRRRGGGGGGGGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
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

	return $message;
	
	
		}


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
                                                                 print $key ." ".$value;              
                                                                                                                            
															
                                                                 $outputs{$key} = $value;


                                                               }

                                                                                                                                


                                                return \%outputs;
                                        }

sub getFileName{
	
	my $xmlFile = $_[0];
				my $fileName;
				my $xml = new XML::Simple;
				my $in = $xml->XMLin($xmlFile) || die "Failed to Parse Ardome XML $xmlFile";


				$fileName = $in->{itm_site_id_str};

				if ($fileName eq "" ){
					
					die "Failed to Retrieve item ID from $xmlFile" ;
					}
					else {
						return $fileName;
						}
	
	}

sub callRhozet {
	
	
						my $soapMessage = $_[0];
						my $userAgent = LWP::UserAgent->new();
						my $httpR = HTTP::Request->new(POST => 'http://10.64.20.210:8731/Rhozet.JobManager.JMServices/SOAP');
						$httpR->header(SOAPAction => 'http://Rhozet.com/Rhozet.Services.IJmLib/IJmLib/QueueJobXML');
						$httpR->content($soapMessage);
						$httpR->content_type("text/xml;charset=UTF-8");
						my $response = $userAgent->request($httpR);

						
	

		if ($response->is_success) {
        					print $response->decoded_content;
    						}
    		else {
        		print $response->status_line;
        		exit (-1);
						
						if ($response->is_success){
							
							print $response->decoded_content;
							return $response->decoded_content;
							
														
							}else {
							
							print $response->error_as_HTML . "\n";
							die "Error getting MOB data";
							}					
	
	
	}
	
}
	
	

