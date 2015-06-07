library(sqldf)

consumption <- read.csv.sql('household_power_consumption.txt', 
                            sql="select * from file where Date == '1/2/2007' or Date == '2/2/2007'", 
                            header=TRUE,stringsAsFactors = FALSE,sep=';')

Date  <- as.Date(consumption$Date, "%e/%m/%Y")
DateTime <- as.POSIXct(paste(Date, consumption$Time))

mydata <- data.frame(DateTime=DateTime, 
                     SM1=consumption$Sub_metering_1, 
                     SM2 = consumption$Sub_metering_2, 
                     SM3 = consumption$Sub_metering_3)

par(mar=c(4,4,1,1))
plot(mydata$DateTime, mydata$SM1, type='l', xlab = "", ylab = "Energy sub metering")
lines(mydata$DateTime, mydata$SM2, col = 'red')
lines(mydata$DateTime, mydata$SM3, col = 'blue')

legend('topright', legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), 
       lty = 1, lwd = 3, col = c('black', 'red', 'blue'), cex=0.6)

dev.copy(png, file = 'plot3.png', width=480, height=480)
dev.off()

