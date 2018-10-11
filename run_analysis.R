
# Download Data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data/Dataset.zip")
unzip(zipfile = "./data/Dataset.zip", exdir="./data")


# Read Files
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

features <- read.table('./data/UCI HAR Dataset/features.txt')
activity_labels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

# Column Names
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(activity_labels) <- c('activityId','activityType')

# 1. Merge Data

merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
big_data <- rbind(merge_train, merge_test)


# 2. Extract Mean and SD

indx <- grepl("subject|activity|mean|std", colnames(big_data))
means_sd <- big_data[, indx]


# 3. Name Activities in Data Set
# the activityType (last column) has the activity name

activity_names <- merge(means_sd, activity_labels, by = "activityId", all.x = T)


# 4. Label data set with descriptive variable names

names(big_data) <- gsub("^t", 'time', names(big_data))
names(big_data) <- gsub("^f", "frequency", names(big_data))
names(big_data) <- gsub("Acc", "Accelerometer", names(big_data))
names(big_data) <- gsub("Gyro", "Gyroscope", names(big_data))
names(big_data) <- gsub("Mag", "Magnitude", names(big_data))
names(big_data) <- gsub("BodyBody", "Body", names(big_data))
names(big_data) <- gsub("mean", "Mean", names(big_data))
names(big_data) <- gsub("std", "StandardDeviation", names(big_data))
names(big_data) <- gsub("iqr", "InterquartileRange", names(big_data))


# 5. Create independent tidy data with average of each variable

library(plyr)
tidy_data <- aggregate(. ~ subjectId + activityId, big_data, mean)
tidy_data <- tidy_data[order(tidy_data$subjectId, tidy_data$activityId), ]
write.table(tidy_data, "tidy_data.txt")






