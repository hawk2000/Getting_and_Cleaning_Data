# Load required "dplyr" package for the execution of the function
library("dplyr")

# Paths and file names to download and unzip data. 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileZip <- "getdata_projectfiles_UCI_HAR_Dataset.zip"

basePath <- "UCI HAR Dataset"
fileResult <- "UCI_HAR_Dataset_Clean.txt"

# Download and unzip file 
download.file(fileUrl, destfile=fileZip)

unzip(fileZip, overwrite=TRUE)


# Define common files and paths for data files 
fileActivityLabels <- paste0(basePath, "/activity_labels.txt")
fileFeatures <- paste0(basePath, "/features.txt")

dataPaths <- c("test", "train")

# Load activity labels file
activityLabels <- tbl_df(read.table(fileActivityLabels, header=FALSE, comment.char=""))

# Load features file
features <- filter(tbl_df(read.table(fileFeatures, header=FALSE, comment.char="")), grepl("(mean\\(\\))|(std\\(\\))", V2))

# Normalize features names
features[[2]] <- gsub("^t", "Time",
                      gsub("^f", "Frequency",
                           gsub("\\(\\)", "",
                                gsub("BodyBody", "Body",
                                     gsub("Acc", "Accelerometer",
                                          gsub("mean", "Mean",
                                               gsub("std", "Std",
                                                    gsub("Gyro", "Gyroscope",
                                                         gsub("Mag", "Magnitude",
                                                              gsub("-", "", features[[2]])
                                                              )
                                                         )
                                                    )
                                               )
                                          )
                                     )
                                )
                           )
                      )

# Merge independently every kind of file 
for(path in dataPaths) {
  
  fileSubjects <- paste0(basePath, "/", path, "/subject_", path, ".txt")
  fileX <- paste0(basePath, "/", path, "/X_", path, ".txt")
  fileY <- paste0(basePath, "/", path, "/Y_", path, ".txt")
    
  # if the merged datasets don't exist, create them  
  if (!exists("subjects")) {
    
    # Load data frame with subjects data     
    subjects <- tbl_df(read.table(fileSubjects, header=FALSE, comment.char="", colClasses="integer"))
    
    # Load data frame with the labels for activities data     
    activities <- tbl_df(read.table(fileY, header=FALSE, comment.char="", colClasses="integer")) %>% 
                              mutate(Activity = activityLabels$V2[V1]) %>%
                              select(Activity)
    
    # Load data frame with only the mean and std measures     
    measures <- tbl_df(read.table(fileX, header=FALSE, comment.char="", colClasses="numeric")) %>% 
                              select(features[[1]])
  }
  else {
    
    # Add loaded data to frame with subjects data         
    subjects <- bind_rows(subjects, tbl_df(read.table(fileSubjects, header=FALSE, comment.char="", colClasses="integer")))
    
    # Add loaded data to frame with the labels for activities data         
    activities <- bind_rows(activities, tbl_df(read.table(fileY, header=FALSE, comment.char="", colClasses="integer")) %>% 
                              mutate(Activity = activityLabels$V2[V1]) %>%
                              select(Activity))
    
    # Add loaded data to frame with only the mean and std measures     
    measures <- bind_rows(measures, tbl_df(read.table(fileX, header=FALSE, comment.char="", colClasses="numeric"))) %>% 
                              select(features[[1]])
  }
}

# Remove activity labels data frame
rm(activityLabels)

# Define appropiate column names for each data framme 
colnames(subjects) <- c("Subject")
colnames(activities) <- c("Activity")
colnames(measures) <- features[[2]]

# Remove features data frame
rm(features)

# Summarize the data with the average of each variable for each activity and subject 
data_summary <- bind_cols(subjects, activities, measures)  %>%
            group_by(Subject, Activity) %>%
            summarise_each(funs(mean))

# Remove independent data frames
rm(subjects)
rm(measures)
rm(activities)

write.table(data_summary, fileResult, row.name=FALSE)