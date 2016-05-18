*let sysparm = 5 ;
options sgen ;
%let i = &sysparm ;

libname mydata '~/sasdata' ;

proc sql ;
select libref_name,	trim(indata_name), schema_name, indexyn     
into  :libref_name,:indata_name,:schema_name,:indexyn
from MYDATA.libref_table_schema
where i = &i ;
quit ;

%put JOBPARMS libref_name  indata_name  schema_name  indexyn ;
%put JOBPARMS &libref_name &indata_name &schema_name &indexyn ;

/*Extra setting for use with SPDS =2 means force parallel where evaluation; */
%let SPDSEV1T=2 ;
%let SPDSEV2T=2 ; 

%let logname = ~/ARMlogs/&i._&libref_name._&indata_name._&indexyn._%sysfunc(today(),yymmddn8.):%sysfunc(time(),tod8.).log ;

%let lognamec= %sysfunc(compress(&logname)) ;
%put logname= &lognamec ;

filename log "&lognamec" ;

options armloc=log;
*options armsubsys=(arm_all);
*options armsubsys=(ARM_DSIO VARINFO WHERETXT) ;
options armsubsys=(ARM_DSIO) ;

*%perfstrt(txnname="LIBNAME &libref_name"); /* Does nothing */
LIBNAME &libref_name SASSPDS  LIBGEN=YES  IP=YES  DISCONNECT=YES schema="&schema_name" 
 USER="dataadm" PASSWORD="spds7737" HOST='localhost' Serv='5404' 
 unixdomain=yes netcomp=no compress=yes; 

*%perfstrt(txnname="Extract from &libref_name &indata_name with noindex= &indexyn" ) ;  /* Does nothing */
data work._temp_&libref_name._&indata_name ;
set &libref_name..&indata_name 
  (noindex=&indexyn where= 
      (NDCNUM in ('00009034702', '00009041701', '00009041702', '00314077270', '00364660954', '00364661054', '00364661754',
      '00574046005', '00574046025', '00574046105', '00574046125', '00574082001', '00574082010', '00574082105', '00591322126',
      '00591322379', '00703612101', '00703612501', '00781307370', '00781307470', '00781307471', '10116100102', '10116100103',
      '17317056702', '17317056703', '17317056802', '35356005810', '38779004703', '38779004704', '38779004705', '38779016300',
      '38779016303', '38779016304', '38779016305', '38779016308', '38779016309', '38779016403', '38779016404', '38779016405',
      '43773100102', '43773100103', '43773100104', '54396032816', '54396032840', '54868021600', '54868361800', '54868361801',
      '65628002001', '65628002101', '67979050140')
      ) 
   ) 
;
run ;

*%perfstop;

libname &libref_name clear ;

