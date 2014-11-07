# This R script readys the household_power_consumption.txt file provided by Coursera as a downloadable dataset 
# and sourced from the UC Irvine Machine Learning Repository (http://archive.ics.uci.edu/ml/).

# The script transforms the separate date and time character variables to a combined datetime variable of time posixlt
# The script subsets observations relating to 01/02/2007 and 02/02/2007 only
# The script transforms null values represented as '?' to NA before omitting them from the results to be plotted
# The script plots a line graph of the Global Active Power results and writes it to plot2.png in the current working directory

#set the working directory to the source of the downloaded dataset
setwd("C:/Users/Kate/Documents/coursera/electric")

# Read in the source file, specifying header present and na strings represented as "?" characters
mydata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

#convert the date variable from a string to a date
mydata[,1] <- as.Date(mydata[,1], format="%d/%m/%Y") 

#concatonate the date and time variables and reformat to posixlt format
mydata$datetime <-strptime(paste(mydata[,1],mydata[,2]), format="%Y-%m-%d %H:%M:%S") 

# subset readings from 01/02/2007 and 02/02/2007
mydata2 <- mydata[mydata$datetime >= "2007-02-01" & mydata$datetime < "2007-02-03",]

#remove the NA values
mydata3 <- na.omit(mydata2) 

# open the plot2.png output device
png("plot2.png", width=480, height=480)

# Create the graph without plotting the points, set the x / y labels as "" and "Global Active Power (kilowatts)" respectively
plot(mydata3$datetime, mydata3$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")

# Add lines to the plot
lines(mydata3$datetime, mydata3$Global_active_power)

# close the output device
dev.off()
