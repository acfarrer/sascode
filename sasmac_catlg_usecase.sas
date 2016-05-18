/* Compare defaults between execution modes */
options nofullstimer ;

data _null_ ;
set sashelp.vscatlg (where=( libname = 'WORK')) ;
put memname = ;
run ;

/* Will give warning outside EG */
%put _clientapp= &_clientapp ;
/* Execution mode */
%put SYSPROCESSMODE = &SYSPROCESSMODE ;
