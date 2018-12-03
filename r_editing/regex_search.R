#script is used to crawl a website and edit the resulting code in a, first, very basic way cutting off some non-necessary values
source("html_to_text_method.R")
library(Rcrawler)






#this URL is about to get crawled
seite <- "https://www.wiederbelebt.de"
#complete script for one page, further paramter can be used to edit the depth of crawling
Rcrawler(Website= seite)


#list all the file that were cawled
files <- list.files()


#this further script goes through all the files and edits the texts as can be see in lines 28-30 and creates a dataframe (page.frame) and 
#then puts each page´s text in one row 
page.frame <- data.frame()
length <- length(files)
for(counter in 1:length){



txt <- htmlToText(files[counter])
plain.text <- gsub("\t", "\\1", txt)
a <- gsub("\t", "", plain.text, perl = TRUE)
a <- gsub("  ", " ", a, perl = TRUE)


vec <- c(files[counter], a)
page.frame <- dplyr::bind_rows(page.frame, as.data.frame(t(vec)))



}
#finally, name the dataframe by the name of the crawled site
assign(seite, page.frame)
