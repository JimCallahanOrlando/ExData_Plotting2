# Plot1.R
# PURPOSE:  Load EPA Air Pollution Data files into R AND draw plot 1

# Set Directory to project directory for plots
setwd("~/GitHub/ExData_Plotting2/")  # set
getwd()                              # verify

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

# Question 1:
# Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# Summarize NEI$Emissions by NEI$year
NEI$year <- factor(NEI$year)
Year <- levels(NEI$year)
summary(NEI$Emissions)

par(mar = c(4, 4, 4, 1) )
# With Logs (extremely wide range of values; log scale needed to reduce spread)
# See Winston Chang's "R Graphics Cookbook" pages 327-329 for use of "ppi"
# reduced size to 3.5*ppi -- so whole graph would show in Coursera window.
ppi <- 150
png(filename = "plot1.png", height = 3.5*ppi, width=3.5*ppi, units = "px", pointsize = 14)
boxplot(log10(Emissions) ~ year, NEI, 
            xlab = "Year", ylab = "PM 2.5 readings (base 10 log scale)")
            title(main = "U.S. Particulate Matter 2.5 Emissions  \nDecreased from 1999 to 2008")
dev.off()            
            
# Plot1.png complete.
#
# Here are some alternate approaches
#Without Logs
# NEI <- NEI[NEI$Emissions < (20000), ] # omit known outliers
# bp <- boxplot(Emissions ~ year, NEI, 
#              xlab = "Year", ylab = "PM 2.5 readings", range = 1.5)
# title(main = "U.S. Emissions  Decreased \n from 1999 to 2008" )

# alternate approach
# EmissionsByYear <- tapply(NEI$Emissions, NEI$year, sum)
# EmissionsByYear <- as.data.frame(EmissionsByYear)
# EmissionsByYear <- cbind(Year, EmissionsByYear)
# plot(EmissionsByYear)
# title(main = "Have U.S. Emissions  Decreased \n from 1999 to 2008?" )

#  End of Plot1.R