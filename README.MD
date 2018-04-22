The objective of this project is to understand the Fine particulate matter in the US over the time frame. For this exploratory data analysis Base plot and GGPLOT2 are used in order to understand the behaviour of this pollutant. 
The data for this project is available in this site (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"), by using the following R code the data has been downloaded and unzipped.
urlp <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url = urlp, destfile = "ProjectData.zip")
unzip("ProjectData.zip")	

The files are in RDS file format, by using readRDS the data has been read and stored under the following variable.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

The following the questions has been answered in this analysis.

Question 1:
Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


R Code: Question_1_Script.R
Plot: plot1.png

Question 2:

Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

R Code: Question_2_Script.R
Plot: plot2.png

Question 3:

Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

R Code: Question_3_Script.R
