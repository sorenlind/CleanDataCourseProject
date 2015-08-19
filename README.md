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

## What exactly does the output look like? ##

See the `CodeBook.md`file.

## Usage ##
Simply change the working directory to the directory containing the `README.txt` of the data set. Then `source` the `run_analysis.R` and it will create a tidy version data of the data set in the working directory. The file will be called `tidy.txt`.

## Dependencies ##
The code requires the `data.table` and `dplyr` packages to run.


