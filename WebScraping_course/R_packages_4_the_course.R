# Rlibraries to be used in the Web Scraping course

# 1 - Intro & Parsing html

if(!require(rvest)) install.packages("rvest")
if(!require(xml2)) install.packages("xml2")
if(!require(magrittr)) install.packages("magrittr")

# 2 - Regular expressions
if(!require(stringi)) install.packages("stringi")
if(!require(stringr)) install.packages("stringr")

# 3 - Twitter
if(!require(dplyr)) install.packages("dplyr")
if (!require(twitteR)) install.packages("twitteR")
if (!require(ROAuth)) install.packages("ROAuth")
if (!require(httr)) install.packages("httr")
if (!require(tm)) install.packages("tm")
if (! require(wordcloud) ) install.packages("wordcloud")

# 4 - XML
if (! require(XML) ) install.packages("XML")
if (! require(xml2) ) install.packages("xml2")
