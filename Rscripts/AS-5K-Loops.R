#load libraries
library("Sushi")
library("biomaRt")
library("glue")

#creates variable for target folder
XX <- '/Users/fsociety/Library/CloudStorage/OneDrive-UCDavis/Documents/Dovetailoutput/NP4sUDP4sBEST'

#Get all the .bed files from path directory
files <- dir(path = {XX},pattern = ".bed$", recursive=TRUE)

#Set Region to visualize (Angelman locus 15q.11-q13)
chrom = "chr15"
chromstart = 23600000
chromend = 26900000

for(f in files) {
  #load data from fithichip
  filename= glue("{XX}/{f}")
  file <- basename(filename)
  arc <- read.table(filename, header=TRUE)
  #adds distance column
  arc$dist <- abs(arc$e2 - arc$s1)

  #Takes bed extension out of name
  new.file <- sub(".bed", "",file)
  
  #Writes image as png with desired dimensions and uses file currently loaded for naming image
  png(file=glue("{XX}/{new.file}.png"),width = 1043,height = 516)
  
  #Sub out underscore for spaces and cleans up title clarifying FDR
  new.file <- gsub("_", " ", new.file)
  new.file <- gsub("-", " ", new.file)
  new.file <- gsub("01", "FDR:0.01", new.file)
  new.file <- gsub("05", "FDR:0.05", new.file)
  new.file <- gsub("10", "FDR:0.10", new.file)
  #Plot arcs with arc heights based on contact frequency
  plotBedpe(arc,
            chrom,
            chromstart,
            chromend,
            heights = pmin(arc$sumCC, 50), 
            plottype="loops", 
            colorby = arc$sumCC, 
            colorbycol=SushiColors(2), 
            flip=FALSE)
  labelgenome(chrom, chromstart,chromend,side=1, n=12,scale="Mb")
  axis(side=2,las=2,tcl=.2)
  mtext("Contact Frequency",side=2,line=2.5,cex=1,font=2)
  labelplot("          chr15:23600000-26900000", new.file, titlecex=2, titleline="1.7")
  dev.off()
}
