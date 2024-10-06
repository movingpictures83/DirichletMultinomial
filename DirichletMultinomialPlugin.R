## ----setup_knitr, include=FALSE, cache=FALSE-------------------------------
library(knitr)
library(DRIMSeq)
opts_chunk$set(cache = FALSE, warning = FALSE, out.width = "7cm", fig.width = 7, out.height = "7cm", fig.height = 7)
library(PasillaTranscriptExpr)


input <- function(inputfile) {
myD <<- readRDS(inputfile)
}
run <- function() {}
output <- function(outputfile) {
design_full <- model.matrix(~ group, data = samples(myD))
myD <<- dmPrecision(myD, design = design_full)
pdf(paste(outputfile,"pdf",sep="."))
library(ggplot2)
ggp <- plotPrecision(myD)
ggp + geom_point(size = 4)
myD <<- dmFit(myD, design = design_full, verbose = 1)
## Get fitted proportions
head(proportions(myD))
## Get the DM regression coefficients (gene-level) 
head(coefficients(myD))
## Get the BB regression coefficients (feature-level) 
head(coefficients(myD), level = "feature")
saveRDS(myD, paste(outputfile,"rds",sep="."))
}

