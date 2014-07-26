gettingAndCleaningData
======================


### Getting and Cleaning Data Course Project

The purpose of this project is collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

I create one R script called run_analysis.R that does the following. 

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 
    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


### Contents of this Repository

In this repository you find:

README.md (this file): explains how the the scripts work.  

CodeBook.txt: a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

run_analysys.R the R script explained before

tidyDataStep.txt the final tidy data set


### The script run_analysis.R did it with this steps:

	load all sets train and test from subdirecty train and test
    
	load labels from main directory
    
	get only labels, remove special character and prefix "avg" for the tidy data set

	rename labels for best comprehension
    
	merge activity_code with activity description
    
	drop activity_code, we need only the activity description

	union with activity description and train/test
    
	union with train/test subject and train/test union (activity description and train/test)
    
	rename column 2 names for better reading 
    
	union train e test

	extracts only the measurements on the mean and standard deviation for each measurement

	creates a second, independent tidy data set with the average of each variable for each activity and each subject
    
	write the tidy data set 

	"comment" step for TEST PURPOSE load written tidy data set for check it


### Thr dimension of tidy data set

The dimension of tidy data set are 180x68 because we have:

30 subjects and 6 activities = 30 * 6 = 180 rows

subject + activity description + 66 mean and std features (not including angle nor frequencies) = 68 columns


### You can verify the loading of tidy data set with this command:

tidy_data_step5_check <- read.table("tidyDataStep.txt", sep=",", header= TRUE)