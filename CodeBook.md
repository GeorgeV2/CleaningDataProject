
# Code Book for Courera Getting and Cleaning Data Project

This code book that describes the variables, the data, and the work performed to clean up the data and create a tidy data set.

## 1. Merges the training and the test sets to create one data set.

After the data was downloaded and unzipped, the text files below were loaded into R and the columns of the datasets were given names:
  * X Train
  * Y Train
  * X Test
  * Y Test
  * Features
  *Activity Labels

After the column names are assigned, the train and test sets are merged to create one data set. 
 

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

To extract the measurements for the means and standard deviations of the measurements, we use the R function **grepl** to return the occasions where the word "mean" or "std" appear in the columns names for the merged data set.


## 3. Uses descriptive activity names to name the activities in the data set

To add descriptive activity names to the data set, I used the **merge** function on the data with the means and standard deviations and a dataset with the  activity labels. The merged data set named *activity_names* has the column with activity names (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, LAYING, SITTING, STANDING). 

## 4. Appropriately labels the data set with descriptive variable names.

To add meaningful names to the columns in the data set created in step 1, I used the function **gsub** on the following words:
  * t became time
  * f became frequency
  * Acc became Accelerometer
  * Gyro became Gyroscope
  * Mag became Magnitude
  * BodyBody was corrected to Body
  * mean became Mean
  * std became StandardDeviation
  * iqr was expanded to InterquartileRange
	

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Finally, the data set with the improved variable names is written into a text file named **tidy_data.txt**












