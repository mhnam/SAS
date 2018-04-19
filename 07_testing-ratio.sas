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

DATA support;
	INPUT gender $ yesno $ count @@;
CARDS;
	남자 YES 110 남자 NO 140
	여자 YES 104 여자 NO 96
;

DATA exam;
	INPUT pre $ post $ count @@;
CARDS;
	YES YES 63 YES NO 4
	NO YES 21 NO NO 12
;
RUN;

/*****PROC FREQ*****/
/*ci*/
PROC FREQ data = goods order = data;
	weight count; /*since the given data is not */
	exact binomial; /*to define a distribution*/
	tables state / binomial (p = 0.15)  alpha = 0.05;
RUN;

/*indep*/
PROC FREQ data = support order = data;
	weight count;
	tables gender * yesno / fisher chisq nopercent nocol;
RUN;

/*dep*/
PROC FREQ data = exam;
	weight count;
	exact mcnem; /*cannot be used as option*/
	tables pre * post;
RUN;

/*dep - wrong case*/
PROC FREQ data = exam;
	weight count;
	exact fisher; /*cannot be used as option*/
	tables pre * post;
RUN;
