# GetStateCodes.R
# Get State Codes (Postal Service and FIPS from EPA website)
# Jim Callahan (used StackOverFlow.com code)
# September 1, 2015

# Code (except for URL) from Stack Over Flow.
#  http://stackoverflow.com/questions/1395528/scraping-html-tables-into-r-data-frames-using-the-xml-package
# EPA website (with state codes) Nsuggested by Dr. Roger Peng
#  http://www.epa.gov/enviro/html/codes/state.html
    
require(XML)
theURL <- "http://www.epa.gov/enviro/html/codes/state.html"
tables <- readHTMLTable(theURL)
state.table = as.data.frame(tables)
ColumnNames <- c("USPS.code", "FIPS.code", "state.name")
colnames(state.table) <- ColumnNames
state.table
str(state.table)
