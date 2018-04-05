Homework 2

Introduction

Question 1
The script (homework2_template.m) loads a .CSV file containing a dataset for later use in neural network training and applies a haar wavelet transform to extract wavelet features that will act as a feature vector for the input layers of the neural network for training.

Question 2
The script (homework2_2.m) trains a neural network to determine different facial expressions from a public labeled dataset available on Kaggle. After the image dataset is read in different types of wavelet transforms are applied. The transformed data is then used as inputs to the neural networks for training, verifying, and testing. The resulting neural networks will be a classifier than will theoretically be capable of the recognizing facial expression and properly categorizing the testing images properly

Usage

Setup
The matlab script file script files (homework2_template.m and homework2_2.m) should be be placed in the same folder as the Kaggle dataset (fer2013.csv).

Question 1
The question 1 script (homework2_template.m) should be run normally. During the execution, the script will save several of the datasets into a series of .MAT files so that the memory usage is lower and future operation will be faster. The script operates by applying a Haar Wavelet transform to the input dataset and then finishes by saving the data to a file called ‘HaarData.mat’ 

Question 2
The question 2 script (homework2_template.m) should be run normally. During the execution, the script will go through a loop (two iterations) to complete two neural network training sessions using the feature vector extract with two kinds of wavelets (coiflet and biorthogonal). After applying the wavelets to the dataset, the training, verifying, and testing loop will begin and the two neural networks will be trained. The process will be started when the NN GUI appears and the training starts. Following the completion, ROC curves and other information will be available from the NN GUI.



