#Write a function that takes a directory of data files and a threshold 
#for complete cases and calculates the correlation between sulfate and 
#nitrate for monitor locations where the number of completely observed 
#cases (on all variables) is greater than the threshold. The function 
#should return a vector of correlations for the monitors that meet the 
#threshold requirement. If no monitors meet the threshold requirement, 
#then the function should return a numeric vector of length 0. 

#setwd("C:/Users/Owner/Documents/Coursera/rprog-data-specdata")

corr<- function(directory,threshold=0){
    #initailize final dataframs
    df<- numeric()
    
    #read file list in directory
    files<- dir(directory)


    for (i in 1:length(files)){
	    Current_File<- read.csv(paste(directory,"/",files[i],sep=""))
	    CountComplete<- sum(complete.cases(Current_File[,2],Current_File[,3]))
	
        if (CountComplete > threshold){
		    Complete<- subset(Current_File,
                              !is.na(sulfate) & !is.na(nitrate),
                              select=sulfate:nitrate)
		    A<-cor(Complete$sulfate,Complete$nitrate)
		    df<-c(df,A)
		    }
	    else {next}
	}
df
}
#A<- paste(directory,"/",sprintf("%03d",i),".csv",sep="")
#Data<- read.csv(A)
#B<- sum(complete.cases(Data[,2],Data[,3]))
#d<-rbind(d,c(i,B))
#}
#colnames(d)<-c("id","nobs")
#d

        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations