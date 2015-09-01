### FILE:     Tidy_EPA_National_Emissions_Inventory_Data.R
### PURPOSE:  Load EPA Air Pollution Data files into R AND tidy it up
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


setwd("~/GitHub/ExData_Plotting2/")
getwd()

### What is the date? (useful for bibliography: retrieved URL on date)
dateLoadedToR <- date()

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS(".data/summarySCC_PM25.rds")
SCC <- readRDS(".data/Source_Classification_Code.rds")

str(NEI)
# Convert all of the NEI columns except Emissions to factor.
NEI$fips      <- factor(NEI$fips)
NEI$SCC       <- factor(NEI$SCC)
NEI$Pollutant <- factor(NEI$Pollutant)
NEI$type      <- factor(NEI$type)
NEI$year      <- factor(NEI$year)
str(NEI)


# Number of oberservations for each year.
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
bp <- boxplot(log10(Emissions) ~ year, NEI, 
              xlab = "Year", ylab = "PM 2.5 readings (base 10 log scale)", range = 1.5)
title(main = "Have U.S. Emissions  Decreased \n from 1999 to 2008?" )

EmissionsByYear <- tapply(NEI$Emissions, NEI$year, sum)
EmissionsByYear <- as.data.frame(EmissionsByYear)
EmissionsByYear <- cbind(Year, EmissionsByYear)
plot(EmissionsByYear)
title(main = "Have U.S. Emissions  Decreased \n from 1999 to 2008?" )



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
title(main = "Have Baltimore Emissions  Decreased \n from 1999 to 2008?" )


BaltimoreEmissionsByYear <- tapply(BaltimoreEI$Emissions, BaltimoreEI$year, sum)
BaltimoreEmissionsByYear <- as.data.frame(BaltimoreEmissionsByYear)
BaltimoreEmissionsByYear <- cbind(Year, BaltimoreEmissionsByYear)
plot(BaltimoreEmissionsByYear)
title(main = "Have Baltimore Emissions  Decreased \n from 1999 to 2008?" )


# Question 3:
# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Question 4:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# How does one identify "coal combustion-related?

# Question 5:
# How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City?

# NOTE: For "motor vehicle sources" may have to merge NEI and SCC on SCC


# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# NOTE: For "motor vehicle sources" may have to merge NEI and SCC on SCC
LosAnglesEI <- NEI[NEI$fips == "06037", ]



### End of: Tidy_EPA_National_Emissions_Inventory_Data.R