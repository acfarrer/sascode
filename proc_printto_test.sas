/* Demonstrate how syntax errors are handled */
/* From Issue Log #172
proc printto log='/lillyce-qa/qa/ly2820671js6/f1j_us_hmfr/final/logs/testksa.log' 
print='/lillyce-qa/qa/ly2820671js6/f1j_us_hmfr/final/logs/testksa.lst' new; run;
*/
proc printto log='~/saslogs/testksa.log' print='~/sasprint/testksa.lst' new ; 
run ;

%put SYSPROCESSMODE = &SYSPROCESSMODE ;
 
/* Should execute without errors */
proc print data=sashelp.air(obs=5); run;
 
/* Error introduced on purpose */
data test;
  set sashelp.prdsale(odd=100);
run;
 
/* Should execute without errors */
proc print data=sashelp.prdsale(obs=5); run;
 
proc printto; run;
