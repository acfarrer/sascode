/* Test return code translation by LSF */
data _null_ ; 
*abort ;        /* sets the ERRORLEVEL variable to 3 */
*abort return 1 ;  /* attempt to emulate a warning  */
*abort return ; /* sets the ERRORLEVEL variable to 4 */
*abort abend ;  /* sets the ERRORLEVEL variable to 5 */
abort return 15 ; /* sets the ERRORLEVEL variable to 15 */
*abort abend 15 ;  /* sets the ERRORLEVEL variable to 15 */
run ;
