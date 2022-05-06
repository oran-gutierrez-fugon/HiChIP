# load libraries
library(dplyr)

#load data
bed <- as.data.frame(read.table("/Users/osman/Documents/GitHub/angelman_ctcf/NP4s-10K-01-hg19_INTER_filtered_sorted.bed",header = TRUE, sep="\t",stringsAsFactors=FALSE))
head(bed)

#create variables to be tested 
s1 <- bed$s1
e2 <- bed$e2

# check if s1 is greater than e2
for(i in s1){
  for(j in e2){
    if (i > j){
      print("needs flip")
    }
    else{
      print("correct order");
    }
  }
}
