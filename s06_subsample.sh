#!/bin/bash
#===============================================================================
#
# File Name    : subsample.sh
# Description  : Iteratively subsample reads paired fastq.gz files.
# Usage        : sbatch subsample.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-09-30
# Last Modified: 2020-09-30
#===============================================================================
#

#SBATCH --array=1-26
#SBATCH --mem=12G
#SBATCH --cpus-per-task=2
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurmout/rarefaction/x_subsample6-13.out
#SBATCH --error=slurmout/rarefaction/y_subsample6-13.err

eval $( spack load --sh seqtk@1.3 )


ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p 221108_Samples4Rarefaction.txt)


# Randomly subsample reads samples in parallel (forward and then reverse read 
# files) in steps from 6 mill to 13 mill. 

for i in {6000000..13000000..1000000}; do
    echo "Subsampling $ID at $i reads"
    seqtk sample -s42 processed_reads/${ID}_R1.fastq.gz $i > rarefaction/${ID}_sub${i}_R1.fastq.gz  
    seqtk sample -s42 processed_reads/${ID}_R2.fastq.gz $i > rarefaction/${ID}_sub${i}_R2.fastq.gz
done


