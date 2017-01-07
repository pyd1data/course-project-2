library(ggplot2)
#read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#restriction to baltimore City, fips 24510
ID1=which(NEI[,"fips"]=="24510")
NEI2=NEI[ID1,]
#prepare png frame
png("plot3.png",width=480,height=480)
#plotting all emissions by type using ggplot, internal function summary does the sum job
g<-ggplot(NEI2,aes(year,Emissions,color=type))
g+geom_line(stat = "summary",fun.y="sum")+ labs(y="Baltimore PM2.5 Emissions per type source ",x="year")
##point type slightly increase and was responsible for all the emission increase, other type decrease
#save to png
dev.off()
