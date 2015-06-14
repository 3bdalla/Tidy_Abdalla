library(dplyr) #load dplyr package
library(stringr) #load stringr package

rNamesTest = y_test[,1] #assign vector with activity codes for the testing set
rNamesTrain = y_train[,1] #assign vector with activity codes for the training set
Features = as.character(features$V2) #assign variable names both sets

#**Parameters: 
#1: dataset = the df with all the measurments. (data frame)
#2. rowNames = activity codes (Vector)
#3. colnames = the features, aka variable names (Vector)
#4. subjects = codes representing subjects (data frame 1x1)
tidyUp = function(dataset, rowNames, colNames, subjects){
  
  #Create a look up table
  lut = c("1" = "WALKING", "2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", "5" = "STANDING", "6" = "LAYING")
  
  #Replace lookup activity codes with lookup table
  rowNames = lut[rowNames]
  
  #Bind the measurements, the activity labels, and subject codes; by columns
  y = cbind(dataset, rowNames, subjects)
  
  colNames[length(colNames)+1] = "activity" #add one more variable in the features called $activity
  colNames[length(colNames)+1] = "subjects" #add one more variable in the features called $subjects
  
  #Make variable names syntactically correct
  colNames = make.names(colNames, unique = TRUE)
  
  #Assign syntactically correct column names to the binded dataset
  colnames(y) = colNames
  
  a = y[,562:563] #create new df with only the activity and subjects
  b = select(y, contains("mean")) #df with only variables containing "mean"
  c = select(y, contains("std")) #df with only variables containing "std"
  y = cbind(a,b,c) #column bind all the the activity and subject columns, with the mean df and the std df
  
  y = select(y, -contains("meanFreq"), -starts_with("angle")) #..and drop the weighted average and angle measurements
  
  return(y) #return the resulting df
}

FinalTest = tidyUp(X_test, rNamesTest, Features, subject_test) #Run and assign function with test measurements, test activity codes, variables, and subjects
FinalTrain = tidyUp(X_train, rNamesTrain, Features, subject_train) #Run and assign function with train measurements, train activity codes, variables, and subjects
FinalSet = rbind(FinalTest, FinalTrain) #bind both sets by rows


x = data.frame(summarise_each(group_by(FinalSet, activity), funs(mean))) #Calculate mean for variables, grouped by activity
y = data.frame(summarise_each(group_by(FinalSet, subjects), funs(mean))) #Calculate mean for variables, grouped by subjects

x[,2] = NULL #Remove second column of each. See ReadMe file for more details
y[,2] = NULL 

x[,1] = as.character(x[,1]) #Converted activity names into class character, in order to bind by rows

colnames(x)[1] = "subject.activity" #Change variable names for both dfs, in order to bind by rows
colnames(y)[1] = "subject.activity"

TidyFinal = rbind(x,y) #Bind both x and y dfs by rows, and assign completed df. 