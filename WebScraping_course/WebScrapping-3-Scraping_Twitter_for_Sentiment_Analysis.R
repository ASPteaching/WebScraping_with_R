## ----setLicense, child = 'license.Rmd'-----------------------------------




## ----disclaimer, child = 'disclaimer.Rmd'--------------------------------




## ----setup, include=FALSE------------------------------------------------
require(knitr)
# include this code chunk as-is to set options
opts_chunk$set(comment = NA, prompt = TRUE, tidy = FALSE, fig.width = 7, fig.height = 7,echo = TRUE, message = FALSE, warning = FALSE, cache=FALSE)
Sys.setlocale("LC_TIME", "C")


## ----eval=TRUE-----------------------------------------------------------
if(!require(dplyr)) install.packages("dplyr")
if(!require(stringr)) install.packages("stringr")
if (!require(twitteR)) install.packages("twitteR")
# if (!require(ROAuth)) install.packages("ROAuth")
# if (!require(httr)) install.packages("httr")
if (!require(tm)) install.packages("tm")
if (! require(wordcloud) ) install.packages("wordcloud")


## ----eval=FALSE----------------------------------------------------------
## # Use this code chunk to assign values to these 4 variables.
## # The values can be obtained from **your** twitter developer account.
## key <- XXXX         # "your API key from twitter"
## secret <-   XXXX  # "your Secret key from twitter"
## mytoken <-  XXXX    # "Access Token from Twitter"
## secrettk <- XXXX   # "Access Token Secret from Twitter"


## ----eval=TRUE, results='hide', echo=FALSE, include=TRUE-----------------
source("twitterAutentication.R") # Do not put thhis file in github (exclude it with .gitignore)


## ----eval=TRUE-----------------------------------------------------------
require(twitteR)
setup_twitter_oauth(consumer_key = key, consumer_secret = secret,
                    access_token= mytoken, access_secret=secretoken)
 # (1) choose direct authentication and answer "Yes"


## ------------------------------------------------------------------------
searchTwitter("#beer", n=10)


## ----eval=FALSE----------------------------------------------------------
require(twitteR)
search.string <- "#Judici"
no.of.tweets <- 1000
aTopicTweets <- searchTwitter(search.string, n=no.of.tweets, lang="ca",
                          since='2019-04-01', until='2019-04-10')
head(aTopicTweets)
save(aTopicTweets, file="aTopicTweets.Rda")


## ----eval=FALSE----------------------------------------------------------
## aUser <- "nntaleb" # f2harrell
## aUserTweets <- userTimeline(aUser, n = 3200)
## save(aUserTweets, file="aUserTweets.Rda")


## ----regexClean----------------------------------------------------------
require(twitteR)
showTweets <- TRUE
if (!exists("aTopicTweets")) load("aTopicTweets.Rda")
 tweets.text <- sapply(aTopicTweets, function(x) x$getText())
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


## ------------------------------------------------------------------------
require("tm")
#create corpus
tweets.text.corpus <- Corpus(VectorSource(tweets.text))
head(stopwords())
#clean up by removing stop words
tweets.text.corpus <- tm_map(tweets.text.corpus, function(x) removeWords(x, stopwords()))
head(tweets.text.corpus)


## ----message=FALSE-------------------------------------------------------
#generate wordcloud
require(wordcloud)
wordcloud(tweets.text.corpus, min.freq = 2, scale=c(7,0.5),
colors=brewer.pal(8, "Dark2"),random.color= TRUE, random.order = FALSE, 
max.words = 150)


## ------------------------------------------------------------------------
require(tm)
#create corpus
# mycorpus <- Corpus(VectorSource(tweets.text))
# mytdm <- TermDocumentMatrix(mycorpus)
mytdm <- TermDocumentMatrix(tweets.text.corpus)
inspect(mytdm[1:15,1:30])
findFreqTerms(mytdm, lowfreq=55) # experiment with the lowfreq
tdm <-removeSparseTerms(mytdm, sparse=0.93) # experimet with sparse


## ------------------------------------------------------------------------
tdmscale <- scale(tdm)
dist <- dist(tdmscale, method = "canberra")
fit <- hclust(dist)

# we need to change the margins and delete some titles
par(mai=c(1,1.2,1,0.5))
plot(fit, xlab="", sub="", col.main="salmon")
rect.hclust(fit, k=6, border="salmon")
# cutree(fit, k=6)


## ------------------------------------------------------------------------
pos <- readLines("Positive-Words.txt")
pos[sample(1:length(pos), 5)]
neg <- readLines("Negative-Words.txt")
neg[sample(1:length(neg), 5)]


## ------------------------------------------------------------------------
source("https://raw.githubusercontent.com/jeffreybreen/twitter-sentiment-analysis-tutorial-201107/master/R/sentiment.R")


## ----eval=FALSE----------------------------------------------------------
## require(twitteR)
## usatweets = searchTwitter("usa", n=900, lang="en")
## indiatweets = searchTwitter("india", n=900, lang="en")
## russiatweets = searchTwitter("russia", n=900, lang="en")
## chinatweets = searchTwitter("china", n=900, lang="en")
## save(usatweets, indiatweets, russiatweets, chinatweets, file="countryTweets.Rda")


## ------------------------------------------------------------------------
if (!exists("usatweets") )load(file="countryTweets.Rda")
usa_txt = sapply(usatweets, function(x) x$getText())
india_txt = sapply(indiatweets, function(x) x$getText())
russia_txt = sapply(russiatweets, function(x) x$getText())
china_txt = sapply(chinatweets, function(x) x$getText())
country = c(usa_txt, india_txt, russia_txt, china_txt)


## ------------------------------------------------------------------------
countries <-  gsub( '[^A-z0-9_]', ' ', country)
scores <- score.sentiment(countries, pos, neg, .progress='none')
nd <- c(length(usa_txt), length(india_txt), length(russia_txt), length(china_txt))
scores$country = factor(rep(c("usa", "india", "russia", "china"), nd))
scores$very.pos = as.numeric(scores$score >= 2)
scores$very.neg = as.numeric(scores$score <= -2)
numpos = sum(scores$very.pos)
numneg = sum(scores$very.neg)


## ------------------------------------------------------------------------
head(scores)
boxplot(score~country, data=scores)


## ------------------------------------------------------------------------
require(lattice)
histogram(data=scores, ~score|country, 
main="Sentiment Analysis of 4 Countries", xlab="", sub="Sentiment Score")


