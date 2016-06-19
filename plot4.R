# Read the data being careful to treat ? as NA
household_power <- read.table("household_power_consumption.txt",
                              sep=";", na.strings = "?",
                              header = TRUE,
                              stringsAsFactors = FALSE)

#create a new field that combines Date and Time
household_power$DateTime <- paste(household_power$Date, 
                                  household_power$Time)

#convert that new field into POSIXlt type
household_power$DateTime <- strptime(household_power$DateTime, "%d/%m/%Y %H:%M:%S")

# subset the data into the range we care about
household_power <- subset(household_power, 
                           DateTime >= as.POSIXlt("2007-02-01") & 
                           DateTime < as.POSIXlt("2007-02-03") )

#create a png device with the proper name and dimensions
png(filename = "plot4.png", height = 480, width=480, units = "px")

# set up the layout for 2 rows, 2 columns and smaller margins
par(mfrow= c(2,2), mar = c(4,4,1,1) )

#plot the different plots with the proper color and titles
with(household_power, plot(DateTime, Global_active_power, 
                           type = "l", 
                           ylab= "Global Active Power",
                           xlab = ""))

with(household_power, plot(DateTime, Voltage, 
                           type = "l", 
                           ylab= "Voltage", 
                           xlab = "datetime"))

with(household_power, plot(DateTime, Sub_metering_1, type = "l", 
                           col = "black", xlab="", 
                           ylab = "Energy Sub Metering"))

with(household_power, lines(DateTime, Sub_metering_2, col="red"))


with(household_power, lines(DateTime, Sub_metering_3, col="blue"))

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"), 
       col = c("black", "red", "blue"),lty = 1)


with(household_power, plot(DateTime, Global_reactive_power, 
                           type = "l", 
                           ylab= "Global_reactive_power",
                           xlab = "datetime"))


#close the device
dev.off()