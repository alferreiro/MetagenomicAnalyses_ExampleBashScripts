#!/bin/bash

#===============================================================================
#
# File Name    : fastastats.sh
# Description  : generate assembly stats from contigs fasta file using seqkit
# Usage        : sbatch fastastats.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2021-01-07
# Last Modified: 2021-01-07
#===============================================================================


#SBATCH --mem=32G
#SBATCH --time=1-00:00:00 #days-hh:mm:ss
#SBATCH --output=slurm_out/metaspades/z_210107_fastastats.out
#SBATCH --error=slurm_out/metaspades/z_210107_fastastats.err



# 'Module load' is deprecated. Update to enable spack loading:
module load seqkit


seqkit stats Set1Set2/metaspades/*contigs.fasta --all --skip-err --tabular > Set1Set2/metaspades/210107_contigstats.txt


