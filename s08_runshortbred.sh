#!/bin/bash

#===============================================================================
#
# File Name    : s08_runshortbred.sh
# Description  : This script will run shortbred in parallel, which is a tool to
#                identify and quantify antibiotic resistance genes in metagenomes
#                based on unique marker sequences derived from the CARD database.
#                This script needs to be updated to enable spack loading of
#                module to reflect new cluster policies, and make sure the
#                reference databases are up to date.
# Usage        : sbatch s08_runshortbred.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-09-14
# Last Modified: 2020-09-14
#===============================================================================

#SBATCH --array=1-260%80
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/shortbred/z_shortbred_%a.out
#SBATCH --error=slurm_out/shortbred/z_shortbred_%a.err

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p processed/200913_filecheck_uniq.txt)


# 'Module load' is deprecated. Update to enable spack loading.
module load shortbred

echo "$ID"

gunzip processed/${ID}_R1.fastq.gz
gunzip processed/${ID}_R2.fastq.gz
gunzip processed_singletons/${ID}_singletons.fastq.gz

shortbred_quantify.py \
    --markers /scratch/ref/gdlab/Shortbred_markers/170926_shortbredMarkers_CARD2017-Uniref90_clustIdentity-100perc.faa \
    --wgs processed/${ID}_R1.fastq processed/${ID}_R2.fastq processed_singletons/${ID}_singletons.fastq \
    --results shortbred_out/${ID}_shortbread_out.txt \
    --tmp shortbred_tmp/${ID}_quantify

gzip processed/${ID}_R1.fastq
gzip processed/${ID}_R2.fastq
gzip processed_singletons/${ID}_singletons.fastq
