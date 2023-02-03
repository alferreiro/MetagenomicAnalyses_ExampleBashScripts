#!/bin/bash

#===============================================================================
#
# File Name    : s0d_runrepair.sh
# Description  : This script will fix pairedends in parallel using repair.sh from 
#                bbtools. For use after trimmomatic/deconseq. Metaphlan does not
#                used paired read information (just all reads concatenated), but
#                if other analyses will be done it may be necessary to re-pair
#                paired reads. Good practice to always run.
# Usage        : sbatch s0d_runrepair.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-11-14
# Last Modified: 2020-11-14
#===============================================================================

#SBATCH --array=1-120%60
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/processed/z_processed_%a.out
#SBATCH --error=slurm_out/processed/z_processed_%a.err

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p 201114_deconseq_filecheck_s.txt)

# 'Module load' is deprecated. Update to enable spack loading:
module load bbtools

#Run repair

repair.sh in1=deconseq_out/${ID}_fwd_clean.fq.gz \
    in2=deconseq_out/${ID}_rev_clean.fq.gz \
    out1=processed/${ID}_R1.fastq.gz \
    out2=processed/${ID}_R2.fastq.gz \
    outs=processed_singletons/${ID}_singletons.fastq.gz
