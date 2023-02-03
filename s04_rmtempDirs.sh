#!/bin/bash
#===============================================================================
# File Name    : s04_rmtempDirs.sh
# Description  : rm temp dirs for completed hmnn3 runs
# Usage        : sbatch s04_rmtempDirs.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2022-10-31
# Last Modified: 2022-11-07
#===============================================================================


#SBATCH --time=0-01:00:00 # days-hh:mm:ss
#SBATCH --job-name=rmtempdirs
#SBATCH --array=1-266%30
#SBATCH --cpus-per-task=2
#SBATCH --mem=2G
#SBATCH --output=slurmout/humann3/x_221107rmtempdirs.out
#SBATCH --error=slurmout/humann3/y_221107rmtempdirs.err


#read in the slurm array task
sample=`sed -n ${SLURM_ARRAY_TASK_ID}p 221107_hmn3_complete.txt`

indir="/scratch/gdlab/alferreiro/HECSFIRN/humann3_out"

rm -r ${indir}/${sample}_humann_temp




