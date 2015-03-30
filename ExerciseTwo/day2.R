library(xlsx)
library(mi)
library(mice)
library(Hmisc)


datasetM <- read.xlsx("Data/DataSet_01.xlsx", sheetIndex = 1, endRow=277)
mi.info(datasetM)

typecast(datasetM)









