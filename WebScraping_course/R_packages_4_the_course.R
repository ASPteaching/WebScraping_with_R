# Rlibraries to be used in the Web Scraping course
if(!require(rvest)) install.packages("rvest")
if(!require(plyr)) install.packages("plyr")
if (!require(twitteR)) install.packages("twitteR")
if (!require(ROAuth)) install.packages("ROAuth")
if (!require(tm)) install.packages("tm")
if (! require(wordcloud) ) install.packages("wordcloud")
if (! require(XML) ) install.packages("XML")

# 1 - Intro & Parsing html

# if(!require(rvest)) install.packages("rvest")
# Other packages required that are automatically installed: 
# ‘sys’# 
# ‘askpass’# 
# ‘glue’# 
# ‘stringi’# 
# ‘Rcpp’# 
# ‘curl’# 
# ‘jsonlite’# 
# ‘mime’# 
# ‘openssl’# 
# ‘R6’# 
# ‘stringr’# 
# ‘xml2’# 
# ‘httr’# 
# ‘selectr’# 
# ‘magrittr’

# 2 - General packages
# if(!require(dplyr)) install.packages("dplyr")

# 3 - Twitter
# if (!require(twitteR)) install.packages("twitteR")
# ‘bit’# 
# ‘bit64’# 
# ‘rjson’# 
# ‘DBI’# 

# if (!require(ROAuth)) install.packages("ROAuth")
# ‘bitops’
# ‘RCurl’
# ‘digest’

# if (!require(tm)) install.packages("tm")
# if (! require(wordcloud) ) install.packages("wordcloud")
# ‘NLP’
# ‘slam’

# 4 - XML
# if (! require(XML) ) install.packages("XML")
