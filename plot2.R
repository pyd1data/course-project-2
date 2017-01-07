#read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#restriction to baltimore City, fips 24510
ID1=which(NEI[,"fips"]=="24510")
NEI2=NEI[ID1,]
#aggregate gives directly the sum of all emissions ordered per year
Emissions2 <- aggregate(NEI2[, 'Emissions'], by=list(NEI2$year), FUN=sum)
#prepare png frame
png("plot2.png",width=480,height=480)
#plotting the result and observe the global decrease
plot(Emissions2,type="l",xlab="years",ylab="Baltimore PM2.5 Emissions")
#save to png
dev.off()