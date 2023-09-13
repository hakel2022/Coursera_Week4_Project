# Read train and test datasets
library(dplyr)
x_train <- read.table('./train/X_train.txt',header=FALSE)
y_train <- read.table('./train/y_train.txt',header=FALSE)
x_test <- read.table('./test/X_test.txt',header=FALSE)
y_test <- read.table('./test/y_test.txt',header=FALSE)
# get features data
features<-read.table('./features.txt', header=FALSE)
# get activity data
activity<-read.table('./activity_labels.txt', header=FALSE)
# get subject train and test data
subtrain<-read.table('./train/subject_train.txt', header=FALSE)
subtest<-read.table('./test/subject_test.txt', header=FALSE)
subtrain<-subtrain %>% rename(subjectID=V1)
subtest<-subtest %>% rename(subjectID=V1)
# add column names to test and train dataset
col_header <- features[,2]
col_header_ <- t(col_header)
colnames(x_train) <- col_header_
colnames(x_test) <- col_header_
# rename activity column names=
colnames(activity)<-c('ID','action')
# merging train and test data:
#row bind X test and train data
X_all <- rbind(x_train,x_test)
#row bind Y test and train data
Y_all <- rbind(y_train,y_test)
#row bind subject train and test data
subject_all <- rbind(subtrain,subtest)
#column bind X,Y and subject data
XYSdf <- cbind(X_all,Y_all,subject_all)
# This step concludes the first point of merging train and test data and also achieves third point i.e using descriptive activity names to name the activities in the data set
df<-merge(XYSdf, activity,by.x = 'V1',by.y = 'ID')
# 2nd point: getting the mean and standard deviation
colNames<-colnames(df)
df2<-df%>%
  select(action, subjectID, grep("\\bmean\\b|\\bstd\\b",colNames))
# transform activity to a factor variable 
df2$action<-as.factor(df2$action)

# 4th point: use descriptive activity names to name the activities in the data set
colnames(df2)<-gsub("^t", "time", colnames(df2))
colnames(df2)<-gsub("^f", "frequency", colnames(df2))
colnames(df2)<-gsub("Acc", "Accelerometer", colnames(df2))
colnames(df2)<-gsub("Gyro", "Gyroscope", colnames(df2))
colnames(df2)<-gsub("Mag", "Magnitude", colnames(df2))
colnames(df2)<-gsub("BodyBody", "Body", colnames(df2))
# 5th Point:second independent dataset from the above dataset with the average of each variable for each activity and each subject
df2_mean<-aggregate(. ~subjectID + action, df2, mean)
# text file for final output
write.table(df2_mean, file = "tidydata.txt",row.name=FALSE)







