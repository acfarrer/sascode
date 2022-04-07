%let cfygrp = APP-SAS_GRID_MEDECON ;
/* From adquery user $ID -n -b displayName -b mail for each ID */
/* Created list by running adquery_group_members2.sh APP-SAS_GRID_MEDECON */

data dskusage.userdtls (label="userid name email from &cfygrp") ;
infile "/sas/home/$USER/ref_files/&cfygrp._userid_name.lst" ;
length userid $12 name $30 email $45 ;
input @'unixname:' userid ;
input @'displayName:' name & ; 
input @'mail:' email ;
run ;

/* Create $userdtl and $usrmail formats */
/* Good way of defining default */
data hlo ;
   start = ' ' ; label = ' ' ; hlo   = 'O' ; output ;
run ;

data dskusage.cntlin (keep = fmtname type start label hlo) ;
   retain fmtname 'userdtl' type 'C' ;
   set dskusage.userdtls (rename=(userid = start name = label))
       hlo ;
run ;

proc format lib = dskusage cntlin = dskusage.cntlin ;
run ;

data dskusage.cntlin (keep = fmtname type start label hlo) ;
   retain fmtname 'usrmail' type 'C' ;
   set dskusage.userdtls (rename=(userid = start email = label))
       hlo ;
run ;

proc format lib = dskusage cntlin = dskusage.cntlin ;
run ;

options fmtsearch=(dskusage) ;
