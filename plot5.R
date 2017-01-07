library(ggplot2)
#read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#using vehicle class to obtain motor vehicle sources 
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
#subset to obtain all source codes linked to motor vehicle source
SCC_vehicle <- SCC[vehicle,]$SCC
IDF1=which(NEI$SCC %in% SCC_vehicle)
#specifying Baltimore fips code and vehicle type "On road"
IDF2=which((NEI[,"fips"]=="24510")&(NEI$type=="ON-ROAD"))
vehicleBaltimore <- NEI[intersect(IDF1,IDF2),]
#aggregate gives directly the sum of all emissions ordered per year
SumvehicleBaltimore <- aggregate(Emissions ~ year, data=vehicleBaltimore, FUN=sum)
#prepare png frame
png("plot5.png",width=480,height=480)
#plotting vehicle emissions in Baltimore by type using ggplot, a global decrease is observed
g<-ggplot(SumvehicleBaltimore,aes(year,Emissions))
g+geom_bar(stat = "identity",width=0.5)+ labs(y="Vehicle emission in Baltimore ",x="year")
#save to png
dev.off()

