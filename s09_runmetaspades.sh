#!/bin/bash

#===============================================================================
#
# File Name    : runmetaspades.sh
# Description  : This script will run metaspades in parallel, to assemble contigs
#                from short read metagenomic sequence data.
# Usage        : sbatch runmetaspades.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-09-25
# Last Modified: 2020-09-25
#===============================================================================

#SBATCH --array=1-67%20
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/metaspades/z_metaspades_%a.out
#SBATCH --error=slurm_out/metaspades/z_metaspades_%a.err

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p processed/200919_filecheck_uniq.txt)


# Module load deprecated. Update to enable spack loading:
module load spades

echo "$ID"

#start debug mode (will send commands to outfile)
set -x

time spades.py --meta \
    -1 processed/${ID}_R1.fastq.gz \
    -2 processed/${ID}_R2.fastq.gz \
    --memory 1000 \
    -o metaspades_out/${ID}




#End debug mode
set +x

