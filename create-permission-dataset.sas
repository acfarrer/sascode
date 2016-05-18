%let incsv = /lillyce-dev/cdrtest/isilon-map/jreview-cluwe-permissions.csv ;

libname irdd '/sasfs/data/jreview/DEV/stats/irserver_el6/irdd' ;

/*data irxls.id_paths ;*/
/*length group $8 id $8 path $50 ;*/
/*infile incsv dsd ; /* dsd can handle both quoted and unquoted csv */*/
/*input group id path ;*/
/*run ;*/;

proc import datafile="&incsv"
out=irdd.id_paths ( rename=var1=userid rename=var2=path label="From &incsv") 
dbms=csv replace ;
getnames=no; guessingrows=2147483647 ;
run;

proc print data = irdd.id_paths ;
title 'Report of ids and paths' ;
run ;

/* When output location confirmed, archive output of last 12 runs */
/* proc datasets lib = irxls noprint memtype = data ; */
/* age id_paths id_paths1-id_paths12 ; */
/* quit ; */
