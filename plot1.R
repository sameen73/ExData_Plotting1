#Reading in the data

#Saving the sub-section of data encompassing Feb 1 2007- Feb 2 2007 via grep function. Number of rows calculated via samples per day - 1 (1 sample a minute for 24 hours over 2 days = 2880)
#New data frame: p1_data
p1_data <- read.table("household_power_consumption.txt", skip = grep("1/2/2007", readLines("household_power_consumption.txt")), nrows = 2879, sep = ";")

#Assigning variable names to the data frame to improve readability
names(p1_data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#Transforming the Date and Time columns from separate factor variables to a single Posixct variable: big_time
combined_date_time <- paste(p1_data$Date, p1_data$Time)
big_time <- as.POSIXct(combined_date_time, format = "%d/%m/%Y %T")

#Binding the new big_time variable to the original dataframe: p1_data
p1_data <- cbind(p1_data, big_time)

#First plot code
#Opening the png device, setting some values needed for the project
png(filename = "plot1.png",width = 480, height = 480)

#Using the hist function to create the desired histogram with frequency of readings in kilowatts for 
#global active power.
hist(p1_data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#Turning off the device
dev.off()