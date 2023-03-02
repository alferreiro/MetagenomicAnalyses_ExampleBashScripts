#!/bin/bash

#===============================================================================
#
# File Name    : s0a_runtrimmomatic.sh
# Description  : This script will run trimmomatic in parallel, to remove adapter
#                sequences from raw fastq data, and trim/filter on quality
#                metrics.
# Usage        : sbatch s0a_runtrimmomatic.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-09-17
# Last Modified: 2020-09-17
#===============================================================================

#SBATCH --array=1-384%30
#SBATCH --mem=16G
#SBATCH --cpus-per-task=2
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/trimmomatic/y_trimmomatic_%a.out
#SBATCH --error=slurm_out/trimmomatic/z_trimmomatic_%a.err


# Load trimmomatic module
eval $( spack load --sh trimmomatic@0.39 )

# Samples for slurm array
ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p rawseq/230302_SampleList2.txt)


# I/O
indir="rawseq/230124-cat"
outdir="trimm_out"

mkdir -p ${outdir}


# Declare memory
export JAVA_ARGS="-Xmx1000M"

# adapter file
adapter="/ref/gdlab/data/trimmomatic_adapters/0.39/NexteraPE-PE.fa"


trimmomatic PE -phred33 -trimlog \
    ${outdir}/${ID}_trimlog.txt \
    ${indir}/${ID}_R1.fastq.gz \
    ${indir}/${ID}_R2.fastq.gz \
    -baseout ${outdir}/${ID}_filt.fastq.gz \
    ILLUMINACLIP:${adapter}:2:30:10:1:TRUE \
    LEADING:10 \
    TRAILING:10 \
    SLIDINGWINDOW:4:20 \
    MINLEN:60




