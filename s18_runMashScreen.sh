#!/bin/bash

#===============================================================================
#
# File Name    : runMashScreen.sh
# Description  : Run mash screen on genome bins to identify contained genomes
# Usage        : sbatch runMashScreen.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2021-01-09
# Last Modified: 2021-01-09
#===============================================================================

#SBATCH --array=1-3372%50
#SBATCH --mem=32G
#SBATCH --time=3-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/mashScreen/z_mashScreen_%a.out
#SBATCH --error=slurm_out/mashScreen/z_mashScreen_%a.err
#SBATCH --cpus-per-task=4



eval $(spack load --sh mash@2.3 )

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p CheckM_out/210330_checkMpass.txt)

refpath="/scratch/ref/gdlab/mash_sketches/refseq.genomes.k21s1000.msh"


mash screen -w -p ${SLURM_CPUS_PER_TASK} ${refpath} \
    MetaBat_out/${ID} > MashScreen_out/${ID}_temp.tab


sort -gr MashScreen_out/${ID}_temp.tab > MashScreen_out/${ID}.tab
rm MashScreen_out/${ID}_temp.tab

