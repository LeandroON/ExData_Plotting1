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
                         Sub_metering_2, Sub_metering_3),
                  eletric.consumption$Date.time)

# Important: the x-axis ticks are system dependent (specially on the date-time locale of your computer)
# if you're not in USA, run this line prior to making the plot
Sys.setlocale("LC_TIME", "English")

# open device
png("plot3.png", width = 480, height = 480)

# draw plot, one column at a time
plot(graph.data[,"Sub_metering_1"], xlab = "", ylab = "Energy sub metering")
lines(graph.data[,"Sub_metering_2"], col = "red")
lines(graph.data[,"Sub_metering_3"], col = "blue")
legend("topright", legend = names(graph.data), lty = 1, col = c("black", "red", "blue"))

# close device
dev.off()