/*
DATE: 17/05/2018 - 05/06/2018
AUTHOR: MINHYUK NAM
PURPOSE: ANOVA
NOTES: 
1) using ANOVA
2) using GLM
3) using GPLOT
*/

/*****CREATE DATASET*****/
DATA ONEFAC;
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

DATA HARVEST;
	DO FERTIL = 'F1', 'F2', 'F3', 'F4';
	DO resp = 1 TO 5;
	INPUT YIELD @@;
	OUTPUT;
	END;
	END;

CARDS;
	148 76 134 98 .
	166 153 255 . .
	264 214 327 304 .
	335 436 423 380 465
;

DATA SALES;
	DO city = 'Large  ', 'Middle', 'Small';
		DO design = 'A', 'B', 'C';
			DO resp = 1 to 3;
				INPUT sales @@;
				OUTPUT;
			END;
		END;
	END;

CARDS;
	23 20 21	22 19 20	19 18 21
	22 20 19	24 25 22	20 19 22
	18 18 16	21 23 20	20 22 24
;
RUN;

PROC PRINT data = ONEFAC;
RUN;

PROC PRINT data = HARVEST;
RUN;

PROC PRINT data = SALES;
RUN;

/*****ONE-WAY ANOVA*****/
PROC ANOVA data = ONEFAC;
	CLASS DENSITY; /*TO MARK X*/
	MODEL Y = DENSITY; /*TO MARK Y = X*/
RUN;

PROC ANOVA data = HARVEST;
	CLASS FERTIL; /*TO MARK X*/
	MODEL YIELD = FERTIL; /*TO MARK Y = X*/
RUN;

/*Multiple Comparison*/
PROC ANOVA data = ONEFAC;
	CLASS DENSITY; /*TO MARK X*/
	MODEL Y = DENSITY; /*TO MARK Y = X*/
	MEANS DENSITY / LSD ALPHA = 0.01; /*BON, SCHEFFE, TUKEY, DUNCAN // CLDIFF, LINES */
RUN;

PROC ANOVA data = HARVEST;
	CLASS FERTIL; /*TO MARK X*/
	MODEL YIELD = FERTIL; /*TO MARK Y = X*/
	MEANS FERTIL / HOVTEST = BARTLETT; /*There are various types of options - BARTLETT is used when distribution is normal, sample numbers are different, and generalised version of F test (more than three classes)*/
	MEANS FERTIL / TUKEY CLDIFF ALPHA = 0.1;
	MEANS FERTIL / TUKEY LINES ALPHA = 0.1;
RUN;

QUIT; /*to mark that the procedure is finished*/

/*CONTRAST ```USE GLM```*/
PROC GLM data = ONEFAC;
	CLASS DENSITY; /*TO MARK X*/
	MODEL Y = DENSITY; /*TO MARK Y = X*/
	CONTRAST '6% 8% 10 % VS 12%' DENSITY .33333 .33333 .33333 -1;
	CONTRAST '6% VS 8%' DENSITY 1 -1 0 0;
	MEANS DENSITY / LSD ALPHA = 0.01; /*NOT rejected b/c 1 and 2 are different under 2% p-value*/ /*BON, SCHEFFE, TUKEY, DUNCAN // CLDIFF, LINES */
RUN;

/*****TWO-WAY ANOVA*****/
PROC ANOVA data = SALES;
	CLASS city design; /*put TWO variables*/
	MODEL sales = city design city * design; /*put INTERACTION term*/
	MEANS city design city * design;
RUN;

QUIT;

/*Check Interaction Effect using Plot*/
PROC SUMMARY data = SALES nway;
	CLASS city design;
	VAR sales;
	OUTPUT out = meanout mean(sales) = mean;
RUN;

PROC PRINT data = meanout;
RUN;

/*
NOTE
i: connection method
w: width of line
v: shape of vertex
cv: colour of vertex
h: size of vertex
*/

symbol1 i = join w = 1 v = dot cv = black h = 2;
symbol2 i = join w = 1 v = circle cv = red h = 2;
symbol3 i = join w = 1 v = square cv = blue h = 2;

PROC GPLOT data = meanout;
	PLOT mean * city=design; /* PLOT <y-axis> * <x-axis> = <drawn by> */
RUN; /*By checking the plot, we can determine whether there is an interaction effect*/
