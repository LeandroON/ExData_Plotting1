# load required packages - if you don't have them installed, run install.packages() prior to this script

library(data.table)
library(dplyr)

# set path of where the file containing the data is stored (working directory)
wd <- "D:/Users/ortiz/Documents/Data Science/data_science_specialization/eda_assignment1/"
setwd(wd)

# read data and filter for the dates of interest - make sure your computer has enough
# memory to run this part of the script
eletric.consumption <- fread("household_power_consumption.txt", na.strings = "?") %>%
  mutate(Date.time = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")) %>%
  filter(Date %in% c("1/2/2007", "2/2/2007"))

#open device
png("plot1.png", width = 480, height = 480)
# draw plot
hist(eletric.consumption$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
# close device
dev.off()
