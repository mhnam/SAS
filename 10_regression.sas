/*
DATE: 12/06/2018
AUTHOR: MINHYUK NAM
PURPOSE: REGRESSION
NOTES: 
1) using REG
*/

/*****CREATE DATASET*****/
DATA adversales;
	DO company = 1 to 12
	INPUT adver sales @@;
	OUTPUT;
	END; /*to finish DO loop*/

CARDS;
	11 23 19 32 23 36 26 46 56 93
	62 99 29 49 30 50 38 65 39 70
	46 71 49 89
;

PROC PRINT data = adversales;
RUN;

/*****REGRESSION*****/
PROC REG data = adversales;
	MODEL sales = adver / dw;
	PLOT sales * adver;
RUN;
QUIT
