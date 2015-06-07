library(sqldf)

consumption <- read.csv.sql('household_power_consumption.txt', 
                            sql="select * from file where Date == '1/2/2007' or Date == '2/2/2007'", 
                            header=TRUE,stringsAsFactors = FALSE,sep=';')

Date  <- as.Date(consumption$Date, "%e/%m/%Y")
DateTime <- as.POSIXct(paste(Date, consumption$Time))

mydata <- data.frame(DateTime = DateTime, ActivePower = consumption$Global_active_power,
                     SM1 = consumption$Sub_metering_1, SM2 = consumption$Sub_metering_2,
                     SM3 = consumption$Sub_metering_3, Voltage = consumption$Voltage,
                     ReactivePower = consumption$Global_reactive_power)

par(mfcol = c(2,2))
par(mar = c(4,4,1,1))

#first topleft plot
plot(mydata$DateTime, mydata$ActivePower, type='l', 
     xlab = "", ylab = "Global Active Power")

#second bottomleft plot
plot(mydata$DateTime, mydata$SM1, type='l', xlab = "", ylab = "Energy sub metering")
lines(mydata$DateTime, mydata$SM2, col = 'red')
lines(mydata$DateTime, mydata$SM3, col = 'blue')

legend('topright', legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), 
       lty = 1, lwd = 3, col = c('black', 'red', 'blue'), cex=0.8, box.lty=0)


#third topright plot
plot(mydata$DateTime, mydata$Voltage, type='l', 
     xlab = "datetime", ylab = "Voltage")

#fourth bottomright plot
plot(mydata$DateTime, mydata$ReactivePower, type='l', 
     xlab = "datetime", ylab = "Global_reactive_power")

dev.copy(png, file = 'plot4.png', width=480, height=480)
dev.off()

