/*
DATE: 10/04/2018
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
RUN;

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
/*single*/
PROC TTEST data = csi H0 = 70; /*only ci for mean is possible*/
	var csi;
RUN;

/*two groups with indep.*/

/*two groups with matching sample*/
