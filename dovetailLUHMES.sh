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

#7.6 Call peaks using MACS3 (MACS2 was not able to run on UCDavis cluster)
macs3 callpeak –t prefix.primary.aln.bed -n prefix.macs3; echo "#7.6 Macs3" | mail -s "#7.6 Macs3" ojg333@gmail.com

#8 Library QC
python3 ./HiChiP/get_qc.py -p stats.txt

#9 ChIP Enrichment Stats
./HiChiP/enrichment_stats.sh -g hg38.genome -b mapped.PT.bam -p /share/lasallelab/Oran/dovetail/ENCFF017XLW.bed -t 50 -x CTCF; echo "#9 ChIP Enrichment Stats" | mail -s "#9 ChIP Enrichment Stats" ojg333@gmail.com