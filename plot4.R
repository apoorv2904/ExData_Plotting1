## Clears workspace
rm(list = ls())

## Getting working data file 

fileUrl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile <- "household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"

if (!file.exists(dataFile)){
        #dir.create(destFile) ## unzip already creates the directory
        download.file(fileUrl, destfile = destFile, method = "auto")
        unzip(destFile)
}

# Reading data setting ? as NA
cols <- c( "factor","factor","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
df<-read.table("household_power_consumption.txt",sep=";",header = TRUE,na.strings = "?",colClasses = cols)

# Subsetting data to use the mentioned dates
df <- subset(df,df$Date=="1/2/2007" | df$Date=="2/2/2007")

# Converting Time as time data type and Date as date data type
df$Time<-paste(df$Date,df$Time,sep=" ")
df$Date=as.Date(df$Date,"%d/%m/%Y")
df$Time=strptime(df$Time, "%d/%m/%Y %H:%M:%S")

##----------------------------------------------------------------------------------------------------------
##----------------------------------------------------------------------------------------------------------

# Making Plot4 with multiple plots on one figure and saving as plot4.png

png("plot4.png")
par(mfrow=c(2,2))
plot(y=df$Global_active_power,x=df$Time,type='l',ylab="Global Active Power",xlab="")

plot(y=df$Voltage,x=df$Time,type='l',ylab="Voltage",xlab="datetime")

plot (y=df$Sub_metering_1,x=df$Time,col="black",type = 'l',ylab = "Energy sub metering",xlab = "")
lines (y=df$Sub_metering_2,x=df$Time,col="red")
lines (y=df$Sub_metering_3,x=df$Time,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c(1,2,4),lty = c(1,1,1))

plot(y=df$Global_reactive_power,x=df$Time,type='l',ylab="Global_reactive_power",xlab="datetime")
dev.off()
