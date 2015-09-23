# Plot4.R
# PURPOSE:  Load EPA Air Pollution Data files into R AND draw plot 4

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

# Subset before merging


# coalFuelCombustionData <- SCC[grep("^fuel comb -(.*)- coal$", SCC$EI.Sector, ignore.case=T), ]



#  End of Plot4.R