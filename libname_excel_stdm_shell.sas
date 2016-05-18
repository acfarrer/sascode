/*From stdm_shell.sas supplied by Kyle */

%let projdir_=\\mango\sddext.grp\SDDEXT053\lillyce\b5k_mc_ibhd;
%let projdir=&projdir_\intrm1; 
%let sdtmspec1=&projdir_\Study_documents\B5K-MC-IBHD_SDTM_STUDYSPEC1.xlsx; 

libname inxls1 excel "&sdtmspec1" header=no mixed=yes scan_text=no;

/* Gives ERROR: The EXCEL engine cannot be found.*/
