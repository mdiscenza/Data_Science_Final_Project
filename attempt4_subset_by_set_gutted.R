require(RTextTools)
require(randomForest)
setwd("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project")






#for evaluating models
#random_forest_evaluate <- function(training_data,test_data,number_of_trees){
    



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

