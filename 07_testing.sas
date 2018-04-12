DATA goods;
	INPUT state $ count @@;
CARDS;
	Poor 54 Good 346
;
RUN;

PROC FREQ data = goods order = data;
	weight count; /*since the given data is not */
	exact binomial; /*to define a distribution*/
	tables state / binomial (p = 0.15)  alpha = 0.05;
RUN;
