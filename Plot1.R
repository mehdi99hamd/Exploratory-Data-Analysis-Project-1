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

#Plotting the histogram 
hist(table$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

# Save file and close device
dev.copy(png,"Plot1.png", width=480, height=480)
dev.off()