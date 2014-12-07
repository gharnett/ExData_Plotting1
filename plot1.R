## This code generates graphics file "plot4.png" for Exploratory Data Analysis Course Project 1.
## This is what the data file looks like (the first two rows):
## Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
## 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000

# Read full file (not yet implemented to be fast, but good enough);
# and extract Date and Global_active_power columns (1 and 3).
data <- read.table("household_power_consumption.txt", 
                   header = TRUE,
                   sep = ";",
                   na.strings = c("NA", "-", "?"),
                   colClasses = c("character", "character", rep("numeric",7))
)[c(1, 3)]

# Extract data for February 1 and 2, 2007 (2*24*60 = 2880 data rows)
Feb0102GlobalActivePower <- data[which(data$Date=="1/2/2007" | data$Date=="2/2/2007"), ]

# Check the data frame.
# dim(Feb0102GlobalActivePower)
# head(Feb0102GlobalActivePower)

# Get GAP values in a vector.
Feb0102GAPValues <- as.numeric(as.vector(Feb0102GlobalActivePower[, 2]))

## Open PNG device; create 'plot1.png' in working directory.
png(file = "plot1.png", width = 480, height = 480)
hist(Feb0102GAPValues,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power"
     )
dev.off() ## Close the PNG file device.



