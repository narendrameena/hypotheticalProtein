
## Create transaction data set.
data <- list(
  c("a","b","c"),
  c("a","b"),
  c("a","b","d"),
  c("b","e"),
  c("b","c","e"),
  c("a","d","e"),
  c("a","c"),
  c("a","b","d"),
  c("c","e"),
  c("a","b","d","e")
)

#functions 
sNumeric <- function(x) as.numeric(as.character(x))
factorsNumeric <- function(d) modifyList(d, lapply(d[, sapply(d, is.factor)],   
                                                   as.numeric))


library(xlsx)
dataMinus <- read.xlsx2("Datasets.xls" ,sheetIndex = 2)
rownames(dataMinus) <- dataMinus$Accession
dataMinus$Accession <- NULL
head(dataMinus) 



t <- as(dataMinus, "transactions")

## Mine itemsets with tidLists.
f <- eclat(dataMinus, parameter = list(support = 0.69, tidLists = TRUE))

## Get dimensions of the tidLists.
dim(tidLists(f))

## Coerce tidLists to list.
as(tidLists(f), "list")

## Inspect visually.
image(tidLists(f))

##Show the Frequent itemsets and respectives supports
inspect(f)

## Get the itemsets as a list
as(items(f), "list")

## Get the itemsets as a binary matrix
as(items(f), "matrix")

## Get the itemsets as a sparse matrix, a ngCMatrix from package Matrix.
## Warning: for efficiency reasons, the ngCMatrix you get is transposed
as(items(f), "ngCMatrix")

write.csv(inspect(f), file = "aprioryResults.csv")
