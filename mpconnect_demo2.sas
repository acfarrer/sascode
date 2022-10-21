
  /* Signon to two separate Multi-Process CONNECT sessions */
  signon sortask1 sascmd="/opt/sas/SASFoundation/9.3/sas -nosyntaxcheck -noterminal" ;
  signon sortask2 sascmd="/opt/sas/SASFoundation/9.3/sas -nosyntaxcheck -noterminal" ;

 /* You will need to now create libraries in which to store your */
 /* data for this sample.  Uncomment and specify your own path...*/

  libname loc1 '/saswork/mpconnect/loc1';
*  libname loc2 '/saswork/mpconnect/loc2';

 /* Use the SASHELP data library shipped with the SAS System to  */
 /* create datasets to sort and merge.                           */
data loc1.prod1;
   set sashelp.prdsal2;
run;

data loc1.prod2;
   set sashelp.prdsal3;
run;

 /*******************/
 /* First sort task */
 /*******************/
rsubmit sortask1 wait=no;
   libname stask1 '/saswork/mpconnect/loc1';

   proc sort data=stask1.prod1 out=stask1.sort1 force;
     by year;
   run;
endrsubmit;

 /********************/
 /* Second sort task */
 /********************/
rsubmit sortask2 wait=no;
   libname stask1 '/saswork/mpconnect/loc1';

   proc sort data=stask1.prod2 out=stask1.sort2 force;
     by year;
   run;
endrsubmit;

 /* See the processes running in background                    */
listtask;

waitfor _all_ sortask1 sortask2;

data loc1.mergit;
   merge loc1.sort1 loc1.sort2;
   by year;
run;

title "Combined Data Set";
proc print data=loc1.mergit (obs=10);
run;

 /* Signoff both Multi-Process CONNECT sessions and see the remote logs */
 
signoff sortask1;
signoff sortask2;
