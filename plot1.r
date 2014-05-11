#Reading and subsetting of the file
myFile<-"household_power_consumption.txt"
require ("sqldf")
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv.sql(myFile,mySql,header=TRUE,sep=";")




#Plots the graph
hist(myData$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")


#Output to png file
png(file="plot1.png",width=480,height=480)
hist(myData$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()
