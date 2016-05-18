/* Other users may need to change to writable location */

*let unixfilepath = /net/unixfs1/fs_guts_sas/sas/Andrew/sashelp_Multisheet5.xlsx ;
%let folderpath = /lillyce-dev/prd/ly12345678-it/q311sidb/programs/sas-test/Andrew ;
%let xlsxname = sashelp_Multisheet6.xlsx ;
*put "&folderpath./&xlsxname" ;
	
libname testxlsx xlsx "&folderpath./&xlsxname" ;

data testxlsx.sashelp_shoes ; set sashelp.shoes ; run ;

data testxlsx.sashelp_class ; set sashelp.class ; run ;

libname testxlsx list ;
/* As per 7611693130 to stop results from frezing EG. Still not solid */
libname testxlsx clear ;


	
