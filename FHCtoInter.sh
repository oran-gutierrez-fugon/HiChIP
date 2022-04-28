#Strips header
tail -n +2 /share/lasallelab/Oran/dovetail/luhmes/NP4s.bed > NP4s-NH.bed
#Convert FitHiChIP data table to UCSC genome browser data
awk -F'\t' '{print $1,$2,$6,".",$14/5.470,$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "NP4-10K-01.bed" > "NP4-10K-01-hg38_INTER.bed"
awk -F'\t' '{print $1,$2,$6,".",$14/5.505,$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "UDP4-10K-01.bed" > "UDP4-10K-01-hg38_INTER.bed"
awk -F'\t' '{print $1,$2,$6,".",$14/5.470,$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "NP4s.id.all.hg19.bed" > "NP4s-10K-01-hg19_INTER.bed"
awk -F'\t' '{print $1,$2,$6,".",$14/5.470,$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "UDP4s.id.all.hg19.bed" > "UDP4s-10K-01-hg19_INTER.bed"

#Sorts and converts to bigbed for viewing in UCSC browser
bedSort NP4s-10K-01-hg19_INTER.bed NP4s-10K-01-hg19_INTER.bed
bedToBigBed -as=interact.as -type=bed5+13 NP4s-10K-01-hg19_INTER.bed hg19.chrom.sizes NP4s-10K-01-hg19_INTER.bb

#Tries to fix error when start is greater than end columns
awk -F'\t' '{
if ($2 >= $3)
{
print $1,$15,$11,$4,$5,$6,$7,$8,$9,$15,$16,$12,$13,$14,$10,$11,$17,$18
}
else
{
print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18
}
}' OFS="\t" "NP4s-10K-01-hg19_INTER.bed" > "NP4s-10K-01-hg19_INTER_SORT.bed"


#sample that works with interact track type
track type=interact name="NP4 hg38 head" description="NP4 hg38" useScore=on maxHeightPixels=200:100:50 visibility=full browser position chr1:10,520,000-10,960,000
chr1	10530000	10870000	.	329.799	1804	.	0	chr1	10530000	10540000	.	.	chr1	10860000	10870000	.	.
chr1	10510000	10950000	.	329.799	1804	.	0	chr1	10510000	10520000	.	.	chr1	10940000	10950000	.	.
chr1	10500000	10870000	.	329.799	1804	.	0	chr1	10500000	10510000	.	.	chr1	10860000	10870000	.	.

