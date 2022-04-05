/* From Howard Schreier on 27Jan2005 */
/* http://groups.google.ca/group/comp.soft-sys.sas/msg/743aa83fa692edcb */
data one; 
do key = .,1,2,4; output; end; 
run; 
data two; 
do key = 1,2,3; output; end; 
run; 

/* Equivalent to merge with data set (in=) option */
proc sql; 
select 
  coalesce(one.key,two.key) as key, 
  case when one.key is not null then 1 else 0 end as in_one, 
  case when two.key is not null then 1 else 0 end as in_two 
 from one full join two on one.key=two.key; 
quit; 
