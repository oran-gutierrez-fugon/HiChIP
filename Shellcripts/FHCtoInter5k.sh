##download hg38 to hg19 chain
#wget http://hgdownload.soe.ucsc.edu/goldenPath/hg38/liftOver/hg38ToHg19.over.chain.gz
#gunzip hg38ToHg19.over.chain.gz

##install liftOver in conda environment
#conda install ucsc-liftover
#created env share/lasallelab/Oran/dovetail/luhmes/lift created with all needed programs 
#Files placed in /share/lasallelab/Oran/dovetail/luhmes/UCSC folder



#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Copy this block and run from /share/lasallelab/Oran/dovetail/luhmes/UCSC/ folder

#created alias li that loads lift env and changes to UCSC directory
li
#creates and changes to intermediates folder
mkdir inter
cd inter
# separate coordinates for liftover
tail -n +2 /share/lasallelab/Oran/dovetail/luhmes/UCSC/NP4-5K-01.bed | awk 'BEGIN{OFS="\t"; a=1}{id="ID_"a;a+=1; print id"\t"$0}' > NP4s.id.bed
awk '{OFS="\t"}{print $2,$3,$4,$1}' NP4s.id.bed > NP4s.id.1.bed
awk '{OFS="\t"}{print $5,$6,$7,$1}' NP4s.id.bed > NP4s.id.2.bed
cut -f1,8- NP4s.id.bed > NP4s.id.annot.bed
# same for undif
tail -n +2 /share/lasallelab/Oran/dovetail/luhmes/UCSC/UDP4-5K-01.bed | awk 'BEGIN{OFS="\t"; a=1}{id="ID_"a;a+=1; print id"\t"$0}' > UDP4s.id.bed
awk '{OFS="\t"}{print $2,$3,$4,$1}' UDP4s.id.bed > UDP4s.id.1.bed
awk '{OFS="\t"}{print $5,$6,$7,$1}' UDP4s.id.bed > UDP4s.id.2.bed
cut -f1,8- UDP4s.id.bed > UDP4s.id.annot.bed

# liftover coordinates from hg38 to hg19
liftOver NP4s.id.1.bed /share/lasallelab/Oran/dovetail/luhmes/UCSC/hg38ToHg19.over.chain NP4s.id.1.hg19.bed NP4s.id.1_unMapped
liftOver NP4s.id.2.bed /share/lasallelab/Oran/dovetail/luhmes/UCSC/hg38ToHg19.over.chain NP4s.id.2.hg19.bed NP4s.id.2_unMapped
# for undif
liftOver UDP4s.id.1.bed /share/lasallelab/Oran/dovetail/luhmes/UCSC/hg38ToHg19.over.chain UDP4s.id.1.hg19.bed UDP4s.id.1_unMapped
liftOver UDP4s.id.2.bed /share/lasallelab/Oran/dovetail/luhmes/UCSC/hg38ToHg19.over.chain UDP4s.id.2.hg19.bed UDP4s.id.2_unMapped

# merge lifted coordinates and annotations by ID
join -t $'\t' -1 4 -2 4 <(sort -k4,4 NP4s.id.1.hg19.bed) <(sort -k4,4 NP4s.id.2.hg19.bed) > NP4s.id.1_2.hg19.bed
join -t $'\t' -1 1 -2 1 <(sort -k1,1 NP4s.id.1_2.hg19.bed) <(sort -k1,1 NP4s.id.annot.bed) | cut -f2- > NP4s-5k-01_hg19.bed
# for undif
join -t $'\t' -1 4 -2 4 <(sort -k4,4 UDP4s.id.1.hg19.bed) <(sort -k4,4 UDP4s.id.2.hg19.bed) > UDP4s.id.1_2.hg19.bed
join -t $'\t' -1 1 -2 1 <(sort -k1,1 UDP4s.id.1_2.hg19.bed) <(sort -k1,1 UDP4s.id.annot.bed) | cut -f2- > UDP4s-5k-01_hg19.bed

#Convert FitHiChIP data table to UCSC genome browser data
awk -F'\t' '{print $1,$2,$6,".",int($14/5.470),$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "/share/lasallelab/Oran/dovetail/luhmes/UCSC/NP4-5K-01.bed" > "NP4s-5K-01-hg38_INTER.bed"
awk -F'\t' '{print $1,$2,$6,".",int($14/8.844),$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "/share/lasallelab/Oran/dovetail/luhmes/UCSC/UDP4-5K-01.bed" > "UDP4s-5K-01-hg38_INTER.bed"
#hg19
awk -F'\t' '{print $1,$2,$6,".",int($14/5.470),$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "NP4s-5k-01_hg19.bed" > "NP4s-5K-01-hg19_INTER.bed"
awk -F'\t' '{print $1,$2,$6,".",int($14/8.844),$14,".","0",$1,$2,$3,".",".",$4,$5,$6,".","."}' OFS="\t" "UDP4s-5k-01_hg19.bed" > "UDP4s-5K-01-hg19_INTER.bed"

#Clips coordinates that are out of range for genome
#hg19
bedClip NP4s-5K-01-hg19_INTER.bed /share/lasallelab/Oran/dovetail/luhmes/UCSC/hg19.chrom.sizes NP4s-5K-01-hg19_INTER_CLIP.bed
bedClip UDP4s-5K-01-hg19_INTER.bed /share/lasallelab/Oran/dovetail/luhmes/UCSC/hg19.chrom.sizes UDP4s-5K-01-hg19_INTER_CLIP.bed
#hg38 just have to remove headers
tail -n +2 NP4s-5K-01-hg38_INTER.bed > NP4s-5K-01-hg38_INTER_CLIP.bed
tail -n +2 UDP4s-5K-01-hg38_INTER.bed > UDP4s-5K-01-hg38_INTER_CLIP.bed

#Sorts and converts to bigbed for viewing in UCSC browser
bedSort NP4s-5K-01-hg19_INTER_CLIP.bed NP4s-5K-01-hg19_INTER_SORT.bed
bedSort UDP4s-5K-01-hg19_INTER_CLIP.bed UDP4s-5K-01-hg19_INTER_SORT.bed
bedSort NP4s-5K-01-hg38_INTER_CLIP.bed NP4s-5K-01-hg38_INTER_SORT.bed
bedSort UDP4s-5K-01-hg38_INTER_CLIP.bed UDP4s-5K-01-hg38_INTER_SORT.bed

bedToBigBed -as=/share/lasallelab/Oran/dovetail/luhmes/UCSC/interact.as -type=bed5+13 NP4s-5K-01-hg19_INTER_SORT.bed /share/lasallelab/Oran/dovetail/luhmes/UCSC/hg19.chrom.sizes /share/lasallelab/Oran/dovetail/luhmes/UCSC/NP4s-5K-01_hg19.bb
bedToBigBed -as=/share/lasallelab/Oran/dovetail/luhmes/UCSC/interact.as -type=bed5+13 UDP4s-5K-01-hg19_INTER_SORT.bed /share/lasallelab/Oran/dovetail/luhmes/UCSC/hg19.chrom.sizes /share/lasallelab/Oran/dovetail/luhmes/UCSC/UDP4s-5K-01_hg19.bb
bedToBigBed -as=/share/lasallelab/Oran/dovetail/luhmes/UCSC/interact.as -type=bed5+13 NP4s-5K-01-hg38_INTER_SORT.bed /share/lasallelab/Oran/dovetail/luhmes/UCSC/hg38.chrom.sizes /share/lasallelab/Oran/dovetail/luhmes/UCSC/NP4s-5K-01_hg38.bb
bedToBigBed -as=/share/lasallelab/Oran/dovetail/luhmes/UCSC/interact.as -type=bed5+13 UDP4s-5K-01-hg38_INTER_SORT.bed /share/lasallelab/Oran/dovetail/luhmes/UCSC/hg38.chrom.sizes /share/lasallelab/Oran/dovetail/luhmes/UCSC/UDP4s-5K-01_hg38.bb

#Deletes intermediates folder
cd ..
rm -r inter

#include this to add last enter space needed to execute rm
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<End copy





#Upload to bioshare (Dennis labs bioshare)
rsync -vrt --no-p --no-g --chmod=ugo=rwX NP4s-5K-01_hg19.bb bioshare@bioshare.bioinformatics.ucdavis.edu:/hbl76b4wa1i6dvm/
rsync -vrt --no-p --no-g --chmod=ugo=rwX UDP4s-5K-01_hg19.bb bioshare@bioshare.bioinformatics.ucdavis.edu:/hbl76b4wa1i6dvm/
#hg38
rsync -vrt --no-p --no-g --chmod=ugo=rwX NP4s-5K-01_hg38.bb bioshare@bioshare.bioinformatics.ucdavis.edu:/hbl76b4wa1i6dvm/
rsync -vrt --no-p --no-g --chmod=ugo=rwX UDP4s-5K-01_hg38.bb bioshare@bioshare.bioinformatics.ucdavis.edu:/hbl76b4wa1i6dvm/

#LaSalle lab track hub #working on permissions
#rsync -vrt --no-p --no-g --chmod=ugo=rwX NP4s-5K-01_hg19.bb bioshare@bioshare.bioinformatics.ucdavis.edu:/4jo97m7umuy7a9a/LUHMES\ HiChIP/NP4s-5K-01_hg19.bb
#rsync -vrt --no-p --no-g --chmod=ugo=rwX UDP4s-5K-01_hg19.bb bioshare@bioshare.bioinformatics.ucdavis.edu:'/4jo97m7umuy7a9a/LUHMES\ HiChIP/'

#Upload to UCSC genome browser
track type=bigInteract interactUp=true name="UDP4s 5K hg19" description="UDP4s 5K hg19" useScore=on visibility=full color=100,50,0 bigDataUrl=https://bioshare.bioinformatics.ucdavis.edu/bioshare/download/hbl76b4wa1i6dvm/UDP4s-5K-01_hg19.bb
track type=bigInteract interactUp=true name="NP4s 5K hg19" description="NP4s 5K hg19" useScore=on visibility=full color=0,60,120 bigDataUrl=https://bioshare.bioinformatics.ucdavis.edu/bioshare/download/hbl76b4wa1i6dvm/NP4s-5K-01_hg19.bb
#Must change to hg38 in browser first
track type=bigInteract interactUp=true name="UDP4s 5K hg38" description="UDP4s 5K hg38" useScore=on visibility=full color=100,50,0 bigDataUrl=https://bioshare.bioinformatics.ucdavis.edu/bioshare/download/hbl76b4wa1i6dvm/UDP4s-5K-01_hg38.bb
track type=bigInteract interactUp=true name="NP4s 5K hg38" description="NP4s 5K hg38" useScore=on visibility=full color=0,60,120 bigDataUrl=https://bioshare.bioinformatics.ucdavis.edu/bioshare/download/hbl76b4wa1i6dvm/NP4s-5K-01_hg38.bb
