#Reading and subsetting of the file
myFile<-"household_power_consumption.txt"
require ("sqldf")
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv.sql(myFile,mySql,header=TRUE,sep=";")


#Converts and combines "Data"and "Time" columns to "%Y-%m-%d %H:%M:%S" format)
myData$Date<-as.Date(myData$Date, "%d/%m/%Y")
myTime<-paste(myData$Date,myData$Time)
myTime2<-strptime(myTime,"%Y-%m-%d %H:%M:%S")

#Plots the graph
plot(myTime2,myData$Global_active_power, xlab="",ylab="Global Active Power (kilowatts)",type="l")


#Output to png file
png(file="plot2.png",width=480,height=480)
plot(myTime2,myData$Global_active_power, xlab="",ylab="Global Active Power (kilowatts)",type="l")
dev.off()
