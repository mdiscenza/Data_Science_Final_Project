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
tokenized_data <- tokenize_data(training, test, type="text") #needs to be called on both sets to make sure that the bag of words is actually the same!
training_tokens <- tokenized_data[[1]]
test_tokens <- tokenized_data[[2]]
rm(tokenized_data) # storing this data in two places would be redundant so we get rid of it



#Deriving additional features of the data 
#------------------------------------------------------------------------
    training_features <- calculate_features(training$essay) #needs to be given only the vector of essays themselves
    test_features <- calculate_features(test$essay) #needs to be given only the vector of essays themselves


#getting features from outside of R
#------------------------------------------------------------------------
#must take a dataframe with the first column being the id and the second column being the esssay
# export a csv file that can be read into python
setwd("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project")
write.csv(test, file="test.csv")
# export a csv file that can be read into python
setwd("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project")
write.csv(training, file="training.csv")
######## NOW RUN THE FOLLOWING PYTHON SCRIPTS:
#pos tagger - test
#pos tagger - training

#Now read in the data that we POS-tagged using python's nltk
training_POS <- read.csv("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/training_pos.csv")
training_POS <- training_POS[,c(-1,-2)]
test_POS <- read.csv("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/test_pos.csv")
test_POS <- test_POS[,c(-1,-2)]

##warning the next line takes a lot of time to run!
tokenized_pos <- tokenize_data(training_POS, test_POS, type="POS") #needs to be called on both sets to make sure that the bag of words is actually the same!
training_POS_tokens <- tokenized_pos[[1]]
test_POS_tokens <- tokenized_pos[[2]]
rm(training_POS_tokens)

#this is doing it for ngrams: n=3
POS_3gram <- tokenize_data(training_POS, test_POS, type="POS-ngram") #needs to be called on both sets to make sure that the bag of words is actually the same!
training_POS_3gram <- tokenized_pos[[1]]
test_POS_3gram <- tokenized_pos[[2]]
rm(training_POS_3gram)

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
rf_training <- cbind(training_tokens,training_features,training_POS_tokens[,-1])
colnames(rf_training)[1] <- "essayset"
rf_test <- cbind(test_tokens,test_features, test_POS_tokens[,-1])
colnames(rf_test)[1] <- "essayset"
#call function
rf_features_and_tokens_4 <- random_forest_evaluate(rf_training, training$grade, rf_test, number_of_trees=150)
#View results
rf_features_and_tokens[[2]] #0.4099043 (with 40 trees)
rf_features_and_tokens[[4]]# percentage correctly categorized 0.6175577 (with 40 trees), 0.6329769 (150 trees)
write.csv(rf_features_and_tokens[[1]], file="submission_features_and_tokens.csv")


rf_features_and_tokens_2[[2]] ##0.3913337 (with 150 trees)
rf_features_and_tokens_2[[4]]#0.6353405 (150)
write.csv(rf_features_and_tokens_2[[1]], file="submission_features_and_tokens.csv")


#with correlation bias control, no replacement mtry=300 
rf_features_and_tokens_3[[2]]
rf_features_and_tokens_3[[4]]
write.csv(rf_features_and_tokens_2[[1]], file="submission_features_and_tokens.csv")

#with correlation bias control, no replacement mtry=300 
rf_training <- cbind(training_tokens,training_features,training_POS_tokens[,-1])
colnames(rf_training)[1] <- "essayset"
rf_test <- cbind(test_tokens,test_features, test_POS_tokens[,-1])
colnames(rf_test)[1] <- "essayset"
rf_features_and_tokens_4 <- random_forest_evaluate(rf_training, training$grade, rf_test, number_of_trees=150)
rf_features_and_tokens_4[[2]]
rf_features_and_tokens_4[[4]]
write.csv(rf_features_and_tokens_4[[1]], file="submission_features_and_tokens6379291.csv")



# same as above, but also includes the % in addition to the mean words
rf_training <- cbind(training_tokens,training_features,training_POS_tokens[,-1],training_POS_tokens[,-1]/training_features$featureWordCount)
colnames(rf_training)[1] <- "essayset"
rf_test <- cbind(test_tokens,test_features, test_POS_tokens[,-1],test_POS_tokens[,-1]/test_features$featureWordCount)
colnames(rf_test)[1] <- "essayset"
rf_features_and_tokens_4 <- random_forest_evaluate(rf_training, training$grade, rf_test, number_of_trees=100)
rf_features_and_tokens_4[[2]]
rf_features_and_tokens_4[[4]]
write.csv(rf_features_and_tokens_4[[1]], file="submission_features_and_tokens.csv")


# with unstemmed words 95 % sparse- didn't do well
#with correlation bias control, no replacement mtry=300 
rf_training <- cbind(training_tokens,training_features,training_POS_tokens[,-1])
colnames(rf_training)[1] <- "essayset"
rf_test <- cbind(test_tokens,test_features, test_POS_tokens[,-1])
colnames(rf_test)[1] <- "essayset"
rf_features_and_tokens_4 <- random_forest_evaluate(rf_training, training$grade, rf_test, number_of_trees=150)
rf_features_and_tokens_4[[2]]
rf_features_and_tokens_4[[4]]
write.csv(rf_features_and_tokens_4[[1]], file="submission_features_and_tokens6379291.csv")


# with unstemmed words 99% sparese - 787 bag of words variables
#with no biase correlations, mtry set to default - 100 trees
rf_training <- cbind(training_tokens,training_features,training_POS_tokens[,-1])
colnames(rf_training)[1] <- "essayset"
rf_test <- cbind(test_tokens,test_features, test_POS_tokens[,-1])
colnames(rf_test)[1] <- "essayset"
rf_features_and_tokens_4 <- random_forest_evaluate(rf_training, training$grade, rf_test, number_of_trees=100)
rf_features_and_tokens_4[[2]]
rf_features_and_tokens_4[[4]]
write.csv(rf_features_and_tokens_4[[1]], file="submission_features_and_tokens6379291.csv")


# with unstemmed word - took out you and i rate
#with no biase correlations, mtry set to default - 150 trees, initial bag of words
rf_training <- cbind(training_tokens,training_features,training_POS_tokens[,-1])
colnames(rf_training)[1] <- "essayset"
rf_test <- cbind(test_tokens,test_features, test_POS_tokens[,-1])
colnames(rf_test)[1] <- "essayset"
rf_features_and_tokens_5 <- random_forest_evaluate(rf_training, training$grade, rf_test, number_of_trees=150)
rf_features_and_tokens_5[[2]]
rf_features_and_tokens_5[[4]]
write.csv(rf_features_and_tokens_4[[1]], file="submission_5.csv")


# with unstemmed word - took out you and i rate
#with no biase correlations, mtry set to default - 150 trees, initial bag of words
rf_training <- cbind(training_tokens,training_features,training_POS_tokens[,-1])
colnames(rf_training)[1] <- "essayset"
rf_test <- cbind(test_tokens,test_features, test_POS_tokens[,-1])
colnames(rf_test)[1] <- "essayset"
rf_features_and_tokens_5 <- random_forest_evaluate(rf_training, training$grade, rf_test, number_of_trees=150)
rf_features_and_tokens_5[[2]]
rf_features_and_tokens_5[[4]]
write.csv(rf_features_and_tokens_4[[1]], file="submission_6.csv")
