##@author narumeena
#@script calculation tanimato score


library(xlsx)

data <- read.xlsx2("Nine point classification dataset_17th Oct_2016.xlsx",2)

data <- data[!apply(data == "", 1, all),]
rownames(data) <- data$Accession
head(data) 

data[1:2] <- list(NULL)

head(data)



jacardCalculation <- as.matrix(dist(data, "binary"))

head(jacardCalculation)


write.csv2(jacardCalculation, file = "jcardDistanceCaluclation.csv")




library(ggplot2)
library(plyr)
library(arm)
library(reshape2)


#Matric Plot 

nba <- jacardCalculation

nba.m <- melt(nba)

head(nba.m)
jpeg('matrix.jpg', width=10000, height=10000, unit='px')
nba.m <- ddply(nba.m, .(Var2), transform,
               rescale = value)#rescale = rescale(value))
(p <- ggplot(nba.m, aes(Var2, Var1)) + geom_tile(aes(fill = rescale),
        colour = "white") + scale_fill_gradient(low = "white",
          high = "steelblue")+geom_text(aes(label=round(rescale,1))))

dev.off()

###forced directed graph 

head(nba)
dist_m <- as.matrix(dist(jacardCalculation))
dist_mi <- 1/dist_m # one over, as qgraph takes similarity matrices as input
library(qgraph)
jpeg('forcedraw.jpg', width=10000, height=10000, unit='px')
qgraph(dist_mi, layout='spring', vsize=3)
dev.off()

