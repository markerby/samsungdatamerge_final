
# Introduction

This describes the run_analysis.R script that processes accelerometer and gyrometer
data produced by 30 volunteers wearing Samsung Galaxy S smartphones. The data files
containing the data are downloaded and processed by the run_analysis.R script
to generate a tidy data set.

Accelerometer and gyroment data was recorded for 30 people in total, 21 of whom were 
assigned to a "training" group and 9 of whom were assigned to a "test" group.
The data was recorded while the Subjects performed 6 different activities: walking, 
walking upstairs, walking downstairs, sitting, standing and laying. 

The run_analysis.R script will combine the appropriate data files to output a
tidy set, as a .txt file, that will summarise the average of the observations
for each subject and activity performed.

# 1. run_analysis.R

Download and place in the current working directory of R Studio. run_analysis.R
assumes that the data files (described in next section) are downloaded and unzipped
one level below the current working directory.

# 2. Execute the run_analysis.R script

Type
    source('~/run_analysis.R')

in R Studio's console.

# 3. INPUT: Data Files

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


# 4. OUTPUT: tidy data set summarised_samsung_data.txt

This file will be created in the current working directory.

See the CodeBook.md file in this repository for a description of the variables
in this file as well as the transformations of the data to produce this tidy
data set.


# 5. Steps in the Analysis of Samsung Galaxy S Smartphone accelerometer data

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