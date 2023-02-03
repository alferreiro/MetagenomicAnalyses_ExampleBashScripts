#!/bin/bash
#===============================================================================
# File Name    : s07_merge_humann3.sh
# Description  : merge humann3 pathabundaces for multiple samples
# Usage        : sbatch s07_merge_humann3.sh
# Author       : Aura Ferreiro
# Version      : 1.0
# Created On   : 2022-12-17
# Last Modified: 2022-12-17
#===============================================================================


#SBATCH --time=0-03:00:00 # days-hh:mm:ss
#SBATCH --job-name=mergehumann3
#SBATCH --cpus-per-task=2
#SBATCH --mem=2G
#SBATCH --output=slurmout/humann3/x_221217_mergehumann_%a.out
#SBATCH --error=slurmout/humann3/y_221217_mergehumann_%a.err


# load bowtie2 spack module
eval $( spack load --sh bowtie2@2.4.2 )


# load python and activate humann venv
# Eventually we will install a spack module for humann3.
module load python
. /opt/apps/labs/gdlab/envs/humann/3.0.0a4/bin/activate




indir="/scratch/gdlab/alferreiro/HECSFIRN/humann3_out"
outdir="/scratch/gdlab/alferreiro/HECSFIRN/merged_humann3"




set -x # Start debug mode (will send commands to outfile)


# Join humann output for all samples into one table
humann_join_tables \
        -i ${indir} \
        -o ${outdir}/221217_humann3pathabund_merged.tsv \
        --file_name pathabundance


# Renormalize pathway abundances (cpm method)
humann_renorm_table \
    -i ${outdir}/221217_humann3pathabund_merged.tsv \
    -o ${outdir}/221217_humann3pathabund_merged-cpm.tsv




set +x # End debug mode (will stop sending commands to outfile)

deactivate # deactivate venv
