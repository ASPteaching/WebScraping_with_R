library(rvest)
# Start googling "list of all star war films IMDB"
# Select one page, for example: https://www.imdb.com/list/ls069505240/

star_wars_movies <- read_html("https://www.imdb.com/list/ls069505240/")

# Inspect the page to find appropriate selectors for each movie's urls
# Notice that we don't have to recover the node's text but the url, so we use "html_attr"
# Selection with selector gadget can yield distinct results because these are but "guesses"

# selectorDescription <- ".mode-detail:nth-child(2) a"
selectorDescription <- "h3 a"

url_film <- star_wars_movies %>% 
  html_nodes(selectorDescription) %>% 
  html_attr('href')

# Inspect the object. 
# First ten items correspond to titles but they miss the first part of the url

urls <- character()
for(i in 1:10){
  urls[i] <- paste0("https://www.imdb.com",url_film[i])
}

# Now we have the lists of pages that have to be scrapped 
# we iterate with the code used in the example

# lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")
# tables <- html_table(lego_movie, fill = TRUE) #Parses tables into data frames
# castTable<- tables[[1]]
# castNames3 <- as.character(castTable[-1,2])

cast = list()
n = 1
for(i in urls){
  film <- read_html(i)
  tables <- html_table(film, fill = TRUE)
  castTable<- tables[[1]]
  castNames <- as.character(castTable[-1,2])
  cast[[n]] <- castNames
  n = n + 1
}

# To complet the process joint the lists with 'unlist', tabulate and sort

sortedCast <- sort(table(unlist(cast)), dec=TRUE)
sortedCast[1:5]
# And the winner is: "Actors[1]"
