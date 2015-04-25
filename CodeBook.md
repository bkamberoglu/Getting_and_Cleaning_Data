1 - Merges the training and the test sets to create one data set.

	1 - train/X_train.txt:
	'data.frame':	7352 obs. of  561 variables:

	2 - test/X_test.txt:
	'data.frame':	2947 obs. of  561 variables:

	3 - rbind(train/X_train.txt, test/X_test.txt)
	'data.frame':	10299 obs. of  66 variables:

	4 - train/subject_train.txt 
	'data.frame':	7352 obs. of  1 variable:

	5 - test/subject_test.txt
	'data.frame':	2947 obs. of  1 variable:

	6 - rbind(train/subject_train.txt, test/subject_test.txt)
	'data.frame':	10299 obs. of  1 variable:

	7 - train/y_train.txt
	'data.frame':	7352 obs. of  1 variable:

	8 - test/y_test.txt
	'data.frame':	2947 obs. of  1 variable:

	9 - rbind(train/y_train.txt, test/y_test.txt)
	'data.frame':	10299 obs. of  1 variable:


2 - Extracts only the measurements on the mean and standard deviation for each measurement. 

features.txt:
'data.frame':	561 obs. of  2 variables:

3 - Uses descriptive activity names to name the activities in the data set

activity_labels.txt:
'data.frame':	6 obs. of  2 variables:

	1 WALKING
	2 WALKING_UPSTAIRS
	3 WALKING_DOWNSTAIRS
	4 SITTING
	5 STANDING
	6 LAYING

4 - Appropriately labels the data set with descriptive activity names.

cleanedData <- cbind(sTrainTestData, yTrainTestData, xTrainTestData)
cleanedData:
'data.frame':	10299 obs. of  68 variables:

The result is saved as "tidy.txt" and it is 10299X68 data frame

5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
results:
'data.frame':	180 obs. of  68 variables

The result is saved as "each_activity_and_subject_averages.txt" and it is 180x68 data frame,

