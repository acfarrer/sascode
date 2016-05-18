/* Generate &syscc values to be parsed by LSF wrapper */
/* Some behaviour may be influenced by syntaxcheck option */
/* Explained by Jim Ward in Track 7611423321: */
/* How to make SAS set exit code when OS command used in SAS code with NOXCMD */
options syntaxcheck ;

DATA _NULL_; 
      INFILE 'ls -al' PIPE; 
      INPUT;  LIST; 
   RUN; 
   %PUT _ALL_; 

%put sysrc=&sysrc syscc=&syscc syserr=&syserr ;

