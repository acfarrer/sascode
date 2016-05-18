proc sql noprint;
  select distinct cats ("describe table dictionary.",memname,";")
  into :describeAll separated by ' '
  from dictionary.dictionaries
  ;

  %put %quote(&describeAll);

  &describeAll
quit; 
