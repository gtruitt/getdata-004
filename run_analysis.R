# load the data descriptors
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

# load the raw test data into tables
subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

# load the raw training data into tables
subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

# combine the test and training data tables
subject_all <- rbind(subject_test, subject_train)
X_all <- rbind(X_test, X_train)
y_all <- rbind (y_test, y_train)

# label the features in X_all using the names in features
colnames(X_all) <- as.character(features$V2)

# use a regular expression to determine which rows in table
# features designate a "-mean()-" or "-std()-" measurement;
# these correspond to the columns we want to keep from X_all
salient_features <- grepl("-(mean|std)\\(\\)-", features$V2)

# build a new table from X_all with just the columns we want
tidy_data <- X_all[, salient_features]

# combine the identifiers from y_all with the labels from
# activity_labels to build a factor of all the activities
activities_all <- factor(y_all$V1,labels=activity_labels$V2)

# prepend activities_all as the first column of tidy_data and label it
current_colnames <- colnames(tidy_data)
tidy_data <- cbind(activities_all, tidy_data)
colnames(tidy_data) <- c("Activity", current_colnames)

# prepend subject_all as the first column of tidy_data and label it
current_colnames <- colnames(tidy_data)
tidy_data <- cbind(subject_all, tidy_data)
colnames(tidy_data) <- c("Subject", current_colnames)

# write our tidy data set to a file
write.table(tidy_data, "tidy_data.txt")
