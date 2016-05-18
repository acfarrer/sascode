/* From http://support.sas.com/documentation/cdl/en/armref/64756/HTML/default/viewer.htm#n1vhd78wv8ywv4n15sgz0eak4jno.htm */
options mprint ;

libname armout '~/armdata' ;

%armproc(lib=armout,log=~/ARMlogs/2_SPDS09_CC_OUTPTRX0912_YES_20160224:16:27:36.log) ;
%armproc(lib=armout,log=~/ARMlogs/3_SPDS09_CC_OUTPTRX_CMP_YES_20160224:16:27:37.log) ;
%armproc(lib=armout,log=~/ARMlogs/4_SPDS10_CC_OUTPTRX_YES_20160224:16:27:41.log) ;

*%armproc(lib=armout,log=~/saslogs/tabulate1M_armlog.log) ;

/*  From http://support.sas.com/documentation/cdl/en/armref/64756/HTML/default/viewer.htm#p12wwm09at8iz0n1jo2hlnr4lf2d.htm*/

    %armjoin(libin=armout,libout=work);
run;

/* SAS view work.txnview looks nice but needs work to create meaningful report */
