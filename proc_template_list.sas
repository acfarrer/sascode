proc template ;
list /store=sasuser.templat ;
run ;

proc template ;
path sasuser.templat ;
*list /store=sasuser.templat ;
source / where=(datepart(modified) = today()-1);
run ;
