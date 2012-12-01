#regEx test cases:

#First copy these into Microsoft word and see that they have for word counts and char counts
#copy into a text editor to see the number of instances of specific characters
test$essay[4]

# specific character instances
feature_word_count <- str_count(test$essay[4], ' ') + 1 
feature_word_count # word says 421
feature_commas <- str_count(test$essay[4], ',')
feature_commas #sublime says 13
feature_semi_colon<- str_count(test$essay[4], ';')
feature_semi_colon #sublime says 13
feature_dash <- str_count(test$essay[4], '-')
feature_dash #sublime says 4
#proxy for number of sentences
feature_periods <- str_count(test$essay[4], '\\.') # retunrs the number of periods - have to escape
feature_periods #sublime says 24
feature_alphanumeric_char <- nchar(test$essay[4]) - feature_word_cout + 1
feature_avg_word_length <- feature_alphanumeric_char/feature_word_count
feature_avg_word_length
