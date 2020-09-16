t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
t$Date <- as.Date(t$Date, "%d/%m/%Y")
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
t <- t[complete.cases(t),]

DateTime <- paste(t$Date, t$Time)
DateTime <- setNames(DateTime, "DateTime")
t <- t[ ,!(names(t) %in% c("Date","Time"))]

t <- cbind(DateTime, t)
t$DateTime <- as.POSIXct(DateTime)
plot(t$Global_active_power~t$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, "plot2.png",
         width  = 480,
         height = 480)

dev.off()

rm(list = ls())