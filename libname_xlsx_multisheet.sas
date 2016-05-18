libname testxlsx xlsx '/net/unixfs1/fs_guts_sas/sas/Andrew/MultisheetgsubDMS.xlsx' ;

data testxlsx.sheet1 ; set sashelp.shoes ; run ;

data testxlsx.sheet2 ; set sashelp.class ; run ;


libname testxlsx list ;

proc print data = testxlsx.sheet2 ;
run ;

data work.fromxlsx ;
set testxlsx.sheet2 (obs = 10) ;
run ;
