The script assumes that the Samsung files were extracted as they were arranged and located in the zip file provided in the Coursera project guidelines, i.e. there should be a folder named UCI HAR Dataset with the subfolders "test" and "train"; just like in the zip file.

The first section explain the steps taken to arrive at the final data set. The second section elaborates on why this is indeed in accordance with the Tidy Data principles.

##SECTION 1##

The code begins with assigning variables that would then be used in a custom function that does the following to a given set of parameters:

1. Change the activity codes given in Y files to activity labels using a simple lookup table
2. Bind the X data file with the activity labels and subject codes
3. Takes the information in the features file and processes the following:

  * Adds two more names in the features list called "activity" and "subjects". These will be the variable headers for the activity labels and subject codes, respectively.
  * Converts all the names given in the features file, into syntactically valid names, using make.names()
  * Takes this new features list and assigns it as the new column headers for the dataframe made in point No.2.

4. The new dataframe now has activity, subjects, and variables included. It then processes the following:
  
  * The final two columns in the data set are the activity and subjects. These two columns are assigned to a different variable.
  * A separate data frame is created that includes only the variables that contain the word "mean".
  * Another separate data frame is that includes only the variable that contain the word "std".
  * The above three data frames are then binded by columns to created the format, ACTIVITY-SUBJECTS-[ALL MEANS]-[ALL STDs]
  * Lastly, the weighted average and angle variables are then dropped from the final data set, due to the following points:

    * The measurements that were taken represent variables of feature vector pattern, which total to 17 measurements. 8 of which have 3-axial signals, which totals to 33 measurements.
    * A given set of 17 variables were then estimated out of the aforementioned 33 measurements. Variables that are, among other things, summary statistics of these measurements.
    * The final data set is required to have only the mean and standard deviation of each measurement. The information provided in the UCI feature_info file clearly mentions that the mean and standard deviation are the features affixed with mean() and std() in the features file.
    * With the above points in mind, all the columns containing the words meanFreq and angle were subsequently dropped as they do not represent the mean and standard deviation of the 33 measurements. 33 measurements, 2 variables of each, would result in a total of 66 variables.
    
5. The test and train data are then run through the function and the results are assigned to FinalTest and FinalTrain respectively, and subsequently binded by rows and named FinalSet. The FinalSet contains:
  
  * An activity column that's been appropriately converted to labels.
  * A subject code column
  * Only the means and standard deviations of the complete list of features.

6. Using the summarise_each() function, the dataframe summarises each column by the mean function.. This is then assigned to x. The same thing is then done once more, but summarized for subjects instead of activities. This is then assigned to y.
7. The second columns are then removed for each x and y because the second columns show a summary of the activity column (for the x df) and the subject column (for the y df). In order to show tidy data, those columns need to be removed in order to show meaningful variables in the final data set.
8. Both x and y are the binded by rows after having changed the first column in x to class character, and renamed the first column for both x and y to the same name. The resulting data frame is then assigned to the variable TidyFinal, which is the complete tidy data set.

##_____##

##SECTION 2##

The final data frame that is created can be labeled as tidy data for the mean reason that the columns represent each of the variables that were required for the analysis, namely the average of each mean and standard deviation of the original measurements; and also because the rows represent each observation for each activity and each subject. 

##_____##
