# script containing function that imports the data from files and tokenizes the words
require("RTextTools")

###################################################################################################

import_training_set <- function(){
    setwd("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project")
    train <- read.delim("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/train.tsv", header=TRUE)
    #train <- read.delim("https://inclass.kaggle.com/c/columbia-university-introduction-to-data-science-fall-2012/download/train.tsv", header=TRUE)
    train$essay <- as.character(train$essay)
    train<-na.omit(train)
    return (train)
}

###################################################################################################

#import and process the training set
#column order: id,set,essay, rater1, rater2, grade
import_test_set <- function(){
    #import and process the test set
    #column order: id, set, essay
    test <- read.delim("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/test.tsv", header=TRUE)
    #test <- read.delim("https://inclass.kaggle.com/c/columbia-university-introduction-to-data-science-fall-2012/download/test.tsv", header=TRUE)
    test$essay <- as.character(test$essay)
    return  (test)
}

###################################################################################################


tokenize_data <- function(train, test, type){
    
    #Tokenizing the training data----------------------------------------------------------
    if (type=="text"){
        training_tokens <- create_matrix(train, language="english", removeNumbers=TRUE, stemWords=TRUE, removePunctuation=T, removeStopwords=T, toLower=T, removeSparseTerms=.98)
    }
    if (type=="text-unstemmed"){
        training_tokens <- create_matrix(train, language="english", removeNumbers=TRUE, stemWords=FALSE, removePunctuation=T, removeStopwords=T, toLower=T, removeSparseTerms=.99)
    }
    if (type=="POS"){
        training_tokens<-create_matrix(train, language="english", removeNumbers=TRUE, stemWords=FALSE, removePunctuation=FALSE, removeStopwords=FALSE, toLower=TRUE, removeSparseTerms=.98)
    }
    if (type=="POS-ngram"){
        training_tokens<-create_matrix(train, language="english", removeNumbers=TRUE, stemWords=FALSE, removePunctuation=FALSE, removeStopwords=FALSE, toLower=TRUE, removeSparseTerms=.98, ngramLength=3,minWordLength=1)
    }
    training_tokens <- as.data.frame(as.matrix(training_tokens))
    #need to change row names from being the whole essays
    rownames(training_tokens) <- c(1:dim(training_tokens)[1]) 
    train <- train[,-3] #gets rid of essay as one field
    training_grades <- as.numeric(as.character(train$grade))
    training_data <- cbind(training_grades,train$set,training_tokens)
    rm(training_tokens)
    # there is count of the occurances of the word "set" in the essays themselves so need to change this:
    colnames(training_data)[1] <- "grades"
    colnames(training_data)[2] <- "essayset" 
    
    #Tokenizing the test data----------------------------------------------------------
    test_ids <- test$id
    if (type=="text"){
        test_tokens <- create_matrix(test, language="english", removeNumbers=TRUE, stemWords=TRUE, removePunctuation=T, removeStopwords=T, toLower=T, removeSparseTerms=.98)
    }
    if (type=="text-unstemmed"){
        test_tokens <- create_matrix(test, language="english", removeNumbers=TRUE, stemWords=FALSE, removePunctuation=T, removeStopwords=T, toLower=T, removeSparseTerms=.99)
    }
    if (type=="POS"){
        test_tokens<-create_matrix(test, language="english", removeNumbers=TRUE, stemWords=FALSE, removePunctuation=FALSE, removeStopwords=FALSE, toLower=TRUE, removeSparseTerms=.98)
    }
    if (type=="POS-ngram"){
        test_tokens<-create_matrix(test, language="english", removeNumbers=TRUE, stemWords=FALSE, removePunctuation=FALSE, removeStopwords=FALSE, toLower=TRUE, removeSparseTerms=.98, ngramLength=3,minWordLength=1)
    }
    test_tokens <- as.data.frame(as.matrix(test_tokens))
    #need to change row names from being the whole essays
    rownames(test_tokens) <- c(1:dim(test_tokens)[1])
    test_data <- cbind(test$set,test_tokens)
    rm(test_tokens)
    colnames(test_data)[1] <- "essayset" # need to do this because there is count of the occurances of the word "set" in the essays themselves
    
    #I need to have both the test and the training data that I give both methods the same features
    both <- intersect(colnames(test_data), colnames(training_data))
    training_data <- training_data[,both]
    test_data <- test_data[,both]
    tokenized_data_frames <- NULL
    tokenized_data_frames[[1]] <- training_data
    tokenized_data_frames[[2]] <- test_data
    return (tokenized_data_frames)
}
