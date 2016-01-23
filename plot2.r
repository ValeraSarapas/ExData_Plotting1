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


## Plot 2 
plot(dataTidy$DateTime, 
     dataTidy$Global_active_power,
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)") 

## Save to file 
dev.copy(png, file="plot2.png", height=480, width=480) 
dev.off() 
