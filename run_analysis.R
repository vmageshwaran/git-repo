# Data Source : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Script Steps : 0 to 99.

# 0. Initialize
setwd("/myfolder/myworkarea/r/assignments")

# 1. Merges the train & test datasets into a single dataset
rs_train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
rs_train[,ncol(rs_train)+1] <- read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
rs_train[,ncol(rs_train)+1] <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
rs_test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
rs_test[,ncol(rs_test)+1] <- read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
rs_test[,ncol(rs_test)+1] <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
ds_trainANDtest <- rbind(rs_train, rs_test)

#2. Prepare Activcity Labels
rs_activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

#3. Prepare Features 
rs_features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
rs_features[,2] <- gsub('-mean', 'Mean', rs_features[,2])
rs_features[,2] <- gsub('-std', 'Std', rs_features[,2])
rs_features[,2] <- gsub('[-()]', '', rs_features[,2])

#4. Find column positions 
colPos <- grep(".*Mean.*|.*Std.*", rs_features[,2])
#5. subset Featues
rs_features <- rs_features[colPos,]
#6. add columns - subject & activity
colPos <- c(colPos, 562, 563)

#7. subset ds_trainANDtest
ds_trainANDtest <- ds_trainANDtest[,colPos]

#8. Change Col Names - ds_trainANDtest
colnames(ds_trainANDtest) <- c(rs_features$V2, "Activity", "Subject")
colnames(ds_trainANDtest) <- tolower(colnames(ds_trainANDtest))

#9. Vloopup for activity
ds_trainANDtest$activity <- rs_activityLabels$V2[match(ds_trainANDtest$activity, rs_activityLabels$V1)]

#10. Final tidy dataset 
ds_trainANDtest$activity <- as.factor(ds_trainANDtest1$activity)
ds_trainANDtest$subject <- as.factor(ds_trainANDtest1$subject)
ds_tidy <- aggregate(ds_trainANDtest[!names(ds_trainANDtest) %in% c("activity", "subject")], by=list(Activity = ds_trainANDtest$activity, Subject=ds_trainANDtest$subject), mean)

#11. Write to tidydataset.txt 
write.table(ds_tidy, "tidydataset.txt", sep="\t", row.names=FALSE)

#99. END