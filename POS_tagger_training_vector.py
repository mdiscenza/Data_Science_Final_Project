import pandas
from pandas import read_csv
from urllib import urlopen
import nltk
from nltk.tag.simplify import simplify_wsj_tag
from sklearn.feature_extraction.text import CountVectorizer

training = read_csv('/Users/michaeldiscenza/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/training.csv')
#training = training[0:50] # for testing only

def pos_tokens(essay):
	#converts an essay into a bag of parts of speech
	text = nltk.word_tokenize(essay)
	tagged_text = nltk.pos_tag(text)
	simplified = [(word, simplify_wsj_tag(tag)) for word, tag in tagged_text]
	pos_tags_only =""  # how do I just inittialize a list, like this??
	for word in range(0,len(simplified)):
		pos_tags_only = pos_tags_only +" " + simplified[word][1]
	return pos_tags_only

training['essay'] = training['essay'].map(pos_tokens)
training.to_csv('/Users/michaeldiscenza/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/training_pos.csv')
