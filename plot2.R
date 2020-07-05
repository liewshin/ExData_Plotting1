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

#Second Plot
subdata$Date <- as.Date(subdata$Date, format = "%d/%m/%Y")
subdata$sequential <- paste(subdata$Date, subdata$Time, sep = " ")
subdata$sequential <- strptime(subdata$sequential, format = "%Y-%m-%d %H:%M:%S")
png(file = "plot2.png")
plot(subdata$sequential, subdata$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
