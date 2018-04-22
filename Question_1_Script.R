

listofpackages <- c("dplyr", "ggplot2")
newPackages <- listofpackages[!(listofpackages %in% installed.packages()[,"Package"])]

if(length(newPackages)) install.packages(newPackages)

lapply(listofpackages, require, character.only = TRUE)



mainDir <- getwd()
subDir <- "Project_1"

dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
setwd(file.path(mainDir, subDir))
urlp <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url = urlp, destfile = "ProjectData.zip")
unzip("ProjectData.zip")

NEI <- readRDS("summarySCC_PM25.rds")
# to know the data structure
str(NEI)
SCC <- readRDS("Source_Classification_Code.rds")


##Question 1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
###Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
data_1 <- NEI %>% 
  group_by(year) %>% summarise(Total_Emission = sum(Emissions))

barplot(
  
  height = data_1$Total_Emission
  ,names.arg = data_1$year
  ,xlab = "Years"
  ,ylab = "Total PM2.5 Emission"
  ,main = "Total PM2.5 Emission By Year"
  ,col = "orange"
  ,border = NA
)
dev.copy(png, file ="plot1.png", height = 1000, width = 1000)
dev.off()
