# CleanDataCourseProject #

## What is it? ##
This project contains Søren Lind Kristiansen's solution for the course project for the *Getting and Cleaning Data* course on [Cousera](https://www.coursera.org).

## What does it do?  ##

The code in the file `run_analysis.R` creates a [tidy](http://www.jstatsoft.org/v59/i10/) version of the [UCI Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The code expects to find an unzipped copy of the data set in the working directory.

Specifically, the code performs the following steps to create the tidy data set:

1. Training and the test sets are merged to create one data set.
2. Mean and standard deviation for each measurement are extracted.
3. Descriptive activity names are added to the data set.
4. Descriptive variable names are added to the data set. 
5. From the data set in step 4, a second, independent tidy data set with the average of each variable for each activity and each subject is created and persisted.

## Why is the output tidy? ##

The output data set adheres to the rules of tidy data. Specifically each variable you is one and only column, and each different observation of that variable is in a different row. Specifically each row corresponds to one activity for one subject. Since there are six different activities (*WALKING*, *WALKING\_UPSTAIRS*, *WALKING\_DOWNSTAIRS*, *SITTING*, *STANDING* and *LAYING*) and 30 subjects, the total number of rows in the data is 6 * 30 = 180.

Each row is made up of the following columns:
* ID of the subject (a value from 1 to 30)
* The activity of the observation (*WALKING*, *WALKING\_UPSTAIRS*, *WALKING\_DOWNSTAIRS*, *SITTING*, *STANDING* or *LAYING*).
* 79 variables beginning with `tBodyAcc-mean()-X`, and ending with `fBodyBodyGyroJerkMag-meanFreq()`.

Each variable contains the average of the values for that variable in the original data set, for each activity and each subject.

For further details, see the `CodeBook.md`file.

## What exactly does the output look like? ##

See the `CodeBook.md`file.

## Usage ##
Simply change the working directory to the directory containing the `README.txt` of the data set. Then `source` the `run_analysis.R` and it will create a tidy version data of the data set in the working directory. The file will be called `tidy.txt`.

## Dependencies ##
The code requires the `data.table` and `dplyr` packages to run.


