#### This code reads in the relevant power consumption data for 1/2/2007 and 2/2/2007,
#### and generates the .png for plot3
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

## Create plot3 png
png(file = "plot3.png")
plot(meterData$Time, meterData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(meterData$Time, meterData$Sub_metering_2, col="red")
lines(meterData$Time, meterData$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

