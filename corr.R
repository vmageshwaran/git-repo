corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  ## Return a numeric vector of correlations
  
  pwd <- getwd()
  datadir <- paste(pwd, directory, sep ="/")
  cr <- numeric(0)
      
  myfilelist <- list.files(path = datadir, pattern ="csv")
  for(i in 1:length(myfilelist))
  {
    tmpcasecount <- NULL
    tmprecordset <- NULL
    
    tmprecordset <- read.table(paste(datadir, myfilelist[i], sep="/"), header=TRUE, sep=",")
    tmpcasecount <- sum(complete.cases(tmprecordset))
    
    if (tmpcasecount > threshold)
    {
      cr <- c(cr, round(cor(tmprecordset$sulfate,tmprecordset$nitrate, use="complete.obs"), 5))
    }
  }   
  return(cr)
}