#!/bin/bash

#===============================================================================
#
# File Name    : adddirname.sh
# Description  : Rename bin files in each MetaBat outdir to add sampleid (i.e. dir name)
# Usage        : sbatch adddirname.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2021-01-15
# Last Modified: 2021-01-15
#===============================================================================

#SBATCH --array=1-261%60
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/MAGs/z_renameMetaBatbin_%a.out
#SBATCH --error=slurm_out/MAGs/z_renameMetaBatbin_%a.err


eval $( spack load --sh python@3.9.12 )

# Metabat dirs correspond to samples
ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p 210329_MetaBatdirs.txt)


python pythonscripts/p08_addSampleid2MAGbins.py ${ID}

