#!/bin/bash

#===============================================================================
#
# File Name    : runMetaBat2.sh
# Description  : bin metagenome assemblies
# Usage        : sbatch runMetaBat2.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2021-01-08
# Last Modified: 2021-01-08
#===============================================================================

#SBATCH --array=1-207%60
#SBATCH --mem=32G
#SBATCH --time=3-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/MAGs/z_metabat_%a.out
#SBATCH --error=slurm_out/MAGs/z_metabat_%a.err

eval $( spack load --sh metabat@2.15 )


ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p 210109_sortedbamfiles.txt)


runMetaBat.sh  Set1Set2/metaspades/${ID}_contigs.fasta \
    Set1Set2/metaspades/bowtie2out/${ID}.sorted.bam

