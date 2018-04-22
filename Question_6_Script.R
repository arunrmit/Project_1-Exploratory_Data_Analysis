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

