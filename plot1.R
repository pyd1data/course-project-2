NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#read data
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
#aggregate gives directly the sum of all emissions ordered per year
Emissions <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
#prepare png frame
png("plot1.png",width=480,height=480)
#plotting the result and observe the global decrease
plot(Emissions,type="l",xlab="years",ylab="USA total PM2.5 Emissions")
#save to png
dev.off()