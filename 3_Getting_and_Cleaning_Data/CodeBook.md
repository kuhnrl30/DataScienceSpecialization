#Codebook for Getting and Cleaning Data
##Study Design
The dataset was curated by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto herein referred to as 'curators', from activity trackers worn by 30 participants while performing several activities.  The curators prepared a readme file with basic information and citations.  The file can be downloaded from [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

##Data Dictionary
###Activity
This is a set of 6 different activities each of the participants performed.  The values are shown below.  The values are stored numerically in early dataset but are converted to the text format in the final.dataset and submit.txt file 

No | Activity Description |
--- | ------|
1 | Walking
2 | Waling upstairs
3 | Walking downstairs
4 | Sitting
5 | Standing
6 | Laying

###Measures
This is a set of 66 different continuous variables collected by the data curators.  The source data set included greater than 500 variables.  As part of the data transformation, the number of variables was reduced to 66.  The variables were selected using grep, a regex function, to search for terms 'mean' or 'std'.  These values take on character or numeric modes in differing stages of the analysis.

 | Measures |
:-- | ----- |
 | tBodyAcc-mean()-X | 
 | tBodyAcc-mean()-Y | 
 | tBodyAcc-mean()-Z | 
 | tBodyAcc-std()-X | 
 | tBodyAcc-std()-Y | 
 | tBodyAcc-std()-Z | 
 | tGravityAcc-mean()-X | 
 | tGravityAcc-mean()-Y | 
 | tGravityAcc-mean()-Z | 
 | tGravityAcc-std()-X | 
 | tGravityAcc-std()-Y | 
 | tGravityAcc-std()-Z | 
 | tBodyAccJerk-mean()-X | 
 | tBodyAccJerk-mean()-Y | 
 | tBodyAccJerk-mean()-Z | 
 | tBodyAccJerk-std()-X | 
 | tBodyAccJerk-std()-Y | 
 | tBodyAccJerk-std()-Z | 
 | tBodyGyro-mean()-X | 
 | tBodyGyro-mean()-Y | 
 | tBodyGyro-mean()-Z | 
 | tBodyGyro-std()-X | 
 | tBodyGyro-std()-Y |
 | tBodyGyro-std()-Z |
 | tBodyGyroJerk-mean()-X |
 | tBodyGyroJerk-mean()-Y |
 | tBodyGyroJerk-mean()-Z |
 | tBodyGyroJerk-std()-X |
 | tBodyGyroJerk-std()-Y |
 | tBodyGyroJerk-std()-Z |
 | tBodyAccMag-mean() |
 | tBodyAccMag-std() |
 | tGravityAccMag-mean() |
 | tGravityAccMag-std() |
 
###Identifier
The 'subject' identifier ranges from 1 to 30.  Each represents one of the 30 volunteers that performed the activities for the study.  No further information is provided about each of the volunteers to protect their identity.  

###Source Files
The X_train & X_testcontain the measurement data for each of the measures noted above.  The files are 64mb and 25mb respectively so will take a few moments to load into R.  The data is arranged in rows with a activity code (1-6) as the first character in each row.  

##Calculation
The mean value is calculated for measurement by activity and subject.  This calculation was performed using the aggregate function.  The original measure title was retained.


See the ReadMe.md file stored in the repo: github.com/kuhnrl30/data_science_course.git for a description of the analysis performed.