library(dplyr)
fpath <- "C:/Users/sures/Documents/R/Coursera/Getting and Cleaning Data Month 3/Week 4/Dataset"
setwd(fpath)
# read labels and features
features <- c("Subject", "Activity", read.table("features.txt", as.is = TRUE)[,2])
activity_labels <- read.table("activity_labels.txt")

#reading in test data
xtest <- read.table(file.path(fpath, "test", "x_test.txt"))
ytest <- read.table(file.path(fpath, "test", "y_test.txt"))
subject_test <- read.table(file.path(fpath, "test", "subject_test.txt"))
test_df <- cbind(subject_test, ytest, xtest)

#reading in train data
xtrain <- read.table(file.path(fpath, "train", "x_train.txt"))
ytrain <- read.table(file.path(fpath, "train", "y_train.txt"))
subject_train <- read.table(file.path(fpath, "train", "subject_train.txt"))
train_df <- cbind(subject_train, ytrain, xtrain)

# merge into one df and find mean and standard deviation 
df <- rbind(test_df, train_df) 
colnames(df) <- features
df <- df %>% select("Subject", "Activity", contains("mean()"), contains("std()"))
# name activities with descriptions
df$Activity <- factor(df$Activity, labels = activity_labels[, 2])
#make separate table with labels
tidy_data <- df %>% group_by(Subject, Activity) %>% summarise_all(mean)
write.table(tidy_data, file = "tidy_table.txt", row.name = FALSE)
View(tidy_data)