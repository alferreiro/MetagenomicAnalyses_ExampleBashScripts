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

#SBATCH --array=1-67
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/trimmomatic/y_trimmomatic_%a.out
#SBATCH --error=slurm_out/trimmomatic/z_trimmomatic_%a.err



eval $( spack load --sh trimmomatic@0.39 )

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p 201103_filelookup_uniq.txt)


java -jar $TRIMMOMATIC_HOME/trimmomatic-0.38.jar PE rawreads/${ID}_R1.fastq.gz rawreads/${ID}_R2.fastq.gz \
     -baseout trimmomatic_out/${ID}_filtered.fastq.gz \
     ILLUMINACLIP:/opt/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10:1:TRUE \
     LEADING:10 TRAILING:10 SLIDINGWINDOW:4:20 MINLEN:60

