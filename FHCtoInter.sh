#Convert FitHiChIP data table to UCSC genome browser data
awk -F'\t' '{print $1,$2,$6,".",$14/5.470,$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "NP4-10K-01.bed" > "NP4-10K-01_INTER.bed"
awk -F'\t' '{print $1,$2,$6,".",$14/5.505,$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "UDP4-10K-01.bed" > "UDP4-10K-01_INTER.bed"
