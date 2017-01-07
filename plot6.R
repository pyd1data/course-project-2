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
#specifying LA fips code and vehicle type "On road"
IDF2=which((NEI[,"fips"]=="06037")&(NEI$type=="ON-ROAD"))
vehicleLA <- NEI[intersect(IDF1,IDF2),]
#aggregate gives directly the sum of all emissions ordered per year
SumvehicleBaltimore <- aggregate(Emissions ~ year, data=vehicleBaltimore, FUN=sum)
SumvehicleLA <- aggregate(Emissions ~ year, data=vehicleLA, FUN=sum)
#adding town field to plot the two results per town
SumvehicleBaltimore$town<-"BAL"
SumvehicleLA$town<-"LA"
bothNEI <- rbind(SumvehicleBaltimore,SumvehicleLA)
#prepare png frame
png("plot6.png",width=480,height=480)
#plotting vehicle emissions in Baltimore and LA by type using ggplot, 
#and observe a quasi constant relative variation between 1998 and 2008 in LA
g<-ggplot(bothNEI,aes(year,Emissions,fill=town))
g+geom_bar(stat = "identity",width=0.5) + 
  #facet_grid(town ~ .) + 
  facet_grid(town ~ ., scales="free") + 
  labs(y="Vehicle emission in LA and Baltimore ",x="year")
#save to png
dev.off()