/*
DATE: 12/06/2018
AUTHOR: MINHYUK NAM
PURPOSE: REGRESSION
NOTES: 
1) using REG
*/

/*****CREATE DATASET*****/
DATA adversales;
	DO DENSITY = '  6%', '  8%', '10%', '12%'; /* 1 to 4; *수분함유량 OR use respective*/
	INPUT Y @@;
	OUTPUT;
	END; /*to finish DO loop*/

CARDS;
	6250 6150 6080 6200
	6300 6290 6120 6220
	6420 6170 6020 6010
	6220 6180 6040 6030
	6320 6080 6020 6000
;

PROC PRINT data = adversales;
RUN;

/*****REGRESSION*****/
PROC REG data = adversales;
	MODEL sales = adver / dw;
	PLOT sales * adver;
RUN;
QUIT
