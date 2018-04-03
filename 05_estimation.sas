/*
DATE: 03/04/2018
AUTHOR: MINHYUK NAM
PURPOSE: Estimation
NOTES: Use UNIVARIATE with CIBASIC
*/

/*****CREATING DATASET*****/
DATA csi;
	INPUT csi @@; /* if there is no @@, then SAS would read in each row */
CARDS; /*DATALINES;*/
12 48 39 59 94 38 48 18 93 48 57 83 92 37 55 92 71 37
19 27 47 37 74 91 29 49 30 50 20 18 58
;
RUN;

DATA drink;
	INPUT age drink $ count @@;
CARDS;
18 A 10 19 A 13 20 A 12
18 B 14 19 B 7 20 B 4
18 C 2 19 C 10 20 C 6
18 D 12 19 D 8 20 D 10
;
RUN;

/*****PROC UNIVARIATE*****/
/*default*/
PROC UNIVARIATE data = csi cibasic alpha = 0.05;
	LABEL csi = "소비자만족지수";
RUN;
