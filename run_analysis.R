# Here are the data for the project:         
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# R script called run_analysis.R that does the following:
# 1 - Merges the training and the test sets to create one data set.

xTrainData <- read.table("./r_programming_coursera/Getting-and-Cleaning-Data/UCI_HAR_Dataset/train/X_train.txt", header=FALSE)
xTestData <- read.table("./r_programming_coursera/Getting-and-Cleaning-Data/UCI_HAR_Dataset/test/X_test.txt", header=FALSE)
xTrainTestData <- rbind(xTrainData, xTestData)

sTrainData <- read.table("./r_programming_coursera/Getting-and-Cleaning-Data/UCI_HAR_Dataset/train/subject_train.txt", header=FALSE)
sTestData <- read.table("./r_programming_coursera/Getting-and-Cleaning-Data/UCI_HAR_Dataset/test/subject_test.txt", header=FALSE)
sTrainTestData <- rbind(sTrainData, sTestData)

yTrainData <- read.table("./r_programming_coursera/Getting-and-Cleaning-Data/UCI_HAR_Dataset/train/y_train.txt", header=FALSE)
yTestData <- read.table("./r_programming_coursera/Getting-and-Cleaning-Data/UCI_HAR_Dataset/test/y_test.txt", header=FALSE)
yTrainTestData <- rbind(yTrainData, yTestData)

# 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 

featureData <- read.table("./r_programming_coursera/Getting-and-Cleaning-Data/UCI_HAR_Dataset/features.txt")
meanAndStandardDeviationData <- grep("-mean\\(\\)|-std\\(\\)", featureData[, 2])
xTrainTestData <- xTrainTestData[, meanAndStandardDeviationData]
names(xTrainTestData) <- featureData[meanAndStandardDeviationData, 2]
names(xTrainTestData) <- gsub("\\(|\\)", "", names(xTrainTestData))
names(xTrainTestData) <- tolower(names(xTrainTestData))


# 3 - Uses descriptive activity names to name the activities in the data set

activitiesData <- read.table("./r_programming_coursera/Getting-and-Cleaning-Data/UCI_HAR_Dataset/activity_labels.txt")
activitiesData[, 2] = gsub("_", "", tolower(as.character(activitiesData[, 2])))
yTrainTestData[,1] = activitiesData[yTrainTestData[,1], 2]
names(yTrainTestData) <- "activityName"

# 4 - Appropriately labels the data set with descriptive activity names.

names(sTrainTestData) <- "subjectName"
cleanedData <- cbind(sTrainTestData, yTrainTestData, xTrainTestData)
write.table(cleanedData, "./r_programming_coursera/Getting-and-Cleaning-Data/tidy.txt")

# 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

uniqueSubjectData = unique(sTrainTestData)[,1]
numberSubjects = length(unique(sTrainTestData)[,1])
numberActivities = length(activitiesData[,1])
numberColumns = dim(cleanedData)[2]
results = cleanedData[1:(numberSubjects * numberActivities), ]

row = 1
for (subject in 1:numberSubjects) {
        for (activity in 1:numberActivities) {
                results[row, 1] = uniqueSubjectData[subject]
                results[row, 2] = activitiesData[activity, 2]
                temp <- cleanedData[cleanedData$subjectName == subject 
                        & cleanedData$activityName == activitiesData[activity, 2], ]
                results[row, 3:numberColumns] <- colMeans(temp[, 3:numberColumns])
                row = row + 1
        }
}
write.table(results, "./r_programming_coursera/Getting-and-Cleaning-Data/each_activity_and_subject_averages.txt")





