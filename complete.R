complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  pwd <- getwd()
  datadir <- paste(pwd, directory, sep ="/")
    
  mydf <- data.frame(matrix(nrow=length(id), ncol=2))
  colnames(mydf) <- c("id", "nobs")
  
  myfilelist <- list.files(path = datadir, pattern ="csv")
  #myfilelist <- list.files(path = paste("./", directory, sep =""), pattern ="csv")
  for(i in 1:length(myfilelist))
  {
    
    if (i < min(id) || i > max(id))  # If block to skip/break for outside range
    {
      if (i < min(id))
      {
        next  
      }
      if (i > max(id))
      {
        break
      }
    }
    
    if (isTRUE(i %in% id))
    {
      mydf[which(id %in% i),] <- data.frame(id=i,nobs=nrow(na.omit(data.frame(read.csv(paste(datadir, myfilelist[i], sep="/"), header=TRUE, sep=",")))))
    }
  }      
  print (mydf) 
}