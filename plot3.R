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

# Convert date and time and save as new variable
data_2007$newdate <- as.POSIXct(paste(data_2007$Date, data_2007$Time), format="%d/%m/%Y %H:%M:%S")

# Open png
png(filename="plot3.png")

# Create plot
plot(Sub_metering_1 ~ newdate, data=data_2007, type="l", col="black", ylab="Energy sub metering", xlab="")
lines(Sub_metering_2 ~ newdate, data=data_2007, type="l", col="red")
lines(Sub_metering_3 ~ newdate, data=data_2007, type="l", col="blue")

# Add legend
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering1", "Sub_metering_2", "Sub_metering_3"), lty=1)

# Close connection
dev.off()
