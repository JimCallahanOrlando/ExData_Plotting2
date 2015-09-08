# Plot2.R
# PURPOSE:  Load EPA Air Pollution Data files into R AND draw plot 2

# Set Directory to project directory for plots
setwd("~/GitHub/ExData_Plotting2/")
getwd()

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS(".data/summarySCC_PM25.rds")
SCC <- readRDS(".data/Source_Classification_Code.rds")

str(NEI) # before removal
# Convert all of the NEI columns EXCEPT Emissions, fips and SCC to factor.
# NEI$fips      <- factor(NEI$fips)
# NEI$SCC       <- factor(NEI$SCC)
NEI$Pollutant <- factor(NEI$Pollutant)
NEI$type      <- factor(NEI$type)
NEI$year      <- factor(NEI$year)
str(NEI) # after removal

# Number of observations for each year (before NA and INF removal).
table(NEI$year)

# Remove incomplete, missing, infinite, negative and zero observations.
# Only computing sums(not averages) and zeros appear to be missing data.
NEI <- NEI[complete.cases(NEI), ]
NEI <- NEI[!is.na(NEI$Emissions), ]
NEI <- NEI[!is.infinite(NEI$Emissions), ]
NEI <- NEI[NEI$Emissions > 0, ]   # will be taking log() -- can't have neg value.

# Number of observations for each year (after NA and INF removal).
table(NEI$year)

# Question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.
NEI$year <- factor(NEI$year)
Year <- levels(NEI$year)
BaltimoreEI <- NEI[NEI$fips == "24510", ]

par(mar = c(4, 4, 4, 1) )
bp <- boxplot(log10(Emissions) ~ year, BaltimoreEI, 
              xlab = "Year", ylab = "PM 2.5 readings (base 10 log scale)", range = 1.5)
title(main = "Baltimore PM 2.5 Emissions \n Decreased from 1999 to 2008" )

#  End of Plot2.R