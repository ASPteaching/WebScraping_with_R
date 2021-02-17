#Exercise 1

library(stringr)

text1 <- "The current year is 2019"
my_pattern <- "[0-9]"
grep(my_pattern,text1,value=TRUE)
grepl(my_pattern,text1)
grep("[0-9]*","The current year is 2019",value=TRUE)

my_pattern <- "[A-z]*[0-9]+[A-z]*"
grep(my_pattern,text1,value=TRUE)

str_extract_all("The current year is 2019","[0-9]")
str_extract_all("The current year is 2019","[0-9]*")

#Exercise 2

gregexpr("[0-9]","The current year is 2019")
(string_position <- gregexpr("[0-9]","The current year is 2019"))
str_locate_all("The current year is 2019","[0-9]")
(string_position <- str_locate_all("The current year is 2019","[0-9]")[[1]][,1])


#Exercise 3

str_extract_all("The current year is 2019","[0-9]|[A-Z]")
grepl("[0-9]|[A-Z]","The current year is 2019")


#Exercise 4

regexpr("[:blank:]","The current year is 2019") #no surt no sé perquè

#Exercise 5

grepl("[:lower:][A-Z|0-9|:blank:[0-9]","The current year is 2019")

#Exercise 6

str_extract("The current year is 2019","[:lower:]([A-Z]|[0-9]|[:blank:])[0-9]")
str_locate("The current year is 2019","[:lower:]([A-Z]|[0-9]|[:blank:])[0-9]")
pos <- str_locate("The current year is 2019","[:lower:]([A-Z]|[0-9]|[:blank:])[0-9]")
pos[1,1]

#Exercise 7

str_extract("The current year is 2019","[:blank:][:lower:]{2}[:blank:]")
str_locate("The current year is 2019","[:blank:][:lower:]{2}[:blank:]")
pos <- str_locate("The current year is 2019","[:blank:][:lower:]{2}[:blank:]")
pos[1,1]

#Exercise 8
sub(pattern="[:blank:][:lower:]{2}[:blank:]",replacement = " is not ", x="The current year is 2019")

str_replace(pattern="[:blank:][:lower:]{2}[:blank:]",replacement = " is not ", string="The current year is 2019")

text2 <- str_replace(pattern="[:blank:][:lower:]{2}[:blank:]",replacement = " is not ", string="The current year is 2019")

#Exercise 8
str_extract(string=text2,pattern="[0-9]{4}$")
str_locate(string=text2,pattern="[0-9]{4}$")

#Exercise 10

LipidData <- read.table(file="Exercises/LipidData.txt",header=TRUE,sep="\t",dec=",")
dim(LipidData)
summary(LipidData)
string <- LipidData$LIPID
(carbons <- str_extract(string=string,pattern="[0-9]{2}"))
(bonds <- str_extract(string=string,pattern=":[0-9]{1}"))
(bonds <- str_extract(string=bonds,pattern="[0-9]"))
bonds[is.na(bonds)] <- "0" ; bonds
(lipid <- str_extract(string=string,pattern="[^0-9|-]*$"))

data.frame(carbons,bonds,lipid)









gsub(pattern="[:blank:][:lower:]{2}[:blank:]",replacement = "is not", x="The current year is 2019")

