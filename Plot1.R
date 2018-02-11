library(lubridate)
library(dplyr)
#### STEP 1 read the data from the file
#### na.strings='?' is used to replace missing data ? by a real NA

ElectricPower <- read.table("data/household_power_consumption.txt",header =TRUE,sep = ";",
                          colClasses=c("character","character",rep("numeric",7)),na.strings='?')

#### STEP 2 Convert column Date and Time to date and time values 
ElectricPower$Date <- dmy(ElectricPower$Date)                         
ElectricPower$Time <- hms(ElectricPower$Time) 

#### STEP 3 analysis only on data from 2007-02-01 and 2007-02-02
ElectricPower2days <- ElectricPower %>% filter(Date >="2007-02-01",Date <"2007-02-03")

png(filename = "Plot1.png",
    width = 480, height = 480, units = "px")
hist(ElectricPower2days$Global_active_power,col="red", main="Global Active Power", 
     xlab="Global active power (in kilowatt)")
dev.off() ## Close the PNG device


