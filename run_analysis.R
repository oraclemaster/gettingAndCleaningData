run_analysis <- function() {
    
    ## Getting and Cleaning Data - Course Project 2014/07
    ## The goal is to prepare tidy data that can be used for later analysis.
    ##
    ## This function merges the training and the test sets to create one data set.
    ## Extracts only the measurements on the mean and standard deviation for each measurement. 
    ## Uses descriptive activity names to name the activities in the data set
    ## Appropriately labels the data set with descriptive variable names. 
    ## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
    
    # change working directory, use IF necessary
    # setwd("C:/Documents and Settings/c048978/My Documents/Personali/Sorgenti/R/Data Cleaning/Course Project/") #change working directory
    
    # load library used in the function
    library(sqldf)
    library(plyr)
    
    # load all sets train and test from subdirecty train and test
    train_subject <- read.table("train/subject_train.txt")
    train_activity <- read.table("train/y_train.txt")
    train <- read.table("train/X_train.txt")
    test_subject <- read.table("test/subject_test.txt")
    test_activity <- read.table("test/y_test.txt")
    test <- read.table("test/X_test.txt")
    
    # load labels from main directory
    label <- read.table("features.txt")
    activity <- read.table("activity_labels.txt")
    
    # get only labels, remove special character and prefix "avg" for the tidy data set    
    labelok <- label[,2]
    labeloknochar <- gsub("[[:punct:]]", "", labelok)
    labeloknocharmean <- paste0("avg", labeloknochar)
    
    # rename labels for best comprehension
    names(train_subject) <- "subject"
    names(test_subject) <- "subject"
    names(train) <- labeloknocharmean
    names(test) <- labeloknocharmean
    names(train_activity) <- "activity_code"
    names(test_activity) <- "activity_code"
    names(activity) <- c("activity_code","activity")
    
    # merge activity_code with activity description
    train_activity_data <- sqldf("SELECT * FROM train_activity JOIN activity USING(activity_code)")
    test_activity_data <- sqldf("SELECT * FROM test_activity JOIN activity USING(activity_code)")
    
    # drop activity_code, we need only the activity description
    train_activity_descr <- train_activity_data[,2]
    test_activity_descr <- test_activity_data[,2]
    
    # union with activity description and train/test
    train_union <- cbind(train_activity_descr, train)
    test_union <- cbind(test_activity_descr, test)
    
    # union with train/test subject and train/test union (activity description and train/test)
    train_subject_union <- cbind(train_subject, train_union)
    test_subject_union <- cbind(test_subject, test_union)
    
    # rename column 2 names for better reading 
    names(train_subject_union)[2] <- "activitydescription"
    names(test_subject_union)[2] <- "activitydescription"
    
    # union train e test
    all_data <- rbind(train_subject_union, test_subject_union)
    
    # extracts only the measurements on the mean and standard deviation for each measurement
    
    tidy_data <- all_data[,c(1, 2, 3, 4, 5, 6, 7, 8, 43, 44, 45, 46, 47, 48, 83, 84, 85, 86, 87, 88, 123, 124,
                             125, 126, 127, 128, 163, 164, 165, 166, 167, 168, 203, 204, 216, 217, 229,
                             230, 242, 243, 255, 256, 268, 269, 270, 271, 272, 273, 347, 348, 349, 350,
                             351, 352, 426, 427, 428, 429, 430, 431, 505, 506, 518, 519, 531, 532, 544, 545)]
    
    # creates a second, independent tidy data set with the average of each variable for each activity and each subject
    tidy_data_step5 <- ddply(tidy_data,.(subject, activitydescription),numcolwise(mean))
    
    # write the tidy data set 
    write.table(tidy_data_step5, file = "tidyDataStep.txt", sep=",")
    
    # uncheck for TEST PURPOSE load written data set for check is readibility
    # tidy_data_step5_check <- read.table("tidyDataStep.txt", sep=",", header= TRUE)
    
}

