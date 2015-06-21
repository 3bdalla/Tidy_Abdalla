## Preface ##

The run_analysis.R script provided creates a tidy data frame using the train and test data provided by the University of California Irvine's human activity recognition experiments. The script creates a data frame that contains averages of all the means and standard deviation of the original measurements compiled by UCI, for each subject and also for each activity. More information on the raw information can be found on UCI's machine learning repository at their website  [here.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The script assumes that the data files were extracted in to the working directory as they were arranged and located in the zip file provided in the Coursera project guidelines, i.e. there should be a folder named UCI HAR Dataset with the subfolders "test" and "train"; just like in the zip file.

The script also assumes that the `dplyr` and `stringr` packages are already installed.

The first section explains the steps taken to arrive at the final data set. The second section elaborates on why this is indeed in accordance with the principles of Tidy Data.

### Section 1 ###

1. The code begins with assigning variables that would then be used in a custom function that processes the following to a given set of parameters:

 i. Change the activity codes given in Y files to activity labels using a simple lookup table
 
 ii. Bind the X data file with the activity labels and subject codes
 
 iii. Takes the information in the features file and processes the following:
 
  * Adds two more names in the features list called "activity" and "subjects". These will be the variable headers for the activity labels and subject codes, respectively.
  * Converts all the names given in the features file, into syntactically valid names, using make.names()
  * Takes this new features list and assigns it as the new column headers for the dataframe made in point No.2.
 
 iv. The resulting dataframe now has activity, subjects, and variables included. It then processes the following:
  * The final two columns in the data set are the activity and subjects. These two columns are assigned to a different variable.
  * A separate data frame is created that includes only the variables that contain the word "mean".
  * Another separate data frame is created that includes only the variable that contain the word "std".
  * The above three data frames are then binded by columns to create a data frame with a format ACTIVITY-SUBJECTS-[ALL MEANS]-[ALL STDs]
  * Lastly, the weighted average and angle variables are then dropped from the final data set, due to the following points:
 
    * The measurements that were taken represent variables of feature vector pattern, which total to 17 measurements. 8 of which have a XYZ 3-axial signals, which totals to 33 measurements.
    * A given set of 17 variables were then estimated out of the aforementioned 33 measurements. Variables that are, among other things, summary statistics of these measurements.
    * The final data set is required to have only the **mean** and **standard deviation** of each measurement. The information provided in the UCI feature_info file clearly mentions that the mean and standard deviation are the features affixed with *mean()* and *std()* in the features file.
    * With the above points in mind, all the columns containing the words *meanFreq* and *angle* were subsequently dropped as they do not represent the mean and standard deviation of the 33 measurements. 33 measurements, 2 variables of each, would result in a total of 66 variables.

5. The test and train data are then run through the `tidyUp()` function and the results are assigned to **FinalTest** and **FinalTrain** respectively, and subsequently binded by rows and named **FinalSet**. The FinalSet contains:
  
  * An activity column that's been appropriately converted to labels.
  * A subject code column.
  * Only the means and standard deviations of the complete list of features.
  * Appropriate column names per variable.

6. Using a combination of the *summarise_each()* and *group_by()* functions, the dataframe summarises each column by activities, and averages the measurements. This is then assigned to x. The same thing is then done once more, but summarized for subjects instead of activities. This is then assigned to y.
7. The second column is then removed for each x and y because the second columns show a summary of the activity column (for the x data frame) and the subject column (for the y dataframe). In order to show tidy data, those columns need to be removed in order to show meaningful variables in the final data set.
8. Both x and y are then binded by rows after having changed the first column in x to class character, and renamed the first column for both x and y to the same name. The resulting data frame is then assigned to the variable **TidyFinal**, which is the complete tidy data set.
9. The final `write.table()` function simply exports the final complete tidy data set as a txt file, and removing all row names.

### _____ ###

### Section 2 ###

The final data frame that is created can be described as tidy data for the reason that the columns represent each of the variables that were required for the analysis, namely the average of each mean and standard deviation of the original measurements; and also because the rows represent each observation for each activity and each subject. An argument can be made that the subject.activity might violate the Tidy Data rule of housing a single variable per column. However, the summarization of each activity and subject in the same dataframe does not allow for separate columns for subjects and activities; unless the data provided was transposed to a long format - in which case the variables would appear to be rows (observations), which would still be a violation of the tidy data principles. Given the summarization instructions that were given, and the data provided, the resulting data set that is created can still be classified as tidy data.

### _____ ###
