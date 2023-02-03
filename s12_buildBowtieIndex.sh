#!/bin/bash

#===============================================================================
#
# File Name    : buildbowtieidx.sh
# Description  : build bowtie idx files for multifasta files (to enable read
#                alignment to contigs with bowtie2).
# Usage        : sbatch buildbowtieidx.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2021-01-07
# Last Modified: 2021-01-07
#===============================================================================

#SBATCH --array=1-218%60
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/MAGs/z_buildbowtie_%a.out
#SBATCH --error=slurm_out/MAGs/z_buildbowtie_%a.err



eval $( spack load --sh bowtie2@2.4.2 )

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p 210107_contigfiles.txt)

bowtie2-build -f Set1Set2/metaspades/${ID}_contigs.fasta Set1Set2/metaspades/${ID}

