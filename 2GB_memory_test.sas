/* Stress machine memory by loading large arrays */
options fullstimer ;
/* Create 2 datasets to be combined into a hash array */
/* Consistently runs out of system memory at 2Gb */
/* fullstimer reports 5244986k when memsize=16G so 6G might be OK */
/* Gather ARM metric for each step */
%perfstrt(txnname="Create 55m samp"); 
data xw_test1;
   do mem_xw_id = 1 to 55000000;
     member = put(mem_xw_id, best25.);
     dtsc_cd = put(mem_xw_id, best5.);
     day_offset = 1;
     output;
   end;
 run;
%perfstop;

%perfstrt(txnname="Create 5k samp");
 data med_test1;
   do mem_xw_id = 1 to 5000;
     member = put(mem_xw_id, best25.);
     dtsc_cd = put(mem_xw_id, best5.);
     output;
   end;
 run;
%perfstop;

%perfstrt(txnname="Populate hash array");
 data mem_GLX01;
   length member $25 dtsc_cd $5 mem_xw_id day_offset 8.;

   if _n_ = 1 then do;
     declare hash m (hashexp:16, dataset: "xw_test1" );
     m.definekey ("member", "dtsc_cd");
     m.definedata("mem_xw_id", "day_offset");
     m.definedone();
     call missing (mem_xw_id, day_offset);
   end;

   set med_test1 end=eoftest ;
   by member dtsc_cd;

   rc=m.find(key:member, key:dtsc_cd );
   if eoftest then m.delete();

run;
%perfstop;

/* Dump options setting to the log */
proc options group=(sort memory performance) ; 
run ;
