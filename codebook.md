This is the codebook for the peer-graded assignment which explanes all the transormations in the data.

First of all the data set zip is dowloaded and unpacked. Then all the relevant test, train, subject activities and features files are loaded:
X_train;X_test - train and test data X_train.txt, X_test.txt
Y_train;Y_test - code of activity loaded Y_train.txt, Y_test.txt
subject_test;subject_train - loading subject data subject_train.txt, subject_test.txt
activities - loading activity_labels.txt
featurers - loading the features of the dataset. features.txt

Renaming the variables using the features.txt list to name the columns names of X_train and X_test.

X_combined - binding the rows from X_train and X_test
Y_combined - binding the rows from Y_train and Y_test
Y_combined column name is "code" for code of the activity
subject_combined - binding subject_train and subject_test

combined_dataset - binding all of the above in one dataset
Adding subject column to the dataset
Creating a dataset with mean and sd only, this is done through selecting the columns which contain "mean" and "std"
Appropriately labels the data set with descriptive variable names. The abbreviations are given full names for readability.
Create a second tidy data set with the average of each variable for each activity and each subject. The name of the set is mean_sd_combined_dataset. This dataset is being exported and provided for the assignment:

mean_sd_combined_dataset.txt
