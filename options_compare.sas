/* 3 way compare of SAS default options */
libname mytemp '~/dlcreatedir' ;

proc sql ; 
title 'Datasets in this library' ; 
select memname format=$25. 
, nobs format=comma13. 
, nvar 
, datepart(modate) format = date9. as mod_date
, memlabel format=$55. 
from dictionary.tables 
where libname = 'MYTEMP' 
and memtype = 'DATA' ; 

select memname into :memlist separated by ' '
from dictionary.tables 
where libname = 'MYTEMP' 
and memtype = 'DATA' 
and memname like 'OPTSAVE%' ;

quit ;

%put &memlist ;

%macro investigate ;
proc sql ; 
title 'proc optsave variables' ;
select name format=$25. 
, label format=$55. 
from dictionary.columns
where libname = 'MYTEMP' 
and memname = 'SASAPP_OPTIONS' ; 
quit ;

proc print data = mytemp.SASAPP_OPTIONS ;
var optstart optname setting ;
*var group level offset opttype optdesc ;
run ;
%mend investigate ;

proc sql ;
create table mytemp.options_diff3way (label='3 way compare of options that differ') 
as select
  t1.optname 
, t1.optvalue as optsave_sasbatchmode
, t2.optvalue as optsave_sasconnectsession
, t3.optvalue as optsave_sasworkspaceserver
from mytemp.optsave_sasbatchmode t1
   , mytemp.optsave_sasconnectsession t2
   , mytemp.optsave_sasworkspaceserver t3
/* 3 way join */
where t1.optname eq t2.optname
and   t1.optname eq t3.optname
/* keep differences */
and   t1.optvalue ne t2.optvalue
and   t1.optvalue ne t3.optvalue
;
quit ;


proc print data = mytemp.options_diff3way ;
run ;

libname outxlsx '~/dlcreatedir/compare_default_options.xlsx' ;

proc copy in = mytemp out = outxlsx ;
run ;
