#load libraries
library("Sushi")

#load data from fithichip
cov <- read.table("/Users/fsociety/Documents/GitHub/angelman_ctcf/output_tables/5k.coverage.bedgraph")
arc <- read.table("/Users/fsociety/Documents/GitHub/angelman_ctcf/output_tables/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)

head(arc)
