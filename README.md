CleaningDataCourseProject
=========================

## run_analysis.R Markdown file.

The script begins by downloading the .zip files from the internet and 
then extracts the contents of the .zip into the users working directory.

Once this is done the script extracts the training data, it's subject data and it's 
activity data into seperate tables. The same is done for the test data and 
finally the variables data.

Both the test and train dataframes then have column names added using the variable data.
Column names are also added to the Activity and SubjectNumber tables.

The Activity and SubjectNumber dataframes are then binded to the front of the test and train 
dataframes.

The two data frames are then merged and reordered. First by SubjectNumber and then by Activity.

The Activity numbers are then replaced by a text description.

After this has ben completed the dataframe is subset to include only SubjectNumber, Activity
and any columns that include the mean or std.

The dataframe is subset again to remove columns with meanFreq as they are unneeded.

The column names are then edited, replacing -mean()- and -std()- with .Mean. and .STD. 
This is done to make the data look more presentable and to prevent errors when calling
columns by name.

Next the reshape2 package is loaded and the melt function is used to break down the dataframe.

The dataframe is then recast by SubjectNumber and Activity, giving the mean results of each pair
for the remaining columns.

Finally the dataframe is saved as a .txt file seperated by commas.