#Downloading the zip file.
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Destfile <- ".//R/Data/adl.zip"
download.file(Url, Destfile, "curl")
unzip(".//R/Data/adl.zip", exdir = ".//R/Data")

#Load all the sets and feature.txt which is variable names for all.
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
Y_train <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
Y_test <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")

#Renaming the variables using the features.txt list.
names(X_train) <- features$V2
names(X_test) <- features$V2
library(dplyr)
X_combined <- union_all(X_train, X_test)

#Check. The expression should be zero.
nrow(X_combined)-( nrow(X_train) + nrow(X_test) )

#Combining Y.
Y_combined <- union_all(Y_train, Y_test)
names(Y_combined) <- "code"

#Combining subject.
subject_combined <- union_all(subject_train, subject_test)
names(subject_combined) <- "subject"

#Forming one dataset.
combined_dataset <- cbind(subject_combined, X_combined, Y_combined)
names(activities) <- c("subject","activity")
combined_dataset$subject <- activities[combined_dataset$subject, 2]
names(combined_dataset)

#Creating a dataset with mean and sd only
mean_std_subset <- combined_dataset %>% select(subject,code, contains("mean"), contains("std"))

#Appropriately labels the data set with descriptive variable names.
names(mean_std_subset)<-gsub("-mean()", "Mean", names(mean_std_subset), ignore.case = TRUE)
names(mean_std_subset)<-gsub("-std()", "STD", names(mean_std_subset), ignore.case = TRUE)
names(mean_std_subset)<-gsub("angle", "Angle", names(mean_std_subset), ignore.case = TRUE)
names(mean_std_subset) <-  gsub("Acc", "Accelerometer",names(mean_std_subset), ignore.case = TRUE)
names(mean_std_subset)<-gsub("BodyBody", "Body", names(mean_std_subset), ignore.case = TRUE)
names(mean_std_subset) <-gsub("Gyro", "Gyroscope", names(mean_std_subset), ignore.case = TRUE)
names(mean_std_subset)<-gsub("gravity", "Gravity", names(mean_std_subset), ignore.case = TRUE)
names(mean_std_subset)<-gsub("Mag", "Magnitude", names(mean_std_subset), ignore.case = TRUE)
names(mean_std_subset)<-gsub("^t", "Time", names(mean_std_subset), ignore.case = TRUE)
names(mean_std_subset)<-gsub("^f", "Frequency", names(mean_std_subset), ignore.case = TRUE)
names(mean_std_subset)<-gsub("tBody", "TimeBody", names(mean_std_subset), ignore.case = TRUE)
names(mean_std_subset)<-gsub("-freq()", "Frequency", names(mean_std_subset), ignore.case = TRUE)

#Create a second tidy data set with the average of each variable for each activity and each subject.

mean_sd_combined_dataset <- mean_std_subset %>%
    group_by(subject, code) %>%
    summarise_all(funs(mean))

#Export the txt file.
write.table(mean_sd_combined_dataset,"./data/mean_sd_combined_dataset.txt", row.names = FALSE)
