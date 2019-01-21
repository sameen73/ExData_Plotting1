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

#Second plot code

#Opening the png device
png(filename = "plot2.png")

#Using the plot function within the with function to create a linegraph of date vs global active power in kilowatts.
with(p1_data, plot(big_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

#Turning off the device
dev.off()