#!/bin/bash

#===============================================================================
#
# File Name    : rmShortContigs.sh
# Description  : This script will remove sequences <1000bp in a .fasta file
#                (i.e. of assembled contigs)
# Usage        : sbatch rmShortContigs.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-11-23
# Last Modified: 2020-11-23
#===============================================================================

#SBATCH --array=1-40
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/rmShortContigs/z_rmShortContigs_%a.out
#SBATCH --error=slurm_out/rmShortContigs/z_rmShortContigs_%a.err




eval $( spack load --sh seqtk@1.3 )

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p 201123_ACS_1-40.txt)


seqtk seq -L 1000 metaspades_out/${ID}/contigs.fasta > ADmetaspades_contigs1000/${ID}_contigs.fasta

