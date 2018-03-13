/*DATE: 13/03/2018AUTHOR: MINHYUK NAMPURPOSE: Summary StatitsitcsNOTES: There are 3 different kinds of procedure1) univariate
*/
/*****CREATING DATASET*****/
DATA cholest; INPUT gender $ age super @@; /* if there is no @@, then SAS would read in each row */CARDS;M 23 40 M 64 88 M 66 110 M 31 86 M 55 137M 48 78 M 58 111 M 31 88 M 27 80 M 25 86F 20 80 F 32 47 F 63 106 F 23 65 F 62 74;RUN;
/*****PROC UNIVARIATE*****//* need some options to reduce stat result  */
PROC SORT data = cholest;by gender;RUN;
PROC UNIVARIATE data = cholest; /* data option is mandatory */class gender; /* show statistics by gender; REQUIRE SORTING PROCEDURE BEFORE; otherwise use CLASS; print in alphabetical order, to change its order by its input order, USE order = data */var super age; /* stat. to see, exclude gender b/c its stat. has no meaning */

