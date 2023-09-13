Code book for Coursera Getting and Cleaning Data course project

The data set that this code book pertains to is located in the tidydata.txt file of this repository.

See the README.md file of this repository for background information on this data set.
The structure of the data set is described in the Data section, its variables are listed in the Variables section, and the transformations that were carried out to obtain the data set based on the source data are presented in the Transformations section.

Data

The tidydata.txt data file is a text file, containing space-separated values.

The first row contains the names of the variables, which are listed and described in the Variables section, and the following rows contain the values of these variables.

Variables

Each row contains, for a given subject and activity, 66 averaged signal measurements.

Identifiers

subject

Subject identifier, integer, ranges from 1 to 30.

activity

Activity identifier, string with 6 possible values:

WALKING: subject was walking WALKING_UPSTAIRS: subject was walking upstairs WALKING_DOWNSTAIRS: subject was walking downstairs SITTING: subject was sitting STANDING: subject was standing LAYING: subject was laying Average of measurements

Transformations

The following transformations were applied to the source data:

The training and test sets were merged to create one data set.

The measurements on the mean and standard deviation (i.e. signals containing the strings mean and std) were extracted for each measurement, and the others were discarded.

The activity identifiers (originally coded as integers between 1 and 6) were replaced with descriptive activity names (see Identifiers section).

The variable names were replaced with descriptive variable names (e.g. tBodyAcc-mean()-X was expanded to timeDomainBodyAccelerometerMeanX), using the following set of rules: Special characters (i.e. (, ), and -) were removed The initial f and t were expanded to frequencyDomain and timeDomain respectively. Acc, Gyro, Mag, Freq were replaced with Accelerometer, Gyroscope, Magnitude, Frequency respectively. Replaced (supposedly incorrect as per source's features_info.txt file) BodyBody with Body.

From the data set in step 4, the final data set was created with the average of each variable for each activity and each subject.

The collection of the source data and the transformations listed above were implemented by the R script named run_analysis.R

