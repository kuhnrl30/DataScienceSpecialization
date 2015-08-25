pollutantmean <- function(directory,pollutant,id=1:332){
d<- data.frame()
A<- paste(directory,"/",sprintf("%03d",id),".csv",sep="")
for (i in A){
C<- subset(read.csv(i),select=pollutant)
d<-rbind(d,C)
}

bad<-is.na(d)
good<-d[!bad]
sum(good)/length(good)
}


        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used

        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)





