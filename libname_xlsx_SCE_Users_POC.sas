/* Successfully executed by Kapil Gulati. 10Feb2016*/

%let folderpath = /sasfs/data/advan/scetest ; /* Running as c226507 gives Error code=8000101D */
%let xlsxname = sashelp_Multisheet5.xlsx ;
     
libname testxlsx xlsx "&folderpath./&xlsxname" ;

data testxlsx.sashelp_shoes ; set sashelp.shoes ; run ;
data testxlsx.sashelp_class ; set sashelp.class ; run ;

libname testxlsx clear ;
