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

#Fourth plot code

#Opening the png device
png(filename = "plot4.png")

#Using the par function to specify a 2 x 2 matrix of plots
par(mfrow = c(2,2))

#First subplot
plot(p1_data$big_time, p1_data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

#Second subplot
plot(p1_data$big_time, p1_data$Voltage, type= "l", xlab = "datetime", ylab = "Voltage")

#Third subplot
plot(p1_data$big_time, p1_data$Sub_metering_1, type = "l", ylab = "Energy Sub Metering", xlab = "" )
par(new= TRUE)
plot(p1_data$big_time, p1_data$Sub_metering_2, type = "l", xlab = "", ylab = "", ylim = range(p1_data$Sub_metering_1), col = "red")
par(new= TRUE)
plot(p1_data$big_time, p1_data$Sub_metering_3, type = "l", xlab = "", ylab = "", ylim = range(p1_data$Sub_metering_1), col = "blue")
legend("topright",c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"),lty = 1,bty = "n", col = c("black", "red", "blue"))

#Fourth subplot
plot(p1_data$big_time, p1_data$Global_reactive_power, type = "l", xlab = "datetime", ylab= "Global Reactive Power")

#Turning the device off.
dev.off()