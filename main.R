setwd("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project")
#wow, I made this file so much cleaner, I'm so happy :)
#import the data


#Importing the data
#------------------------------------------------------------------------
training<-import_training_set()
test<-import_test_set()

#Generating a bag of words for each of the data sets
#------------------------------------------------------------------------
#warning the next line takes a lot of time to run!
tokenized_data <- tokenize_data(training, test) #needs to be called on both sets to make sure that the bag of words is actually the same!
training_tokens <- tokenized_data[[1]]
test_tokens <- tokenized_data[[2]]
rm(tokenized_data) # storing this data in two places would be redundant so we get rid of it

#Deriving additional features of the data 
#------------------------------------------------------------------------
training_features <- calculate_features(training$essay) #needs to be given only the vector of essays themselves
test_features <- calculate_features(test$essay) #needs to be given only the vector of essays themselves


#Combining the all of the features
#------------------------------------------------------------------------



#Fitting Various Models
###################################################################################################
#Random Forest - to use random_forest_evaluate(), you need a 
#   1) a training dataframe with:
#       -the first column is the  'grade'
#       -the second column is the 'essayset'
#       -the rest of features
#   2) a test dataframe with:
#       -the first column is the 'essayset'
#       -the rest of the features which are the same as the in the training dataframe
#this function will return

#let's fit this model with only the bag of words
#------------------------------------------------------------------------
rf_results <- random_forest_evaluate(training_tokens, training$grade,test_tokens,number_of_trees=40)
temp <-rf_results[3]

test_features
rf_training <- cbind(training_data$essayset,training_features
rf_results <- random_forest_evaluate(training_tokens,test_tokens,number_of_trees=40)

###################################################################################################