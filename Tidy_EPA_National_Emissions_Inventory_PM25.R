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
# Convert all of the NEI columns EXCEPT Emissions, fips and SCC to factor.
# NEI$fips      <- factor(NEI$fips)
# NEI$SCC       <- factor(NEI$SCC)
NEI$Pollutant <- factor(NEI$Pollutant)
NEI$type      <- factor(NEI$type)
NEI$year      <- factor(NEI$year)
str(NEI)


# Number of observations for each year (before NA and INF removal).
table(NEI$year)

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


# BaltimoreEmissionsByYear <- tapply(BaltimoreEI$Emissions, BaltimoreEI$year, sum)
# BaltimoreEmissionsByYear <- as.data.frame(BaltimoreEmissionsByYear)
# BaltimoreEmissionsByYear <- cbind(Year, BaltimoreEmissionsByYear)
# plot(BaltimoreEmissionsByYear)
# title(main = "Have Baltimore Emissions  Decreased \n from 1999 to 2008?" )


# Question 3:
# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# NEI$type factor (point, nonpoint, onroad, nonroad)
NEI$type      <- factor(NEI$type)

NEI$year <- factor(NEI$year)
Year <- levels(NEI$year)
BaltimoreEI <- NEI[NEI$fips == "24510", ]
BaltimoreEI <- BaltimoreEI[!is.na(BaltimoreEI$Emissions), ]

require(ggplot2)
# use same box plot, but faceted.
# use facets to display type.

# This is same boxplot as above; need to add facets for "type"
# BaltimoreEI$EmissionsLog10 <- log10(BaltimoreEI$Emissions)

# HONOR CODE: "R Graphics Cookbook" by Winston Chang
# Argument to log must be in quotes: log = "y"
par(mar = c(4, 4, 4, 1) )
bp2 <- qplot( data = BaltimoreEI, x = year, y = Emissions, log = "y" )  + geom_boxplot()

# Add facets (note: tilda, "~" is required!)
bp3 <- bp2 + facet_wrap( ~ type ) + ggtitle("US PM2.5 Emission Trends By Source")
bp3 <- bp3 + ylab("Emissions - log scale") + xlab("Year\nSource: US EPA Nation Emissions Inventory (NEI)")
bp3


# Question 4:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# How does one identify "coal combustion-related?

levels(SCC$EI.Sector)
# HONOR CODE: Used class forum comment by Abhishek Singh
#Filtering the sources to the ones related to Coal Fuel Combustion
#Select data from the sources which are of the form "Fuel Comb - <string> - Coal"
#Example Fuel Comb - Electric Generation - Coal
#This is done based on the specification provided on the 
# epa website http://www.epa.gov/air/emissions/basic.htm
CoalCombustionTest <- grep("^fuel comb (.*) coal$", levels(SCC$EI.Sector), ignore.case=T)
EI.SectorLevels <- levels(SCC$EI.Sector)
CoalCombustionLevels <- EI.SectorLevels[CoalCombustionTest]
CoalCombustionLevels

CoalCombustion <- grep("^fuel comb -(.*)- coal$", SCC$EI.Sector, ignore.case=T)

## Need to merge (join) NEI and SCC on scc 
## (see Jared Lander, "R for Everyone" page 142-149)
## Then need to subset coal combustion


# coalFuelCombustionData <- SCC[grep("^fuel comb -(.*)- coal$", SCC$EI.Sector, ignore.case=T), ]


# Question 5:
# How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City?

# NOTE: For "motor vehicle sources" may have to merge NEI and SCC on SCC
# coalFuelCombustionData <- SCC[grep("^Mobile - On-Road", SCC$EI.Sector, ignore.case=T), ]



# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# NOTE: For "motor vehicle sources" may have to merge NEI and SCC on SCC
NEI$year <- factor(NEI$year)
Year <- levels(NEI$year)
BaltimoreEI <- NEI[NEI$fips == "24510", ]
LosAnglesEI <- NEI[NEI$fips == "06037", ]



MotorVehicleTest <- grep("^Mobile . On-Road (.*) Vehicles$", levels(SCC$EI.Sector), ignore.case=T)
EI.SectorLevels <- levels(SCC$EI.Sector)
MotorVehicleLevels <- EI.SectorLevels[MotorVehicleTest]
MotorVehicleLevels



### End of: Tidy_EPA_National_Emissions_Inventory_Data.R