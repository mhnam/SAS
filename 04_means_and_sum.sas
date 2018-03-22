/*
DATE: 22/03/2018
AUTHOR: MINHYUK NAM
PURPOSE: Summary Statitsitcs
NOTES: There are 3 different kinds of procedure
1) means
2) summary
*/

/*****CREATING DATASET*****/
DATA score;
	INPUT dept $ gender $ age score @@; /* if there is no @@, then SAS would read in each row */
CARDS; /*DATALINES;*/
STAT M 10 94 STAT F 10 96 STAT M 15 91 STAT M 15 86
STAT F 10 76 STAT M 20 88 MATH M 20 71 MATH F 20 66
MATH M 15 81 MATH F 10 77 MATH F 15 55 MATH F 20 78
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

/*****PROC MEANS*****/
/*default*/
PROC MEANS data = score;
RUN;

PROC MEANS data = score;
	class dept;
RUN;

PROC MEANS data = score maxdec = 2 max min mean cv css; /*maxdec is only available for PROC MEANS; no std is printed*/
	class dept;
	var age score;
	output out = score_out mean = m_age m_score std = s_age s_score; /*maxdec is not done here; type specification is only avail. for output out*/
RUN;

PROC PRINT data = score_out;
RUN;

/*****PROC SUMMARY*****/
/*default*/
PROC SUMMARY data = score;
	class dept gender;
	var age score;
	output out = score_sum mean = m_age m_score;
RUN;

PROC PRINT data = score_sum;
RUN;

/*nway option*/
PROC SUMMARY data = score nway; /*nway option is for the last type - the most specific type */
	class dept gender;
	var age score;
	output out = score_sum_nway mean = m_age m_score;
RUN;

PROC PRINT data = score_sum_nway;
RUN;

/*****PROC FREQ*****/
/*default*/
PROC FREQ data = score;
	tables dept gender dept*gender;
RUN;

/*order option*/
PROC FREQ data = score order = data; /*order = data is for let SAS to print that data in input order otherwise print in alphabetical order*/
	tables dept gender dept*gender;
RUN;

/*no percentage option*/
PROC FREQ data = score order = data;
	tables dept gender;
	tables dept*gender / norow nocol; /*to omit*/
RUN;

PROC FREQ data = score order = data;
	tables dept gender;
	tables dept*gender / norow nocol nopercent nofreq; /*to omit*/
RUN;

/*weight*/
PROC FREQ data = drink;
	weight count;
	tables age*drink;
	tables age*drink / nocol nopercent;
RUN;

/*common mistake on not doing weight*/
PROC FREQ data = drink;
	tables age*drink;
RUN;
