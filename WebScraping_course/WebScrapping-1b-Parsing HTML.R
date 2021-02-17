## ----setLicense, child = 'license.Rmd'-----------------------------------




## ----disclaimer, child = 'disclaimer.Rmd'--------------------------------




## ------------------------------------------------------------------------
url <- "http://www.r-datacollection.com/materials/html/fortunes.html"
fortunes <- readLines(con = url)
head(fortunes, n=10)


## ----eval=FALSE----------------------------------------------------------
## # install.packages("rvest", dependencies=TRUE)
## require(rvest)
## lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")


## ----eval=FALSE----------------------------------------------------------
## rating <- lego_movie %>%
##   html_node("strong span") %>%
##   html_text()# %>%
##   # as.numeric()
## rating


## ----eval=FALSE----------------------------------------------------------
## poster <- lego_movie %>%
##   html_nodes(".poster img") %>%
##   html_attr("src")
## poster


## ----eval=FALSE----------------------------------------------------------
## cast <- lego_movie %>%
##   html_nodes("td a") %>%
##   html_text()
## cast


## ----eval=FALSE----------------------------------------------------------
## library(stringi)
## castNames <- cast %>%
##   stri_locate(regex="\\n")
## namesPos<-which(!is.na(castNames[1:44,1]))
## names<-cast[namesPos]
## castNames2 <- substring(names,2, nchar(names)-1 )
## castNames2


## ----eval=FALSE----------------------------------------------------------
## require(rvest)
## tables <- html_table(lego_movie, fill = TRUE) #Parses tables into data frames
## castTable<- tables[[1]]
## castNames3 <- as.character(castTable[-1,2])
## castNames3

