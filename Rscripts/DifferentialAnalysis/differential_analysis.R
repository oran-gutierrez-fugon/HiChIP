library("dplyr")
library("Sushi")
library("GenomicInteractions")

total_table <- read.table("/Volumes/DOVETAIL/DifAnalysis_outdir/MasterSheet_Undiff_Neurons_Loops.bed", sep = "\t", header = TRUE)
head(total_table)

#from terminal
total_table <- read.table("/share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis/outdir/MasterSheet_Undiff_Neurons_Loops.bed", sep = "\t", header = TRUE)
head(total_table)

label_ld_ld <- total_table %>% filter(Bin1_Label == "LD", Bin2_Label == "LD")
head(label_ld_ld)
label_nd_nd <- total_table %>% filter(Bin1_Label == "ND", Bin2_Label == "ND")
head(label_nd_nd)
label_ld_nd <- total_table %>% filter(Bin1_Label == "LD", Bin2_Label == "ND")
head(label_ld_nd)
label_nd_ld <- total_table %>% filter(Bin1_Label == "ND", Bin2_Label == "LD")
head(label_nd_ld)
#No columns had hd and there were 0 results for the following filters
#label_hd_hd <- total_table %>% filter(Bin1_Label == "HD", Bin2_Label == "HD")
#label_hd_ld <- total_table %>% filter(Bin1_Label == "HD", Bin2_Label == "LD")
#label_hd_nd <- total_table %>% filter(Bin1_Label == "HD", Bin2_Label == "ND")
#label_ld_hd <- total_table %>% filter(Bin1_Label == "LD", Bin2_Label == "HD")
#label_nd_hd <- total_table %>% filter(Bin1_Label == "ND", Bin2_Label == "HD")

#Adds distance column
label_ld_ld$dist <- abs(label_ld_ld$end2 - label_ld_ld$start1)
head(label_ld_ld)
label_nd_nd$dist <- abs(label_nd_nd$end2 - label_nd_nd$start1)
head(label_nd_nd)
label_ld_nd$dist <- abs(label_ld_nd$end2 - label_ld_nd$start1)
head(label_ld_nd)
label_nd_ld$dist <- abs(label_nd_ld$end2 - label_nd_ld$start1)
head(label_nd_ld)

#Notes from meeting with Corey
"""
Print each COMBO to file
To plot:
  Import bedpe since associated with genomic intervals
  Scale to distance and use color for interaction count (see sushi bioconductor page)
  Add column for distance (maybe before previous?)
  Plot tracks for all conditions
"""
  
'''
#Borrowed snippet of code from arc loops

#Set Region to visualize Angelman locus
chrom = "chr15"
chromstart = 24718748
chromend = 26143749

plotBedpe(label_ld_ld,chrom,chromstart,chromend,heights = label_ld_ld$sumCC,plottype="loops", flip=TRUE)
labelgenome(chrom, chromstart,chromend,side=3, n=3,scale="Mb")
axis(side=2,las=2,tcl=.2)
mtext("contact freq",side=2,line=1.75,cex=.75,font=2)
'''

'''
#Trying to export each object to a bedpe file
export.bedpe(label_ld_ld, fn = ld_ld.bedpe, score = "counts")
export.bedpe(label_nd_nd, fn = nd_nd.bedpe, score = "counts")
export.bedpe(label_ld_nd, fn = ld_nd.bedpe, score = "counts")
export.bedpe(label_nd_ld, fn = nd_ld.bedpe, score = "counts")
'''


#Guide from bioconductor page for sushi page 14
"""
plotHic:   plots HiC interactio matrix
Description:
    plots HiC interactio matrix
Usage:
    plotHic(hicdata, chrom, chromstart, chromend, max_y = 30, zrange = NULL,
      palette = SushiColors(7), flip = FALSE)
  
Arguments:

hicdata     interaction matrix representing HiC data. Row and column names should be postions along a chromosome
chrom       chromosome of region to be plotted 
chromstart  start position
chromend    end position
max_y       The maximum bin distance to plot
zrange      The range of interaction scores to plot (more extreme value will be set to the max or min)
palette     color palette to use for representing interaction scores 
flip        TRUE/FALSE whether plot should be flipped over the x-axis

Examples:

data(Sushi_HiC.matrix)
chrom = "chr15"
chromstart = 24718748
chromend = 26143749

phic = plotHic(label_ld_ld,chrom,chromstart,chromend,max_y = 20,zrange=c(0,28),palette = topo.colors,flip=FALSE)

labelgenome(chrom,chromstart,chromend,side=1,scipen=20,n=4,scale="Mb",edgeblankfraction=0.20,line=.18,chromline 

addlegend(phic[[1]],palette=phic[[2]],title="score",side="right",bottominset=0.4,topinset=0,xoffset=-.035,label
"""
