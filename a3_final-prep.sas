/*
DATE: 13/06/2018
AUTHOR: MINHYUK NAM
PURPOSE: FINAL PREP
NOTES: 
1) using REG
2) using ANOVA
3) using CORR
*/

/*QUESTION 1*/
DATA steel;
	DO TYPE = 1 TO 10;
	INPUT X Y @@;
	OUTPUT;
	END;

CARDS;
20 10 30 16 40 22 50 30 60 35
70 40 80 45 90 50 100 60 25 15
;
RUN;

PROC REG data = steel;
	MODEL Y = X;
	PLOT Y*X;
RUN;

QUIT;

/*QUESTION 2*/
DATA toy;
	DO COLOR = 'RED', 'BLUE', 'YELLOW', 'GREEN';
	DO RESP = 1 TO 10;
	INPUT TIME@@;
	OUTPUT;
	END;
	END;
	
CARDS;
	71 24 52 24 62 44 27 26 45 29
	19 35 54 37 16 27 18 25 33 44
	66 26 36 38 76 85 27 80 64 50
	20 26 46 16 32 37 22 19 24 45
;
RUN;

PROC ANOVA;
	CLASS COLOR;
	MODEL TIME = COLOR;
	MEANS COLOR / LSD CLDIFF;
RUN;
QUIT;

/*QUESTION 3*/
DATA satisfaction;
	INPUT SEX YEAR Q3 - Q12@@;

CARDS;
	1  1  5  5  5  3  3  4  5  3  5  4  
	1  1  5  5  5  5  5  4  4  4  5  4 
	1  1  3  3  2  4  4  5  4  3  3  4  
	1  1  4  5  3  5  4  4  4  3  2  4
	1  2  5  4  5  5  4  3  3  5  4  5 
	1  2  2  2  2  4  4  4  4  3  3  2
	1  2  4  3  4  5  5  4  3  2  2  3
	1  2  5  4  5  5  4  3  4  4  2  4
	1  3  4  3  4  1  2  3  2  3  4  3
	1  2  2  3  2  5  4  5  4  2  3  3 
	2  3  3  2  2  4  4  3  3  4  4  3 
	2  2  4  4  4  4  4  3  4  3  4  4
	2  4  3  4  4  4  4  3  2  3  3  4  
	2  3  4  4  3  4  2  3  2  3  3  3 
	2  4  3  3  2  4  4  3  3  4  3  3 
	2  3  4  4  3  5  4  3  5  3  2  4 
	2  1  4  3  4  3  4  4  3  2  2  3 
	2  3  2  2  3  5  4  3  4  3  4  2
	2  1  4  3  4  4  3  4  3  3  2  3 
	2  4  4  4  4  4  4  3  3  3  4  4  
	1  2  3  2  2  3  4  3  3  2  3  3  
	1  4  4  3  4  4  3  4  3  3  4  4 
	1  3  4  4  4  4  4  4  4  4  4  4 
	1  2  3  3  3  3  3  3  3  3  3  3
	1  2  4  3  4  4  3  3  3  3  4  4  
	1  4  3  3  3  4  4  3  4  3  3  3
;
RUN;

PROC CORR DATA = satisfaction ALPHA;
	VAR Q3 Q4 Q5 Q6;
RUN;


DATA satisfaction_v1;
	SET satisfaction;
	IF SEX = 2 THEN FEMALE = 1;
	ELSE FEMALE = 0;
	PREP = Q3 + Q4 + Q5;
	ENV = Q7 + Q8;
	PARTICIP = Q9 + Q10;
RUN;

PROC ANOVA data = satisfaction_v1;
	CLASS YEAR;
	MODEL PREP = YEAR;
	MEANS YEAR / LSD CLDIFF;
RUN;
QUIT;

PROC REG data = satisfaction_v1;
	MODEL Q12 = PREP ENV PARTICIP
				/ SELECTION = STEPWISE;
	PLOT Q12 * PREP;
RUN;
QUIT;
