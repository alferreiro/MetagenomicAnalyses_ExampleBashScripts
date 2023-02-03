#!/bin/bash

#===============================================================================
#
# File Name    : sam2sortedbam.sh
# Description  : convert sam to bam and sort. Binner for MAGs assemblies (e.g. MetaBat2)
#                require sorted bam files.
# Usage        : sbatch sam2sortedbam.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2021-01-08
# Last Modified: 2021-01-08
#===============================================================================

#SBATCH --array=1-207%60
#SBATCH --mem=32G
#SBATCH --time=3-00:00:00 #days-hh:mm:ss
#SBATCH --output=../../slurm_out/MAGs/z_sam2bam_%a.out
#SBATCH --error=../../slurm_out/MAGs/z_sam2bam_%a.err

# 'Module load' is deprecated. Update to enable spack loading:
module load samtools

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p ../../210108_samfiles.txt)


samtools faidx ${ID}_contigs.fasta
samtools view -bt ${ID}_contigs.fasta.fai bowtie2out/${ID}.sam > bowtie2out/${ID}.bam
samtools sort -o bowtie2out/${ID}.sorted.bam bowtie2out/${ID}.bam
