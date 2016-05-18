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

proc sgrender data=sashelp.class template=scatter;
run;

ods path show ;

ods path work.templat(update) sasuser.templat(read)sashelp.tmplmst(read);

ods path show ;
