#script that contains the function for fitting different models to a given feature set
#Random Forest - to use random_forest_evaluate(), you need a 
#   1) a training dataframe with:
#       -the first column is the  'grade'
#       -the second column is the 'essayset'
#       -the rest of features
#   2) a test dataframe with:
#       -the first column is the 'essayset'
#       -the rest of the features which are the same as the in the training dataframe
#this function will return
require(randomForest)

# for testing the random_forest_evaluate() function:
training_data<-training_tokens
test_data<-test_tokens
number_of_trees <-20
training_grades <- training$grade
#set <-1
random_forest_evaluate <- function(training_data,training_grades,test_data,number_of_trees){
    results <- NULL
    oob_error <- NULL
    comp <- NULL
    for (set in 1:5){
        print(paste("Now fitting model to essayset, ",set, sep=""))
        subset_training <- training_data[which(training_data$essayset==set),-1]
        subset_test <- test_data[which(test_data$essayset==set),-1]
        subset_training_grades <- training_grades[which(training_data$essayset==set)]
        model_subset <-randomForest(x=subset_training, y=subset_training_grades, ntree=number_of_trees, type="Classification")
        assign(paste("pred_subset",set,sep=""),predict(model_subset, subset_test))
        pred_temp <- predict(model_subset, subset_test)
        set_label <- rep(x=set, times=dim(subset_test)[1])
        weight <- rep(x=1, times=dim(subset_test)[1])
        assign(paste("pred_subset",set,sep=""),cbind(test$id[which(test$set==set)],set_label, weight,round(pred_temp)))
        oob_error[[set]] <- model_subset$predicted - subset_training_grades
        comp[[set]] <-cbind(model_subset$oob.times,subset_training_grades,model_subset$oob.times - subset_training_grades)
    }
    #now create the submission document:
    submission <- rbind(pred_subset1,pred_subset2,pred_subset3,pred_subset4,pred_subset5)
    rm(pred_subset1,pred_subset2,pred_subset3,pred_subset4,pred_subset5)
    colnames(submission) <- c("id","set","weight","grade")
    #write.csv(submission, file="submission.csv")
    results[[1]] <- submission
    #calculate error metrics, absolute mean error
    errors <- c(oob_error[[1]], oob_error[[2]], oob_error[[3]], oob_error[[4]], oob_error[[5]])
    results[[2]] <- mean(abs(errors))
    comparison <- rbind(comp[[1]], comp[[2]], comp[[3]], comp[[4]], comp[[5]])
    results[[3]] <- comparison
    plot(density(errors))
    
    
    return (results)
}
    

