/* Copied from Interactive Program1 in GridMix.egp */

%let CPUMinutes =1;
%let DiskMinutes =1;
%let SleepMinutes =1;
%let FlagDataset =!HOME/stopflag.dat;

%macro GridLoad;

%let IterNum =1;

%let ContinueFlag =1;
%do %while(&ContinueFlag.);

/* Copy the 10 GB file randomly to a directory, and clean up the old file */

data _null_;
_rnum = floor(ranuni(0) * 9000) + 1000; /* generate a number between 1000 and 9999 */
call symput("ToFile", "LoadData"||put(_rnum, z4.));
run;

data &ToFile.;
set &FromFile.;
_rnum = floor(ranuni(0) * 10000); /* generate a number between 0 and 9999 */
VL4N01 = put(_rnum, z4.); /* change the data slightly to foil cache managers */
run;

proc sql;
drop table &FromFile.;
quit;

%let FromFile =&ToFile.;

/* Sleep for as many minutes as indicated in SleepMinutes */

data _null_;
_time = &SleepMinutes. * 60;
_rvar = sleep(_time, 1);
run;

/* Do a bunch of cpu processing that hits a large number of memory locations */

data _null_;
array NumArray ArrayElm000001-ArrayElm999999; /* large numeric vector to fill up a bunch of memory */

call streaminit(1259);

do LoopCount = 1 to &CPUMinutes.; /* pound the cpu for as many minutes as indicated in CPUMinutes */

do i = 1 to 999999; /* fill it up with random numbers */
  NumArray(i) = rand('uniform');
end;

call sortn(of NumArray(*)); /* sort it */

do i = 1 to 999999; /* copy random locations into sequential locations */
rnum = ceil(rand('uniform')*999998);
NumArray(i) = NumArray(rnum);
end;

do i = 1 to 625000000; /* calculate a bunch of factorials */
xnum = ceil(rand('uniform')*170);
rnum = ceil(rand('uniform')*999998);
NumArray(rnum) = fact(xnum);
end;

do i = 1 to 999999; /* take the square root of all of the elements */
  NumArray(i) = sqrt(NumArray(i));
end;

do i = 1 to 999998; /* put the ith location in the i+1th location */
j = i + 1;
NumArray(i) = NumArray(j);
end;

call sortn(of NumArray(*)); /* sort it */

end;

run;

/* Check if the flag dataset has been created, if it has set the flag to stop */

/* Uncomment this block to turn on dataset semaphore 

data _null_;
if fileexist("&FlagDataset.")
then call symput('ContinueFlag', '0');
run;

*/

/* For now, we'll only run one time. Take out or comment following code to turn back on semaphore */

data _null_; call symput('ContinueFlag', '0'); run;

%end;
%mend GridLoad;

/* Create the 10 GB random data file...about 2 minutes of overhead */

data LoadDataMaster;

/* Create an 11,000 byte string of random characters, to substring from */

length _ScrapHeap $ 11000;
_Reservoir = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789`-=[]\;',./~!@#$%^&*()_+{}|:""<>?";
_LnRes = length(_Reservoir);
call streaminit(1311261018);
do _i = 1 to 11000;
  _ScrapHeap = trim(_ScrapHeap) || substr(_Reservoir, ceil((rand('uniform') * _LnRes)), 1);
end;

/* Generate the variables */

do _i = 1 to 3000000;

/* Numeric - 200 variables */

V10 = rand('uniform'); V11 = rand('uniform'); V12 = rand('uniform'); V13 = rand('uniform'); V14 = rand('uniform'); V15 = rand('uniform'); V16 = rand('uniform'); V17 = rand('uniform'); V18 = rand('uniform'); V19 = rand('uniform'); 
V20 = rand('uniform'); V21 = rand('uniform'); V22 = rand('uniform'); V23 = rand('uniform'); V24 = rand('uniform'); V25 = rand('uniform'); V26 = rand('uniform'); V27 = rand('uniform'); V28 = rand('uniform'); V29 = rand('uniform'); 
V30 = rand('uniform'); V31 = rand('uniform'); V32 = rand('uniform'); V33 = rand('uniform'); V34 = rand('uniform'); V35 = rand('uniform'); V36 = rand('uniform'); V37 = rand('uniform'); V38 = rand('uniform'); V39 = rand('uniform'); 
V40 = rand('uniform'); V41 = rand('uniform'); V42 = rand('uniform'); V43 = rand('uniform'); V44 = rand('uniform'); V45 = rand('uniform'); V46 = rand('uniform'); V47 = rand('uniform'); V48 = rand('uniform'); V49 = rand('uniform'); 
V50 = rand('uniform'); V51 = rand('uniform'); V52 = rand('uniform'); V53 = rand('uniform'); V54 = rand('uniform'); V55 = rand('uniform'); V56 = rand('uniform'); V57 = rand('uniform'); V58 = rand('uniform'); V59 = rand('uniform'); 
V60 = rand('uniform'); V61 = rand('uniform'); V62 = rand('uniform'); V63 = rand('uniform'); V64 = rand('uniform'); V65 = rand('uniform'); V66 = rand('uniform'); V67 = rand('uniform'); V68 = rand('uniform'); V69 = rand('uniform'); 
V70 = rand('uniform'); V71 = rand('uniform'); V72 = rand('uniform'); V73 = rand('uniform'); V74 = rand('uniform'); V75 = rand('uniform'); V76 = rand('uniform'); V77 = rand('uniform'); V78 = rand('uniform'); V79 = rand('uniform'); 
V80 = rand('uniform'); V81 = rand('uniform'); V82 = rand('uniform'); V83 = rand('uniform'); V84 = rand('uniform'); V85 = rand('uniform'); V86 = rand('uniform'); V87 = rand('uniform'); V88 = rand('uniform'); V89 = rand('uniform'); 
V90 = rand('uniform'); V91 = rand('uniform'); V92 = rand('uniform'); V93 = rand('uniform'); V94 = rand('uniform'); V95 = rand('uniform'); V96 = rand('uniform'); V97 = rand('uniform'); V98 = rand('uniform'); V99 = rand('uniform'); 
V100 = rand('uniform'); V101 = rand('uniform'); V102 = rand('uniform'); V103 = rand('uniform'); V104 = rand('uniform'); V105 = rand('uniform'); V106 = rand('uniform'); V107 = rand('uniform'); V108 = rand('uniform'); V109 = rand('uniform'); 
V110 = rand('uniform'); V111 = rand('uniform'); V112 = rand('uniform'); V113 = rand('uniform'); V114 = rand('uniform'); V115 = rand('uniform'); V116 = rand('uniform'); V117 = rand('uniform'); V118 = rand('uniform'); V119 = rand('uniform'); 
V120 = rand('uniform'); V121 = rand('uniform'); V122 = rand('uniform'); V123 = rand('uniform'); V124 = rand('uniform'); V125 = rand('uniform'); V126 = rand('uniform'); V127 = rand('uniform'); V128 = rand('uniform'); V129 = rand('uniform'); 
V130 = rand('uniform'); V131 = rand('uniform'); V132 = rand('uniform'); V133 = rand('uniform'); V134 = rand('uniform'); V135 = rand('uniform'); V136 = rand('uniform'); V137 = rand('uniform'); V138 = rand('uniform'); V139 = rand('uniform'); 
V140 = rand('uniform'); V141 = rand('uniform'); V142 = rand('uniform'); V143 = rand('uniform'); V144 = rand('uniform'); V145 = rand('uniform'); V146 = rand('uniform'); V147 = rand('uniform'); V148 = rand('uniform'); V149 = rand('uniform'); 
V150 = rand('uniform'); V151 = rand('uniform'); V152 = rand('uniform'); V153 = rand('uniform'); V154 = rand('uniform'); V155 = rand('uniform'); V156 = rand('uniform'); V157 = rand('uniform'); V158 = rand('uniform'); V159 = rand('uniform'); 
V160 = rand('uniform'); V161 = rand('uniform'); V162 = rand('uniform'); V163 = rand('uniform'); V164 = rand('uniform'); V165 = rand('uniform'); V166 = rand('uniform'); V167 = rand('uniform'); V168 = rand('uniform'); V169 = rand('uniform'); 
V170 = rand('uniform'); V171 = rand('uniform'); V172 = rand('uniform'); V173 = rand('uniform'); V174 = rand('uniform'); V175 = rand('uniform'); V176 = rand('uniform'); V177 = rand('uniform'); V178 = rand('uniform'); V179 = rand('uniform'); 
V180 = rand('uniform'); V181 = rand('uniform'); V182 = rand('uniform'); V183 = rand('uniform'); V184 = rand('uniform'); V185 = rand('uniform'); V186 = rand('uniform'); V187 = rand('uniform'); V188 = rand('uniform'); V189 = rand('uniform'); 
V190 = rand('uniform'); V191 = rand('uniform'); V192 = rand('uniform'); V193 = rand('uniform'); V194 = rand('uniform'); V195 = rand('uniform'); V196 = rand('uniform'); V197 = rand('uniform'); V198 = rand('uniform'); V199 = rand('uniform'); 
V200 = rand('uniform'); V201 = rand('uniform'); V202 = rand('uniform'); V203 = rand('uniform'); V204 = rand('uniform'); V205 = rand('uniform'); V206 = rand('uniform'); V207 = rand('uniform'); V208 = rand('uniform'); V209 = rand('uniform'); 

/* 20 1 byte chars */

length VL1N01 VL1N02 VL1N03 VL1N04 VL1N05 VL1N06 VL1N07 VL1N08 VL1N09 VL1N10 VL1N11 VL1N12 VL1N13 VL1N14 VL1N15 VL1N16 VL1N17 VL1N18 VL1N19 VL1N20 $ 1;

VL1N01 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N02 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N03 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N04 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N05 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N06 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N07 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N08 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N09 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N10 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N11 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N12 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N13 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N14 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N15 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N16 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N17 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N18 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N19 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);
VL1N20 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 1);

/* 20 4 byte chars */

length VL4N01 VL4N02 VL4N03 VL4N04 VL4N05 VL4N06 VL4N07 VL4N08 VL4N09 VL4N10 VL4N11 VL4N12 VL4N13 VL4N14 VL4N15 VL4N16 VL4N17 VL4N18 VL4N19 VL4N20 $ 4;

VL4N01 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N02 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N03 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N04 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N05 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N06 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N07 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N08 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N09 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N10 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N11 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N12 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N13 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N14 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N15 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N16 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N17 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N18 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N19 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);
VL4N20 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 4);

/* 30 8 byte chars */

length VL8N01 VL8N02 VL8N03 VL8N04 VL8N05 VL8N06 VL8N07 VL8N08 VL8N09 VL8N10 VL8N11 VL8N12 VL8N13 VL8N14 VL8N15 VL8N16 VL8N17 VL8N18 VL8N19 VL8N20 VL8N21 VL8N22 VL8N23 VL8N24 VL8N25 VL8N26 VL8N27 VL8N28 VL8N29 VL8N30 $ 8;

VL8N01 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N02 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N03 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N04 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N05 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N06 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N07 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N08 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N09 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N10 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N11 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N12 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N13 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N14 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N15 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N16 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N17 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N18 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N19 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N20 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N21 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N22 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N23 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N24 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N25 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N26 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N27 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N28 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N29 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);
VL8N30 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 8);

/* 20 20 byte chars */

length VL20N01 VL20N02 VL20N03 VL20N04 VL20N05 VL20N06 VL20N07 VL20N08 VL20N09 VL20N10 VL20N11 VL20N12 VL20N13 VL20N14 VL20N15 VL20N16 VL20N17 VL20N18 VL20N19 VL20N20 $ 20;

VL20N01 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N02 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N03 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N04 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N05 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N06 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N07 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N08 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N09 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N10 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N11 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N12 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N13 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N14 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N15 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N16 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N17 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N18 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N19 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);
VL20N20 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 20);

/* 10 100 byte chars */

length VL100N01 VL100N02 VL100N03 VL100N04 VL100N05 VL100N06 VL100N07 VL100N08 VL100N09 VL100N10 $ 100;

VL100N01 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 100);
VL100N02 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 100);
VL100N03 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 100);
VL100N04 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 100);
VL100N05 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 100);
VL100N06 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 100);
VL100N07 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 100);
VL100N08 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 100);
VL100N09 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 100);
VL100N10 = substr(_ScrapHeap, ceil(rand('uniform') * 10000), 100);

drop _:;
output;

end;

run;

%let FromFile =LoadDataMaster;

%GridLoad; run;