library(reshape2)

doAnalysis <- function(){
  #Load the features from the data set
  features <- read.table("./dataset/features.txt")
  
  #Mean and Std column names only
  meanAndStd <- features[grep("(mean|std)\\(", features[,2]),]
  
  #Load the test data from the data set
  testData =  read.table("dataset/test/X_test.txt", col.names = features[,2]);
  testSubjects =  read.table("dataset/test/subject_test.txt");
  testActivities =  read.table("dataset/test/y_test.txt");
  
  testData = testData[,meanAndStd[,1]]
  
  testData$Subject <- testSubjects$V1
  testData$Activity <- transformActivities(testActivities);
  testData$Dataset <- 'Test'
  
  
  #Loaded the training data from the dataset
  trainData = read.table("dataset/train/X_train.txt", col.names = features[,2]);
  trainSubjects = read.table("dataset/train/subject_train.txt");
  trainActivities = read.table("dataset/train/y_train.txt");
  
  trainData = trainData[,meanAndStd[,1]]
  
  trainData$Subject <- trainSubjects$V1
  trainData$Activity <- transformActivities(trainActivities);
  trainData$Dataset <- 'Train'
	
  #merge the two data sets
	merged = rbind(testData, trainData);
	
	#5
	cut <- subset(merged, select=-c(Subject, Activity, Dataset))
  avs <- aggregate(cut, by = list(activity=merged$Activity, subject=merged$Subject), mean)
  
  write.table(avs, file='output.table', row.name=FALSE)
}


#map activities to text labels(more descriptive)
transformActivities <- function(trainActivities){
  ifelse(trainActivities$V1 == 1, 'WALKING', 
         ifelse(trainActivities$V1 == 2, 'WALKING_UPSTAIRS', 
                ifelse(trainActivities$V1 == 3, 'WALKING_DOWNSTAIRS',
                       ifelse(trainActivities$V1 == 4, 'SITTING',
                              ifelse(trainActivities$V1 == 5, 'STANDING', 
                                     ifelse(trainActivities$V1 == 6, 'LAYING', 'ERROR'))))));
}