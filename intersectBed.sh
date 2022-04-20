#Analyses loops that are present in Neurons and either present or Nonpresent in Undifferentiated LUHMES for region of interest 

#cut out region of interest and eliminates headers required for intersectBed to work
awk '$1=="chr15" && $2>23000000 && $3<26000000' NP4s.bed > NP4sROI.bed
awk '$1=="chr15" && $2>23000000 && $3<26000000' UDP4s.bed > UDP4sROI.bed
awk '$1=="chr15" && $2>23000000 && $3<26000000' NP4-1and2.bed > NP4-1and2ROI.bed
awk '$1=="chr15" && $2>23000000 && $3<26000000' UDP4-1and3.bed > UDP4-1and3ROI.bed

#Bal = NP4-1and2 + UDP4-1and3
#Finds unique loops
intersectBed -v -a NP4-1and2ROI.bed -b UDP4-1and3ROI.bed > UniqueBalROI.bed
intersectBed -v -a NP4sROI.bed -b UDP4sROI.bed > UniqueROI.bed
#Finds common loops
intersectBed -wa -a NP4-1and2ROI.bed -b UDP4-1and3ROI.bed > CommonBalROI.bed
intersectBed -wa -a NP4sROI.bed -b UDP4sROI.bed > CommonROI.bed
#Finds common, unique in NP4s has -1 in row 17 and 18
intersectBed -wao -a NP4-1and2ROI.bed -b UDP4-1and3ROI.bed > UniqueCommonBalROI.bed
intersectBed -wao -a NP4sROI.bed -b UDP4sROI.bed > UniqueCommonROI.bed

#Same as above but using Undif compared to Dif
#Finds unique loops
intersectBed -v -a UDP4-1and3ROI.bed -b NP4-1and2ROI.bed > UniqueBalROIu-n.bed
intersectBed -v -a UDP4sROI.bed -b NP4sROI.bed > UniqueROIu-n.bed
#Finds common loops
intersectBed -wa -a UDP4-1and3ROI.bed -b NP4-1and2ROI.bed > CommonBalROIu-n.bed
intersectBed -wa -a UDP4sROI.bed -b NP4sROI.bed > CommonROIu-n.bed
#Finds common, unique in NP4s has -1 in row 17 and 18
intersectBed -wao -a UDP4-1and3ROI.bed -b NP4-1and2ROI.bed > UniqueCommonBalROIu-n.bed
intersectBed -wao -a UDP4sROI.bed -b NP4sROI.bed > UniqueCommonROIu-n.bed


#Flipped columns 123 for 456 for intersectBed purposes (in excel)
#Bal = NP4-1and2 + UDP4-1and3
#Finds unique loops
intersectBed -v -a NP4-1and2ROIflipped.bed -b UDP4-1and3ROIflipped.bed > UniqueBalROIflipped.bed
intersectBed -v -a NP4sROIflipped.bed -b UDP4sROIflipped.bed > UniqueROIflipped.bed
#Finds common loops
intersectBed -wa -a NP4-1and2ROIflipped.bed -b UDP4-1and3ROIflipped.bed > CommonBalROIflipped.bed
intersectBed -wa -a NP4sROIflipped.bed -b UDP4sROIflipped.bed > CommonROIflipped.bed
#Finds common, unique in NP4s has -1 in row 17 and 18
intersectBed -wao -a NP4-1and2ROIflipped.bed -b UDP4-1and3ROIflipped.bed > UniqueCommonBalROIflipped.bed
intersectBed -wao -a NP4sROIflipped.bed -b UDP4sROIflipped.bed > UniqueCommonROIflipped.bed

#Same as above but using Undif compared to Dif
#Finds unique loops
intersectBed -v -a UDP4-1and3ROIflipped.bed -b NP4-1and2ROIflipped.bed > UniqueBalROIu-nflipped.bed
intersectBed -v -a UDP4sROIflipped.bed -b NP4sROIflipped.bed > UniqueROIu-nflipped.bed
#Finds common loops
intersectBed -wa -a UDP4-1and3ROIflipped.bed -b NP4-1and2ROIflipped.bed > CommonBalROIflipped.bed
intersectBed -wa -a UDP4sROIflipped.bed -b NP4sROIflipped.bed > CommonROIu-nflipped.bed
#Finds common, unique in NP4s has -1 in row 17 and 18
intersectBed -wao -a UDP4-1and3ROIflipped.bed -b NP4-1and2ROIflipped.bed > UniqueCommonBalROIu-nflipped.bed
intersectBed -wao -a UDP4sROIflipped.bed -b NP4sROIflipped.bed > UniqueCommonROIu-nflipped.bed

#join all forward and flipped files
#don't think I have use for common, unique -1 files
cat UniqueBalROIflipped.bed UniqueBalROIu-nflipped.bed > UniqueNP4.bed
cat UniqueROIflipped.bed UniqueROIu-nflipped.bed > UniqueUDP4.bed
cat CommonBalROIflipped.bed CommonBalROIflipped.bed > CommonNP4-UDP4.bed
cat CommonROIflipped.bed CommonROIu-nflipped.bed > CommonUDP4-NP4.bed
cat CommonNP4-UDP4.bed CommonUDP4-NP4.bed > Common.bed

#Removes duplicates from Common file
awk '!a[$10$11$12$13]++' UniqueNP4.bed > UniqueNP4noDups.bed
awk '!a[$10$11$12$13]++' UniqueUDP4.bed > UniqueUDP4noDups.bed
awk '!a[$10$11$12$13]++' Common.bed > CommonNoDups.bed

cat FitHiChIP_header.bed UniqueNP4noDups.bed > UniqueNP4noDups2.bed; mv UniqueNP4noDups{2,}.bed



