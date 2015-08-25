<<<<<<< HEAD
Data_Science_Course
===================
The purpose of this README is to explain the files within the repo and scope of the project.  The project was undertaken as an assignement to the Getting and Cleaning Data course run by Jeff Leek at John Hopkins Unversity and hosted by Coursera.  The course can be found [here] (https://class.coursera.org/getdata-005).  

The sourse files for the project are found [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  The end goal of this project to to clean the source data and deliver a summarized file with the average value of each participant and activity.   The data cleaning script is written for R and is in file run_analysis.R  The output of the transformation was saved to file submit.txt and submitted to the course project page.

###Analysis Process
The data transformation starts with setting the working directory.  This step is specific to the author's machine and can be run to setup the users machine with a similar directory.  It is optional but the user should manually update the working directory if not run.  This will ensure the source files are loaded correctly.  

The second phase of the analysis is to download the data and unzip the file.  The data is downloaded to the working directory and named Data.zip.  The upzip process creates the folder 'UCI HAR Dataset'.  This folder contains the original data owner's readme file and datasets.  There are 2 train dataset and 2 test datasets as well as several file with data variables and labels.

We begin data transformation by adding column names to the 'activity_lables' file and removing the index values from the 'feature_name' file 

The X_train dataset is prepared by first splitting each row into a list of values using the scientific notation indication, for example: e-001. These lists of values are unlisted and reassembled into a matrix with a row for each original row of strings.  The Y_train dataset is bound to the matrix to identify the row of measurements to a subject.  The result of this step is the X_train.matrix value.  The same steps are performed to prepare the X_test dataset which results in the X_test.matrix value.

After transformation, the X_train.matrix and X_test.matrix files are combined into a single data frame titled 'complete'.  I used regex again to identify the measures with -mean or std in the name.  These columns were extracted to create a new data framed titled 'complete.trimmed'.  
   
The final step in the analysis was to use the aggregate function to calculated the mean value for each measure by the subject and activity IDs.  This created a dataset called final.dataset that was 180 rows by 68 columns wide.  

=======
# 3_Get_and_Clean_Data
>>>>>>> 934b83cbf8465f58dd58e65711f17153291319c4
