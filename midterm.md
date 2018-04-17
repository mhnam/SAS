# SAS Midterm
## Contents
1. [Dataset](#1-dataset)
2. [Summary Statistics](#2-summary-statistics)
3. [Plot](#3-plot)
4. [Estimation](#4-estimation)
5. [Testing](#5-testing)

## 1. Dataset
### Creating
```SAS
DATA data_name;
  INPUT variable_name [variable_names...] @@;
  [LABEL variable_name = "label_name";]
  /*use $ for every string 'variable_name'*/
  /*use @@ to let sas to read every rows*/
CARDS;
  [data]
;
```

```SAS
DATA data_name;
  SET previous_data_name;
```

### Print
```SAS
PROC PRINT [data = data_name];
```

### Order
```SAS
PROC RANK [data = data_name] [out = output_data_name] [ties = {low}] [descending];
/*default is ties high, ascending*/

  [where variable_name = something;]
  var = variable_name;
  ranks new_variable_name;
```

### Sorting
```SAS
PROC SORT [data = data_name];
  [by variable_name /*cannot use class*/
```

### Create new variable
```SAS
new_variable_name = methods;
```

## 2. Summary Statistics
### UNIVARIATE
```SAS
PROC UNIVARIATE [data = data_name];
  [by variable_name;] /*this requires "sort" before*/
  [class variable_name;] /*this does not requires sort*/
  [var variable_names;]
  [output out = output_data_name][statistics = variable_names] ... [statistics = variable_names;] /*to define output data name and its variable names*/
```

### MEANS
```SAS
PROC MEANS [data = data_name];
  [class variable_name;]
  [var variable_names;]
  [output = output_data_name] [statistics = variable_names] ... [statistics = variable_names];
```

Statistics includes following:
```SAS
mean
median
min
max
std
```

### SUMMARY
```SAS
PROC SUMMARY [data = data_name];
  [class variable_names;]
  [var variable_names;]
  [output = output_data_name] [statistics = variable_names] ... [statistics = variable_names];
```

### FREQ
```SAS
PROC FREQ [data = data_name] [order = data];
  [weight variable_name;] /* if the given data is already counted */
  [tables type_of_tables [/ Options];]  
```

Type_of_tables includes following:
```SAS
variable /* for single */
variable * variable /* for double */
```

Options includes following:
```SAS
norow
nocol
nopercent
nofreq
```

## 3. Plot
### UNIVARIATE
```SAS
PROC UNIVARIATE [data = data_name] PLOT;
  [by variable_name;] /*this requires "sort" before*/
  [var variable_names;]
```

```SAS
PROC UNIVARIATE [data = data_name] PLOT;
  [by variable_name;] /*this requires "sort" before*/
  HISTOGRAM variable_names [/ options;]
```

Options includes following:
```SAS
outhistogram = <output_name>
cfill = <color_name>
vaxis = <start> to <end> by <step>
midpoint = <start> to <end> by <step>
nrows = <number_of_histogram_in_row>
ncol = <number_of_histogram_in_column>
```

### BOXPLOT
```SAS
PROC BOXPLOT [data = data_name];
	PLOT []super * gender [/ options];
```

Options includes following:
```SAS
boxstyle = {skeletal | schematic} /* skeletal exclude outlier */
boxwidth = <>
hoffset = <>
```

## 4. Estimation
### UNIVARIATE
```SAS
PROC UNIVARIATE [data = data_name] cibasic [alpha = 0.05];
  [var variable_name;]
```

### MEANS
Only confidence interval on mean is possible when using ```MEANS``` procedure.

```SAS
PROC MEANS [data = data_name] [{n | mean | std}] clm [alpha = 0.05];
  [var variable_name;]
```

## 5. Testing
### UNIVARIATE (SINGLE ONLY)
```SAS
PROC UNIVARIATE [data = data_name] MU0 = <null_hypoth>;
  [var variable_name;]
```

### TTEST
```SAS
PROC TTEST [data = data_name] [HO = <null_hypoth>];
  [var variable_name;] /* use for single testing or two indep. group testing */
  [class variable_name;] /* include to test two independent groups */
  [paired variable_name * variable_name;] /* include to test two dependent groups */
```

### FREQ
```SAS
PROC FREQ [data = data_name] [order = data];
  [weight variable_name;]
  exact binomial; /* to define distribution - Bernoulli in this case */
  tables variable_name / binomial (p = <p-value>) alpha = <significant_ratio>;
```
