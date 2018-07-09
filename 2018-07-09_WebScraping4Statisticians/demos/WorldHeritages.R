# load packages
require(stringr)
require(XML)
require(maps)

## ------------------------------------------------------------------------
# parsing from locally stored HTML file
heritage_parsed <- htmlParse("worldheritagedanger.htm")

## ------------------------------------------------------------------------
# Extract table from web page and select desired table
danger_table <- readHTMLTable(heritage_parsed, stringsAsFactors = FALSE, which = 2) 
## ------------------------------------------------------------------------

# select and rename columns
danger_table <- danger_table[,c(1,3,4,6,7)]
colnames(danger_table) <- c("name","locn","crit","yins","yend")

## ------------------------------------------------------------------------
# Clean data
danger_table$crit <- ifelse(str_detect(danger_table$crit, "Natural")==T, "nat", "cult")
# cleanse years
danger_table$yins <- as.numeric(danger_table$yins)
danger_table$yend
yend_clean <- unlist(str_extract_all(danger_table$yend, "[[:digit:]]{4}$"))
danger_table$yend <- as.numeric(yend_clean)

## ------------------------------------------------------------------------
# get countries
reg <- "[[:alpha:] ]+(?=[[:digit:]])"
country <- str_extract(danger_table$locn , reg) 
# use forward assertion in Perl regular expression
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
# plot endangered heritage sites
par(oma=c(0,0,0,0)); par(mar=c(0,0,0,0))
pch <- ifelse(danger_table$crit == "nat", 19, 2)
map("world", col = "darkgrey", lwd = .5, mar = c(0.1,0.1,0.1,0.1))
points(danger_table$x_coords, danger_table$y_coords, pch = pch, col = "black", cex = .8)
box()


