# CodeBook for Getting_and_Cleaning_Data_Project
      This file will describes the variables, the data, and any transformations or work that I performed to 
    clean up the data.
    
  * The data was obtained:        
   * http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

  * Here are the data for the project:
   * https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
   
  * The run_analysis.R script will perform the following steps:
   * 1. Read X_train.txt, y_train.txt and subject_train.txt and store them in variables respectively.
   * 2. Read X_test.txt, y_test.txt and subject_test.txt and store them in variables respectively.
   * 3. Rbind X txt into variable called datax, y txt into datay and subject text into subject respectively 
   * 4. Read the features_txt, grep the specific names and select the specific colums
   * 5. Remove the "()" and "-" symbols in the names 
   * 6. cbind subject,datay,datax
   * 7. Read the activity_labels.txt and transform the datay to values of activity accordingly
   * 8. Write the cleandata out to "merged_data.txt" file in current working directory.
   * 9. Finally write our a second tidy dataset.Each of 30 subjects and each of 6 activity has the average of 
        each measurement, so the first column will be the subject number, second the activity. For there are six
        activities, so each subject ID will be repeated six times. At last, a 180-row data frame will be generated.
   * 10. write out this dataset too.
