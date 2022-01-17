#first copied hichip and pairix folders
#then all hg38 titled files to new directory "merged" and 'neuronscat"
#must run each sample group in separate folders though since aligned.sam file would be overwritten
#adding email commands informs you when job is done (please change to your own email :P)
#using concatenated samples although processing fastq samples separately and then using bedtools intersectBed would be better
#If get error like numpy not detected, close down terminal and restart with just HiChiP module and env

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
#Don't try running both neurons and dif at the same time or will error out.
#Don't run on screen, will also cause memory issues on UCDavis Cluster
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
#corrected -view removed dash and input file namen to mapped.PT.bam
samtools view -h -F 0x900 mapped.PT.bam | bedtools bamtobed -i stdin > prefix.primary.aln.bed

#7.6 Call peaks using MACS2 (Must be typed out not pasted or ran as snippet)
module load macs2
macs2 callpeak –t prefix.primary.aln.bed --nomodel -n prefix.macs2

#8 Library QC
python3 ./HiChiP/get_qc.py -p stats.txt

#9 ChIP Enrichment Stats
#Using narrowpeak bedfile format resulting from 1D peak call in 7.6
#Since using module and env created by UCDavis core not using ./HiChiP directory
module load hichip
source activate hichip-cb6872b
enrichment_stats.sh -g hg38.genome -b mapped.PT.bam -p /share/lasallelab/Oran/dovetail/luhmes/merged/prefix.macs2_peaks.narrowPeak -t 30 -x CTCF; echo "#9 ChIP Enrichment Stats" | mail -s "#9 ChIP Enrichment Stats" ojg333@gmail.com

#10 Plot ChIP enrichment
#If needed reload module and env
module load hichip
source activate hichip-cb6872b
plot_chip_enrichment.py -bam mapped.PT.bam -peaks /share/lasallelab/Oran/dovetail/luhmes/merged/prefix.macs3_peaks.narrowPeak -output enrichment.png; echo "#10 Plot ChIP enrichment" | mail -s "#10 Plot ChIP enrichment" ojg333@gmail.com

#17 Filtered pairs to HiCpro pairs
#Can skip to here if dont need hic or cooler contact matrix
grep -v '#' mapped.pairs| awk -F"\t" '{print $1"\t"$2"\t"$3"\t"$6"\t"$4"\t"$5"\t"$7}' | gzip -c > hicpro_mapped.pairs.gz; echo "#17 pairs to HiCpro" | mail -s "#17 pairs to HiCpro" ojg333@gmail.com

#20 Runs FitHiChIP
FitHiChIP_HiCPro.sh -C /share/lasallelab/Oran/dovetail/luhmes/neuronscat/config.txt; echo "Process done" | mail -s "Process done" ojg333@gmail.com