#load libraries
library("Sushi")

#load data from fithichip
cov <- read.table("/Users/fsociety/Downloads/Dovetailoutput/Neurons/5k.coverage.bedgraph")
arc <- read.table("/Users/fsociety/Downloads/Dovetailoutput/Neurons/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)

#previews arc 
head(arc)

#adds distance column
arc$dist <- abs(arc$e2 - arc$s1)

#previews arc with new distance column
head(arc)

#Set Region to visualize (Angelman locus 15q.11-q13 in Lymphoblast GM12878) #dovetail sample had chr8:22500000-23200000
  chrom = "chr22"
  chromstart = 49000000
  chromend = 49600000
  #Plot arcs with arc heights based on contact frequency
  plotBedpe(arc,chrom,chromstart,chromend,heights = arc$sumCC,plottype="loops", flip=TRUE)
  labelgenome(chrom, chromstart,chromend,side=3, n=3,scale="Mb")
  axis(side=2,las=2,tcl=.2)
  mtext("contact freq",side=2,line=1.75,cex=.75,font=2)

#Inspect coverage plot
plotBedgraph(cov,chrom,chromstart,chromend)
labelgenome(chrom,chromstart,chromend,n=4,scale="Mb")
mtext("Read Depth",side=2,line=1.75,cex=1,font=2)ale="Mb")
axis(side=2,las=2,tcl=.2)
mtext("contact freq",side=2,line=1.75,cex=.75,font=2)
#Plot arcs with arc heights based on distance
plotBedpe(arc,chrom,chromstart,chromend,heights = arc$dist,plottype="loops", flip=TRUE)
labelgenome(chrom, chromstart,chromend,side=3, n=3,scale="Mb")
axis(side=2,las=2,tcl=.2)
mtext("distance",side=2,line=1.75,cex=.75,font=2)

#Align and print both plots to a PDF file
pdfname <- "/Users/fsociety/Downloads/Dovetailoutput/Neurons/hichip.cov.arcs.pdf"
makepdf = TRUE
if(makepdf==TRUE)
{
  pdf(pdfname , height=10, width=12)
}

##set layout
layout(matrix(c(1,
                2
), 2,1, byrow=TRUE))
par(mgp=c(3,.3,0))

##plot coverage
par(mar=c(3,4,2,2))
plotBedgraph(cov,chrom,chromstart,chromend)
labelgenome(chrom,chromstart,chromend,n=4,scale="Mb")
mtext("Read Depth",side=2,line=1.75,cex=1,font=2)
axis(side=2,las=2,tcl=.2)

##plot arcs with height based on contact frequency
par(mar=c(3,4,2,2))
plotBedpe(arc,chrom,chromstart,chromend,heights = arc$sumCC,plottype="loops", flip=TRUE)
labelgenome(chrom, chromstart,chromend,side=3, n=3,scale="Mb")
axis(side=2,las=2,tcl=.2)
mtext("contact freq",side=2,line=1.75,cex=.75,font=2)

if (makepdf==TRUE)
{
  dev.off()
}
