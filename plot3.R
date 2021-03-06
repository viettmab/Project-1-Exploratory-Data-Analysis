t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
t$Date <- as.Date(t$Date, "%d/%m/%Y")
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
t <- t[complete.cases(t),]

DateTime <- paste(t$Date, t$Time)
DateTime <- setNames(DateTime, "DateTime")
t <- t[ ,!(names(t) %in% c("Date","Time"))]

t <- cbind(DateTime, t)
t$DateTime <- as.POSIXct(DateTime)

png("plot3.png",
    width  = 480,
    height = 480)

plot(Sub_metering_1 ~ DateTime, t, type = "l",
     ylab = "Energy sub metering",
     xlab = NA)

lines(Sub_metering_2 ~ DateTime, t, type = "l", col = "red")
lines(Sub_metering_3 ~ DateTime, t, type = "l", col = "blue")

legend("topright",
       col = c("black",
               "red",
               "blue"),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       lty = 1)

dev.off()

rm(list = ls())
