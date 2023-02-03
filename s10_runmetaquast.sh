#!/bin/bash
#===============================================================================
#
# File Name    : runmetaquast_out.sh
# Description  : Run metaquast on contigs.fasta output from metaspades.
#                To determine assembly quality.
# Usage        : sbatch metaquast.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2020-09-30
# Last Modified: 2020-09-30
#===============================================================================
#

#SBATCH --array=1-67%20
#SBATCH --mem=32G
#SBATCH --cpus-per-task=2
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/metaquast/z_metaquast_%a.out
#SBATCH --error=slurm_out/metaquast/z_metaquast_%a.err

module load quast

ID=$(sed -n ${SLURM_ARRAY_TASK_ID}p processed/200919_filecheck_uniq.txt)

set -x

time metaquast.py metaspades_out/${ID}/contigs.fasta \
    -o metaquast_out/${ID} \
    --gene-finding


set +x
