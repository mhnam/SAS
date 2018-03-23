/*
DATE: 13/03/2018 - 20/03/2018
AUTHOR: MINHYUK NAM
PURPOSE: Summary Statitsitcs
NOTES: There are 3 different kinds of procedure
1) univariate
*/

/*****CREATING DATASET*****/
DATA cholest;
	INPUT gender $ age super @@; /* if there is no @@, then SAS would read in each row */
CARDS;
M 23 40 M 64 88 M 66 110 M 31 86 M 55 137
M 48 78 M 58 111 M 31 88 M 27 80 M 25 86
M 20 80 M 32 47 M 63 106 M 23 65 M 62 74
M 43 66 M 43 79 M 36 58 M 67 123 M 27 87
M 29 88 M 48 90 M 63 56 M 27 73 M 19 112
M 59 110 M 65 118 M 26 52 M 53 106 M 42 67
M 60 57 F 30 66 F 25 69 F 40 65 F 38 52
F 57 84 F 33 86 F 23 35 F 42 116 F 49 76
F 35 55 F 49 73 F 44 89 F 50 127 F 60 87
F 63 142 F 47 77 F 23 76 F 27 58 F 36 91
F 48 107 F 23 98 F 74 128 F 44 84 F 56 146
F 53 75 F 37 120 F 41 80 F 41 82 F 57 123
;
RUN;

/*****PROC UNIVARIATE*****/
/* need some options to reduce stat result  */
PROC SORT data = cholest;
	by gender; /*sort is required; there is a keyword that reuireds by (NOT class)*/
RUN;

PROC UNIVARIATE data = cholest; /* data option is mandatory */
	class gender; /* show statistics by gender; REQUIRE SORTING PROCEDURE BEFORE; otherwise use CLASS; print in alphabetical order, to change its order by its input order, USE order = data */
	var super age; /* var selection is required for output out is used */
	output out = univ_out_v1 mean=s_mean a_mean std=s_std a_std; /*variable order would be done in var order*/
RUN;

PROC PRINT data = univ_out_v1;
RUN;

/*****GENERATE NEW VARIABLE, CREATING NEW DATA FILE*****/
DATA univ_out_v2;
	SET univ_out_v1; /*use previous data set*/

a_cv = a_std / a_mean * 100; /*generate variable*/
RUN;

PROC PRINT data = univ_out_v2;
RUN;

/*****PLOT*****/
/* automatic plots */
PROC SORT data = cholest;
	by gender;
RUN;

PROC UNIVARIATE data = cholest PLOT;
	by gender;
	var super age;
RUN;

/* box plot */
PROC SORT data = cholest; /*sort is required if variable is mixed*/
	by gender; 
RUN;

PROC BOXPLOT data = cholest; /* PLOT is required */
	PLOT super * gender / boxstyle = skeletal boxwidth = 20 hoffset = 15; /* exclude outlier - SKELETAL */
	PLOT super * gender / boxstyle = schematic boxwidth = 20 hoffset = 15; /* include outlier */
RUN;

/* histogram */
PROC UNIVARIATE data = cholest;
	class gender;
	HISTOGRAM age / outhistogram = outhisto /*outhistogram is to export the file*/
		cfill = orange vaxis = 0 to 40 by 5 /*vaxis means vertical axis; percentage is default*/
		midpoints = 10 to 80 by 10 nrows = 2  ncol = 1; /*print option*/
RUN;
