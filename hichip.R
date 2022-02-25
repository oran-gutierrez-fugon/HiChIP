#load libraries
library("Sushi")
#load data from fithichip
arc <- read.table("/Volumes/DOVETAIL/UndifConcat/UndifConcat01_Merge_Nearby_Interactions/CTCF.DS.5kb.interactions_FitHiC_Q0.01_MergeNearContacts.bed", header=TRUE)
#adds distance column
arc$dist <- abs(arc$e2 - arc$s1)

#Set Region to visualize (Angelman locus 15q.11-q13 in Lymphoblast GM12878) #dovetail sample had chr8:22500000-23200000
chrom = "chr15"
chromstart = 24718748
chromend = 26143749
#Plot arcs with arc heights based on contact frequency
plotBedpe(arc,chrom,chromstart,chromend,heights = arc$sumCC,plottype="loops", flip=TRUE)
labelgenome(chrom, chromstart,chromend,side=3, n=3,scale="Mb")
axis(side=2,las=2,tcl=.2)
mtext("contact freq",side=2,line=1.75,cex=.75,font=2)