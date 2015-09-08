# ProbeForCoal.R

setwd("~/GitHub/ExData_Plotting2/")
getwd()

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

EI.CoalCombustionTest <- grep("^fuel comb (.*) coal$", levels(SCC$EI.Sector), ignore.case=T)
EI.SectorLevels <- levels(SCC$EI.Sector)
CoalCombustionLevels <- EI.SectorLevels[EI.CoalCombustionTest]
CoalCombustionLevels

str(SCC)

str(SCC$Data.Category)
levels(SCC$Data.Category)

str(SCC$Option.Group)
levels(SCC$Option.Group)

# NOT COAL
# str(SCC$Option.Set)
# levels(SCC$Option.Set)

str(SCC$SCC.Level.One)
levels(SCC$SCC.Level.One)

str(SCC$SCC.Level.Two)
levels(SCC$SCC.Level.Two)

str(SCC$SCC.Level.Three)
L3.CoalTest <- grep("coal", levels(SCC$SCC.Level.Three), ignore.case=T)
L3.Levels <- levels(SCC$SCC.Level.Three)
L3.CoalLevels <- L3.Levels[L3.CoalTest]
L3.CoalLevels

str(SCC$SCC.Level.Four)
L4.CoalTest <- grep("coal", levels(SCC$SCC.Level.Four), ignore.case=T)
L4.Levels <- levels(SCC$SCC.Level.Four)
L4.CoalLevels <- L4.Levels[L4.CoalTest]
L4.CoalLevels

# NO COAL
# str(SCC$Usage.Notes)
# levels(SCC$Usage.Notes)

# End of: ProbeForCoal.R