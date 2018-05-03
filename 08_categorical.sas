/*
DATE: 03/05/2018
AUTHOR: MINHYUK NAM
PURPOSE: Testing categorical variable
NOTES: 
1) using freq
*/

/*****CREATE DATASET*****/
DATA soft;
	INPUT age $ beverage $ count @@;
CARDS;
	20대 coke 10 20대 pepsi 14 20대 fanta 4 20대 others 12
	30대 coke 13 30대 pepsi 9 30대 fanta 10 30대 others 8
	40대 coke 12 40대 pepsi 8 40대 fanta 10 40대 others 10
;

DATA edueco;
	INPUT edu eco count @@;
CARDS;
	1 1 255 1 2 105 1 3 81
	2 1 110 2 2 92 2 3 66
	3 1 90 3 2 113 3 3 88 
;

DATA bean;
	INPUT type count @@;
CARDS;
	1 315 2 108 3 101 4 32
;
RUN;

/*****동질성검정*****/
PROC FREQ data = soft order = data;
	weight count;
	exact fisher;
	tables age * beverage / nocol nopercent expected chisq;
RUN;

/*****독립성검정*****/
PROC FREQ data = edueco order = data;
	weight count;
	tables edu * eco / nocol nopercent chisq measures;
RUN;

/*****적합도검정(1)*****/
PROC FREQ data = bean;
	weight count;
	tables type / nocum testp = (0.5625 0.1875 0.1875 0.0625);
RUN;

/*****적합도검정(2)*****/
PROC FREQ data = bean;
	weight count;
	tables type / nocum testf = (317 106 90 43);
RUN;

/*****적합도검정(3)*****/
PROC FREQ data = bean;
	weight count;
	tables type / binomial (p=0.5625);
RUN;
