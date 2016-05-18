/************************************************************
Author  Adam Bullock  13Dec2013
        Andrew Farrer. Added url and html output. 16Oct2015
        Andrew Farrer. Tweaked for Eli Lilly. 11Jan2016
************************************************************/
%let metaserver=gridpmeta2 ;
%let metaport=8564 ;

options 
metaserver="&metaserver" 
metaport=&metaport
metauser="c226507" 
metapass="{SAS002}6F5D9D5B2EEE35A207535896509FBE01";

data tcpip_&metaport ;
keep name port host protocol service url ;
length port host protocol objid service uri name $255;
nobj=0;
n=1;
do while (nobj >= 0);
	nobj=metadata_getnobj("omsobj:TCPIPConnection?@Name='Connection URI' or @Name='External URI'",n,uri);
	if (nobj >= 0) then do;
		rc=metadata_getattr(uri,"Name",name);
		if trim(name)='Connection URI' then name="Internal URI";
		rc=metadata_getattr(uri,"CommunicationProtocol",protocol);
		rc=metadata_getattr(uri,"HostName",host);
		rc=metadata_getattr(uri,"Port",port);
		rc=metadata_getattr(uri,"Service",service);
		*put name protocol || "://"host":" || port || service;
		url = cats(protocol, "://" , host, ":" , port, service) ;
		*put url ;
    	output;
	end ;
	n = n + 1;
end;	
run;

filename htmlout "~/html/webservices_&metaserver._&metaport..html" ;

data _null_;
  file htmlout ;
    set work.tcpip_&metaport end=no_more ;
    *length htmlline $ 200 ;
    *by userid ;
    if _n_ = 1 then do ;
      put '<html>' ;
      put '<head>' ;
      put "<title>Web services defined in &metaserver at &metaport </title>" ;
      put '</head>' ;
      put "<H1><Small>GetMetadataTCPIPConnections.sas run on &sysdate9. </Small></H1>" ;
      put "<H1><Small>Web services defined in &metaserver at &metaport  </Small></H1>" ;
      put "<H1><Small>Listing based on omsobj:TCPIPConnection?@Name=Connection or External URI </Small></H1>" ;
      put '<body bgcolor="white">';
      put "<P><br>";
      put '<UL>';
    end;
*	put url ;
    htmlline = cats('<LI><A href="' , url, '"> ' , url , '</A> ') ;
    put htmlline ;
    if no_more then do;
      put '</UL>' ;
      put '<P>' ;
      put '<pre>' ;
	  put '</body>' ;
	  put '</html>' ;
    end;
run;

/*proc sort data=tcpip_&metaport out=_&metaport._sorted;*/
/*	by service;*/
/*run;*/
/**/
/*proc print data=_&metaport._sorted;*/
/*	var name url ;*/
/*	title  'Internal and External Connections (except SASThemes)';*/
/*	title2 "&metaserver &metaport listed by service" ;*/
/*run;*/

