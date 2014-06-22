## downloads the data and unzips it
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destName = "project.zip"
download.file(url, dest = destName)
unzip(destName)

## extracts each set of data into a table
train <- read.table("./UCI HAR Dataset/train/x_train.txt")
trainActivity <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

test <- read.table("./UCI HAR Dataset/test/x_test.txt")
testActivity <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

variables <- read.table("./UCI HAR Dataset/features.txt")

## creates full training and test data sets
## add column names
colnames(train) <- variables[,2]
colnames(test) <- variables[,2]

colnames(trainActivity) <- "Activity"
colnames(testActivity) <- "Activity"

colnames(trainSubject) <- "SubjectNumber"
colnames(testSubject) <- "SubjectNumber"

## add activity number
train <- cbind(trainActivity, train)
test <- cbind(testActivity, test)

## add subject number
train <- cbind(trainSubject, train)
test <- cbind(testSubject, test)

## merges the training and test data sets
merged <- rbind(train, test)

## re-order the data frame based on Subject No.
merged <- merged[order(merged[,1], merged[,2]),]

## replaces activity number with description
merged$Activity[merged$Activity == 1] <- "Walking"
merged$Activity[merged$Activity == 2] <- "Walking Upstairs"
merged$Activity[merged$Activity == 3] <- "Walking Downstairs"
merged$Activity[merged$Activity == 4] <- "Sitting"
merged$Activity[merged$Activity == 5] <- "Standing"
merged$Activity[merged$Activity == 6] <- "Laying"

## extracts the mean and std into a new data set
subsetData <- merged[,sort(c(1:2, grep("-mean()", colnames(merged)), grep("-std()", colnames(merged))))]
subsetData <- subsetData[,-grep("-mean()Freq", colnames(subsetData))]

## renames variables to be more descriptive
names <- sub("\\-mean\\(\\)\\-*", colnames(subsetData), replacement = ".Mean.")
names <- sub("\\-std\\(\\)\\-*", names, replacement = ".STD.")
colnames(subsetData) <- names

## create a second data set with only the averages of each variable/subject/activity
install.packages("reshape2")
library(reshape2)

melted <- melt(subsetData, id=c("SubjectNumber", "Activity"))
cast <- dcast(melted, SubjectNumber + Activity ~ variable, mean)

## save new data frame
write.table(cast, "tidydata.txt", sep=",")