library(tidyverse)
library(lubridate)

#Download and unzip file
if(!file.exists("./household_power_consumption.txt")){
  URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(URL,destfile="./powerzipfile.zip")
  unzip("./powerzipfile.zip",files = NULL, list = FALSE, overwrite = TRUE,junkpaths = FALSE, exdir = ".", unzip = "internal",
        setTimes = FALSE)
}

#Load the file
alldata<-read.csv("household_power_consumption.txt", sep = ";" ,dec = "." ,header=TRUE, stringsAsFactors = FALSE, na.strings="?", colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#Subset the data
data<-alldata[alldata$Date %in% c("1/2/2007","2/2/2007"),]

#Create datetime variable
datetime<-strptime(paste(data$Date, data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
data<-cbind(datetime,data)

#Plot 4
par(mfrow= c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~datetime, type="l", ylab="Global Active Power (kilowatts)",xlab="")
  plot(Voltage~datetime, type="l",ylab="Voltage",xlab="datetime")
  plot(Sub_metering_1~datetime, type="l", ylab="Energy sub metering",xlab="") 
  lines(Sub_metering_2~datetime,col="red") 
  lines(Sub_metering_3~datetime,col="blue")
  legend("topright",col=c("black","red","blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(Global_reactive_power~datetime, type="l")
})

#Save Plot as PNG File
dev.copy(png,file="plot4.png", height=480, width=480)
dev.off()
  
