#Analyses loops that are present in Neurons and either present or Nonpresent in Undifferentiated LUHMES for region of interest 

#Removes headers
awk '$2>0 && $3<3000000000' NP4s.bed > NP4sAWK.bed
awk '$2>0 && $3<3000000000' UDP4s.bed > UDP4sAWK.bed
awk '$2>0 && $3<3000000000' NP4-1and2.bed > NP4-1and2AWK.bed
awk '$2>0 && $3<3000000000' UDP4-1and3.bed > UDP4-1and3AWK.bed


#For entire genome
#Finds unique loops
intersectBed -v -a NP4-1and2AWK.bed -b UDP4-1and3AWK.bed > UniqueBal.bed
intersectBed -v -a NP4sAWK.bed -b UDP4sAWK.bed > Unique.bed
#Finds common loops
intersectBed -wa -a NP4-1and2AWK.bed -b UDP4-1and3AWK.bed > CommonBal.bed
intersectBed -wa -a NP4sAWK.bed -b UDP4sAWK.bed > Common.bed

#Same as above but using Undif compared to Dif
#Finds unique loops
intersectBed -v -a UDP4-1and3AWK.bed -b NP4-1and2AWK.bed > UniqueBalu-n.bed
intersectBed -v -a UDP4sAWK.bed -b NP4sAWK.bed > Uniqueu-n.bed
#Finds common loops
intersectBed -wa -a UDP4-1and3AWK.bed -b NP4-1and2AWK.bed > CommonBalu-n.bed
intersectBed -wa -a UDP4sAWK.bed -b NP4sAWK.bed > Commonu-n.bed


#Flipps columns 123 for 456 and creates new file
awk -F'\t' '{print $4,$5,$6,$1,$2,$3,$7,$8,$9,$10,$11,$12,$13,$14,$15}' OFS="\t" "NP4-1and2AWK.bed" > "NP4-1and2flipped.bed"
awk -F'\t' '{print $4,$5,$6,$1,$2,$3,$7,$8,$9,$10,$11,$12,$13,$14,$15}' OFS="\t" "UDP4-1and3AWK.bed" > "UDP4-1and3flipped.bed"
awk -F'\t' '{print $4,$5,$6,$1,$2,$3,$7,$8,$9,$10,$11,$12,$13,$14,$15}' OFS="\t" "NP4sAWK.bed" > "NP4sflipped.bed"
awk -F'\t' '{print $4,$5,$6,$1,$2,$3,$7,$8,$9,$10,$11,$12,$13,$14,$15}' OFS="\t" "UDP4sAWK.bed" > "UDP4sflipped.bed"

#Flipped columns 123 for 456 for intersectBed purposes
#Bal = NP4-1and2 + UDP4-1and3
#Finds unique loops
intersectBed -v -a NP4-1and2flipped.bed -b UDP4-1and3flipped.bed > UniqueBalflipped.bed
intersectBed -v -a NP4sflipped.bed -b UDP4sflipped.bed > Uniqueflipped.bed
#Finds common loops
intersectBed -wa -a NP4-1and2flipped.bed -b UDP4-1and3flipped.bed > CommonBalflipped.bed
intersectBed -wa -a NP4sflipped.bed -b UDP4sflipped.bed > Commonflipped.bed

#Same as above but using Undif compared to Dif
#Finds unique loops
intersectBed -v -a UDP4-1and3flipped.bed -b NP4-1and2flipped.bed > UniqueBalu-nflipped.bed
intersectBed -v -a UDP4sflipped.bed -b NP4sflipped.bed > Uniqueu-nflipped.bed
#Finds common loops
intersectBed -wa -a UDP4-1and3flipped.bed -b NP4-1and2flipped.bed > CommonBalu-nflipped.bed
intersectBed -wa -a UDP4sflipped.bed -b NP4sflipped.bed > Commonu-nflipped.bed

#join all forward and flipped files
cat UniqueBal.bed UniqueBalflipped.bed > UniqueNP4Bal.bed
cat Unique.bed Uniqueflipped.bed > UniqueNP4.bed
cat UniqueBalu-n.bed UniqueBalu-nflipped.bed > UniqueUDP4Bal.bed
cat Uniqueu-n.bed Uniqueu-nflipped.bed > UniqueUDP4.bed
cat CommonBal.bed CommonBalflipped.bed > CommonBalNP4-UDP4.bed
cat Common.bed Commonflipped.bed > CommonNP4-UDP4.bed
cat CommonBalu-n.bed CommonBalu-nflipped.bed > CommonBalUDP4-NP4.bed
cat Commonu-n.bed Commonu-nflipped.bed > CommonUDP4-NP4.bed
cat CommonBalNP4-UDP4.bed CommonBalUDP4-NP4.bed > CommonBal.bed
cat CommonNP4-UDP4.bed CommonUDP4-NP4.bed > Common.bed

#Removes duplicates from Common file
awk '!a[$10$11$12$13]++' UniqueNP4.bed > UniqueNP4noDups.bed
awk '!a[$10$11$12$13]++' UniqueUDP4.bed > UniqueUDP4noDups.bed
awk '!a[$10$11$12$13]++' Common.bed > CommonNoDups.bed
awk '!a[$10$11$12$13]++' UniqueNP4Bal.bed > UniqueNP4BalnoDups.bed
awk '!a[$10$11$12$13]++' UniqueUDP4Bal.bed > UniqueUDP4BalnoDups.bed
awk '!a[$10$11$12$13]++' CommonBal.bed > CommonBalNoDups.bed

#Removes ones with different p and q values but same coordinates on either side
awk '!a[$2$3$5$6]++' UniqueNP4noDups.bed > UniqueNP4noDups2.bed; mv UniqueNP4noDups{2,}.bed
awk '!a[$2$3$5$6]++' UniqueUDP4noDups.bed > UniqueUDP4noDups2.bed; mv UniqueUDP4noDups{2,}.bed
awk '!a[$2$3$5$6]++' CommonNoDups.bed > CommonNoDups2.bed; mv CommonNoDups{2,}.bed
awk '!a[$5$6$2$3]++' UniqueNP4noDups.bed > UniqueNP4noDups2.bed; mv UniqueNP4noDups{2,}.bed
awk '!a[$5$6$2$3]++' UniqueUDP4noDups.bed > UniqueUDP4noDups2.bed; mv UniqueUDP4noDups{2,}.bed
awk '!a[$5$6$2$3]++' CommonNoDups.bed > CommonNoDups2.bed; mv CommonNoDups{2,}.bed

#Same as above but for Balanced data
awk '!a[$2$3$5$6]++' UniqueNP4BalnoDups.bed > UniqueNP4BalnoDups2.bed; mv UniqueNP4BalnoDups{2,}.bed
awk '!a[$2$3$5$6]++' UniqueUDP4BalnoDups.bed > UniqueUDP4BalnoDups2.bed; mv UniqueUDP4BalnoDups{2,}.bed
awk '!a[$2$3$5$6]++' CommonBalNoDups.bed > CommonBalNoDups2.bed; mv CommonBalNoDups{2,}.bed
awk '!a[$5$6$2$3]++' UniqueNP4BalnoDups.bed > UniqueNP4BalnoDups2.bed; mv UniqueNP4BalnoDups{2,}.bed
awk '!a[$5$6$2$3]++' UniqueUDP4BalnoDups.bed > UniqueUDP4BalnoDups2.bed; mv UniqueUDP4BalnoDups{2,}.bed
awk '!a[$5$6$2$3]++' CommonBalNoDups.bed > CommonBalNoDups2.bed; mv CommonBalNoDups{2,}.bed


#Puts header back on files and dummy row with 0-300000000 since plotBedpe will error out if nothing in the queried range
sed -n 'p' FitHiChIP_header_dummy.bed UniqueNP4noDups.bed > Unique_NP4s_10k_bins.bed
sed -n 'p' FitHiChIP_header_dummy.bed UniqueUDP4noDups.bed > Unique_UDP4_10k_bins.bed
sed -n 'p' FitHiChIP_header_dummy.bed CommonNoDups.bed > Common_10k_bins.bed
sed -n 'p' FitHiChIP_header_dummy.bed UniqueNP4BalnoDups.bed > Unique_NP4_1and2_10k_bins.bed
sed -n 'p' FitHiChIP_header_dummy.bed UniqueUDP4BalnoDups.bed > Unique_UDP4_1and3_10k_bins.bed
sed -n 'p' FitHiChIP_header_dummy.bed CommonBalNoDups.bed > Common_NP4_1and2_plus_UDP4_1and3_10k_bins.bed



