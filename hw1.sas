/*
DATE: 02/04/2018
AUTHOR: MINHYUK NAM
PURPOSE: Practice Question 2-3
NOTES:
*/

/*****CREATING DATASET*****/
DATA king;
	INPUT name $ age @@;
	IF _N_ <= 14 THEN war = 'Before'; ELSE war = 'After';
	agegroup = INT(age/10)*10;
CARDS;
태조 73 정종 62 태종 45 세종 53 문종 38
단종 16 세조 51 예종 28 성종 37 연산군 30
중종 56 인종 30 명종 33 선조 56 광해군 66
인조 54 효종 40 현종 33 숙종 59 경종 36
영조 82 정조 48 선조 44 헌종 22 철종 32
고종 67 순종 52
;
RUN;

/*****PROBLEM A*****/
PROC UNIVARIATE data = king;
	class war;
	var age;
RUN;

/*****PROBLEM B*****/
PROC MEANS data = king max min median mean cv order = data;
	class war;
	var age;
	output out = king_out max = b_max a_max min = b_min a_min median = b_med a_med mean = b_mean a_mean cv = b_cv a_cv;
RUN;

/*****PROBLEM C*****/
PROC SORT data = king; /*sort is required if variable is mixed*/
	by agegroup;
RUN;

PROC FREQ data = king order = data;
	tables war agegroup war*agegroup;
RUN;
