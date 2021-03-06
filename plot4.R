library(lubridate)
library(dplyr)

#### STEP 1 read the data from the file
#### na.strings='?' is used to replace missing data ? by a real NA

ElectricPower <- read.table("data/household_power_consumption.txt",header =TRUE,sep = ";",
                            colClasses=c("character","character",rep("numeric",7)),na.strings='?')

#### STEP 2 Convert column Date and Time to date and time values 

ElectricPower$DateTime <- dmy_hms(paste(ElectricPower$Date,ElectricPower$Time))
ElectricPower$Date <- dmy(ElectricPower$Date) 

#### STEP 3 analysis only on data from 2007-02-01 and 2007-02-02
ElectricPower2days <- ElectricPower %>% 
  filter(Date >="2007-02-01",Date <"2007-02-03") 
png(filename = "Plot4.png",
    width = 480, height = 480, units = "px")
par(mfrow = c(2, 2),mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(ElectricPower2days$DateTime,ElectricPower2days$Global_active_power, type="l",
     ylab="Global active power (in kilowatt)",
     xlab="")

plot(ElectricPower2days$DateTime,ElectricPower2days$Voltage, type="l",
     xlab="datetime",
     ylab="Voltage")

plot(ElectricPower2days$DateTime,ElectricPower2days$Sub_metering_1, 
     type = "n",
     ylab="Energy sub metering",xlab="")

points(ElectricPower2days$DateTime,ElectricPower2days$Sub_metering_1, type="l")
points(ElectricPower2days$DateTime,ElectricPower2days$Sub_metering_2, type="l",
       col="red")
points(ElectricPower2days$DateTime,ElectricPower2days$Sub_metering_3, type="l",
       col="blue")
legend("topright",  lty=1, cex = 0.70, bty = "n",col = c("black","blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
plot(ElectricPower2days$DateTime,ElectricPower2days$Global_reactive_power, type="l",
     xlab="datetime",
     ylab="Global_reactive_power")



dev.off() ## Close the PNG device
