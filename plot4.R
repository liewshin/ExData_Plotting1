#Installing Packages
if(!require(tidyverse)){
        install.packages("tidyverse")
}
library(tidyverse)

#Checking & Retrieving Data
filename <- "plottingdata.zip"
if(!file.exists(filename)){dir.create("filename")
        filedata <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(filedata, filename, method = "curl")
}

#Unzipping Data
if (!file.exists("plottingdata")){dir.create("plottingdata")
        plottingdata <- unzip(zipfile = filename, exdir = "plottingdata")
}

#Reading & Subsetting Data
powerconsumption <- read.table("plottingdata/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
subdata <- powerconsumption %>% filter(Date == "1/2/2007" | Date == "2/2/2007")
subdata$Global_active_power <- as.numeric(subdata$Global_active_power)
subdata$Date <- as.Date(subdata$Date, format = "%d/%m/%Y")
subdata$sequential <- paste(subdata$Date, subdata$Time, sep = " ")
subdata$sequential <- strptime(subdata$sequential, format = "%Y-%m-%d %H:%M:%S")

#Fourth Plot
png(file = "plot4.png")
par(mfcol = c(2,2))
plot(subdata$sequential, subdata$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
plot(subdata$sequential, subdata$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy Sub Metering")
points(subdata$sequential, subdata$Sub_metering_1, type = "l", col = "red")
points(subdata$sequential, subdata$Sub_metering_2, type = "l", col = "blue")
points(subdata$sequential, subdata$Sub_metering_3, type = "l", col = "green")
legend("topright", col = c("red", "blue", "green"), lty = 1, legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))
plot(subdata$sequential, subdata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(subdata$sequential, subdata$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")
dev.off()