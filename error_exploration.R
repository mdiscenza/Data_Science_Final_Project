# script that I will use to go through and see which essays that I categorized very poorly and see what features from those could be used to identify them as being better essays:

comparing_errors <- rf_features_and_tokens[[3]]
colnames(comparing_errors)[3] <- "error"
comparing_errors <- comparing_errors[order(comparing_errors[,3],decreasing = TRUE),]
large_errors<- rownames(comparing_errors)[1:10]
comp_table <- cbind(comparing_errors[1:10,], training[large_errors,3])
#training grade- predicted grade
error_vector <- comparing_errors[,1] - comparing_errors[,2]
table(error_vector)

#write the comparison table into a format that is easier to read
comp_table[1,]
comp_table[2,]
#changes as a result of this:

#There is a rule for non-adjacent scores - expert grader.  Do expert grader's tend to grade higher or lower than two:   --- oops, no wait, that's really not relevant - there is no grader info on the test set 
grades_from_sum <- training$rater1 + training$rater2
graded_by_sum <- (grades_from_sum==training$grade)

