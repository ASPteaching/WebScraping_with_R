## ----setup, include=FALSE, echo=FALSE------------------------------------
require(knitr)
# include this code chunk as-is to set options
opts_chunk$set(comment = NA, prompt = TRUE, tidy = FALSE, fig.width = 7, fig.height = 7,echo = TRUE, message = FALSE, warning = FALSE, cache=FALSE)
Sys.setlocale("LC_TIME", "C")

## ------------------------------------------------------------------------
# load packages
if (!require(stringr)) install.packages("stringr", dep=TRUE)
if (!require(XML)) install.packages("XML", dep=TRUE)
if (!require(maps)) install.packages("maps", dep=TRUE)

require(stringr)
require(XML)
require(maps)

## ------------------------------------------------------------------------
# parsing from HTML file in the web
# heritage_parsed <- htmlParse("https://en.wikipedia.org/wiki/List_of_World_Heritage_in_Danger", encoding = "UTF-8")

# parsing from locally stored HTML file
heritage_parsed <- htmlParse("worldheritagedanger.htm")

## ------------------------------------------------------------------------
tables <- readHTMLTable(heritage_parsed, stringsAsFactors = FALSE)
names(tables)
# extract desired table
danger_table <- tables[[2]]

# alternatively: directly select second table
danger_table <- readHTMLTable(heritage_parsed, stringsAsFactors = FALSE, which = 2) 

names(danger_table)

## ------------------------------------------------------------------------
# select and rename columns
danger_table <- danger_table[,c(1,3,4,6,7)]
colnames(danger_table) <- c("name","locn","crit","yins","yend")
danger_table$name[1:3]

## ------------------------------------------------------------------------
danger_table$crit <- ifelse(str_detect(danger_table$crit, "Natural")==T, "nat", "cult")
# cleanse years
danger_table$yins <- as.numeric(danger_table$yins)
danger_table$yend
yend_clean <- unlist(str_extract_all(danger_table$yend, "[[:digit:]]{4}$"))
danger_table$yend <- as.numeric(yend_clean)

## ------------------------------------------------------------------------
danger_table$locn[c(1,3,5)]

## ------------------------------------------------------------------------
# get countries
reg <- "[[:alpha:] ]+(?=[[:digit:]])"
country <- str_extract(danger_table$locn, perl(reg)) 
# use forward assertion in Perl regular expression
country
country[29] <- "C?te d'Ivoire / Guinea"
country[32] <- ""
danger_table$country <- country

# get coordinates
reg_y <- "[/][ -]*[[:digit:]]*[.]*[[:digit:]]*[;]"
reg_x <- "[;][ -]*[[:digit:]]*[.]*[[:digit:]]*"
y_coords <- str_extract(danger_table$locn, reg_y)
(y_coords <- as.numeric(str_sub(y_coords, 3, -2)))
danger_table$y_coords <- y_coords
x_coords <- str_extract(danger_table$locn, reg_x)
(x_coords <- as.numeric(str_sub(x_coords, 3, -1)))
danger_table$x_coords <- x_coords
danger_table$locn <- NULL

## ------------------------------------------------------------------------
round(danger_table$y_coords, 2)[1:3]
round(danger_table$x_coords, 2)[1:3]
dim(danger_table)
head(danger_table)

## ------------------------------------------------------------------------
# plot endangered heritage sites
# pdf(file="heritage-map.pdf", height=3.3, width=7, family="URWTimes")
par(oma=c(0,0,0,0))
par(mar=c(0,0,0,0))
pch <- ifelse(danger_table$crit == "nat", 19, 2)
map("world", col = "darkgrey", lwd = .5, mar = c(0.1,0.1,0.1,0.1))
points(danger_table$x_coords, danger_table$y_coords, pch = pch, col = "black", cex = .8)
box()
# dev.off()

## ------------------------------------------------------------------------
# table heritage criteria
table(danger_table$crit)

## ------------------------------------------------------------------------
#pdf(file="heritage-hist1.pdf", height=3.3, width=7, family="URWTimes")
par(oma=c(0,0,0,0))
par(mar=c(4,4,1,.5))
hist(danger_table$yend, freq=TRUE, xlab="Year when site was put on the list of endangered sites", main="")
box()
#dev.off()

## ------------------------------------------------------------------------
duration <- danger_table$yend - danger_table$yins
#pdf(file="heritage-hist2.pdf", height=3.3, width=7, family="URWTimes")
par(oma=c(0,0,0,0))
par(mar=c(4,4,1,.5))
hist(duration, freq=TRUE, xlab="Years it took to become an endangered site", main="")
box()
#dev.off()

