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

#First Plot
png(file = "plot1.png")
hist(subdata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     breaks = 15)
dev.off()