#Author narumeena
#ScriptDescription fisher test and chi test 


#functions 
sNumeric <- function(x) as.numeric(as.character(x))
factorsNumeric <- function(d) modifyList(d, lapply(d[, sapply(d, is.factor)],   
                                                   as.numeric))




library(xlsx)
dataMinus <- read.xlsx2("Datasets.xls" ,sheetIndex = 1)

rownames(dataMinus) <- dataMinus$Accession
dataMinus$Accession <- NULL
head(dataMinus) 



dataMinus <- factorsNumeric(dataMinus)


chisq.test(dataMinus)


dataPlus <-  read.xlsx2("Datasets.xls" ,sheetIndex = 2)

rownames(dataPlus) <- dataPlus$Accession
dataPlus$Accession <- NULL
head(dataPlus) 

dataPlus <- factorsNumeric(dataPlus)


chisq.test(dataPlus)




