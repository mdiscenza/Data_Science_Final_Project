#this file contains functons that will take as their input the actual essays(training or test as vectors and then return dataframes that can be combined with the existing feature sets using the c-bind function)

#only for testing
#vector_of_essays <- test$essay
Sys.setlocale('LC_ALL','C') 
library(stringr)
library(plyr)

#get # of characters

#test_features<-calculate_features(test$essay)

#function to return a number of features of the text
calculate_features<-function(vector_of_essays){
    individual_features<-function(essay){
        feature_word_count <- str_count(essay, ' ') + 1 
        feature_commas <- str_count(essay, ',')
        feature_semi_colon<- str_count(essay, ';')
        feature_dash <- str_count(essay, '-')
        #proxy for number of sentences
        periods <- str_count(essay, '\\.') # retunrs the number of periods - have to escape
        alphanumeric_char <- nchar(essay) - feature_word_count + 1
        feature_avg_word_length <- alphanumeric_char/feature_word_count
        feature_avg_sentence_length <- feature_word_count/periods
        document_feature_set <- c(feature_word_count,feature_avg_word_length,feature_avg_sentence_length,feature_commas,feature_dash,feature_semi_colon)
        return (document_feature_set)
    }
    corpus_feature_set <- ldply(vector_of_essays,individual_features)
    colnames(corpus_feature_set) <-c("featureWordCount","featureAvgWordLength","featureAvgSentenceLength","featurCommas","featureDash","featureSemiColon")
    return (corpus_feature_set)
}


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