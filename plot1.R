# set global variables 
# get a working directory
local_path <- getwd()
#unziped_directory <- "/UCI HAR Dataset"
local_path_unziped <- file.path(local_path)
# url to get data for the project
data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# download the zip and rename file
download.file(data_url, file.path(local_path, "exdata_data_household_power_consumption.zip"))

# extract the content
unzip(zipfile = "exdata_data_household_power_consumption.zip")

# Load in data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings=c("NA", "?"))

# Get correct dates
data_2007 <- subset(data, Date %in% c("1/2/2007","2/2/2007"))

# Convert Date variable to datetime
data_2007$Date <- as.Date(data_2007$Date)

# Convert Global_active_power to numeric
data_2007$Global_active_power <- as.numeric(data_2007$Global_active_power)

# Open png file
png(filename="plot1.png")

# Create histogram
with(data_2007, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))

# Close connection
dev.off()
