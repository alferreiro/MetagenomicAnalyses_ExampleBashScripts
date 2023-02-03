#!/bin/bash
#===============================================================================
#
# File Name    : readcounts.sh
# Description  : This script will count reads in (zipped)  files in  parallel
# Usage        : sbatch readcounts.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-09-14
# Last Modified: 2020-09-14
#===============================================================================

#SBATCH --array=1-2
#SBATCH --mem=2G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurmout/readcounts/x_readcounts.out
#SBATCH --error=slurmout/readcounts/y_readcounts.err



ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p 221108_notcounted.txt)

# Following command zcats (prints without unzipping) fastq file and pipes it to
# 'wc -l' command, which counts the number of lines in the file. This is 
# divided by 4 to count number of reads (evaluated by expr), because in fastq
# format, each read takes up 4 lines (read id, sequence, +, quality scores)


counts=$(expr $(zcat processed_reads/${ID}_R1.fastq.gz | wc -l) / 4)


# Append sample ID and read counts to output file

echo ${ID} $'\t' ${counts} >> 221108_HECSFIRN_readcounts.txt
