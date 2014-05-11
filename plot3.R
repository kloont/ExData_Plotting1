#Reading and subsetting of the file
myFile<-"household_power_consumption.txt"
require ("sqldf")
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv.sql(myFile,mySql,header=TRUE,sep=";")

#Converts and combines "Data"and "Time" columns to "%Y-%m-%d %H:%M:%S" format)
myData$Date<-as.Date(myData$Date, "%d/%m/%Y")
myTime<-paste(myData$Date,myData$Time)
myTime2<-strptime(myTime,"%Y-%m-%d %H:%M:%S")
myData$myTime2<-myTime2

#Decides which sub-metering has the highest value to set the limit of y-axis

sub1<-max(myData$Sub_metering_1)
sub2<-max(myData$Sub_metering_2)
sub3<-max(myData$Sub_metering_3)

maxsub<-which.max(c(sub1,sub2,sub3))
maxsubindex<-6+maxsub
maxsubdata<-myData[,maxsubindex]


#Plots the graph
plot(myData$myTime2,maxsubdata,type ="n", xlab="",ylab="Energy sub metering")
lines(myData$myTime2,myData$Sub_metering_1, col="black")
lines(myData$myTime2,myData$Sub_metering_2, col="red")
lines(myData$myTime2,myData$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))

#Output to png file
png(file="plot3.png", width = 480, height = 480)
plot(myData$myTime2,maxsubdata,type ="n", xlab="",ylab="Energy sub metering")
lines(myData$myTime2,myData$Sub_metering_1, col="black")
lines(myData$myTime2,myData$Sub_metering_2, col="red")
lines(myData$myTime2,myData$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))
dev.off()
