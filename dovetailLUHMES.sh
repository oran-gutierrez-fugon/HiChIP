#KEY for names is found in UNI2695_sample_sheetDECODED.csv
#Concatenated all 5 Undif and all 3 dif
#Will also concatenate just NP4-1 with NP4-2 (DTG-HiChIP-145,DTG-HiChIP-146 ; DTG-HiChIP-135,DTG-HiChIP-136) for neurons and UDP4-1 with UDP4-2 (DTG-HiChIP-137,DTG-HiChIP-138 ; DTG-HiChIP-143, DTG-HiChIP-144).  Will also concat UDP2-1 and UDP2-2 (DTG-HiChIP-139,DTG-HiChIP-140 ; DTG-HiChIP-147,DTG-HiChIP-148) since its from an earlier passage
#Remember to load other modules as before when using xmen env if need to install something since this loads anaconda
#Count number of pairs in a .pairs.gz file
zcat file.pairs.gz | grep -v "#" | wc -l
#Concatenated neurons number of reads 314005891
#Concatenated undif number of reads 623477205
#percent neurons/undif reads 0.50363652188
#After subsampling ended up with 314033091
#Command for subsampling (33 is seed for random number in this example)
pairtools sample -s 33 --nproc-in 20 --nproc-out 20 -o subsample33.pairs.gz 0.50363652188 mapped.pairs.gz


#Example for Neurons R1's  cat sampleA_S1_R1.fastq.gz  sampleB_S2_R1.fastq.gz > Condition1_R1.fastq.gz
#NP4-1 with NP4-2 R1
cat DTG-HiChIP-145_R1_001.fastq.gz  DTG-HiChIP-146_R1_001.fastq.gz DTG-HiChIP-135_R1_001.fastq.gz DTG-HiChIP-136_R1_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/NP4-1and2/NP4-1-2_R1.fastq.gz
#NP4-1 with NP4-2 R2
cat DTG-HiChIP-145_R2_001.fastq.gz  DTG-HiChIP-146_R2_001.fastq.gz DTG-HiChIP-135_R2_001.fastq.gz DTG-HiChIP-136_R2_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/NP4-1and2/NP4-1-2_R2.fastq.gz
#NP4-1 with NP4-3 R1
cat DTG-HiChIP-145_R1_001.fastq.gz  DTG-HiChIP-146_R1_001.fastq.gz DTG-HiChIP-131_R1_001.fastq.gz  DTG-HiChIP-132_R1_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/NP4-1and3/NP4-1-3_R1.fastq.gz
#NP4-1 with NP4-3 R2
cat DTG-HiChIP-145_R2_001.fastq.gz  DTG-HiChIP-146_R2_001.fastq.gz DTG-HiChIP-131_R2_001.fastq.gz  DTG-HiChIP-132_R2_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/NP4-1and3/NP4-1-3_R2.fastq.gz
#UDP4-1 with UDP4-2 R1
cat DTG-HiChIP-137_R1_001.fastq.gz  DTG-HiChIP-138_R1_001.fastq.gz DTG-HiChIP-143_R1_001.fastq.gz DTG-HiChIP-144_R1_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/UDP4-1-2_R1.fastq.gz
#UDP2-1 with UDP2-2 R1
cat DTG-HiChIP-139_R1_001.fastq.gz  DTG-HiChIP-140_R1_001.fastq.gz DTG-HiChIP-147_R1_001.fastq.gz DTG-HiChIP-148_R1_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/UDP2/UDP2-1-2_R1.fastq.gz
#UDP2-1 with UDP2-2 R2
cat DTG-HiChIP-139_R2_001.fastq.gz  DTG-HiChIP-140_R2_001.fastq.gz DTG-HiChIP-147_R2_001.fastq.gz DTG-HiChIP-148_R2_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/UDP2/UDP2-1-2_R2.fastq.gz

#UDP4-1 with UDP4-3 R1
cat DTG-HiChIP-137_R1_001.fastq.gz  DTG-HiChIP-138_R1_001.fastq.gz DTG-HiChIP-141_R1_001.fastq.gz DTG-HiChIP-142_R1_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/UDP4-1-2_R1.fastq.gz

#UDP4-1 with UDP4-2 R2
cat DTG-HiChIP-137_R2_001.fastq.gz  DTG-HiChIP-138_R2_001.fastq.gz DTG-HiChIP-143_R2_001.fastq.gz DTG-HiChIP-144_R2_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/UDP4-1-2_R2.fastq.gz
#UDP4-1 with UDP4-3 R2
cat DTG-HiChIP-137_R2_001.fastq.gz  DTG-HiChIP-138_R2_001.fastq.gz DTG-HiChIP-141_R2_001.fastq.gz DTG-HiChIP-141_R2_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/UDP4-1and3_R2.fastq.gz


#all UDP4s for 3 to 3 comparison in diff analysis
#UDP4-1 with UDP4-2 and UDP4-3 R1
cat DTG-HiChIP-137_R1_001.fastq.gz  DTG-HiChIP-138_R1_001.fastq.gz DTG-HiChIP-143_R1_001.fastq.gz DTG-HiChIP-144_R1_001.fastq.gz DTG-HiChIP-141_R1_001.fastq.gz DTG-HiChIP-142_R1_001.fastq.gz> /share/lasallelab/Oran/dovetail/luhmes/allUDP4sconcat/UDP4-1-2-3_R1.fastq.gz
#UDP4-1 with UDP4-2 and UDP4-3 R2
cat DTG-HiChIP-137_R2_001.fastq.gz  DTG-HiChIP-138_R2_001.fastq.gz DTG-HiChIP-143_R2_001.fastq.gz DTG-HiChIP-144_R2_001.fastq.gz DTG-HiChIP-141_R2_001.fastq.gz DTG-HiChIP-142_R2_001.fastq.gz> /share/lasallelab/Oran/dovetail/luhmes/allUDP4sconcat/UDP4-1-2-3_R2.fastq.gz





#first copied hichip and pairix folders (not needed on UC Davis cluster when using module and env)
#then all hg38 titled files to new directory "merged" and 'neuronscat"
#must run each sample group in separate folders though since aligned.sam file would be overwritten
#adding email commands informs you when job is done (please change to your own email :P)
#using concatenated samples although processing fastq samples separately and then using bedtools intersectBed would be better
#If get error like numpy not detected, close down terminal and restart with just HiChiP module and env

#sample nomenclature used
neurons_R2.fastq.gz  undif_R1.fastq.gz

#0 For lazy and no intermediate files
bwa mem -5SP -T0 -t30 /share/lasallelab/Oran/dovetail/luhmes/merged/hg38.fasta NP4-1-2_R1.fastq.gz NP4-1-2_R2.fastq.gz| pairtools parse --min-mapq 40 --walks-policy 5unique --max-inter-align-gap 30 --nproc-in 30 --nproc-out 30 --chroms-path /share/lasallelab/Oran/dovetail/luhmes/merged/hg38.genome | pairtools sort --tmpdir=/share/lasallelab/Oran/dovetail/luhmes/catbalanced/temp/ --nproc 30|pairtools dedup --nproc-in 30 --nproc-out 30 --mark-dups --output-stats NP4-1and2stats|pairtools split --nproc-in 30 --nproc-out 30 --output-pairs NP4-1and2_mapped.pairs --output-sam -|samtools view -bS -@16 | samtools sort -@30 -o NP4-1and2_mapped.PT.bam;samtools index NP4-1and2_mapped.PT.bam

#1 bwa fastq to aligned.sam
bwa mem -5SP -T0 -t50 hg38.fasta undif_R1.fastq.gz undif_R2.fastq.gz -o aligned.sam; echo "#1 bwa done" | mail -s "#1 bwa done" ojg333@gmail.com
#for neurons from neuronscat folder
bwa mem -5SP -T0 -t50 hg38.fasta neurons_R1.fastq.gz neurons_R2.fastq.gz -o aligned.sam; echo "#1 bwa done" | mail -s "#1 bwa done" ojg333@gmail.com
#For NP4
bwa mem -5SP -T0 -t50 /share/lasallelab/Oran/dovetail/luhmes/merged/hg38.fasta NP4-1-2_R1.fastq.gz NP4-1-2_R2.fastq.gz -o NP4aligned.sam; echo "#1 bwa done" | mail -s "#1 bwa done" ojg333@gmail.com
#For UDP4
bwa mem -5SP -T0 -t50 /share/lasallelab/Oran/dovetail/luhmes/merged/hg38.fasta UDP4-1-2_R1.fastq.gz UDP4-1-2_R2.fastq.gz -o UDP4aligned.sam; echo "#1 UDP4 bwa done" | mail -s "#1 UDP4 bwa done" ojg333@gmail.com


#2 Pairtools aligned sam to parsed.pairsam (not present in UCD)
pairtools parse --min-mapq 40 --walks-policy 5unique --max-inter-align-gap 30 --nproc-in 50 --nproc-out 50 --chroms-path hg38.genome aligned.sam >  parsed.pairsam; echo "#2 pairtools done" | mail -s "#2 pairtools done" ojg333@gmail.com
#For NP4
pairtools parse --min-mapq 40 --walks-policy 5unique --max-inter-align-gap 30 --nproc-in 30 --nproc-out 30 --chroms-path /share/lasallelab/Oran/dovetail/luhmes/merged/hg38.genome aligned.sam >  parsed.pairsam; echo "#2 NP4 pairtools done" | mail -s "#2 pairtools done" ojg333@gmail.com
#FOR UDP4
pairtools parse --min-mapq 40 --walks-policy 5unique --max-inter-align-gap 30 --nproc-in 30 --nproc-out 30 --chroms-path /share/lasallelab/Oran/dovetail/luhmes/merged/hg38.genome UDP4aligned.sam >  UDP4parsed.pairsam; echo "#2 UDP4 pairtools done" | mail -s "#2 pairtools done" ojg333@gmail.com


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
pairtools dedup --nproc-in 30 --nproc-out 30 --mark-dups --output-stats stats --output dedup.pairsam sorted.pairsam; echo "#4 Pairtools Deduplicate done" | mail -s "#4 Pairtools Deduplicate done" ojg333@gmail.com

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

#7.6 Call peaks using MACS3 (For neuronscat, instead of macs2 since macs2 was not working on ucdavis cluster and to keep same one used for undif)



#7.6 Call peaks using MACS2 (Must be typed out not pasted or ran as snippet)
module load macs2
macs2 callpeak –t prefix.primary.aln.bed --nomodel -n prefix.macs2
for neuronscat
macs3 callpeak -t neuronomod.primary.aln.bed --nomodel -n neuronomod.macs3

#8 Library QC
python3 ./HiChiP/get_qc.py -p stats

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


For generating contact maps
#Since juicertools not installed in UC Davis HiChiP env, may need to download and install first
wget https://s3.amazonaws.com/hicfiles.tc4ga.com/public/juicer/juicer_tools_1.22.01.jar
mv juicer_tools_1.22.01.jar ./HiChiP/juicertools.jar

#May not need since hic and coolers files were part of output given by Dovetail
#Will need for concatenated samples
#11 From .pairs to .hic contact matrix (concatenated filesc)
java -Xmx240000m  -Djava.awt.headless=true -jar ./HiChiP/juicertools.jar pre --threads 30 mapped.pairs contact_map.hic hg38.genome; echo "#11 .pairs to .hic" | mail -s "#11 .pairs to .hic" ojg333@gmail.com

#For individual pair files (example for NP4-1)
java -Xmx240000m  -Djava.awt.headless=true -jar /share/lasallelab/Oran/dovetail/luhmes/neuronscat/HiChiP/juicertools.jar pre --threads 30 /share/lasallelab/Oran/dovetail/luhmes/24-12-2021_06:26:08_epi_delivery/validPairs/UNI2695.valid.pairs.gz NP4-1_contact_map.hic /share/lasallelab/Oran/dovetail/luhmes/neuronscat/hg38.genome; echo "#11 Individual .pairs to .hic" | mail -s "#11 Individual .pairs to .hic" ojg333@gmail.com

#For individual pair file NP4-2 only need sample submission form to determine which files
java -Xmx240000m  -Djava.awt.headless=true -jar /share/lasallelab/Oran/dovetail/luhmes/neuronscat/HiChiP/juicertools.jar pre --threads 30 /share/lasallelab/Oran/dovetail/luhmes/24-12-2021_06:26:08_epi_delivery/validPairs/UNI2696.valid.pairs.gz NP4-2_contact_map.hic /share/lasallelab/Oran/dovetail/luhmes/neuronscat/hg38.genome; echo "#11 Individual .pairs to .hic" | mail -s "#11 Individual .pairs to .hic" ojg333@gmail.com

#For subsampled pair file subsample.pairs
java -Xmx48000m  -Djava.awt.headless=true -jar ./HiChiP/juicertools.jar pre --threads 16 subsample33.pairs sub33contact_map.hic hg38.genome; echo "#11 SUB33.pairs to .hic" | mail -s "#11 .pairs to .hic" ojg333@gmail.com

#12 Install pairix and set path
git clone https://github.com/4dn-dcic/pairix
cd pairix
make
#Add the bin path, and utils path to PATH and exit the folder: May not need to exit either since using full path, but should be from pairix folder.  Also ran from base path not UCDavis hichip or xmen.  From hichip module on merged folder just needed to set path
PATH=/share/lasallelab/Oran/dovetail/luhmes/merged/pairix/bin/:/share/lasallelab/Oran/dovetail/luhmes/merged/pairix/util:/share/lasallelab/Oran/dovetail/luhmes/merged/pairix/bin/pairix:$PATH
cd ..

#13 Prep mapped pairs for indexing (last time had to use xmen env only) DO NOT USE gzip as this format will not be accepted by pairix also keep unziped copy to avoid issues when unzipping for downstream analysis, use -k option to keep original file, also to unzip and keep original use (for subsample) gunzip -c subsample33.pairs.gz >subsample33.pairs
bgzip mapped.pairs

#14 Index mapped.pairs (had to type out last time but could be due to previous error setting path without luhmes folder)
pairix mapped.pairs.gz

#15 Single Resolution Contact Matrix
#Use UC Davis env created using
module load cooler
source activate cooler-0.8.11

cooler cload pairix -p 30 hg38.genome:1000 mapped.pairs.gz matrix_1kb.cool
#Subsample
cooler cload pairix -p 16 hg38.genome:1000 subsample33.pairs.gz sub33matrix_1kb.cool

#16 Multiresolution Contact Matrix
cooler zoomify --balance -p 16 matrix_1kb.cool
#subsample
cooler zoomify --balance -p 16 sub33matrix_1kb.cool

#17 Filtered pairs to HiCpro pairs
#Can skip to here if dont need hic or cooler contact matrix
grep -v '#' mapped.pairs| awk -F"\t" '{print $1"\t"$2"\t"$3"\t"$6"\t"$4"\t"$5"\t"$7}' | gzip -c > hicpro_mapped.pairs.gz; echo "#17 pairs to HiCpro" | mail -s "#17 pairs to HiCpro" ojg333@gmail.com

#For subsampled undif
grep -v '#' subsample33.pairs| awk -F"\t" '{print $1"\t"$2"\t"$3"\t"$6"\t"$4"\t"$5"\t"$7}' | gzip -c > hicpro_subsample33.pairs.gz; echo "#17 pairs to HiCpro" | mail -s "#17 pairs to HiCpro" ojg333@gmail.com


#Exit out of previos env and terminal session
#18 & #19 start fithichip module and env
module load fithichip
source activate hicpro-3.1.0

#20 Runs FitHiChIP
#Neurons
FitHiChIP_HiCPro.sh -C /share/lasallelab/Oran/dovetail/luhmes/neuronscat/config; echo "#20 01 Neurons FitHiChIP done" | mail -s "#20 Runs FitHiChIP" ojg333@gmail.com

#Undif
FitHiChIP_HiCPro.sh -C /share/lasallelab/Oran/dovetail/luhmes/merged/configsub33; echo "#20 sub33 FitHiChIP done" | mail -s "#20 Runs FitHiChIP" ojg333@gmail.com

FitHiChIP_HiCPro.sh -C configNP4-1pn; echo "#20 sub33 FitHiChIP done" | mail -s "#20 Runs FitHiChIP" ojg333@gmail.com

#21 mapped.bam to bedgraph
#Exit out of previos env and terminal session
module load fithichip
source activate hicpro-3.1.0

bamCoverage -b mapped.PT.bam -of bedgraph -p 36 -o 5k.coverage.bedgraph; echo "#21 mapped.bam to bedgraph" | mail -s "#21 mapped.bam to bedgraph" ojg333@gmail.com

'''
#note for subsample.bam and subsample33.bam, these are not the same as pairs file subsamples (must go back before mapped.PT.bam and subsample and do again if want to match that) so no point in using these bam or making bigwig files for these, unless can figure out a way to go from pairs to bam but current sumsample bams are useless
'''

#From here on best to use R studio on desktop after downloading bedgraph file and installing sushi library or run from terminal by first opening R with command $R
#22 load sushi
library("Sushi")
#23 load data
cov <- read.table("5k.coverage.bedgraph")
arc <- read.table("CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)
#actual used from personal mac folders for concatenated samples
arc <- read.table("/Users/fsociety/Downloads/Dovetailoutput/Undif/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)
arc <- read.table("/Users/fsociety/Downloads/Dovetailoutput/Neurons/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)

#from USB drive
arc <- read.table("/Volumes/DOVETAIL/UDP2-1_Merge_Nearby_Interactions/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)
arc <- read.table("/Volumes/DOVETAIL/UDP2-2_Merge_Nearby_Interactions/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)
arc <- read.table("/Volumes/DOVETAIL/UDP4-1_Merge_Nearby_Interactions/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)
arc <- read.table("/Volumes/DOVETAIL/UDP4-2_Merge_Nearby_Interactions/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)
arc <- read.table("/Volumes/DOVETAIL/UDP4-3_Merge_Nearby_Interactions/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)
arc <- read.table("/Volumes/DOVETAIL/NP4-1_Merge_Nearby_Interactions/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)
arc <- read.table("/Volumes/DOVETAIL/NP4-2_Merge_Nearby_Interactions/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)
arc <- read.table("/Volumes/DOVETAIL/NP4-3_Merge_Nearby_Interactions/CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed", header=TRUE)



#24 Add column for distance in merged contacts file
arc$dist <- abs(arc$e2 - arc$s1)
head(arc)

#25 Set region to visualize (AS locus) hg19 chr15:24963895-26388896
chrom = "chr15"
chromstart = 24718748
chromend = 26143749

####LUHMES concat interactions####
#zoomed entire locus with interactions hg19 chr15:25365147-26195147		hg38 chr15:25120000-25950000
chromstart = 25120000
chromend = 25950000

#zoomed From PWAR1 Interaction-1 "larger" hg19 chr15:25365147-25765147
chromstart = 25120000
chromend = 25520000

#From Bed file exact Large loop present in both undif and neurons****USED FOR gRNA Targeting
#Comparison ofall data shows highest methylation right up-stream ofthe PAM site (around +25 bp). 
#A second (weaker) peak of methylation is observed downstream of the PAM
#25–30 nucleotide pairs centered at the 27th site (around –40 bp).
#Therefore PAM should be target 25-30bp UPSTREAM of CpG on CTCF binding site with another non fusion dCas9 at CTCF binding site
#Contact points 25135000-25140000 to 25500000-25505000 (hg38)		chr15:25380147-25385147 to chr15:25745147-25750147 (hg19)

chromstart = 25135000
chromend = 25505000

#zoomed "Interaction-2" (smaller)" hg19 chr15:25745147-25945147
chromstart = 25500000
chromend = 25700000

#From Bed file exact small loop present in only undif****
#Contact points 25330000-25335000 to 25435000-25440000 (hg38) 		chr15:25575147-25580147 to chr15:25680147-25685147 (hg19)
chromstart = 25330000
chromend = 25440000

#zoomed "Interaction-3 (larger)" hg19 chr15:25745147-26195147
chromstart = 25500000
chromend = 25950000

#zoomed "Interaction-4" hg19 chr15:25930147-26185147
chromstart = 25685000
chromend = 25940000

#zoomed "Interaction-5" hg19 chr15:25975147-26185147
chromstart = 25730000
chromend = 25940000

#zoomed "Interaction-6" hg19 chr15:26151647-26178547
chromstart = 25906500
chromend = 25933400

####Undif concat interactions####
#zoomed into different one from neurons hg19  chr15:25567147-25688147
chrom = "chr15"
chromstart = 25322000
chromend = 25443000

#NHIP entire locus chr22:49000000-49600000 (hg 38)	chr22:49395812-49993648 (hg19)	
chrom = "chr22"
chromstart = 49000000
chromend = 49600000

#NHIP DMR block chr22:49044669 – 49162642 (hg38), not present in neurons	chr22:49440481-49558654 (hg19)
chrom = "chr22"
chromstart = 49044669
chromend = 49162642
 
#NHIP AK057312 chr22: 49043941 - 49052549 (hg38) *had to expand, not present in neurons	chr22:49422753-49478361 (hg19)
chrom = "chr22"	
chromstart = 49026941
chromend = 49082549

#NHIP Insertion: Location chr22: 49029657 (hg38) chr22:49425469(hg19)  chr22:49027000-49048000 (hg38) *expanded to nearest loop, not present in neurons chr22:49422812-49443812 (hg19)   minus 10 and plus 10 from insertion 49425459-49425469 (hg19) results in sequence GAAAACTCCTTGCTCAAAAGC 
chrom = "chr22"
chromstart = 49027000
chromend = 49048000

#NHIP Fetal brain enhancer 49025000 - 49055000 *same loop seen around the NHIP insertion (49027000-49048000)
chrom = "chr22"
chromstart = 49025000
chromend = 49055000

#Best AS region
chr15:23476800-26895932
#Best AS zoomed
chr15:24761859-25954632
#Best NHIP
chr22:48999824-49079943
#FITHICHIP ONLY ACCEPTS
chr22:49000000-49100000

#26 Inspect coverage plot
plotBedgraph(cov,chrom,chromstart,chromend)
labelgenome(chrom,chromstart,chromend,n=4,scale="Mb")
mtext("Read Depth",side=2,line=1.75,cex=1,font=2)
axis(side=2,las=2,tcl=.2)

#27 Plot arcs with arc heights based on contact frequency
plotBedpe(arc,chrom,chromstart,chromend,heights = arc$sumCC,plottype="loops", flip=TRUE)
labelgenome(chrom, chromstart,chromend,side=3, n=3,scale="Mb")
axis(side=2,las=2,tcl=.2)
mtext("contact freq",side=2,line=1.75,cex=.75,font=2)

#28 Align and print both plots to a PDF file
#where “{}” paste line-by-line rather than bulk copy and paste
pdfname <- "hichip.cov.arcs.pdf"
makepdf = TRUE
if(makepdf==TRUE)
      {
      pdf(pdfname , height=10, width=12)
      }

##set layout
layout(matrix(c(1,
      2
      ), 2,1, byrow=TRUE))
par(mgp=c(3,.3,0))

##plot coverage
par(mar=c(3,4,2,2))
plotBedgraph(cov,chrom,chromstart,chromend)
labelgenome(chrom,chromstart,chromend,n=4,scale="Mb")
mtext("Read Depth",side=2,line=1.75,cex=1,font=2)
axis(side=2,las=2,tcl=.2)

##plot arcs with height based on contact frequency
par(mar=c(3,4,2,2))
plotBedpe(arc,chrom,chromstart,chromend,heights = arc$sumCC,plottype="loops", flip=TRUE)
labelgenome(chrom, chromstart,chromend,side=3, n=3,scale="Mb")
axis(side=2,las=2,tcl=.2)
mtext("contact freq",side=2,line=1.75,cex=.75,font=2)

if (makepdf==TRUE)
{
dev.off()
}

#For diff analysis (better than concatenating samples) 
#first use valid.pairs files as input to FitHiChiP 
#then run differentail.analysis.script.sh on resulting
#CTCF.DS.5kb.interactions_FitHiC_Q0.10_MergeNearContacts.bed file (Incorrect bed file, must be all contacts not just Q0.10
#Don't just rename narrowpeak or try converting using bedtobam since file gets corrupted
Can also use DiffBind with R studio as described https://hbctraining.github.io/Intro-to-ChIPseq/lessons/08_diffbind_differential_peaks.html


#Diff analysis command from https://ay-lab.github.io/FitHiChIP/usage/DiffLoops.html
First convert broadpeak bed file to bam (example bedToBam -i rmsk.hg18.chr21.bed -g human.hg18.genome > rmsk.hg18.chr21.bam)
bedToBam -i /share/lasallelab/Oran/dovetail/luhmes/merged/prefix.macs3_summits.bed -g /share/lasallelab/Oran/dovetail/luhmes/merged/hg38.genome > /share/lasallelab/Oran/dovetail/luhmes/merged/prefix.macs3_summits.bam

#Copied fithichip folder from /software to DifAnalysis folder
#UDP2-1, UDP2-2 correspond to cat1repl4, cat1repl5

#Open new terminal and load module, env
module load fithichip
source activate hicpro-3.1.0

#Must not have any spaces between commas, also removed directory before bed and bam files, be careful to not have enter spaces either.
#First converted narrowpeak to bed then bed to bedgraph (can probably go straight from bed to narrowpeak to bedgraph) Tried to convert bed to bam with bedtools but got weird characters when trying to view bam file afterwards
#narrowpeak to bed
cut -f 1-6 macs_output.narrowPeak > macs_output.bed
#bed to bedgraph
awk '{ print $1"\t"$2"\t"$3"\t"$5 }' macs_output.bed > macs_output.bedgraph

#Executed From (hicpro-3.1.0) fugon@epigenerate:/share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis$ 

Rscript /share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis/fithichip/9.1/lssc0-linux/Imp_Scripts/DiffAnalysisHiChIP.r --AllLoopList cat1_repl1.bed,cat1_repl2.bed,cat1_repl3.bed,cat1_repl4.bed,cat1_repl5.bed,cat2_repl1.bed,cat2_repl2.bed,cat2_repl3.bed --ChrSizeFile /share/lasallelab/Oran/dovetail/refgenomes/hg38.chrom.sizes --FDRThr 0.10 --CovThr 25 --ChIPAlignFileList cat1_ChIPAlign.bedgraph,cat2_ChIPAlign.bedgraph --OutDir /share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis/outdirnpbgraph/ --CategoryList 'Undiff':'Neurons' --ReplicaCount 5:3 --ReplicaLabels1 "R1":"R2":"R3":"R4":"R5" --ReplicaLabels2 "R1":"R2":"R3" --FoldChangeThr 2 --DiffFDRThr 0.05 --bcv 0.4

#just np4 1and2 and udp4 1and2
Rscript /share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis/fithichip/9.1/lssc0-linux/Imp_Scripts/DiffAnalysisHiChIP.r --AllLoopList cat1_repl1.bed,cat1_repl2.bed,cat2_repl1.bed,cat2_repl2.bed --ChrSizeFile /share/lasallelab/Oran/dovetail/refgenomes/hg38.chrom.sizes --FDRThr 0.10 --CovThr 25 --ChIPAlignFileList cat1_ChIPAlign.bedgraph,cat2_ChIPAlign.bedgraph --OutDir /share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis/outdirnp-catbal1-2_bdgraph/ --CategoryList 'Undiff':'Neurons' --ReplicaCount 2:2 --ReplicaLabels1 "R1":"R2" --ReplicaLabels2 "R1":"R2" --FoldChangeThr 2 --DiffFDRThr 0.05 --bcv 0.4

#just np4 1and2 and udp4 1and3
Rscript /share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis/fithichip/9.1/lssc0-linux/Imp_Scripts/DiffAnalysisHiChIP.r --AllLoopList cat1_repl1.bed,cat1_repl3.bed,cat2_repl1.bed,cat2_repl2.bed --ChrSizeFile /share/lasallelab/Oran/dovetail/refgenomes/hg38.chrom.sizes --FDRThr 0.10 --CovThr 25 --ChIPAlignFileList cat1_ChIPAlign.bedgraph,cat2_ChIPAlign.bedgraph --OutDir /share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis/outdirnp-catbal1-3_bdgraph/ --CategoryList 'Undiff':'Neurons' --ReplicaCount 2:2 --ReplicaLabels1 "R1":"R3" --ReplicaLabels2 "R1":"R2" --FoldChangeThr 2 --DiffFDRThr 0.05 --bcv 0.4

#NP4 vs UDP4 (no UDP2)
Rscript /share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis/fithichip/9.1/lssc0-linux/Imp_Scripts/DiffAnalysisHiChIP.r --AllLoopList cat1_repl1.bed,cat1_repl2.bed,cat1_repl3.bed,cat2_repl1.bed,cat2_repl2.bed,cat2_repl3.bed --ChrSizeFile /share/lasallelab/Oran/dovetail/refgenomes/hg38.chrom.sizes --FDRThr 0.10 --CovThr 25 --ChIPAlignFileList cat1_ChIPAlign.bedgraph,cat2_ChIPAlign.bedgraph --OutDir /share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis/outdirnpNoUDP2/ --CategoryList 'Undiff':'Neurons' --ReplicaCount 3:3 --ReplicaLabels1 "R1":"R2":"R3" --ReplicaLabels2 "R1":"R2":"R3" --FoldChangeThr 2 --DiffFDRThr 0.05 --bcv 0.4

#NP4 1&2 vs NP2 1&2
Rscript /share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis/fithichip/9.1/lssc0-linux/Imp_Scripts/DiffAnalysisHiChIP.r --AllLoopList cat1_repl4.bed,cat1_repl5.bed,cat2_repl1.bed,cat2_repl2.bed --ChrSizeFile /share/lasallelab/Oran/dovetail/refgenomes/hg38.chrom.sizes --FDRThr 0.10 --CovThr 25 --ChIPAlignFileList cat1_ChIPAlign.bedgraph,cat2_ChIPAlign.bedgraph --OutDir /share/lasallelab/Oran/dovetail/luhmes/bedintersect/DifAnalysis/outNP4_1-2vUDP2_1-2/ --CategoryList 'Undiff':'Neurons' --ReplicaCount 2:2 --ReplicaLabels1 "R4":"R5" --ReplicaLabels2 "R1":"R2" --FoldChangeThr 2 --DiffFDRThr 0.05 --bcv 0.4

#Make a bigwig over your region of interest (https://deeptools.readthedocs.io/en/develop/content/tools/bamCoverage.html)
deepTools bamCoverage --ignoreDuplicates -bs 1 -p 20 -r chr15:24718748-26143749 -b subsample.bam -o subsample.bigwig
'''
--ignoreDuplicates = do not include PCR dups (should be removed already, but its always better to be safe here)
-bs = bin size here its 50bp - you can change to 1 for single nt, or 1000 for 1kb bins
-p = # of processors to use
-r = region - this is where you specify what part of you want to make a the bigwig around
-b = input bam file
-o = output bigwig file
'''

#To subsample bam to make bigwig for subsamples use
samtools view -s 33.50363652188 -b mapped.PT.bam > subsample33.bam


/share/lasallelab/Oran/dovetail/luhmes/catbalanced$

#for catbalanced
FitHiChIP_HiCPro.sh -C configNP4-01; echo "#20 NP4FitHiChIP done" | mail -s "#20 Runs FitHiChIP" ojg333@gmail.com

catbalanced udp 1 and 3
cat DTG-HiChIP-137_R1_001.fastq.gz DTG-HiChIP-138_R1_001.fastq.gz DTG-HiChIP-141_R1_001.fastq.gz DTG-HiChIP-142_R1_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/NP4-1-3_R1.fastq.gz

cat DTG-HiChIP-137_R2_001.fastq.gz DTG-HiChIP-138_R2_001.fastq.gz DTG-HiChIP-141_R2_001.fastq.gz DTG-HiChIP-142_R2_001.fastq.gz > /share/lasallelab/Oran/dovetail/luhmes/catbalanced/NP4-1-3_R2.fastq.gz
