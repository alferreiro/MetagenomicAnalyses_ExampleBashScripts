#!/bin/bash

#===============================================================================
#
# File Name    : bowtiealn.sh
# Description  : align reads to indexed assemblies of those reads
# Usage        : sbatch buildbowtieidx.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2021-01-07
# Last Modified: 2021-01-07
#===============================================================================

#SBATCH --array=1-218%60
#SBATCH --mem=32G
#SBATCH --time=3-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/MAGs/z_bowtiealn_%a.out
#SBATCH --error=slurm_out/MAGs/z_bowtiealn_%a.err



eval $( spack load --sh bowtie2@2.4.2 )

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p 210107_contigfiles.txt)

bowtie2 --very-sensitive-local -x Set1Set2/metaspades/${ID} -1 processed/${ID}_R1.fastq.gz -2 processed/${ID}_R2.fastq.gz -S Set1Set2/metaspades/bowtie2out/${ID}.sam


