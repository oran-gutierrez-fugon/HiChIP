#!/bin/bash
#SBATCH --job-name=pairtools_sort
#SBATCH --mail-user=ojgutierrez@ucdavis.edu
#SBATCH --ntasks=64
#SBATCH --mem=200000
#SBATCH --partition=production  # Ensure to use the correct partition
#SBATCH --time=2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --chdir=/share/lasallelab/Oran/dovetail/luhmes/neuronscat

# Initialize conda
source /software/anaconda3/4.8.3/lssc0-linux/etc/profile.d/conda.sh

# Activate your conda environment
conda activate pairtools_env

# Run your pairtools command with nice
nice -n 10 pairtools sort --nproc 64 --tmpdir=/share/lasallelab/Oran/dovetail/luhmes/neuronscat/temp/ parsed.pairsam > sorted.pairsam
