/*
DATE: 08/03/2018
AUTHOR: MINHYUK NAM
PURPOSE:
NOTES:

*/

/*****CREATING DATASET*****/
/*
Instruction (blue), Data Set (black), Error (red)
There is an error if there is any green letters in the editor

DATA [cholest]
INPUT [gender] $ (for string variable) [age] [super]
INPUT [A1-A10] is also possible to create A1 through A10 automatically

*delimiter?
*fixed length data (write number of columns)
*/

DATA cholest;
	INPUT gender $ age super @@; /* if there is no @@, then SAS would read in each row */
CARDS;
M 23 40 M 64 88 M 66 110 M 31 86 M 55 137
M 48 78 M 58 111 M 31 88 M 27 80 M 25 86
M 20 80 M 32 47 M 63 106 M 23 65 M 62 74
;
RUN;

/*****PRINT RESULT*****/
/*```PROC print;``` is also possible if there is no specification, dataset would printout the last dataset */

PROC PRINT data = cholest;
RUN;

/*****RANK; to check order*****/

PROC RANK DATA = cholest OUT = rankout TIES = low DESCENDING; /* use ```out``` option to create new dataset; ACCENDING is a default option */
	WHERE gender = 'M'; /* by gender == 'M' in STATA */
	VAR super; /* MANDATORY for what variable */
	RANKS  r_super; /* MANDATORY new variable name */

PROC PRINT DATA = rankout;
RUN;

/*****SORTING; chage the real order*****/
PROC SORT DATA = rankout;
	BY r_super; /* BY DESCENDING r_super; */

PROC PRINT DATA = rankout;
	VAR r_super super;
RUN;


/*****PRINT SUMMARY STAT*****/
