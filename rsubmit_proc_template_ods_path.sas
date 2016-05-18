
/* Use SAS/Connect without spawner */

options sascmd="/sasfs/test/sas/94/controlserver/sashome/SASFoundation/9.4/sas -rsasuser -work ~/saswork  -noobjectserver -noconnectmetaconnection" remote=local;
/* You can add the -rsasuser option to the above, but I don't think you'll need to */
signon test;
rsubmit;

libname sasuser list ;
libname work list ;

ods path show ;

proc template;
  define statgraph Scatter;
    begingraph;
      entrytitle "Test";
      layout overlay;
        scatterplot y=weight x=height / datalabel=name;
      endlayout;
    endgraph;
  end;
run;

ods path show ;

ods listing gpath="~/sasprint" ;

proc sgrender data=sashelp.class template=scatter;
run;

ods path show ;

proc template;
  define statgraph Scatter;
    begingraph;
      entrytitle "Test";
      layout overlay;
        scatterplot y=weight x=height / datalabel=name;
      endlayout;
    endgraph;
  end;
run;

ods path show ;

proc sgrender data=sashelp.class template=scatter;
run;

/* ods path work.templat(update) sasuser.templat(read) sashelp.tmplmst(read) ; */

ods path show ;

proc template;
  define statgraph Scatter;
    begingraph;
      entrytitle "Test";
      layout overlay;
        scatterplot y=weight x=height / datalabel=name;
      endlayout;
    endgraph;
  end;
run;

ods path show ;

proc sgrender data=sashelp.class template=scatter;
run;
endrsubmit ;
signoff ;

