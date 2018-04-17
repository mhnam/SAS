/*
DATE: 04/12/2018
AUTHOR: MINHYUK NAM
PURPOSE: Testing
NOTES: 
1) Use FREQ
*/

/*****CREATING DATASET*****/
DATA goods;
	INPUT state $ count @@;
CARDS;
	Poor 54 Good 346
;
RUN;

/*****PROC FREQ*****/
PROC FREQ data = goods order = data;
	weight count; /*since the given data is not */
	exact binomial; /*to define a distribution*/
	tables state / binomial (p = 0.15)  alpha = 0.05;
RUN;
