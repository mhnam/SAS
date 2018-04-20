/*
DATE: 03/04/2018
AUTHOR: MINHYUK NAM
PURPOSE: Estimation
NOTES:
1) Estimate mean: Use UNIVARIATE with CIBASIC
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

DATA goods;
	INPUT state $ count @@;
CARDS;
	Poor 54 Good 346
;
RUN;

/*****MEAN*****/
/*PROC UNIVARIATE*/
PROC UNIVARIATE data = csi cibasic alpha = 0.05;
	var csi;
	LABEL csi = "소비자만족지수";
RUN;

/*PROC MEANS*/
PROC MEANS data = csi n mean std clm alpha = 0.05; /*only ci for mean is possible*/
	var csi;
	LABEL csi = "소비자만족지수";
RUN;

/*****RATIO*****/
/*PROC FREQ*/
PROC FREQ data = goods order = data;
	weight count; /*since the given data is not */
	exact binomial; /*to define a distribution*/
	tables state / binomial (p = 0.15)  alpha = 0.05;
RUN;
