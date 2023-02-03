#!/bin/bash

#===============================================================================
#
# File Name    : s0b_rundeconseq.sh
# Description  : This script will run deconseq in parallel
# Usage        : sbatch s0b_rundeconseq.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-11-03
# Last Modified: 2020-11-03
#===============================================================================

#SBATCH --array=1-67
#SBATCH --mem=32G
#SBATCH --time=2-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/deconseq/z_deconseq_%a.out
#SBATCH --error=slurm_out/deconseq/z_deconseq_%a.err



ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p trimmomatic_out/201103_filecheck.txt)

eval $( spack load --sh deconseq-standalone@0.4.3 )


gunzip  trimmomatic_out/${ID}_filtered_1P.fastq.gz
gunzip  trimmomatic_out/${ID}_filtered_2P.fastq.gz

# Run deconseq on forward paired reads that passed trimmomatic
# quality filtering. Filter out human reads (hsref38)
/opt/apps/labs/gdlab/software/deconseq/0.4.3-chr38/deconseq.pl \
    -f trimmomatic_out/${ID}_filtered_1P.fastq \
    -out_dir deconseq_out \
    -id ${ID}_fwd \
    -dbs hsref38

# Run deconseq on reverse paired reads that passed trimmomatic
# quality filtering. Filter out human reads (hsref38)
/opt/apps/labs/gdlab/software/deconseq/0.4.3-chr38/deconseq.pl \
    -f trimmomatic_out/${ID}_filtered_2P.fastq \
    -out_dir deconseq_out \
    -id ${ID}_rev \
    -dbs hsref38

gzip trimmomatic_out/${ID}_filtered_1P.fastq
gzip trimmomatic_out/${ID}_filtered_2P.fastq

