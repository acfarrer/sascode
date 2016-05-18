/* From /sasfs/prod/sas/94/controlserver/sasconfig/Lev1/SASApp94/SASEnvironment/SASMacro/mygsub.sas */

%macro dummy1 ;
%mend dummy1 ;

data _null_ ;
  set sashelp.vscatlg (where=( libname = 'WORK')) ;
  put memname = ;
run ;

%macro decide ;
%if &SYSPROCESSMODE = SAS Batch Mode ;
%then %put Batch Mode ;
%else %put Do something else ;
%mend ;

/* Suggestion from Jim Ward */
%macro finish1_jim ;
proc catalog catalog=work.sasmacr; 
   copy out=work.sasmac1; 
quit; 
%mend finish1_jim ;
%finish1_jim ;

%macro finish1 ;
/* From %finish1 */
/* Cleans up work catalogs */
proc catalog catalog= work.sasmac1 force ;
 save finish1/et= macro ;
quit ;
%mend finish1 ;

