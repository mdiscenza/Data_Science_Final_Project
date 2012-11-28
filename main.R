setwd("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project")
#wow, I made this file so much cleaner, I'm so happy :)
#import the data

training<-import_training_set()
test<-import_test_set()
tokenized_data <- tokenize_data(training, test)
