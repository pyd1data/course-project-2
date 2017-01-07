library(ggplot2)
#read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#specifying coal and combustion emission subsets 
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustion & coal)
#subset to obtain all source codes linked to caol combustion
SCC_combustion <- SCC[coalCombustion,]$SCC
#using %in% set operation to obtain all NEI dataframe index linked to coal combustion
IDF=which(NEI$SCC %in% SCC_combustion)
combustion <- NEI[IDF,]
#aggregate gives directly the sum of all emissions ordered per year
Sumcombustion <- aggregate(Emissions ~ year, data=combustion, FUN=sum)
#prepare png frame
png("plot4.png",width=480,height=480)
#plotting coal emissions by type using ggplot, a global decrease is observed
g<-ggplot(Sumcombustion,aes(year,Emissions))
g+geom_bar(stat = "identity",width=0.5)+ labs(y="Total Coal Combustion emission in USA ",x="year")
#save to png
dev.off()
