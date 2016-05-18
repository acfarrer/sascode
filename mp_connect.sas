/* Use SAS/Connect without spawner */

options sascmd="/sasfs/test/sas/94/controlserver/sashome/SASFoundation/9.4/sas -work ~/saswork  -noobjectserver -noconnectmetaconnection" remote=local;
/* You can add the -rsasuser option to the above, but I don't think you'll need to */
signon test;
rsubmit;
   proc options option = config ; run ;
endrsubmit;

/* You can do a second signon and rsubmit as well: */

signon test2;
rsubmit test2;
   proc options group = extfiles ; run ;
endrsubmit;

signoff _all_;
