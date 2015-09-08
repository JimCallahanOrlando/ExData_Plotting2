# Plot3.R
# PURPOSE:  Load EPA Air Pollution Data files into R AND draw plot 3

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


# Summarize NEI$Emissions by NEI$year
NEI$year <- factor(NEI$year)
Year <- levels(NEI$year)
summary(NEI$Emissions)

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
bp3 <- bp2 + facet_wrap( ~ type ) + ggtitle("Baltimore Particulate Matter 2.5 Emission Trends \nBy Source")
bp3 <- bp3 + ylab("Emissions - log scale") + xlab("Year\nSource: US EPA Nation Emissions Inventory (NEI)")
bp3

#  End of Plot3.R