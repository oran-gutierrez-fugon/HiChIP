#load libraries
library("Sushi")
library("biomaRt")
library("glue")

#Get all the .bed files from path directory
files <- dir(path = "/Users/fsociety/Library/CloudStorage/OneDrive-UCDavis/Documents/Dovetailoutput/Redos/intersectBed-10kbins01/noDups/",pattern = ".bed")

for(f in files) {
  #load data from fithichip
  filename= glue("/Users/fsociety/Library/CloudStorage/OneDrive-UCDavis/Documents/Dovetailoutput/Redos/intersectBed-10kbins01/noDups/{f}")
  file <- basename(filename)
  arc <- read.table(filename, header=TRUE)
  
  #adds distance column
  arc$dist <- abs(arc$e2 - arc$s1)
  
  #Set Region to visualize (Angelman locus 15q.11-q13)
  chrom = "chr15"
  chromstart = 25120000
  chromend = 25950000
  #Plot arcs with arc heights based on contact frequency
  file <- sub(" ", "_", file)
  new.file <- sub("\\..*", "",file)
  
  png(file=glue("/Users/fsociety/Library/CloudStorage/OneDrive-UCDavis/Documents/Dovetailoutput/Redos/intersectBed-10kbins01/noDups/{new.file}.png"),width = 1043,height = 516)
  plotBedpe(arc,
            chrom,
            chromstart,
            chromend,
            heights = arc$sumCC, 
            plottype="loops", 
            colorby = arc$sumCC, 
            colorbycol=SushiColors(2), 
            flip=FALSE)
  labelgenome(chrom, chromstart,chromend,side=1, n=12,scale="Mb")
  axis(side=2,las=2,tcl=.2)
  mtext("Contact Frequency",side=2,line=2.5,cex=1,font=2)
  labelplot("                  10k bins FDR: 0.01", new.file, titlecex=2, titleline="1.5")
  dev.off()
}

#In the future would like to plot gene names as well using useMart, getBM and plotGenees
