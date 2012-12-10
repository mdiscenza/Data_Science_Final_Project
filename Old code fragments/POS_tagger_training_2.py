import pandas
from pandas import read_csv
from urllib import urlopen
import nltk
from nltk.tag.simplify import simplify_wsj_tag
from sklearn.feature_extraction.text import CountVectorizer

training = read_csv('/Users/michaeldiscenza/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/training.csv')
training = training[0:50]

def pos_tokens(essay):
	#converts an essay into a bag of parts of speech
	text = nltk.word_tokenize(essay)
	tagged_text = nltk.pos_tag(text)
	simplified = [(word, simplify_wsj_tag(tag)) for word, tag in tagged_text]
	pos_tags_only =""  # how do I just inittialize a list, like this??
	for word in range(0,len(simplified)):
		pos_tags_only = pos_tags_only +" " + simplified[word][1]
	return pos_tags_only

for essay_number in range(0, len(training)): 
	print("POS tagging essay " + str(essay_number) + " of " + str(len(training)))
	training["essay"][essay_number] = pos_tokens(training["essay"][essay_number])



training.to_csv('/Users/michaeldiscenza/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/training_pos_.csv')
