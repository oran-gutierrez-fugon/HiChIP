# download hg38 to hg19 chain
wget http://hgdownload.soe.ucsc.edu/goldenPath/hg38/liftOver/hg38ToHg19.over.chain.gz

# install liftOver in conda environment
conda install ucsc-liftover

# separate coordinates for liftover
tail -n +2 /share/lasallelab/Oran/dovetail/luhmes/UDP4s.bed | awk 'BEGIN{OFS="\t"; a=1}{id="ID_"a;a+=1; print id"\t"$0}' > UDP4s.id.bed
awk '{OFS="\t"}{print $2,$3,$4,$1}' UDP4s.id.bed > UDP4s.id.1.bed
awk '{OFS="\t"}{print $5,$6,$7,$1}' UDP4s.id.bed > UDP4s.id.2.bed
cut -f1,8- UDP4s.id.bed > UDP4s.id.annot.bed

# liftover coordinates from hg38 to hg19
liftOver UDP4s.id.1.bed hg38ToHg19.over.chain UDP4s.id.1.hg19.bed UDP4s.id.1_unMapped
liftOver UDP4s.id.2.bed hg38ToHg19.over.chain UDP4s.id.2.hg19.bed UDP4s.id.2_unMapped

# merge lifted coordinates and annotations by ID
join -t $'\t' -1 4 -2 4 <(sort -k4,4 UDP4s.id.1.hg19.bed) <(sort -k4,4 UDP4s.id.2.hg19.bed) > UDP4s.id.1_2.hg19.bed
join -t $'\t' -1 1 -2 1 <(sort -k1,1 UDP4s.id.1_2.hg19.bed) <(sort -k1,1 UDP4s.id.annot.bed) | cut -f2- > UDP4s.id.all.hg19.bed

# convert to longrange format
python3 bedpeToLongRange.py -i UDP4s.id.all.hg19.bed -f 14

# upload to bioshare
rsync -vrt --no-p --no-g --chmod=ugo=rwX UDP4s.id.all.hg19_washu.bed.gz bioshare@bioshare.bioinformatics.ucdavis.edu:/hbl76b4wa1i6dvm/
rsync -vrt --no-p --no-g --chmod=ugo=rwX UDP4s.id.all.hg19_washu.bed.gz.tbi bioshare@bioshare.bioinformatics.ucdavis.edu:/hbl76b4wa1i6dvm/

# visualize in ucsc genome browser custom track
track type="longTabix" name="NP4 HiChIP" bigDataUrl=https://bioshare.bioinformatics.ucdavis.edu/bioshare/download/hbl76b4wa1i6dvm/UDP4s.id.all.hg19_washu.bed.gz