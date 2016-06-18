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
png(filename = "plot2.png", height = 480, width=480, units = "px")

#plot the histogram with the proper color and titles
plot(household_power$DateTime, household_power$Global_active_power, 
     type = "l", ylab="Global Active Power (kilowatts)", xlab = "")

#close the device
dev.off()