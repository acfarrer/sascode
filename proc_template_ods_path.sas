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

