#load libraries
library("Sushi")
library("biomaRt")
library("glue")

#creates variable for target folder
path = "/Users/fsociety/Library/CloudStorage/OneDrive-UCDavis/Documents/Dovetailoutput/NP4sUDP4sBEST"

#Get all the .bed files from path directory
files <- dir(path,pattern = ".bed$", recursive=TRUE)

#Set Region to visualize (Angelman locus 15q.11-q13)
chrom = "chr15"
chromstart = 23600000
chromend = 26900000

for(f in files) {
  #load data from fithichip
  filename= glue(path)
  file <- basename(filename)
  arc <- read.table(filename, header=TRUE)
  #adds distance column
  arc$dist <- abs(arc$e2 - arc$s1)
  #Sub out underscore for spaces
  file <- gsub("_", " ", file)
  file <- gsub("-", " ", file)
  file <- gsub(".", " ", file)
  #Takes bed extension out of name
  new.file <- sub("\\..*", "",file)
  
  #Puts upper limit on sumCC value using pmin function (chnged to just heights inside plotBedpe so can still view unchanged differences in color)
  arc$sumCC = pmin(arc$sumCC, 100)
  
  ##Renames files
  short.file <- sub('interactions_FitHiC_Q0.10_MergeNearContacts','', new.file)
  file.rename(file.path(XX,new.file), file.path(XX, short.file)) 
  #original code to change name
  #newname <- sub('NO_','', files) ## new name
  #file.rename(file.path(path,files), file.path(path, newname)) ## renaming it.
  
  #Writes image as png with desired dimensions and uses file currently loaded for naming image
  png(file=glue(XX"/{short.file}.png"),width = 1043,height = 516)
  #Plot arcs with arc heights based on contact frequency
  plotBedpe(arc,
            chrom,
            chromstart,
            chromend,
            heights = pmin(arc$sumCC, 75), 
            plottype="loops", 
            colorby = arc$sumCC, 
            colorbycol=SushiColors(2), 
            flip=FALSE)
  labelgenome(chrom, chromstart,chromend,side=1, n=12,scale="Mb")
  axis(side=2,las=2,tcl=.2)
  mtext("Contact Frequency",side=2,line=2.5,cex=1,font=2)
  labelplot("                  {short.file} chr15:23600000-26900000", new.file, titlecex=2, titleline="1.7")
  dev.off()
}

#In the future would like to plot gene names as well using useMart, getBM and plotGenees
