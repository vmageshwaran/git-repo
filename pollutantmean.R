pollutantmean <- function(directory, pollutant, id=1:332) 
{
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  pwd <- getwd()
  datadir <- paste(pwd, directory, sep ="/")
  myfilelist <- list.files(path = datadir, pattern ="csv")
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
    tmprecordset <- read.table(paste(datadir, myfilelist[i], sep="/"), header=TRUE, sep=",")
    if(!exists("myrecordset")) # Check for non existence of myrecordset
    {
      myrecordset <- tmprecordset
    }
    else
    {
      if (exists("myrecordset"))  # Check for existence of myrecorset
      {
        myrecordset <- rbind(myrecordset, tmprecordset)  # Bind by rows
      }
    }
    rm(tmprecordset)  # remove tmprecordset
  }
  mymean <- mean(myrecordset[, pollutant], na.rm = TRUE)  # Calculate mean without NA
  return(round(mymean, digits=3)) # rounded to 3 decimals 
}