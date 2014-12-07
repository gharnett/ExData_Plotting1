## This code generates graphics file "plot2.png" for Exploratory Data Analysis Course Project 1.
## This is what the data file looks like (the first two rows):
## Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
## 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000

# Read full file (not yet implemented to be fast, but good enough);
# and extract Date, Time, and Global_active_power columns (1, 2, and 3).
data <- read.table("household_power_consumption.txt", 
                   header = TRUE,
                   sep = ";",
                   na.strings = c("NA", "-", "?"),
                   colClasses = c( "character", "character", rep("numeric",7))
)[c(1,2,3)]

# Extract data for February 1 and 2, 2007 (2*24*60 = 2880 data rows)
Feb0102TimeAndGAP <- data[which(data$Date=="1/2/2007" | data$Date=="2/2/2007"), ]

# Merge date and time columns into the Time column. (Eliminate Date column.)
Feb0102TimeAndGAP$Time <- paste(Feb0102TimeAndGAP$Date, Feb0102TimeAndGAP$Time)
Feb0102TimeAndGAP <- Feb0102TimeAndGAP[ ,2:3]
# Format DateTime column as POSIX date, and make new column.
Feb0102TimeAndGAP$DateTimePosIx <- as.POSIXlt(
    strptime(Feb0102TimeAndGAP$Time, format="%d/%m/%Y %H:%M:%S")
)
# Check revised data frame.
# head(Feb0102TimeAndGAP)

# Get clockreadings.
clockreadings <- as.vector(Feb0102TimeAndGAP[, 3])
# Get GAP values.
GAPValues <- as.numeric(as.vector(Feb0102TimeAndGAP[, 2]))

## Open PNG device; create 'plot2.png' in working directory.
png(file = "plot2.png", width = 480, height = 480) 
plot(clockreadings, GAPValues,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     main = ""
     )
dev.off() ## Close the PNG file device.




