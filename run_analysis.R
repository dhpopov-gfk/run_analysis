#Downloading the zip file.
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Destfile <- ".//R/Data/adl.zip"
download.file(Url, Destfile, "curl")
unzip(".//R/Data/adl.zip", exdir = ".//R/Data")
#Load all the sets and feature.txt which is variable names for all.
X_train <- read.table("C:/Users/dimitar.popov/Documents/R/data/UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("C:/Users/dimitar.popov/Documents/R/data/UCI HAR Dataset/test/X_test.txt")
Y_train <- read.table("C:/Users/dimitar.popov/Documents/R/data/UCI HAR Dataset/train/Y_train.txt")
Y_test <- read.table("C:/Users/dimitar.popov/Documents/R/data/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("C:/Users/dimitar.popov/Documents/R/data/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("C:/Users/dimitar.popov/Documents/R/data/UCI HAR Dataset/train/subject_train.txt")

features <- read.table("C:/Users/dimitar.popov/Documents/R/data/UCI HAR Dataset/features.txt")

#Renaming the variables using the features.txt list.
names(X_train) <- features$V2
names(X_test) <- features$V2
library(dplyr)
X_combined <- union_all(X_train, X_test)
#Check. The expression should be zero.
nrow(X_combined)-( nrow(X_train) + nrow(X_test) )
#Combining Y.
Y_combined <- union_all(Y_train, Y_test)
nrow(Y_combined)
#Combining subject.
subject_combined <- union_all(subject_train, subject_test)
#forming one dataset.
combined_dataset <- X_combined
combined_dataset$test_labels <- Y_combined
combined_dataset$subject <-subject_combined
names(combined_dataset)
#creating a dataset with mean and sd only
#sapply(combined_dataset, mean)

library(tidyr)
library(dplyr)

mean_combined_dataset <- data.frame(apply(combined_dataset, 2, mean, na.rm = TRUE))
mean_combined_dataset$var <- rownames(mean_combined_dataset)
rownames(mean_combined_dataset)<- NULL
names(mean_combined_dataset) <- c("mean","var")

sd_combined_dataset <- data.frame(apply(combined_dataset, 2, sd, na.rm = TRUE))
sd_combined_dataset$var <- rownames(sd_combined_dataset)
rownames(sd_combined_dataset)<- NULL
names(sd_combined_dataset) <- c("sd","var")

mean_sd_combined_dataset <- inner_join(mean_combined_dataset,sd_combined_dataset) %>% select(var,mean,sd)
mean_sd_combined_dataset
write.table(mean_sd_combined_dataset,"C:/Users/dimitar.popov/Documents/R/mean_sd_combined_dataset.txt", row.names = FALSE)