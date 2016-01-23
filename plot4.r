## Download and unzip dataset file
if (!file.exists("household_power_consumption.txt")) {
  
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile = "household_power_consumption.zip")
  
  unzip("household_power_consumption.zip")
}

## read and make subset
dataRAW <- read.csv2("household_power_consumption.txt", na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F,dec = ".") 

dim(dataRAW) # 2075259 9

dataTidy <- subset(dataRAW, subset=(Date == "1/2/2007" | Date == "2/2/2007")) 

rm(dataRAW) 

## Converting dates 
dateTime <- paste(dataTidy$Date, dataTidy$Time)
dataTidy$DateTime <- strptime(dateTime, "%d/%m/%Y %H:%M:%S") 
rownames(dataTidy) <- 1:nrow(dataTidy) 

dim(dataTidy) # 2880   10

## Plot 4 
par(mfrow = c(2, 2)) 
## 1-Top-left 
plot(dataTidy$DateTime, 
     dataTidy$Global_active_power,  
     type = "l", 
     xlab = "", ylab = "Global Active Power") 

## 2-Top-right 
plot(dataTidy$DateTime, 
     dataTidy$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage") 

## 3-Bottom-left 
plot(dataTidy$DateTime, 
     dataTidy$Sub_metering_1,  
     type = "l", 
     col = "black", 
     xlab = "", ylab = "Energy sub metering") 

lines(dataTidy$DateTime, dataTidy$Sub_metering_2, col = "red") 
lines(dataTidy$DateTime, dataTidy$Sub_metering_3, col = "blue") 

# legend with no border 
legend("topright",
       bty = "n", 
       col = c("black", "red", "blue"), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1) 

## 4-Bottom-right 
plot(dataTidy$DateTime, 
     dataTidy$Global_reactive_power,  
     type = "l", 
     col = "black", 
     xlab = "datetime", 
     ylab = colnames(dataTidy)[4]) 

## Save to file 
dev.copy(png, file="plot4.png", height=480, width=480) 
dev.off() 
