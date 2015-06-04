library(lubridate)


# Read and Format Source Data

sourceData <- read.table("household_power_consumption.txt",header=TRUE,sep=";",colClasses=c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),na.strings="?")

sourceData$dateTime <- do.call(paste,as.data.frame(sourceData[,1:2],stringsAsFactors=FALSE))
sourceData$dateTime <- strptime(sourceData$dateTime, format="%d/%m/%Y %T")

sourceData$Date <- NULL
sourceData$Time <- NULL


# Subset Source Data

startTime <- strptime("01/02/2007 00:00:00", format="%d/%m/%Y %T")
endTime <- strptime("03/02/2007 00:00:00", format="%d/%m/%Y %T")
data <- subset(sourceData,dateTime>=startTime & dateTime<endTime)


# Create and Save Plots

png(filename="plot4.png")
par(mfrow=c(2,2))

# Create 1st Plot

plot(data$dateTime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power")

# Create 2nd Plot

plot(data$dateTime,data$Voltage,type="l",ylab="Voltage",xlab='datetime')

# Create 3rd Plot

plot(data$dateTime,data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(data$dateTime,data$Sub_metering_2,col="red")
lines(data$dateTime,data$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1",'Sub_metering_2','Sub_metering_3'),lty=1,col=c("black","red","blue"))

# Create 4th Plot
 
plot(data$dateTime,data$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab='datetime')

dev.off()
