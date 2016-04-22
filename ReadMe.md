## 1
`1` Merges the training and the test sets to create one data set.
* Load the data files
* Join activity and subject for test and train data sets. 
* Add identity for test and train data sets as variable

`2` Extracts only the measurements on the mean and standard deviation for each measurement.
* Use grep to filter columns containing std and mean.
* Subset dataframe on these columns

`3` Uses descriptive activity names to name the activities in the data set
* Transform the activity labels to the appropriate descripition.

`4` Appropriately labels the data set with descriptive variable names.
* Load all of the column names from the features file

`5` From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* Use aggregate funtion to average all of the measures on activity and subject