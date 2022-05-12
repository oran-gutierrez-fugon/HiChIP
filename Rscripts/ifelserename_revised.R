#Load libraries
library("Sushi")
library("biomaRt")
library("glue")
library("stringr")

#Creates variable for target folder
path <- '/Users/osman/Documents/GitHub/angelman_ctcf'

#Get all the .bed files from path directory
files <- dir(path = {path},pattern = ".bed$", recursive=TRUE)

#Set Region to visualize (Angelman locus 15q.11-q13 extended region)
chrom = "chr15"
chromstart = 23600000
chromend = 26900000

for(file in files) {
  #load data from fithichip
  file_path= glue("{path}/{file}")
  filename <- basename(file_path)
  arc <- read.table(file_path, header=TRUE)
  
  #adds distance column
  arc$dist <- abs(arc$e2 - arc$s1)
  
# this does the naming convention you like 
  all_parts <- strsplit(filename, split = ".", fixed=T)
  part2 <- strsplit(all_parts[[1]][5], split = "_", fixed=T)
  newname <- paste(c(all_parts[[1]][1:3], part2[[1]][1]), collapse = "-")
  newname.bed <- paste(c(newname, "bed"), collapse = ".")
# example : UDP4-SM-5K-05.bed

  #Writes image as png with desired dimensions and uses file currently loaded for naming image
  png(file=glue("{path}/{newname.bed}_test_test.png"),width = 1043,height = 516)
  
  #Sub out underscore for spaces and cleans up title clarifying FDR
  newname.bed <- gsub("_", " ", newname.bed)
  newname.bed <- gsub("-", " ", newname.bed)
  newname.bed <- gsub("01", "FDR:0.01", newname.bed)
  newname.bed <- gsub("05", "FDR:0.05", newname.bed)
  newname.bed <- gsub("10", "FDR:0.10", newname.bed)

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
