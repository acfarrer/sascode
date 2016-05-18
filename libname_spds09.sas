

 LIBNAME SPDS09 SASSPDS  LIBGEN=YES  IP=YES  DISCONNECT=YES schema="tmyr09" 
 USER="dataadm" PASSWORD="spds7737" HOST='localhost' Serv='5404' 
 unixdomain=yes netcomp=no compress=yes; 

  LIBNAME SPDS10 SASSPDS  LIBGEN=YES  IP=YES  DISCONNECT=YES schema="tmyr10" 
 USER="dataadm" PASSWORD="spds7737" HOST='localhost' Serv='5404' 
 unixdomain=yes netcomp=no compress=yes; 

  LIBNAME SPDS11 SASSPDS  LIBGEN=YES  IP=YES  DISCONNECT=YES schema="tmyr11" 
 USER="dataadm" PASSWORD="spds7737" HOST='localhost' Serv='5404' 
 unixdomain=yes netcomp=no compress=yes; 

  LIBNAME SPDS12 SASSPDS  LIBGEN=YES  IP=YES  DISCONNECT=YES schema="tmyr12" 
 USER="dataadm" PASSWORD="spds7737" HOST='localhost' Serv='5404' 
 unixdomain=yes netcomp=no compress=yes; 

proc sql ;
select distinct libname, memname, nobs from dictionary.tables 
where libname in ('SPDS09','SPDS10','SPDS11','SPDS12') ;
quit ;
