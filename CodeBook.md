
This Code Book describes the variables, Samsung data and the transformations of
that data to produce a tidy data set.

# 1. Introduction

This describes the run_analysis.R script that processes accelerometer and gyrometer
data produced 30 volunteers wearing Samsung Galaxy S smartphones. The data files
containing the data are downloaded and processed by the run_analysis.R script to
generate a tidy data set.

Accelerometer and gyromenter data was recorded for 30 people in total, 21 of whom were 
assigned to a "training" group and 9 of whom were assigned to a "test" group.
The data was recorded while the Subjects performed 6 different activities: walking, 
walking upstairs, walking downstairs, sitting, standing and laying. 

The run_analysis.R script combines the appropriate data files to output a
tidy set, as a .txt file, that will summarise the average of the observations
for each subject and activity performed.

# 2. Data Files

The data files are located at the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

When unzipped to the ./samsung_data directory in the working directory of
R Studio, the data files that will be processed by run_analysis.R are:

General:
* ./samsung_data/UCI HAR Dataset/acitvity_labels.txt
* ./samsung_data/UCI HAR Dataset/features.txt

Data recorded for the "train" Subject group:
* ./samsung_data/UCI HAR Dataset/train/X_train.txt
* ./samsung_data/UCI HAR Dataset/train/subject_train.txt
* ./samsung_data/UCI HAR Dataset/train/y_train.txt")

Data recorded for the "test" Subject group:
* ./samsung_data/UCI HAR Dataset/test/X_test.txt
* ./samsung_data/UCI HAR Dataset/test/subject_test.txt
* ./samsung_data/UCI HAR Dataset/test/y_test.txt")



activity_labels.txt - Specifies the descriptive label for each activity performed
by a Subject. The activity labels will replace the activity_ids in the final tidy
data set.

features.txt - Specifies the features recorded for the activities carried out
by the subejcts. These are the column names for the datasets in the X_train.txt 
and the X_test.txt files.

X_train.txt/X_test.txt - These are the raw data recorded for the 21 train
and 9 test subjects respecitively. There are 561 columns of data corresponding to the
561 features in each file.

subject_train.txt/subject_test.txt - These are the subject Ids that identify the
subject for whom each data observation was recorded in each row of the X_train and
X_test files respectively. The tidy set will join the subject Ids to the raw
datasets.

y_train.txt/y_test.txt - These are the activity ids that identify the activity
corresponding to each observation in the X_train.txt and X_test.txt files. The
tidy data set will join these activity Ids to the raw datasets.


# 3. Variables

The final tidy data set summarised_samsung_data.txt includes the following
variables:

* subject_id - Whole number between 1 and 30 - idenitifes the subject Id for
whom the observations were recorded.

* activity_label - String - descriptive name for the acitivity for which the 
observation was recorded.

* feature - String - specifies the feature for which the mean() or std() value was
recorded.
    * Variables with BodyAcc refere to Body linear acceleration measurements.
    * Variables with Gyro are angular velocity measurements.
    * Variables with Jerk are Jerk signals.
    * Variables with Mag are magnitude of the 3-D measurements.

    Time domain signals (prefixed with "t"): UNITS - seconds
        * tBodyAcc - X,Y,Z
        * tBodyAccJerk - X,Y,Z
        * tBodyAccJerkMag
        * tBodyAccMag
        * tBodyGyro - X,Y,Z
        * tBodyGyroJerk - X,Y,Z
        * tBodyGyroJerkMag
        * tBodyGyroMag 
        * tGravityAcc - X,Y,Z
        * tGravityAccMag

    Frequency signals (prefixed by "f") - UNITS: NONE
        * fBodyAcc - X,Y,Z 
        * fBodyAccJerk - X,Y,Z
        * fBodyAccMag
        * fBodyBodyAccJerkMag
        * fBodyGyro - X,Y,Z
        * fBodyBodyGyroJerkMag
        * fBodyBodyGyroMag
    

* axis - String - specifies the axis, X Y or Z, for which the observation was
recorded. If it is NA, then the feature measurement did not involve measuring
a specific axis.

* mean_of_means() - the mean of the mean() values which were recorded for the
observations.

* mean_of_stds() - the mean of the standard deviations (std()) which were recorded
for the observations.


# 4. Steps in the Analysis of Samsung Galaxy S Smartphone accelerometer data

## Assumptions

* The data files with the raw acceleromoter Smartphone data have been downloaded
and unzipped to the directory ./samsung_data within the current working directory
of R Studio.

## Step 1. MERGE THE TRAIN AND TEST DATASETS INTO A SINGLE DATASET

* a. Read the data from ./samsung_data/UCI HAR Dataset/train/X_train.txt into a 
train_data data frame. This is the raw accelerometer data for the subjects in the training
group.
* b. Read the data from ./samsung_data/UCI HAR Dataset/features.txt into a data 
frame. The data in this column are the column names of the X_train.txt and 
X_test.txt data files. Set the train_data column names to be these
features.
* c. Read the observation subject Ids data from subject_train.txt into a data frame.
* d. Read the observation activity Ids data from y_train.txt into a data frame.
* e. Add the data from c. and d. as new columns to the train_data data frame.

Repeat steps a. to e. for the test subject group. Once completed, there will
be train_data and test_data data frames with the 561 columns corresponding to
the features recorded plus the subject_id and activity_id columns. Merge these
two data frames into one data frame.

## 2. EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT. 

* a. From the merged data frame, extract the subject_id, activity_id, and only the
columns with "mean()" or "std()" in the column name. 
* b. To create a tidy data set, there must be one obervation per row. Collapse
the feature columns into key-value pairs by using tidyr's gather() function.
The resulting data frame is now a tall data set with the columns subject_id, 
activity_id, feature-measure-axis and reading. The reading column is the recorded
data point.
* c. The resulting feature column combines 3 underlying variables: feature, measure
and axis. Example: tBodyAcc-mean()-X combines the feature "tBodyAcc", the meaure
"mean()" and the axis "X". To create a tidy set, the feature column must be
separated into the 3 underlying variables. The run_analysis script does this using
tidyr's separate() function. The resulting data set now has the following columns: 
subject_id, activity_id, feature, measure, axis and reading.

#3. USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET.

* a. Read the activity Ids and labels from ./samsung_data/UCI HAR Dataset/activity_labels.txt
into a data frame.
* b. Use join() function to join the activity labels to the data frame from 2.c.
There will now be a column "activity_label" in the data frame that sepcifies the
descriptive label of the activity for each observation.

#4. ASSIGN APPROPRIATE LABELS TO VARIABLE NAMES.

* This has been done throughout the processing of run_analysis.R.

#5. PRODUCE AN INDEPENDENT TIDY DATASET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.
* a. Group the data in the data frame from Step 3 according to subject_id, activity_label,
feature,measure,axis columns. Then use the summarise() function to calculate the
mean of the readings.
* b. Use the spread() function to make a wider data frame that specifies the columns
subject_id, activity_label, feature, axis, mean_of_means() and mean_of_stds().
* c. Write the data frame out to a text file "summarised_samsung_data.txt"
