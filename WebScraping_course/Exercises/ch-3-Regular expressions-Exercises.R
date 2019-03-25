
## ---- echo=FALSE, message=FALSE------------------------------------------
# load packages
if (!require(stringr)) install.packages("stringr", dep=TRUE)
require(stringr)

## ----exercise1-----------------------------------------------------------
text1 <- "The current year is 2017"
my_pattern <- "[A-z]*[0-9]+[A-z]*"
grepl(my_pattern,text1)

## ----exercise2-----------------------------------------------------------
string_position <- gregexpr(my_pattern,text1)
string_position[[1]][1:length(string_position[[1]])]
require(stringr)
str_locate(text1, my_pattern)

## ----exercise3-----------------------------------------------------------
my_pattern <- "[[:upper:][:digit:]]"
grepl(my_pattern,text1)
str_locate_all(text1, my_pattern)

## ----exercise4-----------------------------------------------------------
my_pattern <- "[[:blank:]]"
first_space <- regexpr(my_pattern,text1)
first_space[[1]][1]
str_locate(text1, my_pattern)

## ----exercise5-----------------------------------------------------------
my_pattern <- "[[:lower:]].[[:digit:]]"
grepl(my_pattern,text1)
str_detect(text1, my_pattern)

## ----exercise6-----------------------------------------------------------
string_pos2 <- str_locate(text1, my_pattern)
string_pos2[1]
string_pos2 <- gregexpr(my_pattern,text1)[[1]][1]
string_pos2

## ----exercise7-----------------------------------------------------------
my_pattern <- "\\s[a-z][a-z]\\s"
string_pos3 <- str_locate(text1, my_pattern)
string_pos3
string_pos3 <- gregexpr(my_pattern,text1)[[1]][1]
string_pos3

## ----exercise8-----------------------------------------------------------
text2 <- sub(my_pattern," is not ",text1)
text2
text2 <- str_replace(text1, my_pattern," is not ")
text2

## ----exercise9-----------------------------------------------------------
my_pattern <- "\\d{4}$"
string_pos4 <- gregexpr(my_pattern,text2)[[1]][1]
string_pos4
string_pos4 <- str_locate(text2, my_pattern)
string_pos4

## ----exercise10----------------------------------------------------------
substr(text2,start = string_pos4,string_pos4+1)

