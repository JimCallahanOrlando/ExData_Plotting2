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
summary(NEI)

str(SCC)

### SUBSET BY Date2: "We will only be using data from the dates 2007-02-01 and 2007-02-02."
### If using just dates we can be inclusive; if using date-times have to be less than next day.
# DateRange <- household_power_consumption$Date2 >= "2007-02-01" &  household_power_consumption$Date2 <= "2007-02-02"
# HH_Power_DateSlice <- household_power_consumption[DateRange, ]



### attach(HH_Power_DateSlice) -- alternative to with()

### Assignment: "Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels."
### PNG commands from website:     
###     http://rfunction.com/archives/812
### png(Plot1.png, width=480, height=480)
### PLOT GOES HERE
### dev.off()

# restore default of one plot
# par(cex = .75, mfrow = c(1, 1), mar = c(4, 4, 2, 1))

### Plot 1: Quick and dirty (Move to separate file Plot1.R -- save output in Plot1.png)
# with(HH_Power_DateSlice, 
#     hist(Global_active_power, col = "red", 
#          main = "Global Active Power", 
#          xlab = "Global Active Power (kilowatts)" )
#     )


### Plot 2: Quick and dirty
# with(HH_Power_DateSlice, 
#     plot(DateTime2, Global_active_power, 
#          main = "", 
#          xlab = "",
#          ylab = "Global Active Power (kilowatts)",
#          type = "l")
#     )


### Plot 3: Quick and dirty
# plot(HH_Power_DateSlice$DateTime2, HH_Power_DateSlice$Sub_metering_1, type = "n" ,
#     main = "", 
#     xlab = "",
#     ylab = "Energy sub metering"
#     )
# legend("topright",
#       col = c("black", "red", "blue"),
#       lty = 1,
#       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
#       )
# lines(HH_Power_DateSlice$DateTime2, HH_Power_DateSlice$Sub_metering_1, col = "black" )
# lines(HH_Power_DateSlice$DateTime2, HH_Power_DateSlice$Sub_metering_2, col = "red"   )
# lines(HH_Power_DateSlice$DateTime2, HH_Power_DateSlice$Sub_metering_3, col = "blue"  )





### This did NOT work... lecture used type = n; followed by points(), so I will try lines()
### matlines(as.matrix(cbind(HH_Power_DateSlice$DateTime2,
###                         HH_Power_DateSlice$DateTime2,
###                         HH_Power_DateSlice$DateTime2)
###                   ),
###          as.matrix(cbind(HH_Power_DateSlice$Sub_metering_1,
###                          HH_Power_DateSlice$Sub_metering_2,
###                          HH_Power_DateSlice$Sub_metering_3)
###                    ), 
###          type = "l",
###          lty = 1,
###          col = c("black", "red", "blue"),
###          main = "",
###          xlab = "",
###          ylab = "Energy sub metering")
          
          



### Plot 4: Quick and dirty

# Four Plots on a Page

# par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
# par(cex = .20, mfrow = c(2, 2), mar = c(5, 5, 5, 1) )

# Subplot 1
# plot(HH_Power_DateSlice$DateTime2, HH_Power_DateSlice$Global_active_power, 
#      main = "", 
#     xlab = "",
#     ylab = "Global Active Power",
#     type = "l")
#    
# Subplot 2
# plot(HH_Power_DateSlice$DateTime2, HH_Power_DateSlice$Voltage, 
#     main = "", 
#     xlab = "datetime",
#     ylab = "Voltage",
#     type = "l")
    
# Subplot 3
# plot(HH_Power_DateSlice$DateTime2, HH_Power_DateSlice$Sub_metering_1, type = "n" ,
#     main = "", 
#     xlab = "",
#     ylab = "Energy Sub metering"
# )
# legend("topright",
#       col = c("black", "red", "blue"),
#       lty = 1,
#       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
# )
# lines(HH_Power_DateSlice$DateTime2, HH_Power_DateSlice$Sub_metering_1, col = "black" )
# lines(HH_Power_DateSlice$DateTime2, HH_Power_DateSlice$Sub_metering_2, col = "red"   )
# lines(HH_Power_DateSlice$DateTime2, HH_Power_DateSlice$Sub_metering_3, col = "blue"  )


# Subplot 4
# plot(HH_Power_DateSlice$DateTime2, HH_Power_DateSlice$Global_reactive_power,
#          main = "", 
#         xlab = "datetime",
#         ylab = "Global_reactive_power",
#         type = "h")

     
# restore default of one plot
# par(cex = .75, mfrow = c(1, 1), mar = c(4, 4, 2, 1))

### Need to split into one program for each of four plots, commit to Git
### and push to GitHub.

### End of: Tidy_EPA_National_Emissions_Inventory_Data.R