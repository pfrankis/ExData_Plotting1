# Read the data being careful to treat ? as NA
household_power <- read.table("household_power_consumption.txt",
                              sep=";", na.strings = "?",
                              header = TRUE,
                              stringsAsFactors = FALSE)
#change the date field into PosixLt type
household_power$Date <- strptime(household_power$Date, "%d/%m/%Y")

# subset the data into the range we care about
household_power <- subset(household_power, 
                          Date >= as.POSIXlt("2007-02-01") & 
                          Date <= as.POSIXlt("2007-02-02") )

#create a png device with the proper name and dimensions
png(filename = "plot1.png", height = 480, width=480, units = "px")

#plot the histogram with the proper color and titles
hist(household_power$Global_active_power, col="red", 
     main = "Global Active Power", 
     xlab= "Global Active Power (kilowatts)")

#close the device
dev.off()