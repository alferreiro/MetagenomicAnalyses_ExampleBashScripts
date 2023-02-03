#!/bin/bash

#===============================================================================
#
# File Name    : s00_downloadreads.sh
# Description  : This script will download sra files from ncbi (fastq.gz)
#                given accession ids
# Usage        : sbatch s00_downloadreads.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-11-03
# Last Modified: 2020-11-03
#===============================================================================

#SBATCH --array=1-296%20
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=../slurm_out/download/z_download_%a.out
#SBATCH --error=../slurm_out/download/z_download_%a.err


module load sratoolkit

eval $( spack load --sh sratoolkit@3.0.0 )

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p 201103_Haran_SRR_Acc_List.txt)

fastq-dump --split-files --gzip ${ID}

