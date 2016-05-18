/* SAS/Share service for JReview connections */
/* Isilon location suggested by Clarence Moore. 22Apr2016 */
libname lclffdrs '/lillyce-dev/cdrtest/ly12345678/f1j_us_hmfr/final/data/raw/shared/' access = readonly ;
/* Unsecured until pam.d config is working */
*%let tcpsec = _secure_ ;
proc server id=__5005
authenticate=opt
uapw=blue5005
oapw=blue5005 ;
run;
