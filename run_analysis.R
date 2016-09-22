＃setwd(""/Users/chenyao/Desktop/DATA SCIENCE/getting and cleaning data/week 4)
traindatax <- read.table("./UCI HAR Dataset/train/X_train.txt")
dim(traindatax) # 7352*561
head(traindatax)
traindatay <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
testdatax <- read.table("./UCI HAR Dataset/test/X_test.txt")
dim(testdatax) # 2947*561
testdatay<- read.table("./UCI HAR Dataset/test/y_test.txt") 
testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
datax <- rbind(traindatax, testdatax)
dim(datax) # 10299*561
datay <- rbind(traindatay, testdatay)
dim(datay) # 10299*1
subject <- rbind(trainsubject, testsubject)
dim(subject) # 10299*1
# Step2. Extracts only the measurements on the mean and standard 
# deviation for each measurement. 
features <- read.table("./UCI HAR Dataset/features.txt")
dim(features)  # 561*2
meansd <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meansd) # 66
datax <- datax[, meansd]
dim(datax) # 10299*66
names(datax) <- gsub("\\(\\)", "", features[meansd, 2]) # remove "()"
names(datax) <- gsub("-", "", names(datax)) # remove "-" in column names 
# Step3. Uses descriptive activity names to name the activities in 
# the data set
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activityy <- activity[datay[, 1], 2]
datay[, 1] <- activityy
names(datay) <- "activity"
# Step4. Appropriately labels the data set with descriptive activity 
# names. 
names(subject) <- "subject"
cleandata <- cbind(subject, datay, datax)
dim(cleandata) # 10299*68
head(cleandata)
write.table(cleandata, "merged_data.txt") # write out the first tidy dataset

#Step5. Creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject. 
subjectnum <- length(table(subject)) # 30
activitynum <- nrow(activity) # 6
columnnum <- ncol(cleandata) # 68
result <- matrix(1, nrow=subjectnum*activitynum, ncol=columnnum) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleandata)
row <- 1
for(i in 1:subjectnum) {
        for(j in 1:activitynum) {
                result[row, 1] <- i
                result[row, 2] <- activity[j, 2]
                spec_subj <- cleandata$subject == i
                spec_act <- cleandata$activity == activity[j,2]
                result[row, 3:columnnum] <- colMeans(cleandata[spec_subj&spec_act, 3:columnnum])
                row <- row + 1
        }
}
activity_names<-rep(activity[,2],30) 
# after the loop, the activity column is a bunch of numbers
result$activity<-activity_names
head(result)
write.table(result, "mean_data.txt") # write out the second tidy dataset

