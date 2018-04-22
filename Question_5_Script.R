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

