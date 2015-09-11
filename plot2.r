#### This code reads in the relevant power consumption data for 1/2/2007 and 2/2/2007,
#### and generates the .png for plot2
#### author: Sonia Lebofsky

## Ensure that the raw data "household_power_consumption.txt" is in working directory
## The raw data was opened in a text editor that could show line numbers (eg. Textmate)
## and inpsected to determine row number for start of 1/2/2007, and number of rows until
## end of 2/2/2007.
##
## Read in data for only the two days 1/2/2007 - 2/2/2007
meterData <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", skip = 66637, nrows = 2880, na.strings = "?")

## Read in one row of data set just to get header names
forHeader <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 1, na.strings = "?")
colnames(meterData) <- colnames(forHeader)
rm(forHeader)

## Convert Date and Time factor variables to date variable and POSIXct (time) variable
meterData$Date <- as.Date(meterData$Date, "%d/%m/%Y")
meterData$Time <- strptime(paste(meterData$Date, meterData$Time, sep = " "), "%Y-%m-%d %H:%M:%S")

## Create plot2 png
png(file = "plot2.png")
plot(meterData$Time, meterData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

