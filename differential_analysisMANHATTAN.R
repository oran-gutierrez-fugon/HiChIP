library("dplyr")
library("Sushi")
total_table <- read.table("/Volumes/DOVETAIL/DifAnalysis_outdir/MasterSheet_Undiff_Neurons_Loops.bed", sep = "\t", header = TRUE)
head(total_table)
label_ld <- total_table %>% filter(Bin1_Label == "LD")
head(label_ld)
label_hd <- total_table %>% filter(Bin1_Label == "HD")
plotManhattan(label_ld,
              chrom = 15, 
              chromstart = NULL, 
              chromend = NULL, 
              col = SushiColors(5), 
              space = 0.01, 
              ymax = 1.04, 
              pvalues = 0.05)
