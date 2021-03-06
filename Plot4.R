setwd("D:/Auto_formation/Coursera_Exploratory_Data_Analysis/Project 1")

# Importing The LIbrairies
library(tidyr)

# Importing The Dataset
table <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

# Format date to Type Date
table$Date <- as.Date(table$Date, "%d/%m/%Y")

# subset data from Feb. 1, 2007 to Feb. 2, 2007
table <- subset(table,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Remove incomplete observation
table %>% drop_na()

# Combine Date and Time column
dateTime <- paste(table$Date, table$Time)
names(dateTime) <- "DateTime"

# Remove Date and Time column
table <- subset(table, select = -c(Date,Time))

# Add DateTime column
table <- cbind(dateTime, table)

# Format dateTime Column
table$dateTime <- as.POSIXct(dateTime)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(table, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

# Save file and close device
dev.copy(png,"Plot4.png", width=480, height=480)
dev.off()