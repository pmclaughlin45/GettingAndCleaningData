print("...loading libraries")
##Load up the needed libraries 
library("plyr")
library("sqldf")

print("...reading in datasets")
#read each Test file into its own dataframe
TestSet <- read.table('./UCI HAR Dataset/test/X_test.txt')
TestLabels <- read.table('./UCI HAR Dataset/test/y_test.txt')
TestSubject <- read.table('./UCI HAR Dataset/test/subject_test.txt')

#read each Train file into its own dataframe
TrainSet <- read.table('./UCI HAR Dataset/train/X_train.txt')
TrainLabels <- read.table('./UCI HAR Dataset/train/y_train.txt')
TrainSubject <- read.table('./UCI HAR Dataset/train/subject_train.txt')

print("...renaming dataframe variables")
#read in the features file that contains measurement names, and 
    #extract a vector with the column names
Features <- read.table('./UCI HAR Dataset/features.txt')
FeaturesVector <- Features[,2]

#use vector to rename columns in TestSet and TrainSet
colnames(TestSet) <- FeaturesVector
colnames(TrainSet) <- FeaturesVector
##### STEP 4 COMPLETE #####

#Rename the subject and activity columns
TestSubject <- rename(TestSubject, c("V1" = "Subject"))
TestLabels <- rename(TestLabels, c("V1" = "Activity"))
TrainSubject <- rename(TrainSubject, c("V1" = "Subject"))
TrainLabels <- rename(TrainLabels, c("V1" = "Activity"))

#cbind Train and Test sets into one dataset
TotalTest <-  cbind(TestSubject, TestLabels, TestSet)
TotalTrain <- cbind(TrainSubject, TrainLabels, TrainSet)

print("...combining test and train data sets")
#append the dataframes into one dataframe
TotalSet <- rbind(TotalTest, TotalTrain)
##### STEP 1 FINISHED #####

print("...renaming activities")
#Replace the Activity numbers with the descriptions
TotalSet$Activity <- revalue(as.character(TotalSet$Activity), c("1" = "WALKING")) 
TotalSet$Activity <- revalue(as.character(TotalSet$Activity), c("2" = "WALKING_UPSTAIRS")) 
TotalSet$Activity <- revalue(as.character(TotalSet$Activity), c("3" = "WALKING_DOWNSTAIRS")) 
TotalSet$Activity <- revalue(as.character(TotalSet$Activity), c("4" = "SITTING")) 
TotalSet$Activity <- revalue(as.character(TotalSet$Activity), c("5" = "STANDING")) 
TotalSet$Activity <- revalue(as.character(TotalSet$Activity), c("6" = "LAYING")) 
##### STEP 3 FINISHED #####

print("...removing unneeded variables")
#Reduce the dataframe so that Activity, Subject, and mean() and std() columns are only included
TotalSetSub <- TotalSet[,c(1,2,grep("mean()", colnames(TotalSet), fixed=T), grep("std()", colnames(TotalSet), fixed=T))]
##### STEP 2 FINISHED #####
print("...TotalSetSub dataset finished")
###TotalSetSub is the first finished "Tidy Data Set"

print("...calculating averages by activity and subject")
#use aggregate to get a new tidy data set with the mean for each of the measurements by the Activity and Subject
TotalSetSubAverage <- aggregate(TotalSetSub[, 3:68], list(TotalSetSub$Subject, TotalSetSub$Activity), mean)
##### STEP 5 FINISHED #####
print("...aggregate dataset finished, cleaning up environment")
rm(list=setdiff(ls(), c("TotalSetSub", "TotalSetSubAverage")))

print("")
print("")
print("Execution Finished!  Two Tidy Data Sets Created")
print("TotalSetSub is the tidy data set with original measures")
print("TotalSetSubAverage is a tidy data set with all measured aggregated by Activity and Subject using means")
