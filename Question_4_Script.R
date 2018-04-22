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
