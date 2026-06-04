# CTCF HiChIP in differentiating LUHMES neurons

Analysis and visualization of CTCF HiChIP data (Dovetail Genomics) in LUHMES cells, comparing undifferentiated precursors to day-7 neurons. The goal was to map neuron-specific chromatin loops across the 15q11-q13 imprinted locus and connect them to silencing of the paternal *UBE3A* allele in Angelman syndrome.

This is one of the assays behind:

> Gutierrez Fugón OJ, Sharifi O, Heath NC, et al. *Integration of CTCF Loops, Methylome, and Transcriptome in Differentiating LUHMES as a Model for Imprinting Dynamics of the 15q11-q13 Locus in Human Neurons.* Hum Mol Genet. 2024. https://doi.org/10.1093/hmg/ddae111

## Main result

Two neuron-specific CTCF loops appear during differentiation:

1. A ~1.2 Mb loop between *MAGEL2* and *SNRPN*
2. A loop from *PWAR1* to a region ~64 kb downstream of *UBE3A*

Both track with developmental activation of the *UBE3A-ATS* antisense transcript, supporting a model where the loops help extend *SNHG14* transcription into *UBE3A-ATS* and silence paternal *UBE3A*.

## Pipeline

Sample labels: **NP4** = neurons, **UDP4** = undifferentiated. Processing lives in `Shellcripts/` and the figures in `Rscripts/`.

**1. Concatenate replicates** (`Shellcripts/dovetailLUHMES.sh`, `Shellcripts/dovetail_scriptNOTES.txt`)
Technical and biological replicates are merged per condition before alignment. Sample-to-condition mapping is documented inline (key in `UNI2695_sample_sheetDECODED.csv`).

**2. Balance read depth between conditions** (`Shellcripts/pairtools_sort.slurm`)
Loop calls are sensitive to sequencing depth, so the two conditions are matched before calling. The merged libraries had 314,005,891 neuronal versus 623,477,205 undifferentiated mapped pairs. The undifferentiated library is downsampled to the neuronal depth with a fixed seed so the comparison is reproducible:

```bash
pairtools sample -s 33 --nproc-in 20 --nproc-out 20 \
  -o subsample33.pairs.gz 0.50363652188 mapped.pairs.gz
```

**3. Call significant loops** (FitHiChIP)
CTCF-anchored loops are called at 5 kb resolution, FitHiChIP Q 0.05 with merged near contacts. Both a standard (SM) run and allele-specific maternal/paternal (AA) runs were done. Outputs sit in `NP4-SM-5K-05/` and `UDP4-SM-5K-05/` as plain BED plus bgzipped WashU tracks with tabix indexes, and the `SummaryReports/` folder holds the FitHiChIP HTML reports (NP4 and UDP4, maternal and paternal).

**4. Format and intersect** (`FHCtoInter.sh`, `FHCtoInter5k.sh`, `intersectBed.sh`)
FitHiChIP output is converted to WashU/interaction format and intersected with CTCF sites and loops of interest (`LoopsOfInterestDNAseq.txt`) using bedtools.

**5. Differential and visual analysis** (`Rscripts/`)
`Rscripts/DifferentialAnalysis/differential_analysis.R` and `ld_ld_hichip.R` compare loop strength between conditions. Plotting scripts draw loop arcs over the locus and the *UBE3A-ATS* expression timeline, for example `AngelmanRegionArcs.R`, `AS-5K-Loops.R`, `hichipGraph*.R`, and the `ATStimeline*` / `ATSinNeurons*` panels (color and black-and-white variants for figures). Earlier versions are kept in `Rscripts/Deprecated/`.

## Layout

```
HiChIP/
├── Shellcripts/        concat, pairtools subsample, FitHiChIP formatting, bedtools
├── Rscripts/           loop-arc, ATS-timeline, and DifferentialAnalysis/ scripts
├── SummaryReports/     FitHiChIP HTML reports (NP4/UDP4, maternal/paternal, 5 kb)
├── NP4-SM-5K-05/       neuron loop calls (BED + WashU bed.gz + .tbi)
├── UDP4-SM-5K-05/      undifferentiated loop calls (BED + WashU bed.gz + .tbi)
└── *.png              rendered loop/arc figures
```

## Dependencies

pairtools, FitHiChIP, samtools, bedtools, and R (GenomicRanges and plotting packages). Scripts were run on a SLURM cluster (see `pairtools_sort.slurm`), so paths and `module load` lines will need editing for another environment.
