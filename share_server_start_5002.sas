%let tcpsec = _secure_ ;

/* Start basic service */
proc server serverid=__5002 oapw=blue31 AUTHENTICATE=required ;
*proc server serverid=__5002 oapw=blue31 AUTHENTICATE=optional ;
run;
