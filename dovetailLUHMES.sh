#first copied hichip and pairix folders
#then all hg38 titled files to new directory "merged" and 'neuronscat"
#must run each sample group in separate folders though since aligned.sam file would be overwritten
#adding email commands informs you when job is done
#using concatenated samples

#sample nomenclature used
neurons_R2.fastq.gz  undif_R1.fastq.gz

#1 bwa fastq to aligned.sam
bwa mem -5SP -T0 -t50 hg38.fasta undif_R1.fastq.gz undif_R2.fastq.gz -o aligned.sam; echo "#1 bwa done" | mail -s "#1 bwa done" ojg333@gmail.com

#for neurons from neuronscat folder
bwa mem -5SP -T0 -t50 hg38.fasta neurons_R1.fastq.gz neurons_R2.fastq.gz -o aligned.sam; echo "#1 bwa done" | mail -s "#1 bwa done" ojg333@gmail.com

#2 Pairtools aligned sam to parsed.pairsam
pairtools parse --min-mapq 40 --walks-policy 5unique --max-inter-align-gap 30 --nproc-in 50 --nproc-out 50 --chroms-path hg38.genome aligned.sam >  parsed.pairsam; echo "#2 pairtools done" | mail -s "#2 pairtools done" ojg333@gmail.com

#3 Sorting the pairsam file. 
#Must create temp/ directory or this step will error out! 
#Don't try running both neurons and dif at the same time or will error out also.
#FOR NEURONS
pairtools sort --nproc 40 --tmpdir=/share/lasallelab/Oran/dovetail/luhmes/neuronscat/temp/ parsed.pairsam > sorted.pairsam; echo "#3 NEURON sorting pairsam done" | mail -s "#3 sorting pairsam done" ojg333@gmail.com

#For UNDIF
pairtools sort --nproc 40 --tmpdir=/share/lasallelab/Oran/dovetail/luhmes/merged/temp/ parsed.pairsam > sorted.pairsam; echo "#3 UNDIF sorting pairsam done" | mail -s "#3 sorting pairsam done" ojg333@gmail.com

#4 Pairtools Deduplicate. Can run neurons and undif in parallel, 
#lowered processors used to account for running in parallel
pairtools dedup --nproc-in 30 --nproc-out 30 --mark-dups --output-stats stats.txt --output dedup.pairsam sorted.pairsam; echo "#4 Pairtools Deduplicate done" | mail -s "#4 Pairtools Deduplicate done" ojg333@gmail.com

#5 Pairtools split to dedup.pairsam
pairtools split --nproc-in 30 --nproc-out 30 --output-pairs mapped.pairs --output-sam unsorted.bam dedup.pairsam; echo "#5 Pairtools split to dedup.pairsam" | mail -s "#5 Pairtools split to dedup.pairsam" ojg333@gmail.com

#6 Generating the final bam file with Samtools sort
samtools sort -@30 -o mapped.PT.bam unsorted.bam; echo "#6 Samtools sort" | mail -s "#6 Samtools sort" ojg333@gmail.com

#7 samtools index bam file
samtools index mapped.PT.bam; echo "#7 samtools index bam file" | mail -s "#7 samtools index bam file" ojg333@gmail.com

#Calling 1D peaks from concatenated control samples (undifferentiated LUHMES)
#Only needed since no gold standard ENCODE ChIP-seq data for LUHMES cells

#7.5 Select the primary alignment in the bam file and convert to bed format
#corrected -view removed dash and input file namento mapped.PT.bam
samtools view -h -F 0x900 mapped.PT.bam | bedtools bamtobed -i stdin > prefix.primary.aln.bed

#7.6 Call peaks using MACS2
Macs2 callpeak –t prefix.primary.aln.bed -n prefix.macs2; echo "#7.6 Macs2" | mail -s "#7.6 Macs2" ojg333@gmail.com


#8 Library QC
python3 ./HiChiP/get_qc.py -p stats.txt

#results for neurons
#Total Read Pairs                              703,455,028  100%
#Unmapped Read Pairs                           34,213,851   4.86%
#Mapped Read Pairs                             570,472,581  81.1%
#PCR Dup Read Pairs                            256,466,690  36.46%
#No-Dup Read Pairs                             314,005,891  44.64%
#No-Dup Cis Read Pairs                         241,703,113  76.97%
#No-Dup Trans Read Pairs                       72,302,778   23.03%
#No-Dup Valid Read Pairs (cis >= 1kb + trans)  178,847,900  56.96%
#No-Dup Cis Read Pairs < 1kb                   135,157,991  43.04%
#No-Dup Cis Read Pairs >= 1kb                  106,545,122  33.93%
#No-Dup Cis Read Pairs >= 10kb                 48,968,925   15.59%

undif
Total Read Pairs                              1,200,050,143  100%
Unmapped Read Pairs                           49,185,152     4.1%
Mapped Read Pairs                             1,002,756,649  83.56%
PCR Dup Read Pairs                            379,279,444    31.61%
No-Dup Read Pairs                             623,477,205    51.95%
No-Dup Cis Read Pairs                         498,385,368    79.94%
No-Dup Trans Read Pairs                       125,091,837    20.06%
No-Dup Valid Read Pairs (cis >= 1kb + trans)  369,337,159    59.24%
No-Dup Cis Read Pairs < 1kb                   254,140,046    40.76%
No-Dup Cis Read Pairs >= 1kb                  244,245,322    39.17%
No-Dup Cis Read Pairs >= 10kb                 101,494,724    16.28%


#9 ChIP Enrichment Stats
./HiChiP/enrichment_stats.sh -g hg38.genome -b mapped.PT.bam -p /share/lasallelab/Oran/dovetail/ENCFF017XLW.bed -t 50 -x CTCF; echo "#9 ChIP Enrichment Stats" | mail -s "#9 ChIP Enrichment Stats" ojg333@gmail.com


