### FILE:     Get_EPA_Natoinal_Emissions_Inventory_Data.R
### PURPOSE:  Download EPA Air Pollution Data Zip file
###
### LANGUAGE: R statistical programming language
###           R version 3.2.2 (2015-08-14) -- "Fire Safety"
###           Copyright (C) 2015 The R Foundation for Statistical Computing
###           Platform: x86_64-w64-mingw32/x64 (64-bit)
###
### IDE:      RStudio
###           Version 0.98.1103 © 2009-2014 RStudio, Inc.
###
### PLATFORM: Microsoft Windows 7 Professional [Version 6.1.7601]
### MODIFIED: 08/09/2015 Changed to use /ExData_Plotting1/.data
### NOTE:     This project has a 20 meg datafile that must be ignored by git/GitHub.
### NOTE:     .data folder is intended to be both "hidden" and ignored by git/GitHub.
### NOTE:     Creating an RStudio project will create ".gitignore".
### NOTE:     MUST edit ".gitignore" to add /data and /.data directories.

### NOTE:     This program has a KISS/brute force philosophy
### NOTE:     though it is possible to read directly from .zip; we unzip to .txt.


### descr has the file.head function for dumping the first few lines of a file without interpretation
require(descr)

### If you comment out this specific setwd(); use the getwd() to note what directory you are in.
setwd("~/GitHub/ExData_Plotting2")

### Where am I? (in the directory tree -- useful for debugging file string)
getwd()

### What is the date? (useful for bibliography: retrieved URL on date)
dateDownloaded <- date()

### Get Household Power Consumption Data Zip file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,'~\\GitHub\\ExData_Plotting2\\.data\\exdata%2Fdata%2FNEI_data.zip', mode="wb")

### Unzip the data file
unzip("~\\GitHub\\ExData_Plotting2\\.data\\exdata%2Fdata%2FNEI_data.zip", 
      overwrite = TRUE, exdir = "", unzip = "internal", setTimes = TRUE)

## dump the first few lines of file using file.head() from the descr package
## could have used readlines() for this, but easier to remember head and file.head .
# file.head("~\\GitHub\\ExData_Plotting1\\.data\\household_power_consumption.txt")

### Data file should be downloaded and unzipped; ready for next program read into R.
### End of: Get_EPA_Natoinal_Emissions_Inventory_Data.R