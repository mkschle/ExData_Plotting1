# read the data

data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(data_url, destfile = "data.zip")
unzip("data.zip")

data <- read.table ("household_power_consumption.txt", header =TRUE, na.strings = "?", sep = ";", stringsAsFactors = F)

# Clean the data and get it ready to plot
data$Date_Time <- paste(data$Date, data$Time)
# Below formula is to tell R how to read date (day, month, date)
data$Date_Time <- as.POSIXct(data$Date_Time, format = "%d/%m/%Y %H:%M:%S")
#Only looking to extract Feb 1 and 2nd of 2007 data
limit <- as.POSIXct(c("1/2/2007", "3/2/2007"), format = "%d/%m/%Y")

# data$Date_Time >= limit[1] 
# data$Date_Time < limit[2]
# plot(data$Date_Time >= limit[1] & data$Date_Time < limit[2])

# Get the subset of the data

data_sub <- subset(data, data$Date_Time >= limit[1] & data$Date_Time < limit[2])

par(mfrow = c(2, 2))
plot(x = data_sub$Date_Time, y = data_sub$Global_active_power, 
      type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(x = data_sub$Date_Time, y = data_sub$Voltage, type = "l")
plot(x = data_sub$Date_Time, y = data_sub$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines (x = data_sub$Date_Time, y = data_sub$Sub_metering_2, col = "red")
lines (x = data_sub$Date_Time, y = data_sub$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering 1", "Sub_metering 2", "Sub_metering 3"),
       col = c("black", "red", "blue"), lty = 1)
plot(x = data_sub$Date_Time, y = data_sub$Global_reactive_power, type = "l")
dev.off()

