#!/bin/bash

#===============================================================================
#
# File Name    : findapaters.sh
# Description  : Unfamiliar fastq data? Unclear if adapter sequences have been
#                trimmed? This script will use bbmap to find adapters sequences
#                in rawreads
# Usage        : sbatch s0c_findadapters.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-09-17
# Last Modified: 2020-09-17
#===============================================================================

#SBATCH --array=1-53
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/findadapters/z_findadapters_H%a.out
#SBATCH --error=slurm_out/findadapters/z_findadapters_H%a.err


# 'Module load' is deprecated. Update to enable spack loading:
module load bbtools

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p Haran_rawreads/201105_haran_filecheck_clean.txt)

bbduk.sh in1=Haran_rawreads/${ID}_1.fastq.gz in2=Haran_rawreads/${ID}_2.fastq.gz \
    k=23 \
    ref=/opt/apps/bbtools/38.26/resources/adapters.fa \
    stats=Haran_rawreads/adapters/${ID}_stats.txt \
    out=Haran_rawreads/adapters/${ID}_out.fq


