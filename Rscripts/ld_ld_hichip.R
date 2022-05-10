#load libraries
library("Sushi")
#load data from fithichip
arc <- read.table("/Volumes/DOVETAIL/NeuronsConcat/catbalanced/UDP4_01_Merge_Nearby_Interactions/CTCF.DS.5kb.interactions_FitHiC_Q0.01_MergeNearContacts.bed", header=TRUE)

arc <- read.table("/Users/fsociety/Downloads/Dovetailoutput/Undif/label_ld_ld.bed", header=TRUE)
head(arc)
#adds distance column
arc$dist <- abs(arc$e2 - arc$s1)

#Set Region to visualize (Angelman locus 15q.11-q13)
chrom = "chr15"
chromstart =15120000
chromend = 35950000
#Plot arcs with arc heights based on contact frequency
plotBedpe(arc,chrom,chromstart,chromend,heights = arc$sumCC,plottype="loops", flip=TRUE)
labelgenome(chrom, chromstart,chromend,side=3, n=3,scale="Mb")
axis(side=2,las=2,tcl=.2)
mtext("contact freq",side=2,line=1.75,cex=.75,font=2)