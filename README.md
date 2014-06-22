## Cleaning the UCI HAR Dataset

Download the zip file provided for the class project:

> [getdata-projectfiles-UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The zip file contains one folder, *UCI HAR Dataset*, which you should extract to a convenient location. Next, download the file *run_analysis.R* from this repository, and save it in the folder you just unzipped. Finally, open R or RStudio, set R's working directory to the folder you just unzipped, and source the *run_analysis.R* file.

A new file, *tidy_data.txt*, will be produced in the *UCI HAR Dataset* folder. This tidy dataset can be loaded in R using the *read.table* command. The following operations are performed on the original dataset in order to create the tidy dataset.

### Operations performed by run_analysis.R

 1. Loads raw test data from the *test* directory into data tables representing the **subject**, **X**, and **y** data.

 2. Loads raw training data from the *train* directory into data tables representing the **subject**, **X**, and **y** data.

 3. Combines **subject**, **X**, and **y** data from the test and training datasets into unified data tables.

 4. Loads the data descriptors from the files *features.txt* and *activity_labels.txt* into data tables (**features** and **activity_labels**, respectively). **features** contains descriptive column names for the data found in the unified **X** data table. **activity_labels** contains easy-to-read activity labels that correspond to the numeric identifiers provided in the unified **y** data table.

 5. Changes the column names in the unified **X** data table to correspond with the column names in **features**.

 6. Creates a new factor (**activities**) to store readable activity labels for the unified **y** data table, by checking each against **activity_labels**. Each entry in this factor corresponds to a row in **y**, and each row in **y** corresponds to a row in **X**; we'll combine these later.

 7. Uses a regular expression to filter out the rows from **features** which correspond to means and standard deviations calculated on base measurements. These are stored in **salient_features**. For our purposes, it is assumed that columns with names containing either the string "**-mean()**", or the string "**-std()**", meet the assignment criteria.

 8. Builds a new data table (**tidy_data**) from the unified **X** data table, taking only those columns from **X** which are also found in **salient_features**.

 9. Prepends the **activities** factor as the first column of **tidy_data** and give it a useful name ("Activity").

 10. Prepends the **subjects** unified data table as the first column of **tidy_data** and give it a useful name ("Subject"). Note that "Activity" is now the second column.

 11. Cleans up the column names in **tidy_data** by replacing substrings in every column name, such that:

    - "-mean()-" becomes ".Mean."
    - "-mean()" becomes ".Mean"
    - "-std()-" becomes ".Std."
    - "-std()" becomes ".Std".

 Here are a few examples, before and after string substitution:

    - "tBodyGyro-std()-X" becomes "tBodyGyro.Std.X"
    - "tBodyAccMag-mean()" becomes "tBodyAccMag.Mean"
    - "tGravityAcc-mean()-Y" becomes "tGravityAcc.Mean.Y"

 12. Takes the mean of each feature in **tidy_data**, grouped by subject and activity. Outputs the grouped data to a new file, *tidy_data.txt*.
