# pngcode.R
# Sample code for saving plots as .png file type

# ORIGINAL: From R helpfile for png() (type ?png at the console)
png(filename = "Rplot%03d.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"), antialias)

# code for plot goes here
dev.off()

# MODIFIED FOR ASSIGNMENT (changed filename)
# defaults are ppi = 72, width= 480, height = 480
# implicitly this is  ( ppi = 72, height = 6.6*ppi, width = 6.6*ppi)
# might want to try   (ppi = 150, height = 3*ppi, width=3*ppi)
# assign ppi outside of plot as in ppi<- 300
# See also Winston Chang's "R Graphics Cookbook" pages 327-329
# Calculate the height and width (in pixels) for a 3x3-inch image at 150 dpi

png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12)

# code for plot goes here
dev.off()
