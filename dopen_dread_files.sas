data _null_ ;
filename sascode '~/sascode' ;
did=dopen('sascode') ;
numfiles=dnum(did) ; 
do i = 1 to numfiles ;
  docname=dread(did,i) ;
  if scan(docname,2,'.')='sas'
  then put docname ;
end ;
rc=dclose(did) ;
run ;
