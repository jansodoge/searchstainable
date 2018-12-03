#this script can be used to use the openthesaurus.de API to find synonyms for environmental terms to advance the tag-search
#pay attention on the umlaute
library(RCurl)
library(XML)
library(httr)
library(jsonlite)


#basic source to access API
url <- "https://www.openthesaurus.de"




#basic stock of envirnmental tags we first came up with, the for loop below will go through this vector and look for additinal synonyms
#and save these new generated synonyms in the content vector too
content <- c("nachhaltigkeit", "umwelt", "fussabdruck", "bewusstsein", "fair", "sozial", "oekologisch", "öko", "regional", "lokal", "biologisch", "vegan", "vegetarisch", "recycling", "haltbar", 
             "footprint", "verantwortung", "abbaubar", "abbau", "gerecht", "demokratisch", "ethisch", "moralisch", "vertraulich", "kutlurell", "kultur", "impact", "social")


#skript zur erweiterung des wortschatzes
for(wort in content){
  
  pattern <- paste("/synonyme/search?q=", wort, "&format=application/json&substring=true", sep="")
  raw.result <- GET(url = url, path = pattern)
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  tmp <- as.vector(this.content$synsets$terms[[1]][1])
  terms <- unique(as.vector(tmp$term))
  content <- append(content, terms)

  
  
}

