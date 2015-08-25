# Set the working directory 
setwd("C:/Users/Owner/Dropbox/Coursera/2_R_Programming")


# Part 1

best <- function(state, outcome) {
  ##Read data into R
    Data<- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
  #Validate state and outcome prompt values
    if(!is.element(outcome, c("heart attack","heart failure","pneumonia"))) stop("invalid outcome")
    if(!is.element(state,state.abb))stop("invalid state")
    
    if(outcome=="heart attack"){
        index<-11
    } else if(outcome=="heart failure"){
        index<-17
    } else{
        index<-23
    }

    Data<-subset(Data,Data[,7]==state & Data[,index]!="Not Available")
    
    Data[,index]<-as.numeric(Data[,index])
  
    Data<-Data[order(Data[,7],as.numeric(Data[,index])),]
  
    head(Data[,2],1)
}
#  head(Data[order(Data[,7],Data[,index]),c(2,index)],10)

#MIN<-min(as.numeric(Data[,index]))
#Data<-subset(Data,as.numeric(Data[,index]==MIN))


  #results<- subset(Data, Data$State == state, select = c("Hospital.Name"))
  #field<- paste("Hospital 30-Day Death (Mortality) Rates from",outcome)  
  ## Read outcome data
  ## Return hospital name in that state with lowest 30-day death rate

  #if(outcome!="heart attack"|| "heart failure" || "pneumonia") stop("invalid outcome")