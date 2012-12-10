import nltk
from nltk.tag.simplify import simplify_wsj_tag
from sklearn.feature_extraction.text import CountVectorizer

for file_number in range(8887, 10000): # cycle through all of the files in the dir
	#file_number= 8887  #just for testing  - 11830 max
	file_name ='/Users/michaeldiscenza/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/temp_text_processing/test/' + str(file_number) + '.txt'
	text_file = open(file_name, 'r')
	text = text_file.read()
	text_file.close()
	text = nltk.word_tokenize(text)
	tagged_text = nltk.pos_tag(text)
	simplified = [(word, simplify_wsj_tag(tag)) for word, tag in tagged_text]
	pos_tags_only =""  # how do I just inittialize a list, like this??
	for word in range(1,len(simplified)):
		pos_tags_only = pos_tags_only +" " + simplified[word][1]
	output_file_path ='/Users/michaeldiscenza/Dropbox/Fall_2012/Intro_to_Data_Science/Final Project/temp_text_processing/test/output/' + str(file_number) + '.txt'
	out_file = open(output_file_path, 'w')
	out_file.write(pos_tags_only)
	out_file.close()

	#now I want to make counts of 4- grams of parts of speech and use those as features!




#script

