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

#Plot 3
with(data,{
  plot(Sub_metering_1~datetime, type="l", ylab="Energy sub metering",xlab="") 
  lines(Sub_metering_2~datetime,col="red") 
  lines(Sub_metering_3~datetime,col="blue")
})
legend("topright",col=c("black","red","blue"), lwd=c(1,1,1),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Save Plot as PNG File
dev.copy(png,file="plot3.png", height=480, width=480)
dev.off()
