/* From usage note 51580 */
/* Working using sasgsub -GRIDSUBMITPGM */

proc export data=sashelp.class outfile='!HOME/temp/myfile.xlsx' dbms=xlsx;
   sheet=class;
run;

proc export data=sashelp.shoes outfile='!HOME/temp/myfile.xlsx' dbms=xlsx;
   sheet=shoes;
run;
