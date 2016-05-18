/*From: David Glemaker */
/*Sent: Thursday, September 17, 2015 11:24 AM*/
/*To: 'Priyanka Tiwari - Network' <tiwari_priyanka@network.lilly.com>; Pujyalatha Katakamsetti - Network <katakamsetti_pujyalatha@network.lilly.com>*/
/*Subject: RE: spds indexes*/

%let numsess=6;  /*** numsess = How many grid sessions you want ***/
*let numsess=2;  /*** For syntax checking. Min 2 for %eval(&count/2) to be > 1. Andrew Farrer */
options NOSIGNONWAIT ;
options nosgen nomprint ;

%macro gsignon(count);
   %global tasklist ;  /* Added by Andrew Farrer. 21Jan2016 */
   %let tasklist=;
   %do i = 1 %to &count;
      %let tasklist=&tasklist task&i;
      %let gclient=%sysfunc(compress(&SYSPROCESSMODE));
      %let _gridjobname&i=&gclient..&sysuserid..&sysjobid..&i;
      %let rc=%sysfunc(grdsvc_enable(task&i,"resource=SASApp94L;jobname=_gridjobname&i;"));
      signon task&i macvar=rtask&i wait=no;
  %end;
  %do i = 1 %to &count;
         rsubmit task&i sysrputsync=yes;
            %NRSTR(%let wpath=%sysfunc(pathname(work))); 
            %NRSTR(%sysrput wpath=%bquote(&wpath));
         endrsubmit;
      %put my grid node&i is %sysfunc(grdsvc_getname(task&i))  :  %sysfunc(grdsvc_getaddr(task&i));
        waitfor task&i;
        rget connectremote=task&i;
      libname RMTWORK&i remote "&wpath" server=task&i;
  %end;
  %put tasklist is &tasklist;
%mend gsignon; 
%gsignon(&numsess);

data temp1;
format start time12.2;
   desc="TestCon";
   start=time();
run;

%macro ldspds(count);
   %do i=1 %to %eval(&count/2);
      %syslput i=%bquote(&i) /remote=%bquote(task&i); 
      rsubmit task&i wait=no sysrputsync=yes;
         %NRSTR(%let yr=%eval(&i+8));
         %NRSTR(%put "&yr");   /* Added as per grid_concurrent_testing_092215_21.log */
         %NRSTR(%let type=yes);
           %NRSTR(%let indata=spdslib.CC_OUTPTRX_CMP);/* Changed from CC_OUTPTRX to CC_OUTPTRX_CMP as per grid_concurrent_testing_092215_21.log ACF */
           /* %NRSTR(%let indata=spdarclb.CC_OUTPTRX); */
         data _null_; /* Added as per grid_concurrent_testing_092215_21.log */
           if &yr=9 then call symput("yr","09");
         run; 

        libname Project "/EHI_SharedWorkspace/GPS/P300000_GPS_Development_Area/JMichael/Grid Testing/Data";
   
         /* Setup Libname to SAS Grid SPDS yr data; */
         LIBNAME SPDSLib SASSPDS  LIBGEN=YES  IP=YES  DISCONNECT=YES schema="tmyr&yr" 
          USER="dataadm" PASSWORD="spds7737" HOST='localhost' Serv='5404' 
          unixdomain=yes netcomp=no compress=yes;  

         /* Setup Libname to Archimedes SPDS data; */
         LIBNAME SPDARCLb SASSPDS  LIBGEN=YES  IP=YES  DISCONNECT=YES schema="tmyr&yr" 
          USER="dataadm" PASSWORD="spds456" HOST='archimedes.am.lilly.com' Serv='5190' 
          unixdomain=no netcomp=yes compress=yes;

         /*Extra setting for use with SPDS =2 means force parallel where evaluation; */
         %let SPDSEV1T=2;     %let SPDSEV2T=2;   /*%let SPDSDCMP=NO;*/

         Data NDC_Codes;
           set Project.NDC_Codes200 (obs=50);
         run;
         proc sql noprint;
            select distinct NDC_Char into :DrugList separated by ' ' from NDC_Codes;
         quit;

         Data _temp;
            set &indata(where=(NDCNUM in (&Druglist)));
         run;
        endrsubmit;
   %end;
   %do i=%eval((&count/2)+1) %to &count;
      %syslput i=%bquote(&i) /remote=%bquote(task&i); 
      rsubmit task&i wait=no sysrputsync=yes;
         %NRSTR(%let yr=%eval(&i+8)); /* Changed from 4 to 8 as per grid_concurrent_testing_092215_21.log ACF */
         data _null_; /* Added as per grid_concurrent_testing_092215_21.log */
           if &yr=9 then call symput("yr","09");
         run; 

         %NRSTR(%put "&yr"); /* Added as per grid_concurrent_testing_092215_21.log ACF */
         %NRSTR(%let type=yes);
           %NRSTR(%let indata=spdslib.CC_OUTPTRX); /* Changed from CC_OUTPTRX to CC_OUTPTRX_CMP as per grid_concurrent_testing_092215_21.log ACF */
           /* %NRSTR(%let indata=spdarclb.CC_OUTPTRX); */

         libname Project "/EHI_SharedWorkspace/GPS/P300000_GPS_Development_Area/JMichael/Grid Testing/Data";
   
         /* Setup Libname to SAS Grid SPDS yr data; */ /* Changed tmvyr&yr to tmyr&yr for consistency. ACF */
         LIBNAME SPDSLib SASSPDS  LIBGEN=YES  IP=YES  DISCONNECT=YES schema="tmyr&yr" 
          USER="dataadm" PASSWORD="spds7737" HOST='localhost' Serv='5404' 
          unixdomain=yes netcomp=no compress=yes;  

         /* Setup Libname to Archimedes SPDS data; */ /* Changed tmvyr&yr to tmyr&yr for consistency. ACF */
         LIBNAME SPDARCLb SASSPDS  LIBGEN=YES  IP=YES  DISCONNECT=YES schema="tmyr&yr" 
          USER="dataadm" PASSWORD="spds456" HOST='archimedes.am.lilly.com' Serv='5190' 
          unixdomain=no netcomp=yes compress=yes;

         /*Extra setting for use with SPDS =2 means force parallel where evaluation; */
         %let SPDSEV1T=2;     %let SPDSEV2T=2;   /*%let SPDSDCMP=NO;*/

         Data NDC_Codes;
           set Project.NDC_Codes200 (obs=50);
         run;
         proc sql noprint;
            select distinct NDC_Char into :DrugList separated by ' ' from NDC_Codes;
         quit;

         Data _temp;
            set &indata(noindex=&type where=(NDCNUM in (&Druglist)));
         run;
      endrsubmit;
  %end;
%mend ldspds; 
%ldspds(&numsess);

waitfor _all_ &tasklist;

data temp2;
format end time12.2;
   desc="TestCon";
   end=time();
run;

%macro getrlog(count);
   %do i=1 %to &count;
      rget connectremote=task&i; *** returns remote log and output to local session ***;
   %end;
%mend getrlog; 
%getrlog(&numsess);

data temp;
   merge temp1(in=a) temp2(in=b);
   by desc;
   if a and b;
   secs=end-start;
   put "start = " start "end = " end "total seconds = " secs 10.2;
run;
proc print data=temp;
   var start end secs;
run;

