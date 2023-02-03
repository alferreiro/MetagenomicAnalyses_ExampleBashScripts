#!/bin/bash

#===============================================================================
#
# File Name    : parseCheckM.sh
# Description  : parse CheckM.stdout in parallel for each sample using
#                pythonscripts/p09_parseCheckM.py. Finds bins with completeness
#                >50% and contamination <5%.
# Usage        : sbatch parseCheckM.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2021-01-15
# Last Modified: 2021-01-15
#===============================================================================

#SBATCH --array=1-261%60
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/MAGs/z_parseCheckM_%a.out
#SBATCH --error=slurm_out/MAGs/z_parseCheckM_%a.err


eval $( spack load --sh python@3.9.12 )

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p 210329_MetaBatdirs.txt)


python pythonscripts/p09_parseCheckM.py ${ID}

