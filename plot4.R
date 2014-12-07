## This code generates graphics file "plot4.png" for Exploratory Data Analysis Course Project 1.
## This is what the data file looks like (the first two rows):
## Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
## 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000

# Read full file (not yet implemented to be fast, but good enough);
# and extract all but Global_intensity column.
data <- read.table("household_power_consumption.txt", 
                   header = TRUE,
                   sep = ";",
                   na.strings = c("NA", "-", "?"),
                   colClasses = c("character", "character", rep("numeric",7))
)[c(1,2,3,4,5,7,8,9)]

# Extract data for February 1 and 2, 2007 (2*24*60 = 2880 data rows)
Feb0102Data <- data[which(data$Date=="1/2/2007" | data$Date=="2/2/2007"), ]

# Merge date and time columns into the Time column. (Eliminate Date column.)
Feb0102Data$Time <- paste(Feb0102Data$Date, Feb0102Data$Time)
Feb0102Data <- Feb0102Data[ , 2:8]
# Re-format the Time column as POSIX in a new column.
Feb0102Data$ClockReadings<- as.POSIXlt(
    strptime(Feb0102Data$Time, format="%d/%m/%Y %H:%M:%S")
    )
# Check the revised data frame.
# head(Feb0102Data)

# Get vector of clock readings (POSIX times).
clockreadings <- as.vector(Feb0102Data[, "ClockReadings"])

# Get the vertical variable values for the various plots
GAP <- as.numeric(as.vector(Feb0102Data[, "Global_active_power"]))
subMetering1 <- as.numeric(as.vector(Feb0102Data[, "Sub_metering_1"]))
subMetering2 <- as.numeric(as.vector(Feb0102Data[, "Sub_metering_2"]))
subMetering3 <- as.numeric(as.vector(Feb0102Data[, "Sub_metering_3"]))
voltage <- as.numeric(as.vector(Feb0102Data[, "Voltage"]))
GRP <- as.numeric(as.vector(Feb0102Data[, "Global_reactive_power"]))

## Open PNG device; create 'plot4.png' in working directory.
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(5,5,3,1), oma = c(1, 2, 1, 2))
{
    plot(clockreadings,GAP,
         type = "l",
         xlab = "",
         ylab = "Global Active Power",
         main = "")
    plot(clockreadings, voltage,
         type = "l",
         xlab = "datetime",
         ylab = "Voltage",
         main = "")
    {plot(clockreadings, subMetering1,
      type = "l", col = "black", xlab = "",
      ylab = "Energy sub metering",
      main = "")
    lines(clockreadings, subMetering2,
       type="l", col="red", xlab = "", ylab = "")
    lines(clockreadings, subMetering3,
       type="l", col= "blue", xlab = "", ylab = "")
     legend("topright",
        lty = 1, bty = "n",
        col = c("black", "red", "blue"),
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    }
    plot(clockreadings, GRP,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     main = "")
}
dev.off() ## Close the PNG file device.






