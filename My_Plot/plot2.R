library(sqldf)

consumption <- read.csv.sql('household_power_consumption.txt', 
                            sql="select * from file where Date == '1/2/2007' or Date == '2/2/2007'", 
                            header=TRUE,stringsAsFactors = FALSE,sep=';')

Date  <- as.Date(consumption$Date, "%e/%m/%Y")
DateTime <- as.POSIXct(paste(Date, consumption$Time))

mydata <- data.frame(DateTime=DateTime, Power=consumption$Global_active_power)

plot(mydata$DateTime, mydata$Power, type='l', 
     xlab = "", ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = 'plot2.png', width=480, height=480)
dev.off()