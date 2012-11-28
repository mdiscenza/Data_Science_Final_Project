#script that contains the function for fitting different models to a given feature set
# Random forest- this works, but is not what I want because I need the "essayset" variable to be used in all trees that are fit, so I should use something like bagging or boosting, or just grow a single tree


#this takes two main arguments:
#   1) a training data set that has the grade in the first column and the set in the second column
#   2) a test data set that contains the same predictors 
random_forest_evaluate <- function(training_data,test_data,number_of_trees){
    require(randomForest)
    results <- NULL
    for (set in 1:5){
        print(paste("fiting model for set ", set, sep=""))
        training_subset <- training_data[which(training_data$essayset==set),]
        test_subset <- test_data[which(test_data$essayset==set),]
        # we want to get rid of this line and have grades pased in as the first column
        #training_grades_subset <- training_grades[which(training_data$essayset==set)]
        model_subset <-randomForest(x=training_subset[c(-1,-2),], y=training_subset[1,], ntree=20)
        #    assign(paste("pred_subset",set,sep=""),predict(model_subset, test_subset))
        pred_temp <- predict(model_subset, test_subset)
        set <- rep(x=set, times=length(test_subset))
        weight <- rep(x=1, times=length(test_subset))
        assign(paste("pred_subset",set,sep=""),cbind(test$id[which(test$set==set)],set, weight,round(pred_temp)))
    }
    
    #now create the submission document:
    submission <- rbind(pred_subset1,pred_subset2,pred_subset3,pred_subset4,pred_subset5)
    rm(pred_subset1,pred_subset2,pred_subset3,pred_subset4,pred_subset5)
    colnames(submission) <- c("id","set","weight","grade")
    #write.csv(submission, file="submission.csv")
    result[[1]] <- submission
}
    

