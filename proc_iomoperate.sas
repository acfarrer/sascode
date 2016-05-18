options metaconnect=gridtmeta2_8564_c226507 ;

/* From http://support.sas.com/documentation/cdl/en/biasag/63854/HTML/default/viewer.htm#n20042intelplatform00srvradm.htm */
proc iomoperate 
	spawned="440196D4-90F0-11D0-9F41-00A024BB830C" ;
/* Pointless - rarely finds the string */
/* logical = "SASApp94 - Logical Workspace Server" ; */

list types ; /* Useful */
quit ;

