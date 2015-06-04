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


# Create and Save Plot

png(filename="plot2.png")
plot(data$dateTime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
