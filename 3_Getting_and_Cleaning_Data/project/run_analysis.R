require(reshape2)
##############################################
## To create the working directory
##############################################
  if(file.exists("c:/users/owner/documents/Coursera/GetCleanData")){  
    setwd("c:/users/owner/documents/Coursera/GetCleanData")
  } else {
    dir.create(file.path("c:/users/owner/documents/Coursera/GetCleanData"))
    setwd("c:/users/owner/documents/Coursera/GetCleanData")
  }

##############################################
## To import the data from the course website
##############################################
myURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(myURL,destfile="Data.zip",mode="wb")
unzip("Data.zip")

Y_train<- read.csv("UCI HAR Dataset/train/y_train.txt",header=F)
X_train<- as.matrix(read.csv("UCI HAR Dataset/train/x_train.txt",
                             header=F, stringsAsFactors=FALSE))
Y_test<- read.csv("UCI HAR Dataset/test/y_test.txt",header=F)
X_test<- as.matrix(read.csv("UCI HAR Dataset/test/X_test.txt", 
                            header=F,stringsAsFactors=F))

subject_train<- read.csv("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subject_test<- read.csv("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
activity_labels<- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
feature_names<- read.table("UCI HAR Dataset/features.txt",header=FALSE)

##############################################
## Prepare the activity_labels and feature_names files
##############################################
names(activity_labels)<- c("activity","activity_description")

feature_names[,1]<-NULL
feature_names<- as.vector(as.matrix(feature_names))

##############################################
## To prepare the X_train dataset
##############################################
X_train.list<- strsplit(X_train,"e[-|+]00[[:digit:]] ",fixed=FALSE)
X_train.matrix<- matrix(unlist(X_train.list),length (X_train.list), length(X_train.list[[1]]),byrow=TRUE)
X_train.matrix[,561]<- gsub("e[+|-]00[[:digit:]]","",x=X_train.matrix[,561])
X_train.matrix<- cbind.data.frame(subject_train,Y_train,X_train.matrix, stringsAsFactors=FALSE)
rm(X_train.list,X_train,subject_train)

##############################################
## To prepare the X_test dataset
##############################################
X_test.list<- strsplit(X_test,"e[-|+]00[[:digit:]] ",fixed=FALSE)
X_test.matrix<- matrix(unlist(X_test.list),length(X_test.list), length(X_test.list[[1]]),byrow=TRUE)
X_test.matrix[,561]<- gsub("e[+|-]00[[:digit:]]","",x=X_test.matrix[,561])
X_test.matrix<- cbind.data.frame(subject_test,Y_test,X_test.matrix, stringsAsFactors=FALSE)
rm(X_test.list,X_test,subject_test)

##############################################
## To assmble the completed initial dataset
##############################################
complete<- rbind.data.frame(X_train.matrix,X_test.matrix)
names(complete)<- c("subject","activity",feature_names)

##############################################
## To extract the mean and std features and transform to
## a numeric data frame.
##############################################
Names<-names(complete)
feature.index<-grep("mean[[:punct:]]|(std[[:punct:]])",Names,value=FALSE,fixed=FALSE)
complete.trimmed<-cbind(complete[,1:2],complete[,feature.index],stringsAsFactors=FALSE)
complete.trimmed<- as.data.frame(sapply(complete.trimmed,as.numeric))
rm(Names)

##############################################
## Calculate the mean for each measure by subject and activity
##############################################
attach(complete.trimmed)
Summary.mean<-aggregate(complete.trimmed,by=list(activity,subject),FUN=mean)
detatch(complete.trimmed)
final.dataset<- merge(Summary.mean,activity_labels,by="activity",sort=F)
final.dataset<- final.dataset[order(final.dataset$subject,final.dataset$activity),]
final.dataset<- final.dataset[c(4,71,5:70)]
##############################################
## Prepare .csv submit file and cleanup the R environment
##############################################
write.csv(final.dataset,"submit.txt",row.names=F)
rm(list=ls())
