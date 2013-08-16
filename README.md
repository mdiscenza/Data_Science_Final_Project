Introduction to Data Science - Fall 2012
---------
Kaggle Competition Code
=============

This repository contains the code that I used for our class-wide Kaggle competition.  The goal of the competition was to automate grading of essays and minimize the difference between the machine-assigned grades and the grades that were given to each essay by expert graders across five different sets of essays, on varying topics, written by students grades 7 through 10.

Further details about the compeition can be found here:
(http://inclass.kaggle.com/c/columbia-university-introduction-to-data-science-fall-2012)


High Level Approach and Code Description
------

As with most text processing tasks, I split my approach into two main sections. The first section was text pre-processing and feature extraction. I extracted features from the individual essays and created a table of data points on each of the essays based on various machine readable attributes such as word count, punctuation mark count, part of speech distrubtions, the presense of transition words, a full bag of words with and without stop words, and a variety of other items.  I tried various combinations of these features, sometimes normalizing and sometimes not.The text pre-processing and feature extraction was completed in python using the Natural Language Toolkit or NLTK package.

The second task, once I had created a tabular representation of features of each essay was model fitting.  Though I attempted to use a variety of models, I quickly found that using the random forrest algorithm was one of the more effective models and chose to focus the bulk of my efforts on identifying the best features to use rather than finding the perfect model.  There was clearly more improvement in predictive performance to be achieved as a result effor in the area of feature extraction and selection. All model fitting was done using R.

I refined and iteerated on my approach by examining the two metrics, the percent of essays correctly classified, meaning the machine assinged the same score as two expert human graders, and the mean squared error of the machine grade.  The model that performed baset was a random forest model consisting of 150 trees which included as features a 97 percent sparse matrix from a bag of words, the counts of various puntuation marks, the number of uses of the word "I", and the length of the longest word in the essay.  This model achieved a correct classification rate of 0.6345 and a mean sean squared error of 0.392.


Results
--------
Performance was evalutated using a quadratic weighted kappa error metric, which measures agreement between the grades assigned by two graders and ranges from zero to 1.  Thus I was not optimizing for the error metric that would be evaluated, but focusing on two other measures which could be thought of as roughtly proportional.

I finished third on the public leaderboard on a subset of test data and fourth on the private leaderboard with a different subset of test.
(http://inclass.kaggle.com/c/columbia-university-introduction-to-data-science-fall-2012/leaderboard)
(http://inclass.kaggle.com/c/columbia-university-introduction-to-data-science-fall-2012/leaderboard/public)