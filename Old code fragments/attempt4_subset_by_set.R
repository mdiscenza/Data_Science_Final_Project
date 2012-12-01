require(RTextTools)
#setwd("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project")


#import and process the training set
#column order: id,set,essay, rater1, rater2, grade
train <- read.delim("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/train.tsv", header=TRUE)
#train <- read.delim("https://inclass.kaggle.com/c/columbia-university-introduction-to-data-science-fall-2012/download/train.tsv", header=TRUE)
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
test <- read.delim("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/test.tsv", header=TRUE)
#test <- read.delim("https://inclass.kaggle.com/c/columbia-university-introduction-to-data-science-fall-2012/download/test.tsv", header=TRUE)
test_ids <- test$id
test_tokens<-create_matrix(test, language="english", removeNumbers=TRUE, stemWords=TRUE, removePunctuation=T, removeStopwords=T, toLower=T, removeSparseTerms=.98)
tokens = as.data.frame(as.matrix(test_tokens))
rm(test_tokens)
rownames(tokens) <- c(1:dim(tokens)[1])
test_data <- cbind(test$set,tokens)
colnames(test_data)[1] <- "essayset" # need to do this because there is count of the occurances of the word "set" in the essays themselves
rm(test)


#I need to have both the test and the training data that I give to each of the tree based methods have the same word counts
both <- intersect(colnames(test_data), colnames(training_data))
training_data <- training_data[,both]
test_data <- test_data[,both]
#create a single data frame of training data that has also the y values
train_temp <- cbind(as.data.frame(training_grades),training_data[,both])
colnames(train_temp)[1] <- "grades"


# Random forest- this works, but is not what I want because I need the "essayset" variable to be used in all trees that are fit, so I should use something like bagging or boosting, or just grow a single tree

for (set in 1:5){
    print(set)
    subset_training <- training_tokens[which(training_tokens$essayset==set),-1]
    subset_test <- test_tokens[which(test_tokens$essayset==set),-1]
    training_grades_subset <- training$grade[which(training_tokens$essayset==set)]
    model_subset <-randomForest(x=subset_training, y=training_grades_subset, ntree=20)
    assign(paste("pred_subset",set,sep=""),predict(model_subset, subset_test))
    pred_temp <- predict(model_subset, subset_test)
    set <- rep(x=i, times=length(subset_test))
    weight <- rep(x=1, times=length(subset_test))

    assign(paste("pred_subset",set,sep=""),cbind(test$id[which(test$set==i)],set, weight,round(pred_temp)))
}

#now create the submission document:
submission_grades <- 


summary(test_data$essayset==set)

set1 <- subset(test_data, test_data$essayset==1)
set2 <- subset(test_data, test_data$essayset==2)


table(test_data$essayset)

predict(model_subset, test_subset)


results<-c(pred_subset1,pred_subset2,pred_subset3,pred_subset4,pred_subset5)
prediction <-cbind(test$id, test$set, rep(x=1,length(test$id)),results )
length(test$id)


#Setting up for boosting that really didnt work
trainingdata <- cbind(training_grades_subset, train_subset)
colnames(trainingdata)[1] <- "grades"
model2 <- boosting(grades~.,data=trainingdata) #this didnt work

#OH WOW, THAT WAS BAD <- we really can't forget about the set, the set really determines what is relevant, let's try bagging


#divide the training data and the test data into dataframes by sets
train_temp_1 <- subset(train_temp, train_temp$essayset==1)
test_data_1 <- subset(test_data, test_data$essayset==1)

#Trying boosing and bagging - none of these worked though....
library(adabag)
model2 <- boosting(grades~.,data=train_temp) #this didnt work
model2_subset1 <- boosting(grades~.,data=train_temp_1) #this didnt work
model3 <- bagging(grades~.,data=train_temp)
grades <-training_grades
model4 <- tree(grades~.,data=train_temp)


model_iris <- boosting(Sepal.Width~.,data=iris) #this does not work
model_iris <- boosting(Species~.,data=iris) #this works



# to attempt to get this to work I am going ot use a different package,
library(caret)


#visualizations:
histogram(training_grades, main="Distribution of Grades in Training Set", xlab="Grades")

