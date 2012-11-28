#this file contains functons that will take as their input the actual essays(training or test as vectors and then return dataframes that can be combined with the existing feature sets using the c-bind function)

#only for testing
vector_of_essays <- test$essay

#will likely return NAs
function <- number_of_characters(vector_of_essays){
    nchar_w_NA <- function(x){
       return (nchar(x,allowNA=TRUE))
    }
    lengths <- as.numeric(as.character(lapply(,nchar_w_NA)))
    return (lengths)
}
#get word count
function <- wordcount(vector_of_essays){
    word_count_for_essay <- function(x){
        sapply(strsplit(test$essay[1], " "), length)
    }
    num_of_words <- as.numeric(as.character(lapply(test$essay,word_count_for_essay)))
    return (num_of_words)
    
}



#complex stuff that doesn't yet work
library("koRpus") #supposidly will help me calculate the Gunning-Fog Index

file <- "~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/temp_text_processing"
read.hyph.pat("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/temp_text_processing/output.txt", lang="en")
lex.div("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/temp_text_processing/output.txt")
setwd("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/temp_text_processing")

readability("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/temp_text_processing", force.lang="en",tagger="kRp.env")
          fileConn<-file("output.txt")
          writeLines(train$essay[1], fileConn)
          close(fileConn)
treetag(file)
set.kRp.env(TT.cmd=
    #instructions for getting the tagger to work
    #http://www.ims.uni-stuttgart.de/projekte/corplex/TreeTagger/
    #Page 3 of this : http://cran.r-project.org/web/packages/koRpus/vignettes/koRpus_vignette.pdf
tagged.text <- treetag("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/temp_text_processing/output.txt", treetagger="manual", lang="en", TT.options=c(path="~Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/tree_tagger", preset="en"))