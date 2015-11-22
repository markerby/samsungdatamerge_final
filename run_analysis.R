library(RCurl)
library(dplyr)
library(tidyr)

#1.MERGE THE TRAIN AND TEST DATASETS INTO A SINGLE DATASET

#train data
train_data <- read.table("./samsung_data/UCI HAR Dataset/train/X_train.txt")
column_names_data <- read.table("./samsung_data/UCI HAR Dataset/features.txt")
colnames(train_data) <- column_names_data[["V2"]]
train_subject_Ids <- read.table("./samsung_data/UCI HAR Dataset/train/subject_train.txt")
train_activities_Ids <- read.table("./samsung_data/UCI HAR Dataset/train/y_train.txt")
train_data <- cbind(subject_id=train_subject_Ids[["V1"]], group="train", activity_id=train_activities_Ids[["V1"]], train_data)


# repeat for the "test" data
test_data <- read.table("./samsung_data/UCI HAR Dataset/test/X_test.txt")
colnames(test_data) <- column_names_data[["V2"]]
test_subject_Ids <- read.table("./samsung_data/UCI HAR Dataset/test/subject_test.txt")
test_activities_Ids <- read.table("./samsung_data/UCI HAR Dataset/test/y_test.txt")
test_data <- cbind(subject_id=test_subject_Ids[["V1"]], group="test", activity_id=test_activities_Ids[["V1"]], test_data)

#merge the two data frames
all_data <- rbind(train_data,test_data)


#2. EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT.

all_data <- all_data[,grep("subject_id|group|activity_id|*-mean\\(\\)-[XYZ]$*|*-std\\(\\)-[XYZ]$|*-mean\\(\\)$|*-std\\(\\)$", colnames(all_data))]
cleaned_data <- gather(all_data,feature_measure_axis,reading,`tBodyAcc-mean()-X`:`fBodyBodyGyroJerkMag-std()`)
cleaned_data <- separate(cleaned_data,feature_measure_axis, c("feature", "measure", "axis"), sep = "-",fill="right")


#3. USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET.

activity_labels <- read.table("./samsung_data/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activity_id","activity_label")
cleaned_data <- left_join(x = activity_labels, y = cleaned_data, by = "activity_id")
cleaned_data$activity_label <- as.factor(cleaned_data$activity_label)


#4. APPROPRIATE LABELS HAVE BEEN ASSIGNED TO VARIABLE NAMES AS THIS SCRIPT HAS PROGRESSED.


#5. PRODUCE AN INDEPENDENT TIDY DATASET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.

grouped <- group_by(cleaned_data,subject_id, activity_label, feature, measure, axis)
summarised_data <- summarise(grouped,mean=mean(reading))
wide_data <- spread(summarised_data,measure,mean)
colnames(wide_data) <- c("subject_id","activity_label","feature","axis","mean_of_means()","mean_of_stds()")


#WRITE THE TIDY DATASET TO FILE
write.table(wide_data,file="summarised_samsung_data.txt",row.name=FALSE)



