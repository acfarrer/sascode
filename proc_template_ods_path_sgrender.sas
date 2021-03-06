/* ods path (prepend)work.template(update); From Chevelle Parker. Now in initstmt */

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

/* ods path work.templat(update) sasuser.templat(read) sashelp.tmplmst(read) ;*/

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
