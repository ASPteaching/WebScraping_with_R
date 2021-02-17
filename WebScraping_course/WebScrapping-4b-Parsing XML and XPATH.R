## ----setLicense, child = 'license.Rmd'-----------------------------------




## ----disclaimer, child = 'disclaimerXML.Rmd'-----------------------------




## ------------------------------------------------------------------------
if (!(require(XML))) install.packages("XML", dep=TRUE)
require(XML)


## ------------------------------------------------------------------------
# parsing an xml document
require(XML)
remoteDoc <- "http://www.xmlfiles.com/examples/plant_catalog.xml"
localDoc  <-"Examples/bond.xml"
doc1 <- xmlParse(localDoc)


## ------------------------------------------------------------------------
# class
class(doc1)


## ----eval=TRUE-----------------------------------------------------------
# parsing an xml document into an R structure
doc2 = xmlParse(localDoc, useInternalNodes = FALSE)


## ----eval=TRUE-----------------------------------------------------------
# class
class(doc2)


## ------------------------------------------------------------------------
# parse an xml document into an R structure
doc3 = xmlTreeParse(localDoc)


## ------------------------------------------------------------------------
# class
class(doc3)


## ------------------------------------------------------------------------
# parsing an html document with 'xmlParse()'
doc4 = xmlParse("http://www.r-project.org/mail.html",isHTML = TRUE)


## ------------------------------------------------------------------------
# class
class(doc4)


## ------------------------------------------------------------------------
# parsing an html document with 'htmlParse()'
doc5 = htmlParse("http://www.r-project.org/mail.html")


## ------------------------------------------------------------------------
# class
class(doc5)


## ------------------------------------------------------------------------
# parsing an html document into an R structure
doc6 = htmlTreeParse("http://www.r-project.org/mail.html")


## ------------------------------------------------------------------------
# class
class(doc6)


## ------------------------------------------------------------------------
require(XML)
url<- "http://www.r-datacollection.com/materials/ch-3-xml/bond.xml"
movies_xml <- xmlParse(url)


## ------------------------------------------------------------------------
movies_xml


## ------------------------------------------------------------------------

# (movies_xml is a C-level object)
class(movies_xml)
# get root node
root <- xmlRoot(movies_xml)
class(root)


## ------------------------------------------------------------------------
root


## ------------------------------------------------------------------------
movie_child = xmlChildren(root)
movie_child


## ------------------------------------------------------------------------
(secondMovie<-movie_child[[2]])


## ------------------------------------------------------------------------
xmlName(secondMovie) # node name
xmlSize(secondMovie) # number of children
xmlAttrs(secondMovie)
getSibling(secondMovie)


## ------------------------------------------------------------------------
sapply(movie_child, length)
sapply(movie_child, names)
sapply(movie_child, xmlAttrs)


## ------------------------------------------------------------------------
xmlSApply(root, names)
xmlSApply(root, xmlSize)
xmlSApply(root, xmlAttrs)
xmlSApply(root, xmlValue)


## ------------------------------------------------------------------------
xmlSApply(root[[1]], length)
xmlSApply(root[[1]], xmlSize)
xmlSApply(root[[1]], xmlValue)


## ----eval=FALSE----------------------------------------------------------
## /movies/movie[1]


## ----eval=FALSE----------------------------------------------------------
## getNodeSet(doc, path)


## ------------------------------------------------------------------------
# define some xml content
xml_string = c(
'<?xml version="1.0" encoding="UTF-8"?>',
'<movies>',
'<movie mins="126" lang="eng">',
'<title>Good Will Hunting</title>',
'<director>',
'<first_name>Gus</first_name>',
'<last_name>Van Sant</last_name>',
'</director>',
'<year>1998</year>',
'<genre>drama</genre>',
'</movie>',
'<movie mins="106" lang="spa">',
'<title>Y tu mama tambien</title>',
'<director>',
'<first_name>Alfonso</first_name>',
'<last_name>Cuaron</last_name>',
'</director>',
'<year>2001</year>',
'<genre>drama</genre>',
'</movie>',
'</movies>')


## ----eval=FALSE----------------------------------------------------------
## movies_xml = xmlParse(xml_string, asText = TRUE)
## # movies_xml
## getNodeSet(movies_xml, "/movies/movie")
## getNodeSet(movies_xml, "//movie")
## getNodeSet(movies_xml, "//title")
## getNodeSet(movies_xml, "//year")
## etNodeSet(movies_xml, "//director")
## getNodeSet(movies_xml, "//movie[@lang='eng']")
## getNodeSet(movies_xml, "//movie[@lang='spa']")

