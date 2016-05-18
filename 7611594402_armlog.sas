filename log "~/saslogs/armlog.log";
options armloc=log;
options armsubsys=(arm_all);

%put %scan(%sysget(SAS_EXECFILEPATH),4,%str(\)) ;

/*proc options;run;*/

data fred;
  set sashelp.class;
  where sex='M';
run;
