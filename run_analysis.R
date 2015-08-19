# Running the code in this file results in the following:
# 1. Training and the test sets are merged to create one data set.
# 2. Mean and standard deviation for each measurement are extracted.
# 3. Descriptive activity names are added to the data set.
# 4. Descriptive variable names are added to the data set. 
# 5. From the data set in step 4, a second, independent tidy data set with the average of each variable for
#    each activity and each subject is created and persisted.

require(data.table)
require(dplyr)

activity.file <- "./activity_labels.txt"
features.file <- "./features.txt"
x.train.file <- "./train/X_train.txt"
y.train.file <- "./train/y_train.txt"
subject.train.file <- "./train/subject_train.txt"
x.test.file <- "./test/X_test.txt"
y.test.file <- "./test/y_test.txt"
subject.test.file <- "./test/subject_test.txt"

# Reads messy data, calculates means for each subject and activity and writes tidy data.
makeTidy <- function() {
  data.merged <- readData()
  data.averages <- calculateAverages(data.merged)
  
  message(paste("Tidy data dimensions:", paste(dim(data.averages), collapse = ", ")))
  
  write.table(data.averages, "./tidy.txt", row.name=FALSE)
}

# Returns a version of the specified data grouped by subject and activity with each of other the columns containing
# the mean of the column for that group.
calculateAverages <- function(data.merged) {
  data.merged %>% group_by(Subject, Activity) %>% summarise_each(funs(mean)) %>% arrange(Subject, Activity)
}

# Reads and merges train and test data and related files.
readData <- function() {
  activity.labels <- read.table(activity.file)[,2]
  all.features <- read.table(features.file)[,2]
  relevant.features <- grepl("mean|std", all.features)
  
  train.data <- readDataSet(x.train.file,
                            y.train.file,
                            subject.train.file,
                            activity.labels,
                            all.features,
                            relevant.features)
  
  test.data <- readDataSet(x.test.file,
                           y.test.file,
                           subject.test.file,
                           activity.labels,
                           all.features,
                           relevant.features)

  # Merge training data and test data by "stacking them on top of each other".
  data = rbind(test.data, train.data)
  
  message(paste("Train data dimensions:", paste(dim(train.data), collapse = ", ")))
  message(paste("Test data dimensions:", paste(dim(test.data), collapse = ", ")))
  message(paste("Merged data dimensions:", paste(dim(data), collapse = ", ")))

  data
}

# Reads and merges the specified files and extracts the specified relevant features.
readDataSet <- function(x.file, y.file, subject.file, activity.labels, all.features, relevant.features) {
  
  # Read the data files
  x.data <- read.table(x.file)
  y.data <- read.table(y.file)
  subject.data <- read.table(subject.file)
  
  # Add column names
  names(x.data) = all.features
  names(y.data) = "Activity"
  names(subject.data) = "Subject"

  # Remove the irrelevant features  
  x.data = x.data[,relevant.features]
  
  # Replace the label IDs with the label names.
  y.data[,1] = activity.labels[y.data[,1]]
  
  # Join the subject data, x-data and y-data by binding the columns (side-by-side).
  cbind(subject.data, y.data, x.data)
}

# Perform tidying of the data.
makeTidy()