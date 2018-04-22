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
