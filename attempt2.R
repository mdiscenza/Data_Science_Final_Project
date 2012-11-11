require(RTextTools)
#setwd("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project")


#import and process the training set
#column order: id,set,essay, rater1, rater2, grade
#train <- read.delim("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/train.tsv", header=TRUE)
train <- read.delim("https://inclass.kaggle.com/c/columbia-university-introduction-to-data-science-fall-2012/download/train.tsv", header=TRUE)
train<-na.omit(train)
train_tokens<-create_matrix(train, language="english", removeNumbers=TRUE, stemWords=TRUE, removePunctuation=T, removeStopwords=T, toLower=T, removeSparseTerms=.98)
tokens = as.data.frame(as.matrix(train_tokens))
rm(train_tokens)
rownames(tokens) <- c(1:dim(tokens)[1])
train <- train[,-3]
training_data <- cbind(train$set,tokens)
rm(tokens)
training_grades <- as.numeric(as.character(train$grade))
colnames(training_data)[1] <- "essayset" # need to do this because there is count of the occurances of the word "set" in the essays themselves
rm(train)


#import and process the test set
#column order: id, set, essay
#test <- read.delim("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/test.tsv", header=TRUE)
test <- read.delim("https://inclass.kaggle.com/c/columbia-university-introduction-to-data-science-fall-2012/download/test.tsv", header=TRUE)
test_tokens<-create_matrix(test, language="english", removeNumbers=TRUE, stemWords=TRUE, removePunctuation=T, removeStopwords=T, toLower=T, removeSparseTerms=.98)
tokens = as.data.frame(as.matrix(test_tokens))
rm(test_tokens)
rownames(tokens) <- c(1:dim(tokens)[1])
test_data <- cbind(test$set,tokens)
colnames(test_data)[1] <- "essayset" # need to do this because there is count of the occurances of the word "set" in the essays themselves
rm(tokens,test)


#I need to have both the test and the training data that I give to each of the tree based methods have the same word counts
both <- intersect(colnames(test_data), colnames(training_data))
training_data <- training_data[,both]
test_data <- test_data[,both]
#create a single data frame of training data that has also the y values
train_temp <- cbind(as.data.frame(training_grades),training_data[,both])
colnames(train_temp)[1] <- "grades"


# Random forest- this works, but is not what I want because I need the "essayset" variable to be used in all trees that are fit, so I should use something like bagging or boosting, or just grow a single tree
model1 <- randomForest(x=training_data, y=training_grades, xtest=test_data, ntree=10)
pred <- ceiling(model1$predicted)
#OH WOW, THAT WAS BAD <- we really can't forget about the set, the set really determines what is relevant, let's try bagging


#Trying boosing and bagging - none of these worked though....
library(adabag)
model2 <- boosting(grades~.,data=train_temp) #this didnt work
model3 <- bagging(grades~.,data=train_temp)
grades <-training_grades
model4 <- tree(grades~.,data=train_temp)



#visualizations:
histogram(training_grades, main="Distribution of Grades in Training Set", xlab="Grades")

