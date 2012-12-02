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
#call function
rf_results <- random_forest_evaluate(training_tokens, training$grade,test_tokens,number_of_trees=40)
rf_results[[4]] # percentage correctly categorized
rf_results[[2]] #absolute mean error of rating


#combine dfs to create df that the random_forest_evaluate() function can take with the extracted features
rf_training <- cbind(training$set,training_features)
colnames(rf_training)[1] <- "essayset"
rf_test <- cbind(test$set,test_features)
colnames(rf_test)[1] <- "essayset"
#call function
re_features_only <- random_forest_evaluate(rf_training, training$grade, rf_test, number_of_trees=40)
#View results
re_features_only[[2]]
re_features_only[[4]]# percentage correctly categorized
rf_results_tokens_and_features <- random_forest_evaluate(training_tokens, training$grade,test_tokens,number_of_trees=40)

#combine dfs to create df that the random_forest_evaluate() function can take with the extracted features as well as the bag of words as inputs
rf_training <- cbind(training$set,training_features)
colnames(rf_training)[1] <- "essayset"
rf_test <- cbind(test$set,test_features)
colnames(rf_test)[1] <- "essayset"
#call function
re_features_only <- random_forest_evaluate(rf_training, training$grade, rf_test, number_of_trees=40)
#View results
re_features_only[[2]]
re_features_only[[4]]# percentage correctly categorized
rf_results_tokens_and_features <- random_forest_evaluate(training_tokens, training$grade,test_tokens,number_of_trees=40)








glm_model <- fit_glmnet(rf_training, training$grade, rf_test)
###################################################################################################