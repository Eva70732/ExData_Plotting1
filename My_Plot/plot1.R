library(sqldf)

consumption <- read.csv.sql('household_power_consumption.txt', 
                       sql="select * from file where Date == '1/2/2007' or Date == '2/2/2007'", 
                       header=TRUE,stringsAsFactors = FALSE,sep=';')

hist(consumption$Global_active_power, col='red', main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.copy(png, file = 'plot1.png', width=480, height=480)
dev.off()
