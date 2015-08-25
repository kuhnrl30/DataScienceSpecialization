rankhospital<-function(state,outcome,num="best"){
    Data<- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
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
    
    if(num=="best"){
        num<-1
    } else if (num=="worst"){
        num<-nrow(Data)
    }
    
    Data[,index]<-as.numeric(Data[,index])
    
    Data<-Data[order(as.numeric(Data[,index]),Data[,2]),]
    
    Data[num,2]
}