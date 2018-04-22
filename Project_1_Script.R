

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

##Question 2
##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
##Use the base plotting system to make a plot answering this question.
library("dplyr")
library("ggplot2")

data_2 <- filter(NEI, NEI$fips == "24510") %>% group_by(year) %>% summarise(Total_Emission = sum(Emissions))
barplot(
  
  height = data_2$Total_Emission
  ,names.arg = data_2$year
  ,xlab = "Years"
  ,ylab = "Total PM2.5 Emission"
  ,main = "Total PM2.5 Emission By Year in Baltimore City"
  ,col = "orange"
  ,border = NA
)
dev.copy(png, file ="plot2.png", height = 1000, width = 1000)
dev.off()


##Question 3
##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
##Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
library("dplyr")
library("ggplot2")

data_3 <- filter(NEI, NEI$fips == "24510") %>% group_by(year, type) %>% summarise(Total_Emission = sum(Emissions))
ggplot(
    data = data_3, aes(x=factor(year),y=Total_Emission, fill = type, label = round(Total_Emission,2))
)+
  geom_bar(stat="identity") +
  facet_grid(. ~ type) +
  xlab("Year") +
  ylab(expression("Total PM" [2.5]*" Emission")) +
  ggtitle(expression("PM"[2.5]*paste(" Emission in Baltimore City", " From 1992-2008",sep ="") )) +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_label(aes(fill=type), colour ="white", fontface ="bold") 

dev.copy(png, file ="plot3.png", height = 1000, width = 1000)
dev.off()




##Question 4
##Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
library("dplyr")
library("ggplot2")

ValuesTOSelect <- grepl("Fuel Comb.*Coal",SCC$EI.Sector)
ExtractSCC <- SCC[grepl("Fuel Comb.*Coal",SCC$EI.Sector),]

#Including only coal combustion-realted sources
data_4 <- data.frame(NEI[(NEI$SCC %in% ExtractSCC$SCC),])
data_4 <- data_4 %>% group_by(year) %>% summarise(Total_Emission = sum(Emissions))
ggplot(
    data = data_4, aes(x=factor(year), y = Total_Emission, label = round(Total_Emission,2), fill = year )
) +
  geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression("Total PM" [2.5]*" Emission")) +
  ggtitle(expression("PM"[2.5]*paste(" Emission in Coal Combustion-related Sources", " From 1992-2008",sep ="") )) +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_label(aes(fill= year), colour ="white", fontface ="bold")

dev.copy(png, file ="plot4.png", height = 1000, width = 1000)
dev.off()


##Question 5
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library("dplyr")
library("ggplot2")




#Including only coal combustion-realted sources
ExtractSCC <- SCC[grepl("Vehicles",SCC$EI.Sector, ignore.case = TRUE),]

data_5 <- NEI[(NEI$fips == "24510") & (NEI$SCC %in% ExtractSCC$SCC),]
data_5 <- data_5 %>% group_by(year) %>% summarise(Total_Emission = sum(Emissions))
ggplot(
  data = data_5, aes(x=factor(year), y = Total_Emission, label = round(Total_Emission,2), fill = year )
) +
  geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression("Total PM" [2.5]*" Emission")) +
  ggtitle(expression("PM"[2.5]*paste(" Emission from Motor Vechicel Sources in Baltimore City", " From 1992-2008",sep ="") )) +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_label(aes(fill= year), colour ="white", fontface ="bold")

dev.copy(png, file ="plot5.png", height = 1000, width = 1000)
dev.off()



##Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?
library("dplyr")
library("ggplot2")
city <- c("24510","06037")
ExtractSCC <- SCC[grepl("Vehicles",SCC$EI.Sector, ignore.case = TRUE),]

data_6 <- NEI[(NEI$fips %in% city) & (NEI$SCC %in% ExtractSCC$SCC),]
data_6$state <- ifelse(data_6$fips == "24510", "Baltimore", "Los Angeles")
data_6 <- data_6 %>% group_by(year, state) %>% summarise(Total_Emission = sum(Emissions))
ggplot(
  data = data_6, aes(x=factor(year), y = Total_Emission, label = round(Total_Emission,2), fill = state)
) +
  geom_bar(stat="identity") +
  facet_grid(state~.,scales = "free") +
  xlab("Year") +
  ylab(expression("Total PM" [2.5]*" Emission")) +
  ggtitle(expression("Comparison of PM"[2.5]*paste(" Emission Baltimore vs Los Angeles",sep ="") )) +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_label(aes(fill= state), colour ="white", fontface ="bold")


dev.copy(png, file ="plot6.png", height = 1000, width = 1000)
dev.off()



