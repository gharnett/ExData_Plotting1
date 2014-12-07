## This code generates graphics file "plot2.png" for Exploratory Data Analysis Course Project 1.
## This is what the data file looks like (the first two rows):
## Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
## 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000

# Read full file (not yet implemented to be fast, but good enough);
# and extract Date, Time, and Submetering columns (1, 2, 7, 8, and 9).
data <- read.table("household_power_consumption.txt", 
                   header = TRUE,
                   sep = ";",
                   na.strings = c("NA", "-", "?"),
                   colClasses = c("character", "character", rep("numeric",7))
)[c(1,2,7,8,9)]

# Extract data for February 1 and 2, 2007 (2*24*60 = 2880 data rows).
subMetering <- data[which(data$Date=="1/2/2007" | data$Date=="2/2/2007"), ]

# Merge Date and Time columns into the Time column. (Eliminate Date column.)
subMetering$Time <- paste(subMetering$Date, subMetering$Time)
subMetering <- subMetering[ , 2:5]
# Re-format the Time column as POSIX in a new column.
subMetering$Time <- as.POSIXlt(
    strptime(subMetering$Time, format="%d/%m/%Y %H:%M:%S")
)
# Check revised data frame.
# head(subMetering)

# Get clockreadings.
clockreadings <- as.vector(subMetering[, 1])
# Get Sub-Metering values.
subMetering1 <- as.numeric(as.vector(subMetering[, 2]))
subMetering2 <- as.numeric(as.vector(subMetering[, 3]))
subMetering3 <- as.numeric(as.vector(subMetering[, 4]))

# Open PNG device; create 'plot3.png' in working directory
png(file = "plot3.png", width = 480, height = 480) 
plot(clockreadings, subMetering1,
     type = "l", col = "black", xlab = "",
     ylab = "Energy sub metering",
     main = "")
lines(clockreadings, subMetering2,
      type="l", col="red", xlab = "", ylab = "")
lines(clockreadings, subMetering3,
      type="l", col= "blue", xlab = "", ylab = "")
legend("topright",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off() ## Close the PNG file device




