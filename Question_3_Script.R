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


