#!/bin/bash
#===============================================================================
#
# File Name    : s02_MergeTables_mphln.sh
# Description  : This script will generate merged table of taxa relative abundances 
#                for all samples in the set.
# Usage        : sbatch s02_MergeTables_mphln.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2022-10-23
# Last Modified: 2022-10-23
#===============================================================================

#SBATCH --time=0-02:00:00 # days-hh:mm:ss
#SBATCH --job-name=merge_mphln
#SBATCH --cpus-per-task=2
#SBATCH --mem=2G
#SBATCH --output=slurmout/metaphlan3/x_merge_mphln3.out
#SBATCH --error=slurmout/metaphlan3/y_merge_mphln3.err

#This is actually a single job, not a slurm array. 


indir="/scratch/gdlab/alferreiro/HECSFIRN/metaphlan3_rare"
outdir="/scratch/gdlab/alferreiro/HECSFIRN/merged_metaphlan3"

#load mphln3 spack module
eval $( spack load --sh py-metaphlan@3.1.0 )


set -x

#Merge metaphlan output
merge_metaphlan_tables.py \
    ${indir}/*_profile.txt > ${outdir}/221110_mergedabun_mphln3.tsv

set +x



