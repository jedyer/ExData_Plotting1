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
alldata$Date<-as.Date(alldata$Date, format= "%d/%m/%Y")

#Subset the data
data<-filter(alldata,Date >= "2007-02-01" & Date <= "2007-02-02")

#Plot 1
hist(data$Global_active_power, main= "Global Active Power",xlab= "Global Active Power (kilowatts)",col="red")

#Save Plot as PNG file
dev.copy(png,file="plot1.png", height=480, width=480)
dev.off()
