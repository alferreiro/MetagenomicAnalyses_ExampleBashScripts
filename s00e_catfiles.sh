#!/bin/bash

#===============================================================================
#
# File Name    : catfiles.sh
# Description  : This script will cat files in parallel
# Usage        : sbatch catfiles.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-09-17
# Last Modified: 2020-09-17
#===============================================================================

#SBATCH --array=1-193%40
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/catfiles/x_catfiles_%a.out
#SBATCH --error=slurm_out/catfiles/y_catfiles_%a.err



ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p rawseq/230124/230124_Indices-strip.txt)

indir='rawseq/230124'
outdir='rawseq/230124-cat'

mkdir -p ${outdir}

cat ${indir}/HJW5YDSX5_${ID}_L001_R1.fastq.gz ${indir}/HL2KHDSX5_${ID}_L002_R1.fastq.gz > ${outdir}/LANETOKEN_${ID}_L00X_R1.fastq.gz
cat ${indir}/HJW5YDSX5_${ID}_L001_R2.fastq.gz ${indir}/HL2KHDSX5_${ID}_L002_R2.fastq.gz > ${outdir}/LANETOKEN_${ID}_L00X_R2.fastq.gz


