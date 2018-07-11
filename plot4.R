# load required packages - if you don't have them installed, run install.packages() prior to this script

library(data.table)
library(dplyr)
library(zoo)

# set path of where the file containing the data is stored (working directory)
wd <- "D:/Users/ortiz/Documents/Data Science/data_science_specialization/eda_assignment1/"
setwd(wd)

# read data and filter for the dates of interest - make sure your computer has enough
# memory to run this part of the script
eletric.consumption <- fread("household_power_consumption.txt", na.strings = "?") %>%
  mutate(Date.time = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")) %>%
  filter(Date %in% c("1/2/2007", "2/2/2007"))

# create time-series object (using package zoo) for posterior plotting
graph.data <- zoo(select(eletric.consumption, Sub_metering_1,
                         Sub_metering_2, Sub_metering_3, Global_active_power,
                         Voltage, Global_reactive_power),
                  eletric.consumption$Date.time)

# open device
png("plot4.png", width = 480, height = 480)

# set parameter for 4 simultaneous plots, with 2 rows and 2 columns
par(mfrow = c(2,2))

# draw plot #1 - global active power
plot(graph.data[,"Global_active_power"], xlab = "", ylab = "Global Active Power")

# draw plot #2 - voltage
plot(graph.data[,"Voltage"], xlab = "datetime", ylab = "Voltage")

# draw plot #3 - Sub meterings, one column at a time
plot(graph.data[,"Sub_metering_1"], xlab = "", ylab = "Energy sub metering")
lines(graph.data[,"Sub_metering_2"], col = "red")
lines(graph.data[,"Sub_metering_3"], col = "blue")
legend("topright", legend = names(graph.data)[1:3], lty = 1, col = c("black", "red", "blue"),
       bty = "n")

# draw plot #4 - global reactive power
plot(graph.data[, "Global_reactive_power"], xlab = "datetime", ylab = names(graph.data)[6])

# close device
dev.off()

