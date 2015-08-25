rankall<-function(outcome,num="best"){

    
    if(!is.element(outcome, c("heart attack",
                              "heart failure",
                              "pneumonia")
                   )
       ) 
       stop("invalid outcome")
    
    if(num=="best") num<-1

    if(outcome=="heart attack"){
        index<-11
    } else if(outcome=="heart failure"){
        index<-17
    } else{
        index<-23
    }
    
    Data<- read.csv("outcome-of-care-measures.csv", colClasses = "character")    
    
    Data<-subset(Data, Data[,index]!="Not Available")
    
    Data[,index]<-as.numeric(Data[,index])
    
    
    df<-data.frame()
    for(i in 1:length(state.abb)){
        
        A<- subset(Data,Data[,7]==state.abb[i])
        B<- A[order(as.numeric(A[,index]),A[,2]),]
        df<-rbind(df, B[num,c(2,7)])
    }
    names(df)<- c("hospital","state")
    df[order(df$state),]
}