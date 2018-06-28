LipidsCleanOfZeros <- read.table("LipidsCleanOfZeros.csv", sep=";", dec=",", head=TRUE)
atomsInfo <- as.character(LipidsCleanOfZeros$X)
# La nomenclatura és fàcil si unicament ens quedem amb 
# el Nºde carbonis (1er número -abans dels dos punts-) 
# vs Nº de dobles enllaços (segon número -després dels dos punts-)
# Ex
#   C24Cer 24 carbonis; 0 dobles enllaços
#   C24:1Cer(a) 24 carbonis; 1 dobles enllaços
#   C24:2Cer 24 carbonis; 2 dobles enllaços
#
# Describim la nomenclatura amb uuna expressio regular:
#
#   C* 
#   [:digits:]{2} o tambe \d{2}
#   (\:\d\-*)* 
#   \s
#   [A-z]{2,}
#   (\(a\))*  # No va?
# Resumint: Podem descriure les cadenes fent:
#   C*\d{2}(\:\d\-*)*\s*[A-z]{2,}(\(a\))*
#
#

initC<- grep("^C", atomsInfo,value=FALSE)
foraC <- function(s){
  if (substr(s,1,1)=="C"){
    s=substr(s,2,nchar(s))
  }
  return(s)
  }
atomsNoC <-sapply(atomsInfo, foraC)
numCarbons<- substr(atomsNoC,1,2)
require(stringr)
doubleBounds <- function(s){
  if (length(grep(":", s, value=TRUE))>0){
    secPart<-str_split(s,":")[[1]][2]
    db <- substr(secPart,1,1)
  }else{
    db<-0
  }
}
numDobleEnll <- sapply(atomsNoC, doubleBounds)
s<-"C24:1aLacCer"

familia <- sapply(atomsNoC, function(s) str_extract(s, "([A-z]{2,})$" ))

results <- data.frame(atomsNoC, numCarbons, numDobleEnll,familia)

head(results)
tail(results)

write.csv (results, file="paraGraficos.csv")
