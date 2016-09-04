# Load SQL library in order to filter the data set
library(sqldf)

# Load filtered data from the data file
ds <- read.csv.sql(file = "hpc.txt", sep = ";", header = TRUE , sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'")

# Change column data type to numeric
ds$gap <- as.numeric(ds$Global_active_power)
ds$dt  <- strptime(paste(ds$Date, ds$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
ds$sm1 <- as.numeric(ds$Sub_metering_1)
ds$sm2 <- as.numeric(ds$Sub_metering_2)
ds$sm3 <- as.numeric(ds$Sub_metering_3)

# Create PNG graphic device
png("plot3.png", width=480, height=480)

# Generate graph
with(ds, plot(dt,sm1,type="l", ylab="Energy Submetering", xlab=""))
with(ds, lines(dt, sm2, type="l", col="red"))
with(ds, lines(dt, sm3, type="l", col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# Reset the device
dev.off()