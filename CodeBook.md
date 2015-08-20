# Tidy Smartphones Data Set #

For a full description of the original data set, see [UCI Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

From the `README.txt` of the original data set (as linked to above):

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. > 
> > 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Transformation ##

The tidy data set has been made by performing the following steps on the original data set:

1. Training and the test sets are merged to create one data set.
2. Mean and standard deviation for each measurement are extracted.
3. Descriptive activity names are added to the data set.
4. Descriptive variable names are added to the data set. 
5. From the data set in step 4, a second, independent tidy data set with the average of each variable for each activity and each subject is created and persisted.

### How are the mean and standard deviation measurements identified? ###
In step 2 above, *mean and standard deviation for each measurement are extracted*. The original data set consists of several hundred variables, only some of them being mean or standard deviation measurements. Some of these can easily be identified as mean or standard deviation measurements, for example `tBodyAcc-mean()-X` and `tBodyAcc-std()-X`. Others may be a bit less obvious, for example `fBodyAcc-meanFreq()-X`. The method chosen for identifying the measurements to extract is as follows:

*Extract all variables for which the original variable name contains the substring `mean` or the substring `std`*. 

This approach is chosen because it is inclusive in the sense that it includes the obvious as well as the less obvious variables, for example `fBodyAcc-meanFreq()-X`. If some of the variables turn out to be irrelevant, it is easier to get rid of them later than it would be to add them, had we not included them and later realized that they were relevant.

### Can you explain the transformation steps in detail? ###
Roughly speaking, we have three kinds of files in the original data set: Training data, test data and some meta data. The latter contains the names of the different features as well as the names of the different activities. We will eventually merge the training and test data by stacking them 'on top of each other'. But since both training and test data come in several files we need to do some pre-processing steps. Further, the data files come without column headers so we need to do some processing to add variable names.

We will begin by preparing the test data set. Subsequently we will perform exactly the same steps on the training data set and then finally merge them together. The preparation of each of the data sets (train and test) is carried out as follows.

The train data file, `X_train.txt`, contains neither activity information nor a subject identifier, nor column names, and we will need to add all three in order to eventually build the tidy data. Further, we will only need a fraction of the variables in the file, specifically the ones that contain mean or standard deviation measurements. To achieve this, we perform the following steps:

1. Read training data from `X_train.txt` into data frame.
2. Add column names using values from `features.txt`.
3. Remove irrelevant columns (the ones that are neither mean or standard deviation measures).
4. Read numeric activity values from `X_train.txt` into a data frame.
5. Read the 'dictionary' containing the names of numeric activity values from the `activity_labels.txt` file.
6. Replace the numeric activity values in the data frame with the activity names.
7. Read the subject IDs from `subject_train.txt` into a data frame.
8. Merge the data frames containing subject IDs, activity labels and training data by binding them together *side-by-side*.

Pictorially step 8 above can be represented as follows. The subject IDs are shown as `S`'s, the activity label names are shown as `L`'s and finally, the relevant columns of the training data are shown as `X`'s:


```
S     L     XXX     SLXXX
S     L     XXX     SLXXX
S  +  L  +  XXX  =  SLXXX
S     L     XXX     SLXXX
S     L     XXX     SLXXX
```

Having created such a data frame for the training data, we can now do exactly the same for the test data. And finally we can merge the two resulting data frames by stacking them *on top of each other*. This is done as shown below:

```
                                    SLXXX
                                    SLXXX
SLXXX             SLXXX             SLXXX
SLXXX             SLXXX             SLXXX
SLXXX (train)  +  SLXXX (test)   =  SLXXX
SLXXX             SLXXX             SLXXX       
SLXXX             SLXXX             SLXXX
                                    SLXXX
                                    SLXXX
                                    SLXXX
```

Having this merged data set, we are now ready to calculate the means for each activity and subject.

## Data Columns ##

The output data set adheres to the rules of tidy data. Specifically each variable you is one and only column, and each different observation of that variable is in a different row. Specifically each row corresponds to one activity for one subject. Since there are six different activities (see below) and 30 subjects, the total number of rows in the data is 6 * 30 = 180.

Each row is made up of the following columns:
* ID of the subject (a value from 1 to 30)
* The activity of the observation (`WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING` or `LAYING`).
* 79 variables beginning with `tBodyAcc-mean()-X`, and ending with `fBodyBodyGyroJerkMag-meanFreq()`.

Each variable contains the average of the values for that variable in the original data set, for each activity and each subject.

The tidy data consists of the following columns

### Identifiers ###

* `Subject` - An identifier for each subject. A value between 1 and 30.
* `Activity` - The name of the measured activity performed by the subject. One of the values `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING` and `LAYING`.


### Measurements ###

* `tBodyAcc-mean()-X`
* `tBodyAcc-mean()-Y`
* `tBodyAcc-mean()-Z`
* `tBodyAcc-std()-X`
* `tBodyAcc-std()-Y`
* `tBodyAcc-std()-Z`
* `tGravityAcc-mean()-X`
* `tGravityAcc-mean()-Y`
* `tGravityAcc-mean()-Z`
* `tGravityAcc-std()-X`
* `tGravityAcc-std()-Y`
* `tGravityAcc-std()-Z`
* `tBodyAccJerk-mean()-X`
* `tBodyAccJerk-mean()-Y`
* `tBodyAccJerk-mean()-Z`
* `tBodyAccJerk-std()-X`
* `tBodyAccJerk-std()-Y`
* `tBodyAccJerk-std()-Z`
* `tBodyGyro-mean()-X`
* `tBodyGyro-mean()-Y`
* `tBodyGyro-mean()-Z`
* `tBodyGyro-std()-X`
* `tBodyGyro-std()-Y`
* `tBodyGyro-std()-Z`
* `tBodyGyroJerk-mean()-X`
* `tBodyGyroJerk-mean()-Y`
* `tBodyGyroJerk-mean()-Z`
* `tBodyGyroJerk-std()-X`
* `tBodyGyroJerk-std()-Y`
* `tBodyGyroJerk-std()-Z`
* `tBodyAccMag-mean()`
* `tBodyAccMag-std()`
* `tGravityAccMag-mean()`
* `tGravityAccMag-std()`
* `tBodyAccJerkMag-mean()`
* `tBodyAccJerkMag-std()`
* `tBodyGyroMag-mean()`
* `tBodyGyroMag-std()`
* `tBodyGyroJerkMag-mean()`
* `tBodyGyroJerkMag-std()`
* `fBodyAcc-mean()-X`
* `fBodyAcc-mean()-Y`
* `fBodyAcc-mean()-Z`
* `fBodyAcc-std()-X`
* `fBodyAcc-std()-Y`
* `fBodyAcc-std()-Z`
* `fBodyAcc-meanFreq()-X`
* `fBodyAcc-meanFreq()-Y`
* `fBodyAcc-meanFreq()-Z`
* `fBodyAccJerk-mean()-X`
* `fBodyAccJerk-mean()-Y`
* `fBodyAccJerk-mean()-Z`
* `fBodyAccJerk-std()-X`
* `fBodyAccJerk-std()-Y`
* `fBodyAccJerk-std()-Z`
* `fBodyAccJerk-meanFreq()-X`
* `fBodyAccJerk-meanFreq()-Y`
* `fBodyAccJerk-meanFreq()-Z`
* `fBodyGyro-mean()-X`
* `fBodyGyro-mean()-Y`
* `fBodyGyro-mean()-Z`
* `fBodyGyro-std()-X`
* `fBodyGyro-std()-Y`
* `fBodyGyro-std()-Z`
* `fBodyGyro-meanFreq()-X`
* `fBodyGyro-meanFreq()-Y`
* `fBodyGyro-meanFreq()-Z`
* `fBodyAccMag-mean()`
* `fBodyAccMag-std()`
* `fBodyAccMag-meanFreq()`
* `fBodyBodyAccJerkMag-mean()`
* `fBodyBodyAccJerkMag-std()`
* `fBodyBodyAccJerkMag-meanFreq()`
* `fBodyBodyGyroMag-mean()`
* `fBodyBodyGyroMag-std()`
* `fBodyBodyGyroMag-meanFreq()`
* `fBodyBodyGyroJerkMag-mean()`
* `fBodyBodyGyroJerkMag-std()`
* `fBodyBodyGyroJerkMag-meanFreq()`