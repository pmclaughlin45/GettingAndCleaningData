# run_analysis.R 

#####  This script requires the "UCI HAR Dataset" to be located in the root folder of your working directory.  To run the script you can issue the source("run_analysis.R") command, make sure the script is located in the root folder of your working directory.
# 
The script takes the files provided in the UCI Har Dataset, and combines the files from the test and train folders into one dataset.  The script then takes the dataset and makes it tidy by renaming variables, and changing activity numbers to activity descriptions.  Once the script creates a tidy data set in the form of a data frame called TotalSubSet, it aggreates the dataset by the Activity and Subject and calcualates the means for all the measurment variables.  The aggreagated dataset is called TotalSetSubAverage.  Both datasets are then written out to text files called totalsetsub.txt and totalsetsubaverage.txt in the users working directory.  The environment is cleaned up and all that is left is the dataframes used to created the text files.



