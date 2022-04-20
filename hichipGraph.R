#load libraries
library("Sushi")
library("biomaRt")
#load data from fithichip
arc <- read.table("/Users/fsociety/Library/CloudStorage/OneDrive-UCDavis/Documents/Dovetailoutput/Redos/intersectBed-10kbins01/UDP4uniqueCONCAT.bed", header=TRUE)
#adds distance column
arc$dist <- abs(arc$e2 - arc$s1)

#Set Region to visualize (Angelman locus 15q.11-q13)
chrom = "chr15"
chromstart = 25120000
chromend = 25950000
#Plot arcs with arc heights based on contact frequency
plotBedpe(arc,chrom,chromstart,chromend,heights = arc$sumCC, plottype="loops", colorby = arc$sumCC, colorbycol=SushiColors(2), flip=FALSE)
labelgenome(chrom, chromstart,chromend,side=1, n=12,scale="Mb")
axis(side=2,las=2,tcl=.2)
mtext("Contact Frequency",side=2,line=2.5,cex=1,font=2)

#Trying to plot gene names as well
'''


useMart(biomart, dataset, host="https://www.ensembl.org",
path="/biomart/martservice", port, archive=FALSE, version, verbose = FALSE)

if(interactive()){

    mart = useMart("ensembl")
    mart=useMart(biomart="ensembl", dataset="hsapiens_gene_ensembl")
}

getBM((attributes = c("chromosome_name", "exon_chrom_start", "exon_chrom_end", "external_gene_name")))

plotGenes(geneinfo = NULL, chrom = chrom, chromstart = chromstart,
          chromend = chromend, col = SushiColors(2)(2)[1], bheight = 0.3,
          lheight = 0.3, bentline = TRUE, packrow = TRUE, maxrows = 10000,
          colorby = NULL, colorbyrange = NULL,
          colorbycol = colorRampPalette(c("blue", "red")), types = "exon",
          plotgenetype = "box", arrowlength = 0.005, wigglefactor = 0.05,
          labeltext = TRUE, labeloffset = 0.4, fontsize = 0.7, fonttype = 2,
          labelat = "middle")

'''
