### --- load packages
library(plyr); library(stringr);library(twitteR); library(tm); library(wordcloud)
## ----You may put your real keys in a non-accessible file-----------------
## source("twitterKeys.R") # Do not put thhis file in github (exclued it with .gitignore)
setup_twitter_oauth(consumer_key = twitter_key, consumer_secret = twitter_secret,
                    access_token= access_token, access_secret=access_secret)
# (1) choose direct authentication and answer "Yes"

## ------------------------------------------------------------------------
myTweets<- searchTwitter("#IBC2018BCN", n=200)
save(myTweets, file="myTweets.Rda")

## ----regexClean----------------------------------------------------------
showTweets <- TRUE
if (!exists("myTweets")) load("myTweets.Rda")
tweets.text <- sapply(myTweets, function(x) x$getText())
# Replace @UserName
tweets.text <- gsub("@\\w+", "", tweets.text)
# Remove punctuation
tweets.text <- gsub("[[:punct:]]", "", tweets.text)
# Remove links
tweets.text <- gsub("http\\w+", "", tweets.text)
# Remove tabs
tweets.text <- gsub("[ |\t]{2,}", "", tweets.text)
# remove codes that are neither characters nor digits
tweets.text<-  gsub( '[^A-z0-9_]', ' ', tweets.text)
# Set characters to lowercase
tweets.text <- tolower(tweets.text)
# Replace blank space (“rt”)
tweets.text <- gsub("rt", "", tweets.text)
# Remove blank spaces at the beginning
tweets.text <- gsub("^ ", "", tweets.text)
# Remove blank spaces at the end
tweets.text <- gsub(" $", "", tweets.text)
head(tweets.text)

## ---Use tm package to have a list of stopwords
require("tm")
#create corpus
tweets.text.corpus <- Corpus(VectorSource(tweets.text))
#clean up by removing stop words
tweets.text.corpus <- tm_map(tweets.text.corpus, function(x) removeWords(x, stopwords()))
head(tweets.text.corpus)

#--- generate wordcloud
require(wordcloud)
wordcloud(tweets.text.corpus, min.freq = 2, scale=c(7,0.5),
          colors=brewer.pal(8, "Dark2"),random.color= TRUE, random.order = FALSE, 
          max.words = 150)
