# Getting and Cleaning Data

This is the file with the information required for the assignment.

The assignment is based on the analysis and cleaning of data collected from the gyroscope and accelerometer from the Samsung Galaxy S Smartphone. A full description is available here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## How the script works

It is required to have installed the package "dplyr" to make it work.

It's not required to download and decompress the file, because these ones are the first steps included in the script for the analysis (Everything will be downloaded and decompressed in the working directory).

The files "activity_labels.txt" (contains an id and name of the different activities measured) and "features.txt" (contains an id and the name of the different measures) are loaded, this last one is filtered with the mean() and std() variables to reduce the ammount of data.

After loading the features all the data in it is formatted in order to give more readable names to them.

Then every kind of data file is loaded apart in different data frames to be merged easily. There will be a collection for the subjects with the "subject_test.txt" and "subject_train.txt" files, another one with the names of the activities obtained from the files "Y_test.txt", "Y_train.txt" and the data loaded from the "activity_labels.txt" and finally another one with the different required measures obtained from the files "X_test.txt", "X_train.txt" using the previous filtered "features.txt" file.

Before joining the independent frames the names are assigned to each column.

In order to get the final result, all the data frames are joined and the data grouped by subject and activity to calculate the mean of all the rest of variables.

Finally the result is written in a file.


In this approach it has been tried to reduce the data in memory due to some performance problems, because of that some data frames removals appears in the code.


## Code book

The dataset contains a total of 68 variables and 30 subjects x 6 actitities = 180 observations.

The data is ordered by subject and activity, being the rest of the variables the mean of the different measures for the same subject and activity. 

 [1] "Subject" : Each subject is identified by a number from 1 to 30. The test subjects are 2, 4, 9, 10, 12, 13, 18, 20 and 24. The others are train subjects                                    
 [2] "Activity" : The different activities measured: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING" and "LAYING"                                   

The rest of the variables contain the mean for the different measures in the original data with time and frequency domain variables. They are normalized and bounded within [-1, 1].

(XYZ) is used to denote 3-axial signals in the X, Y and Z directions.

The details for each of these measures is described in the original documentation file.

 [3] "TimeBodyAccelerometerMeanX"                 
 [4] "TimeBodyAccelerometerMeanY"                 
 [5] "TimeBodyAccelerometerMeanZ"                 
 [6] "TimeBodyAccelerometerStdX"                  
 [7] "TimeBodyAccelerometerStdY"                  
 [8] "TimeBodyAccelerometerStdZ"                  
 [9] "TimeGravityAccelerometerMeanX"              
[10] "TimeGravityAccelerometerMeanY"              
[11] "TimeGravityAccelerometerMeanZ"              
[12] "TimeGravityAccelerometerStdX"               
[13] "TimeGravityAccelerometerStdY"               
[14] "TimeGravityAccelerometerStdZ"               
[15] "TimeBodyAccelerometerJerkMeanX"             
[16] "TimeBodyAccelerometerJerkMeanY"             
[17] "TimeBodyAccelerometerJerkMeanZ"             
[18] "TimeBodyAccelerometerJerkStdX"              
[19] "TimeBodyAccelerometerJerkStdY"              
[20] "TimeBodyAccelerometerJerkStdZ"              
[21] "TimeBodyGyroscopeMeanX"                     
[22] "TimeBodyGyroscopeMeanY"                     
[23] "TimeBodyGyroscopeMeanZ"                     
[24] "TimeBodyGyroscopeStdX"                      
[25] "TimeBodyGyroscopeStdY"                      
[26] "TimeBodyGyroscopeStdZ"                      
[27] "TimeBodyGyroscopeJerkMeanX"                 
[28] "TimeBodyGyroscopeJerkMeanY"                 
[29] "TimeBodyGyroscopeJerkMeanZ"                 
[30] "TimeBodyGyroscopeJerkStdX"                  
[31] "TimeBodyGyroscopeJerkStdY"                  
[32] "TimeBodyGyroscopeJerkStdZ"                  
[33] "TimeBodyAccelerometerMagnitudeMean"         
[34] "TimeBodyAccelerometerMagnitudeStd"          
[35] "TimeGravityAccelerometerMagnitudeMean"      
[36] "TimeGravityAccelerometerMagnitudeStd"       
[37] "TimeBodyAccelerometerJerkMagnitudeMean"     
[38] "TimeBodyAccelerometerJerkMagnitudeStd"      
[39] "TimeBodyGyroscopeMagnitudeMean"             
[40] "TimeBodyGyroscopeMagnitudeStd"              
[41] "TimeBodyGyroscopeJerkMagnitudeMean"         
[42] "TimeBodyGyroscopeJerkMagnitudeStd"          
[43] "FrequencyBodyAccelerometerMeanX"            
[44] "FrequencyBodyAccelerometerMeanY"            
[45] "FrequencyBodyAccelerometerMeanZ"            
[46] "FrequencyBodyAccelerometerStdX"             
[47] "FrequencyBodyAccelerometerStdY"             
[48] "FrequencyBodyAccelerometerStdZ"             
[49] "FrequencyBodyAccelerometerJerkMeanX"        
[50] "FrequencyBodyAccelerometerJerkMeanY"        
[51] "FrequencyBodyAccelerometerJerkMeanZ"        
[52] "FrequencyBodyAccelerometerJerkStdX"         
[53] "FrequencyBodyAccelerometerJerkStdY"         
[54] "FrequencyBodyAccelerometerJerkStdZ"         
[55] "FrequencyBodyGyroscopeMeanX"                
[56] "FrequencyBodyGyroscopeMeanY"                
[57] "FrequencyBodyGyroscopeMeanZ"                
[58] "FrequencyBodyGyroscopeStdX"                 
[59] "FrequencyBodyGyroscopeStdY"                 
[60] "FrequencyBodyGyroscopeStdZ"                 
[61] "FrequencyBodyAccelerometerMagnitudeMean"    
[62] "FrequencyBodyAccelerometerMagnitudeStd"
[63] "FrequencyBodyAccelerometerJerkMagnitudeMean"
[64] "FrequencyBodyAccelerometerJerkMagnitudeStd" 
[65] "FrequencyBodyGyroscopeMagnitudeMean"        
[66] "FrequencyBodyGyroscopeMagnitudeStd"         
[67] "FrequencyBodyGyroscopeJerkMagnitudeMean"    
[68] "FrequencyBodyGyroscopeJerkMagnitudeStd"
