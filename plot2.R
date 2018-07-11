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
graph.data <- zoo(eletric.consumption$Global_active_power, eletric.consumption$Date.time)

# Important: the x-axis ticks are system dependent (specially on the date-time locale of your computer)
# if you're not in USA, run this line prior to making the plot
# Sys.setlocale("LC_TIME", "English")

# open device
png("plot2.png", width = 480, height = 480)
# draw plot
plot(graph.data, ylab = "Global Active Power (kilowatts)", xlab = "")
# close device
dev.off()