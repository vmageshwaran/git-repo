x <-5hw
1x
print(x)
?write.csv
iris
head(iris)
getwd()
list.files()
setwd("/myfolder/myworkarea/r/assignments")
darahw1 <- read.csv("hw1_data.csv")
install.packages("swirl")
library(swirl)
ls()
rm(list=ls())
swirl()
magesh
quit
end
x <- 1:10
if(x > 5) {
  x <- 0
}
z <- 10
f(3)
head(mtcars)

mtcars[[1]]
sd(mtcars[[1]])
lapply(X=mtcars,FUN=sd)

output_sapply <- sapply(X=mtcars,FUN=sd)
class(output_sapply)

mtcars_mat <- as.matrix(mtcars)

apply(X=mtcars_mat,1, FUN=max)

apply(X=mtcars_mat,2, FUN=max)


library(datasets)
?iris
head(iris)

s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))

lapply(split(airquality, airquality$Month), function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))

s
lapply(split(iris,iris$Species), function(x) colMeans(x[, c("Sepal.Length","Sepal.Width")]))
head(airquality)
apply(iris, 2, mean)
colMeans(iris[,1:4]) 
apply(iris[, 1:4], 2, mean) 
apply(iris[, 1:4], 1, mean) 

rowMeans(iris[, 1:4]) 
names(mtcars)
head(mtcars)
lapply(split(mtcars,mtcars$cyl), function(x) colMeans(x[,c("mpg", "disp", "hp")]))
sapply(split(mtcars$mpg, mtcars$cyl), mean)

apply(mtcars, 2, mean)

library(plyr)
all_data <- ldply(list.files(path = "./specdata/", pattern = "csv"), function(fname) {
  dum <- read.csv(fname)
  dum$fname <- fname  # adds the filename it was read from as a column
  return(dum)
})

setwd("./specdata")
myfilelist <- list.files(pattern ="csv")
for (myfile in myfilelist)
{
  tmprecordset <- read.table(myfile, header=TRUE, sep=",")
  tmprecordset$ref <- myfile
  tmprecordset <- na.omit(tmprecordset)
  
  if(!exists("myrecordset")) 
  {
    myrecordset <- tmprecordset
  }
  
  if (exists("myrecordset"))
  {
    myrecordset <- rbind(myrecordset, tmprecordset)
  }
  rm(tmprecordset)
}
  
lapply(split(mtcars,mtcars$cyl), function(x) colMeans(x[,c("mpg", "disp", "hp")]))

pollutantmean <- function(directory, pollutant, id) 
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
  
  myfilelist <- list.files(path = paste("../", directory, sep =""), pattern ="csv")
  for (myfile in myfilelist)
  {
    tmprecordset <- read.table(myfile, header=TRUE, sep=",")
    tmprecordset$ref <- myfile
    tmprecordset <- na.omit(tmprecordset)
    if(!exists("myrecordset")) 
    {
      myrecordset <- tmprecordset
    }
    if (exists("myrecordset"))
    {
      myrecordset <- rbind(myrecordset, tmprecordset)
    }
    rm(tmprecordset)
  }
  mymean <- mean(myrs_final[(myrs_final$ID >= min(id) & myrs_final$ID <= max(id)), pollutant])
  return mymean
}

  