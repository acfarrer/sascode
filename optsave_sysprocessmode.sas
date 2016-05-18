/* Save all default options for execution mode for later comparison */
/* See option_compare.sas for example 3-way diff */
option dlcreatedir ; /* Create folder if does not exist. 777 on Unix */
libname mytemp '~/dlcreatedir' ;
proc optsave out=mytemp.optsave_%sysfunc(compress(&SYSPROCESSMODE)) (label = "Default options for &SYSPROCESSMODE") ; 
run ;
