##download hg38 to hg19 chain
#wget http://hgdownload.soe.ucsc.edu/goldenPath/hg38/liftOver/hg38ToHg19.over.chain.gz
#gunzip hg38ToHg19.over.chain.gz

##install liftOver in conda environment
#conda install ucsc-liftover

# separate coordinates for liftover
tail -n +2 /share/lasallelab/Oran/dovetail/luhmes/NP4s-5k-01.bed | awk 'BEGIN{OFS="\t"; a=1}{id="ID_"a;a+=1; print id"\t"$0}' > NP4s.id.bed
awk '{OFS="\t"}{print $2,$3,$4,$1}' NP4s.id.bed > NP4s.id.1.bed
awk '{OFS="\t"}{print $5,$6,$7,$1}' NP4s.id.bed > NP4s.id.2.bed
cut -f1,8- NP4s.id.bed > NP4s.id.annot.bed

tail -n +2 /share/lasallelab/Oran/dovetail/luhmes/UDP4s-5k-01.bed | awk 'BEGIN{OFS="\t"; a=1}{id="ID_"a;a+=1; print id"\t"$0}' > UDP4s.id.bed
awk '{OFS="\t"}{print $2,$3,$4,$1}' UDP4s.id.bed > UDP4s.id.1.bed
awk '{OFS="\t"}{print $5,$6,$7,$1}' UDP4s.id.bed > UDP4s.id.2.bed
cut -f1,8- UDP4s.id.bed > UDP4s.id.annot.bed

# liftover coordinates from hg38 to hg19
liftOver NP4s.id.1.bed hg38ToHg19.over.chain NP4s.id.1.hg19.bed NP4s.id.1_unMapped
liftOver NP4s.id.2.bed hg38ToHg19.over.chain NP4s.id.2.hg19.bed NP4s.id.2_unMapped

liftOver UDP4s.id.1.bed hg38ToHg19.over.chain UDP4s.id.1.hg19.bed UDP4s.id.1_unMapped
liftOver UDP4s.id.2.bed hg38ToHg19.over.chain UDP4s.id.2.hg19.bed UDP4s.id.2_unMapped

# merge lifted coordinates and annotations by ID
join -t $'\t' -1 4 -2 4 <(sort -k4,4 NP4s.id.1.hg19.bed) <(sort -k4,4 NP4s.id.2.hg19.bed) > NP4s.id.1_2.hg19.bed
join -t $'\t' -1 1 -2 1 <(sort -k1,1 NP4s.id.1_2.hg19.bed) <(sort -k1,1 NP4s.id.annot.bed) | cut -f2- > NP4s-5k-01_hg19.bed

join -t $'\t' -1 4 -2 4 <(sort -k4,4 UDP4s.id.1.hg19.bed) <(sort -k4,4 UDP4s.id.2.hg19.bed) > UDP4s.id.1_2.hg19.bed
join -t $'\t' -1 1 -2 1 <(sort -k1,1 UDP4s.id.1_2.hg19.bed) <(sort -k1,1 UDP4s.id.annot.bed) | cut -f2- > UDP4s-5k-01_hg19.bed

#Convert FitHiChIP data table to UCSC genome browser data
awk -F'\t' '{print $1,$2,$6,".",int($14/5.470),$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "NP4-5K-01.bed" > "NP4-5K-01-hg38_INTER.bed"
awk -F'\t' '{print $1,$2,$6,".",int($14/8.844),$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "UDP4-5K-01.bed" > "UDP4-5K-01-hg38_INTER.bed"
awk -F'\t' '{print $1,$2,$6,".",int($14/5.470),$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "NP4s-5k-01_hg19.bed" > "NP4s-5K-01-hg19_INTER.bed"
awk -F'\t' '{print $1,$2,$6,".",int($14/8.844),$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "UDP4s-5k-01_hg19.bed" > "UDP4s-5K-01-hg19_INTER.bed"

#Clips coordinates that are out of range for genome
#hg19
bedClip NP4s-5K-01-hg19_INTER.bed hg19.chrom.sizes NP4s-5K-01-hg19_INTER_CLIP.bed
bedClip UDP4s-5K-01-hg19_INTER.bed hg19.chrom.sizes UDP4s-5K-01-hg19_INTER_CLIP.bed
#hg38
bedClip NP4s-5K-01-hg38_INTER.bed hg38.chrom.sizes NP4s-5K-01-hg38_INTER_CLIP.bed
bedClip NP4s-5K-01-hg38_INTER.bed hg38.chrom.sizes UDP4s-5K-01-hg38_INTER_CLIP.bed

#Sorts and converts to bigbed for viewing in UCSC browser
bedSort NP4s-5K-01-hg19_INTER_CLIP.bed NP4s-5K-01-hg19_INTER_SORT.bed
bedSort UDP4s-5K-01-hg19_INTER_CLIP.bed UDP4s-5K-01-hg19_INTER_SORT.bed
bedSort NP4s-5K-01-hg19_INTER_CLIP.bed NP4s-5K-01-hg38_INTER_SORT.bed
bedSort UDP4s-5K-01-hg19_INTER_CLIP.bed UDP4s-5K-01-hg38_INTER_SORT.bed

bedToBigBed -as=interact.as -type=bed5+13 NP4s-5K-01-hg19_INTER_SORT.bed hg19.chrom.sizes NP4s-5K-01_hg19.bb
bedToBigBed -as=interact.as -type=bed5+13 UDP4s-5K-01-hg19_INTER_SORT.bed hg19.chrom.sizes UDP4s-5K-01_hg19.bb
bedToBigBed -as=interact.as -type=bed5+13 NP4s-5K-01-hg38_INTER_SORT.bed hg38.chrom.sizes NP4s-5K-01_hg38.bb
bedToBigBed -as=interact.as -type=bed5+13 UDP4s-5K-01-hg38_INTER_SORT.bed hg38.chrom.sizes UDP4s-5K-01_hg38.bb

#Upload to bioshare (Dennis labs bioshare)
rsync -vrt --no-p --no-g --chmod=ugo=rwX NP4s-5K-01_hg19.bb bioshare@bioshare.bioinformatics.ucdavis.edu:/hbl76b4wa1i6dvm/
rsync -vrt --no-p --no-g --chmod=ugo=rwX UDP4s-5K-01_hg19.bb bioshare@bioshare.bioinformatics.ucdavis.edu:/hbl76b4wa1i6dvm/

rsync -vrt --no-p --no-g --chmod=ugo=rwX NP4s-5K-01_hg38.bb bioshare@bioshare.bioinformatics.ucdavis.edu:/hbl76b4wa1i6dvm/
rsync -vrt --no-p --no-g --chmod=ugo=rwX UDP4s-5K-01_hg38.bb bioshare@bioshare.bioinformatics.ucdavis.edu:/hbl76b4wa1i6dvm/

#LaSalle lab track hub #working on permissions
#rsync -vrt --no-p --no-g --chmod=ugo=rwX NP4s-5K-01_hg19.bb bioshare@bioshare.bioinformatics.ucdavis.edu:/4jo97m7umuy7a9a/LUHMES\ HiChIP/NP4s-5K-01_hg19.bb
#rsync -vrt --no-p --no-g --chmod=ugo=rwX UDP4s-5K-01_hg19.bb bioshare@bioshare.bioinformatics.ucdavis.edu:'/4jo97m7umuy7a9a/LUHMES\ HiChIP/'

#Upload to UCSC genome browser
#track type=bigInteract interactUp=true name="NP4s hg19" description="NP4s hg19" useScore=on visibility=full bigDataUrl=https://bioshare.bioinformatics.ucdavis.edu/bioshare/download/4jo97m7umuy7a9a/LUHMEShichip/NP4s-5K-01_hg19.bb
track type=bigInteract interactUp=true name="UDP4s hg19" description="UDP4s hg19" useScore=on visibility=full bigDataUrl=https://bioshare.bioinformatics.ucdavis.edu/bioshare/download/hbl76b4wa1i6dvm/UDP4s-5K-01_hg19_INTER.bb
track type=bigInteract interactUp=true name="NP4s hg38" description="NP4s hg38" useScore=on visibility=full bigDataUrl=https://bioshare.bioinformatics.ucdavis.edu/bioshare/download/hbl76b4wa1i6dvm/NP4s-5K-01_hg38_INTER.bb
track type=bigInteract interactUp=true name="UDP4s hg38" description="UDP4s hg38" useScore=on visibility=full bigDataUrl=https://bioshare.bioinformatics.ucdavis.edu/bioshare/download/hbl76b4wa1i6dvm/UDP4s-5K-01_hg38_INTER.bb
