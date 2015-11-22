

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

# run_analysis.R

Download and place in the current working directory of R Studio. run_analysis.R
assumes that the data files (described in next section) are downloaded and unzipped
one level below the current working directory.

# Execute the run_analysis.R script

Type
    source('~/run_analysis.R')

in R Studio's console.

# INPUT: Data Files

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


# OUTPUT: tidy data set summarised_samsung_data.txt

This file will be created in the current working directory.

See the CodeBook.md file in this repository for a description of the variables
in this file as well as the transformations of the data to produce this tidy
data set.

