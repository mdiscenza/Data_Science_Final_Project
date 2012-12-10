#counting unique number of transition words - idea from: h and also kind ofttp://www.stanford.edu/class/cs341/reports/03-Preston_cs341_-_Dan_and_Danny_-_Final.pdf thought of it a bit on my own, just researched it to see if it would be effective.
transition_words <- read.csv("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/Data_Science_Final_Project/transition_words.csv", quote="")
transition_count <- NULL
for (j in 1:length(training$essay)){
    essay <- training$essay[j]
    transition_word_count <- 0
    for (i in 1:dim(transition_words)[1]){
        #print(i)
        #print(pattern)
        pattern <- as.character(transition_words[i,])
        if(str_count(essay, pattern) > 1){
            transition_word_count <- transition_word_count + 1
            print(pattern)
        }
    }
    transition_count[j] <- transition_word_count
}



# Code taken out of feature extraction function
###THIS PART IS INCREDIBLY INEFFICIENT, I need to come up with a better, faster algorithem for this somehow
transition_words <- read.csv("~/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/Data_Science_Final_Project/transition_words.csv", quote="")   
transition_word_count <- 0
for (i in 1:dim(transition_words)[1]){
    #print(i)
    #print(pattern)
    pattern <- as.character(transition_words[i,])
    if(str_count(essay, pattern) > 1){
        transition_word_count <- transition_word_count + 1
        #print(pattern) #for testing purposes only
    }
}
featureUniqueTransitionWords <-transition_word_count


