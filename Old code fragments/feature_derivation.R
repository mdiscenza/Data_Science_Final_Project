#this file contains functons that will take as their input the actual essays(training or test as vectors and then return dataframes that can be combined with the existing feature sets using the c-bind function)

#only for testing
#vector_of_essays <- test$essay
Sys.setlocale('LC_ALL','C') 



#get # of characters


#get word count
wordcount<-function(vector_of_essays){
    word_count_for_essay <- function(x){
        words <- sapply(strsplit(x, " "), length)
        return (words)
    }
    num_of_words <- as.numeric(as.character(lapply(vector_of_essays,word_count_for_essay)))
    return (num_of_words)
}

#get average word length  --- so this function might be off by a 1 because the spaces count
average_word_length <- function(vector_of_essays){
    number_of_characters <- function(vector_of_essays){
        num_of_chars <- as.numeric(as.character(lapply(vector_of_essays,nchar)))
        return (num_of_chars)
    }
    avg_word_length <- number_of_characters(vector_of_essays)/wordcount(vector_of_essays)
    return (avg_word_length)
}
#test
#average_word_length(vector_of_essays)


#return the number of punctiations marks
string <- test$essay
res <- split(seq(nchar(string)),unlist(strsplit(string,'')))
sapply(res,length)







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