 options mprint ;
 
%macro readxlsx_user ;
libname inxlsx pcfiles server=ix1gridppcfile2 
user='am\c226507' pass='{SAS002}6F5D9D5B2EEE35A207535896509FBE01' 
path ='\\statsclstr-d\lillyce-dev\qa\ly2820671js6\xxx_xx_3333\prelock\programs\PCFILES_Testing\Public\ManuallyCreatedMultisheet.xlsx' 
;
/*ERROR: CLI error trying to establish connection: [Microsoft][ODBC Excel Driver] The Microsoft Access database engine cannot open or */
/*       write to the file '(unknown)'. It is already opened exclusively by another user, or you need permission to view and write */
/*       its data.*/
%mend readxlsx_user ;

%macro readxlsx_serveruser ;
libname inxlsx pcfiles server=ix1gridppcfile2 
serveruser='am\c226507' serverpass='{SAS002}6F5D9D5B2EEE35A207535896509FBE01' 
path ='\\statsclstr-d\lillyce-dev\qa\ly2820671js6\xxx_xx_3333\prelock\programs\PCFILES_Testing\Public\SASCreatedMultisheet.xlsx' 
;
/*ERROR: Server is unable to authenticate user credentials. (missing or invalid SERVERUSER=<username> SERVERPASS=<password> on */
/*       libname statement).*/
%mend readxlsx_serveruser ;

%macro readxlsx_nouser ;
libname inxlsx pcfiles server=ix1gridppcfile2 
path ='\\statsclstr-d\lillyce-dev\qa\ly2820671js6\xxx_xx_3333\prelock\programs\PCFILES_Testing\Public\SASCreatedMultisheet.xlsx' 
;
/*ERROR: CLI error trying to establish connection: [Microsoft][ODBC Excel Driver] The Microsoft Access database engine cannot open or */
/*       write to the file '(unknown)'. It is already opened exclusively by another user, or you need permission to view and write */
/*       its data.*/
%mend readxlsx_nouser ;

%macro local_share ;
libname inxlsx pcfiles server=ix1gridppcfile2 
path ="\\IX1GRIDTPCFILE2\XLSX2Read\ManuallyCreatedMultisheet.xlsx"
access = readonly ;
%mend local_share ;

%readxlsx_user ;
%readxlsx_serveruser ;
%readxlsx_nouser ;
%local_share ;

