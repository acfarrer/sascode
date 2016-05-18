/* Demonstrate that macro execution creates different catalog names based on execution mode */
data _null_ ;
  set sashelp.vscatlg (where=( libname = 'WORK')) ;
  put memname = ;
run ;

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

proc catalog catalog= work.sasmac1 ;
contents ;
quit ;

