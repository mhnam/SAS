/*
DATE: 04/10/2018 - 04/17/2018
AUTHOR: MINHYUK NAM
PURPOSE: Testing
NOTES: 
1) Use UNIVARIATE with mu0 option
2) Use TTEST
*/

/*****CREATING DATASET*****/
DATA csi;
	INPUT csi @@; /* if there is no @@, then SAS would read in each row */
	LABEL csi = "소비자만족지수";
CARDS; /*DATALINES;*/
75 63 49 86 53 80 70 72 81 80 69 76 85 95 66 77 77 63 58 74
68 90 82 59 60 
;

DATA edu;
	INPUT group score @@;
	CARDS;
	1 65 1 70 1 76 1 63 1 72 1 71 1 68 1 68
	2 75 2 80 2 72 2 77 2 69 2 81 2 71 2 78
;

DATA paired;
	INPUT id pretest posttest @@;
	CARDS;
	01 80 82 02 73 71 03 70 95 04 60 69 05 88 100
	06 84 71 07 65 75 08 37 60 09 91 95 10 98 99
	11 52 65 12 78 83 13 40 60 14 79 86 15 59 62
;
RUN;

/*//////////
//SINGLE//
/////////*/
/*****PROC UNIVARIATE*****/
/*testing*/
PROC UNIVARIATE data = csi MU0 = 70; /*mu0 can be changed*/
	var csi;
RUN;

/*w/ confidence interval estimation*/
PROC UNIVARIATE data = csi MU0 = 70 alpha = 0.05 cibasic; /*alpha is for cibasic*/
	var csi;
RUN;

/*****PROC TTEST*****/
PROC TTEST data = csi H0 = 70; /*only ci for mean is possible*/
	var csi;
RUN;

/*/////////////////////////
//TWO GROUPS, INDEP//
////////////////////////*/

PROC TTEST data = edu;
	class group;
	var score;
RUN;

/*///////////////////////
//TWO GROUPS, DEP//
//////////////////////*/

PROC TTEST data = paired;
	paired pretest * posttest;
RUN;
