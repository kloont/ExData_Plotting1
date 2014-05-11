#Reading and subsetting of the file
myFile<-"household_power_consumption.txt"
require ("sqldf")
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv.sql(myFile,mySql,header=TRUE,sep=";")


#Converts and combines "Data"and "Time" columns to "%Y-%m-%d %H:%M:%S" format)
myData$Date<-as.Date(myData$Date, "%d/%m/%Y")
myTime<-paste(myData$Date,myData$Time)
myTime2<-strptime(myTime,"%Y-%m-%d %H:%M:%S")

#Decides which sub-metering has the highest value to set the limit of y-axis of Graph 3

sub1<-max(myData$Sub_metering_1)
sub2<-max(myData$Sub_metering_2)
sub3<-max(myData$Sub_metering_3)

maxsub<-which.max(c(sub1,sub2,sub3))
maxsubindex<-6+maxsub
maxsubdata<-myData[,maxsubindex]


#Plots the graph
par(mfrow=c(2,2))
#Graph 1
plot(myTime2,myData$Global_active_power, xlab="",ylab="Global Active Power",type="l")
#Graph 2
plot(myTime2,myData$Voltage, xlab="datetime",ylab="Voltage",type="l")
#Graph 3
plot(myData$myTime2,maxsubdata,type ="n", xlab="",ylab="Energy sub metering")
lines(myData$myTime2,myData$Sub_metering_1, col="black")
lines(myData$myTime2,myData$Sub_metering_2, col="red")
lines(myData$myTime2,myData$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),col=c("black","red","blue"),bty="n",lty=c(1,1,1))
#Graph 4
plot(myTime2,myData$Global_reactive_power, xlab="datetime",ylab="Global_reactive_power",type="l")

#Output to png file
png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2))
#Graph 1
plot(myTime2,myData$Global_active_power, xlab="",ylab="Global Active Power",type="l")
#Graph 2
plot(myTime2,myData$Voltage, xlab="datetime",ylab="Voltage",type="l")
#Graph 3
plot(myData$myTime2,maxsubdata,type ="n", xlab="",ylab="Energy sub metering")
lines(myData$myTime2,myData$Sub_metering_1, col="black")
lines(myData$myTime2,myData$Sub_metering_2, col="red")
lines(myData$myTime2,myData$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),col=c("black","red","blue"),bty="n",lty=c(1,1,1))
#Graph 4
plot(myTime2,myData$Global_reactive_power, xlab="datetime",ylab="Global_reactive_power",type="l")

dev.off()
