/* General purpose memory and I/O  performance test. */
/* Added ARM metrics */

filename log "~/saslogs/tabulate1M_armlog.log";
options armloc=log;
options armsubsys=(arm_all);

/* See what has been set */
proc options group=performance ; run ;

/* Does not work in batch */
*%put %scan(%sysget(SAS_EXECFILEPATH),4,%str(\)) ;

%perfstrt(txnname="Create 110M samp");
/* 100 million obs should make most servers sweat for at least 60 seconds */
data a;
*   do x = 1 to 1e8 ;
   do x = 1 to 1e6 ;
      y = ranuni(1234);
      z = int((x+1)/1e4)+1;
      output;
   end;
run;
%perfstop;

%perfstrt(txnname="Sort sample");
proc sort data=a out=b; by z; run;
%perfstop;

%perfstrt(txnname="Tabulate sample");
proc tabulate data=a out = work.tab_out ;
   class z;
   var x y;
   table z,(x y)*(n='cnt' mean='avg');
run;
%perfstop;
