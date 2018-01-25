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

png(file = "plot2.png")
plot(x = data_sub$Date_Time, y = data_sub$Global_active_power, 
     type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
