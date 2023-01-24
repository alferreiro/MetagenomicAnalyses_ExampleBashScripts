#!/bin/bash
#===============================================================================
#
# File Name    : s01_runmetaphlan3.sh
# Description  : This script will run metaphlan3 on paired reads
# Usage        : sbatch runmetaphlan3.sh
# Author       : Aura Ferreiro
# Version      : 2.0
# Created On   : Wed Jan  6 11:49:47 CST 2021
# Last Modified: Oct 20 2022
#===============================================================================
#
#Submission script for HTCF
#SBATCH --time=3-0:00:00 # days-hh:mm:ss
#SBATCH --job-name=metaphlan
#SBATCH --array=1-442%40
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --output=slurmout/rarefaction/x_metaphlan_%a.out
#SBATCH --error=slurmout/rarefaction/y_metaphlan_%a.err

# load metaphlan3 spack module (should load bowtie2 and python dependencies)
eval $( spack load --sh py-metaphlan@3.1.0)

basedir="/scratch/gdlab/alferreiro/HECSFIRN"
indir="${basedir}/rarefaction"
outdir="${basedir}/metaphlan3_rare"

#make output directory
mkdir -p ${outdir}

#read in the slurm array task
sample=`sed -n ${SLURM_ARRAY_TASK_ID}p ${basedir}/221109_raresamples.txt`

set -x # Start debug mode (will send commands to outfile)

gunzip ${indir}/${sample}_R1.fastq.gz
gunzip ${indir}/${sample}_R2.fastq.gz

time metaphlan \
        ${indir}/${sample}_R1.fastq,${indir}/${sample}_R2.fastq \
        --bowtie2out ${outdir}/${sample}.bowtie2.bz2 \
        -o ${outdir}/${sample}.profile.txt \
        --nproc ${SLURM_CPUS_PER_TASK} \
        --input_type fastq


gzip ${indir}/${sample}_R1.fastq
gzip ${indir}/${sample}_R2.fastq

set +x # End debug mode (will stop sending commands to outfile)



