# Load SQL library in order to filter the data set
library(sqldf)

# Load filtered data from the data file
ds <- read.csv.sql(file = "hpc.txt", sep = ";", header = TRUE , sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'")

# Change column data type to numeric
ds$gap <- as.numeric(ds$Global_active_power)
ds$dt  <- strptime(paste(ds$Date, ds$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# Create PNG graphic device
png("plot2.png", width=480, height=480)

# Generate graph
with(ds, plot(dt, gap, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

# Reset the device
dev.off()