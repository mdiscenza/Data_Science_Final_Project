#----------------------------------------------------
#for testing here:
training_data <- rf_training_1
test_data <- rf_test_1

training_data <- rf_training_2
test_data <- rf_test_2
number_of_trees <- 20
#----------------------------------------------------

set <-1
print(set)
subset_training_data <- training_data[which(training_data$essayset==set),(-1)]
training_grade_subset <- training_data[which(training_data$essayset==set),1]

test_subset <- test_data[which(test_data$essayset==set),c(2:dim(test_data)[2])]
train_subset$
randomForest(grade~., data=training_subset)
model_subset <-randomForest(x=train_subset, y=training_grades_subset, ntree=20)

model_subset <-randomForest(x=training_subset, y=training_grade_subset, ntree=20)
assign(paste("pred_subset",set,sep=""),predict(model_subset, test_subset))
pred_temp <- predict(model_subset, test_subset)
set <- rep(x=i, times=length(test_subset))
weight <- rep(x=1, times=length(test_subset))

assign(paste("pred_subset",set,sep=""),cbind(test$id[which(test$set==i)],set, weight,round(pred_temp)))



#Trying boosting
set <-1
print(set)
training_subset <- training_data[which(training_data$essayset==set),]
training_grade_subset <- training_data[which(training_data$essayset==set),1]

test_subset <- test_data[which(test_data$essayset==set),c(2:dim(test_data)[2])]
library(adabag)
boooo<-boosting(grade~., data=training_subset, boos = TRUE)



model_subset <-randomForest(x=training_subset, y=training_grade_subset, ntree=20)
